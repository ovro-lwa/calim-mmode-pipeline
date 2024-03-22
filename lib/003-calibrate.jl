module Driver

using CasaCore.Measures
using JLD2
using ProgressMeter
using TTCal
using BPJSpec
using Unitful
using YAML

include("Project.jl")
include("CreateMeasurementSet.jl")
include("WSClean.jl")
include("TTCalDatasets.jl"); using .TTCalDatasets
include("BeamModels.jl");    using .BeamModels
include("CalibrationFundamentals.jl"); using .CalibrationFundamentals

struct Config
    input        :: String
    output       :: String
    output_calibration :: String
    output_bandpass    :: String
    metadata     :: String
    skymodel     :: String
    test_image   :: String
    integrations :: Vector{Int}
    channels_at_a_time :: Int
    maxiter      :: Int
    tolerance    :: Float64
    minuvw       :: Float64
    refant       :: Int # the reference antenna (we have just let the overall phase float until now)
    order        :: Int # order of the polynomial fit to the bandpass amplitude
    delete_input :: Bool
end

function load(file)
    dict = YAML.load(open(file))
    if dict["integrations"] isa String
        string = dict["integrations"]
        split_string = split(string, ":")
        start = parse(Int, split_string[1])
        stop  = parse(Int, split_string[2])
        integrations = start:stop
    else
        integrations = dict["integrations"]
    end
    Config(dict["input"],
           get(dict, "output", ""),
           get(dict, "output-calibration", ""),
           get(dict, "output-bandpass", ""),
           dict["metadata"],
           joinpath(dirname(file), dict["sky-model"]),
           dict["test-image"],
           integrations,
           get(dict, "channels-at-a-time", 0),
           dict["maxiter"],
           dict["tolerance"],
           dict["minuvw"],
           dict["refant"],
           dict["order"],
           dict["delete-input"])
end

function go(project_file, wsclean_file, config_file)
    project = Project.load(project_file)
    wsclean = WSClean.load(wsclean_file)
    config  = load(config_file)
    calibrate(project, wsclean, config)
    if config.delete_input
        Project.rm(project, config.input)
    end
end

function calibrate(project, wsclean, config)
    path = Project.workspace(project)
    try
        calibration = Project.load(project, config.output_calibration, "calibration")
        bandpass_coeff = Project.load(project, config.output_bandpass, "bandpass-parameters")
    catch
        calibration, bandpass_coeff = solve_for_the_calibration(project, config)
        #create_test_image(project, wsclean, config, calibration)
        if config.output_calibration != ""
            Project.save(project, config.output_calibration, "calibration", calibration)
        end
        if config.output_bandpass != ""
            Project.save(project, config.output_bandpass, "bandpass-parameters", bandpass_coeff)
        end
    end
    calibration = Project.load(project, config.output_calibration, "calibration")
    bandpass_coeff = Project.load(project, config.output_bandpass, "bandpass-parameters")
    if config.output != ""
        apply_the_calibration(project, config, calibration)
    end
end

function solve_for_the_calibration(project, config)
    println(string("Solving for the calibration: ", config.maxiter))
    metadata = Project.load(project, config.metadata, "metadata")
    if config.channels_at_a_time > 0
        queue = collect(Iterators.partition(1:Nfreq(metadata), config.channels_at_a_time))
        # We don't know what order the calibration will finish in, so we'll write them all down
        # along with their channel numbers and stitch it back together at the end.
        calibrations = Dict{Int, TTCal.Calibration}() # maps (first channel) => (calibration)
        @sync for worker in workers()
            @async while length(queue) > 0
                channels = shift!(queue)
                my_calibration = remotecall_fetch(solve_for_the_calibration_with_channels, worker,
                                                  project, config, channels)
                calibrations[first(channels)] = my_calibration
            end
        end
        # Stitch it back together
        sorted_keys = sort(collect(keys(calibrations)))
        calibration = calibrations[first(sorted_keys)]
        for key in sorted_keys[2:end]
            TTCal.merge!(calibration, calibrations[key], axis=:frequency)
        end
    else
        # We're taking all the channels at once, and we'll do the calibration on the master process
        calibration = solve_for_the_calibration_with_channels(project, config, 1:Nfreq(metadata))
    end
    coeff = smooth!(calibration, metadata, config)
    calibration, coeff
end

function solve_for_the_calibration_with_channels(project, config, channels)
    path  = Project.workspace(project)
    input = BPJSpec.load(joinpath(path, config.input))
    metadata = Project.load(project, config.metadata, "metadata")
    sky   = readsky(config.skymodel)
    beam  = getbeam(metadata)
    measured = read_raw_visibilities(input, metadata, channels, config.integrations)
    model    = genvis(measured.metadata, beam, sky, polarization=TTCal.Dual)
    calibration = TTCal.calibrate(measured, model, maxiter=config.maxiter,
                                  tolerance=config.tolerance, minuvw=config.minuvw,
                                  collapse_time=true, quiet=true)
    calibration
end

####################################################################################################

function smooth!(calibration, metadata, config)
    ν = metadata.frequencies
    coeff  = zeros(config.order + 4, 2, Nant(metadata))
    input  = cal_to_array(calibration, metadata, config.refant)
    output = zeros(Complex128, Nfreq(metadata), 2, Nant(metadata))
    for ant = 1:Nant(metadata)
        coeff[:, 1, ant], output[:, 1, ant] = fit_bandpass(ν, @view(input[:, 1, ant]), config) # xx
        coeff[:, 2, ant], output[:, 2, ant] = fit_bandpass(ν, @view(input[:, 2, ant]), config) # yy
    end
    array_to_cal!(calibration, output, metadata)
    coeff
end

function cal_to_array(calibration, metadata, refant)
    # get the data into a format that is a little easier to work with
    output = zeros(Complex128, 2, Nant(metadata), Nfreq(metadata))
    for β = 1:Nfreq(metadata)
        cal = calibration[β, 1]
        for ant = 1:Nant(metadata)
            J = cal[ant]
            output[1, ant, β] = J.xx
            output[2, ant, β] = J.yy
        end
    end
    # fix the phase to the reference antenna
    for β = 1:Nfreq(metadata)
        xx_phase_factor = conj(output[1, refant, β]) / abs(output[1, refant, β])
        yy_phase_factor = conj(output[2, refant, β]) / abs(output[2, refant, β])
        output[1, :, β] .*= xx_phase_factor
        output[2, :, β] .*= yy_phase_factor
    end
    # put frequency on the fast axis
    output = permutedims(output, (3, 1, 2)) # Nfreq × Npol × Nant
end

function array_to_cal!(calibration, array, metadata)
    for β = 1:Nfreq(metadata)
        cal = calibration[β, 1]
        for ant = 1:Nant(metadata)
            J = TTCal.DiagonalJonesMatrix(array[β, 1, ant], array[β, 2, ant])
            cal[ant] = J
        end
    end
end

function fit_bandpass(ν, gains, config)
    amplitude =   abs.(gains)
    phase     = angle.(gains)
    flags = isnan.(amplitude) .| (amplitude .== 0)
    νMHz  = ustrip.(uconvert.(u"MHz", ν))
    amplitude_coeff, amplitude_fit = fit_amplitude(νMHz, amplitude, flags, config.order)
    phase_coeff,     phase_fit     = fit_phase(νMHz, phase, flags)
    complete_coeff = [phase_coeff; amplitude_coeff]
    complete_fit   = amplitude_fit .* cis.(phase_fit)
    complete_coeff, complete_fit
end

function fit_amplitude(νMHz, amplitude, flags, order)
    polyfit(νMHz, amplitude, flags, order)
end

function fit_phase(νMHz, phase, flags)
    #  0 => phase offset relative to the reference antenna
    #  1 => delay term
    # -1 => differential total electron content (ie. relative to the reference antenna)
    # To get the delay in m, multiply by u"c / (2π*MHz)"
    # To get the TEC in TECU, divide by u"q^2 / (4pi*me*ϵ0*c) * (TECU/MHz)"
    polyfit(νMHz, unroll_phase(phase), flags, (0, 1, -1))
end

function polyfit(x, y, flags, order::Int)
    terms = collect(n for n = 0:order)
    polyfit(x, y, flags, terms)
end

function polyfit(x, y, flags, terms::Union{AbstractVector, Tuple})
    A = zeros(eltype(y), length(y), length(terms))
    for (jdx, n) in enumerate(terms)
        for idx = 1:length(y)
            A[idx, jdx] = x[idx]^n
        end
    end
    coeff  = A[.!flags, :] \ y[.!flags]
    values = A * coeff
    coeff, values
end

function unroll_phase(phase)
    unrolled_phase = copy(phase)
    for idx = 1:length(phase)-1
        Δϕ = phase[idx+1] - phase[idx]
        while Δϕ > π
            Δϕ -= 2π
        end
        while Δϕ < -π
            Δϕ += 2π
        end
        unrolled_phase[idx+1] = unrolled_phase[idx] + Δϕ
    end
    unrolled_phase
end

end

