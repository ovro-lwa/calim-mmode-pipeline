module Driver

using BPJSpec
using TTCal
using ProgressMeter
using YAML

include("Project.jl")
include("WSClean.jl")
include("CreateMeasurementSet.jl")
include("TTCalDatasets.jl"); using .TTCalDatasets
include("BeamModels.jl");    using .BeamModels
include("CalibrationFundamentals.jl"); using .CalibrationFundamentals

struct Config
    input        :: String
    output_calibration :: String
    metadata     :: String
    skymodel     :: String
    additional_model_visibilities :: String
    test_image   :: String
    integrations :: Vector{Int}
    channels_at_a_time :: Int
    maxiter      :: Int
    tolerance    :: Float64
    minuvw       :: Float64
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
           dict["output-calibration"],
           dict["metadata"],
           joinpath(dirname(file), dict["sky-model"]),
           dict["additional-model-visibilities"],
           dict["test-image"],
           integrations,
           get(dict, "channels-at-a-time", 0),
           dict["maxiter"],
           dict["tolerance"],
           dict["minuvw"])
end

function go(project_file, wsclean_file, config_file)
    project = Project.load(project_file)
    wsclean = WSClean.load(wsclean_file)
    config  = load(config_file)
    recalibrate(project, wsclean, config)
end

function recalibrate(project, wsclean, config)
    path = Project.workspace(project)
    calibration, measured, model = solve_for_the_calibration(project, config)
    Project.save(project, config.output_calibration, "calibration", calibration)
    image(project, measured, config.test_image*"-measured")
    image(project, model,    config.test_image*"-model")
    applycal!(measured, calibration)
    image(project, measured, config.test_image*"-calibrated")
end

function solve_for_the_calibration(project, config)
    println("Solving for the calibration")
    metadata = Project.load(project, config.metadata, "metadata")
    if config.channels_at_a_time > 0
        queue = collect(Iterators.partition(1:Nfreq(metadata), config.channels_at_a_time))
        lck = ReentrantLock()
        prg = Progress(length(queue))
        increment() = (lock(lck); next!(prg); unlock(lck))
        # We don't know what order the calibration will finish in, so we'll write them all down
        # along with their channel numbers and stitch it back together at the end.
        calibrations          = Dict{Int, TTCal.Calibration}() # (first channel) => (calibration)
        measured_visibilities = Dict{Int, TTCal.Dataset}()     # (first channel) => (dataset)
        model_visibilities    = Dict{Int, TTCal.Dataset}()     # (first channel) => (dataset)
        @sync for worker in workers()
            @async while length(queue) > 0
                channels = shift!(queue)
                my_calibration, my_measured, my_model =
                    remotecall_fetch(solve_for_the_calibration_with_channels, worker,
                                     project, config, channels, true)
                calibrations[first(channels)] = my_calibration
                measured_visibilities[first(channels)] = my_measured
                model_visibilities[first(channels)] = my_model
                increment()
            end
        end
        # Stitch it back together
        sorted_keys = sort(collect(keys(calibrations)))
        calibration = calibrations[first(sorted_keys)]
        measured    = measured_visibilities[first(sorted_keys)]
        model       = model_visibilities[first(sorted_keys)]
        for key in sorted_keys[2:end]
            TTCal.merge!(calibration,       calibrations[key], axis=:frequency)
            TTCal.merge!(measured, measured_visibilities[key], axis=:frequency)
            TTCal.merge!(model,       model_visibilities[key], axis=:frequency)
        end
    else
        # We're taking all the channels at once, and we'll do the calibration on the master process
        calibration, measured, model =
            solve_for_the_calibration_with_channels(project, config, 1:Nfreq(metadata), false)
    end
    calibration, measured, model
end

function solve_for_the_calibration_with_channels(project, config, channels, quiet)
    path  = Project.workspace(project)
    input = BPJSpec.load(joinpath(path, config.input))
    metadata = Project.load(project, config.metadata, "metadata")
    sky   = readsky(config.skymodel)
    beam  = getbeam(metadata)

    measured = read_raw_visibilities(input, metadata, channels, config.integrations)
    model    = genvis(deepcopy(measured.metadata), beam, sky, polarization=TTCal.Dual)
    add_diffuse_model_visibilities!(model, project, config, channels)

    calibration = TTCal.calibrate(measured, model, maxiter=config.maxiter,
                                  tolerance=config.tolerance, minuvw=config.minuvw,
                                  collapse_time=true, quiet=quiet)

    # pick out a central integration for imaging
    central_integration = round(Int, middle(1:Ntime(metadata)))
    TTCal.slice!(measured, central_integration, axis=:time)
    TTCal.slice!(model,    central_integration, axis=:time)

    calibration, measured, model
end

function add_diffuse_model_visibilities!(model, project, config, channels)
    path = Project.workspace(project)
    additional_model_visibilities_path = joinpath(path, config.additional_model_visibilities)
    additional_model_visibilities = BPJSpec.load(additional_model_visibilities_path)
    for (frequency, frequency′) in enumerate(channels)
        V = additional_model_visibilities[frequency′]
        for (time, time′) in enumerate(config.integrations)
            model_visibilities = model[frequency, time]
            α = 1
            for ant1 = 1:Nant(model), ant2 = ant1:Nant(model)
                # Flagged baselines will have zero additional model visibilities. This is not a
                # problem as long as the baselines flagged in `additional_model_visibilities` are
                # consistent with the baselines flagged in the dataset we are calibrating.
                W = V[α, time′]
                model_visibilities[ant1, ant2] += TTCal.DiagonalJonesMatrix(W, W)
                α += 1
            end
        end
    end
end

function image(project, dataset, name)
    path = Project.workspace(project)
    ms = CreateMeasurementSet.create(dataset, joinpath(path, name*".ms"))
    try
        WSClean.run(WSClean.Config("natural", 0, 8), ms, joinpath(path, name*"-natural"))
    catch
    end
    try
        WSClean.run(WSClean.Config("uniform", 0, 8), ms, joinpath(path, name*"-uniform"))
    catch
    end
end

end

