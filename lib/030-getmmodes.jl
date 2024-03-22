module Driver

using FileIO, JLD2
using ProgressMeter
using TTCal
using BPJSpec
using YAML

include("Project.jl")
include("FlagDefinitions.jl"); using .FlagDefinitions

struct Config
    input        :: String
    input_flags  :: String
    output       :: String
    metadata     :: String
    hierarchy    :: String
    interpolating_visibilities :: String
    flagging_mmodes            :: String
    replacement_threshold :: Float64
    flagging_threshold    :: Float64
    integrations_per_day  :: Int
    delete_input :: Bool
    option       :: String
end

function load(file)
    dict = YAML.load(open(file))
    option = get(dict, "option", "all")
    Config(dict["input"],
           get(dict, "input-flags", ""),
           dict["output"],
           dict["metadata"],
           dict["hierarchy"],
           get(dict, "interpolating-visibilities", ""),
           get(dict, "flagging-m-modes", ""),
           get(dict, "replacement-threshold", 0.0),
           get(dict, "flagging-threshold", 0.0),
           dict["integrations-per-day"],
           dict["delete-input"],
           option)
end

function go(project_file, config_file)
    project = Project.load(project_file)
    config  = load(config_file)
    getmmodes(project, config)
    if config.delete_input
        rm(joinpath(Project.workspace(project), config.input), recursive=true)
    end
end

function getmmodes(project, config)
    path = Project.workspace(project)

    ttcal_metadata = Project.load(project, config.metadata, "metadata")
    metadata  = BPJSpec.from_ttcal(ttcal_metadata)
    hierarchy = Project.load(project, config.hierarchy, "hierarchy")

    Project.set_stripe_count(project, config.output, 1)
    input  = BPJSpec.load(joinpath(path, config.input))
    output = create(MModes, MultipleFiles(joinpath(path, config.output)),
                    metadata, hierarchy)

    queue = collect(1:length(input.frequencies))
    pool  = CachingPool(workers())
    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))

    @sync for worker in workers()
        @async while length(queue) > 0
            frequency = shift!(queue)
            remotecall_wait(_getmmodes, pool, input, output,
                            hierarchy, project, config, frequency)
            increment()
        end
    end

    if config.flagging_mmodes != ""
        flag_mmodes!(output, project, config)
    end
end

function _getmmodes(input, output, hierarchy, project, config, frequency)
    V = input[frequency]
    flag!(V, project, config, frequency)
    W = fold(V, config)
    if config.interpolating_visibilities != ""
        interpolate!(W, project, config, frequency)
    end
    _getmmodes!(output, W, hierarchy, config, frequency)
end

function flag!(V, project, config, frequency)
    if config.input_flags != ""
        flags = Project.load(project, config.input_flags, "flags")
        V[flags.bits[:, frequency, :]] = 0 # apply the flags
    end
end

function fold(V, config)
    _fold(V, config.integrations_per_day)
end

function _fold(V, integrations_per_day)
    Nbase, Ntime = size(V)
    numerator   = zeros(eltype(V), Nbase, integrations_per_day)
    denominator = zeros(      Int, Nbase, integrations_per_day)
    for idx = 1:Ntime, α = 1:Nbase
        if V[α, idx] != 0
            numerator[  α, mod1(idx, integrations_per_day)] += V[α, idx]
            denominator[α, mod1(idx, integrations_per_day)] += 1
        end
    end
    no_data = denominator .== 0
    numerator[no_data]   = 0
    denominator[no_data] = 1
    output = numerator ./ denominator
    output
end

function interpolate!(V, project, config, frequency)
    path = Project.workspace(project)
    interpolating_visibilities = BPJSpec.load(joinpath(path, config.interpolating_visibilities))
    W = interpolating_visibilities[frequency]
    @assert size(W) == size(V)
    _interpolate!(V, W, config.replacement_threshold)
end

function _interpolate!(V, W, replacement_threshold)
    flags   = V .== 0 # `true` indicates data was flagged
    missing = W .== 0 # `true` indicates we don't have a replacement value
    complete_flags = flags .| missing

    # Note that we get baselines with missing data when the baseline isn't represented by the
    # transfer matrix. This happens, for example, to long baselines when I set a low lmax.

    diff = V .- W
    σ = sqrt(mean(abs2.(diff[.!complete_flags])))

    # Fill in any gaps in the data
    Nbase, Ntime = size(V)
    for α = 1:Nbase
        # If a baseline has been completely flagged, don't magically populate it with data
        all(@view flags[α, :]) && continue
        for time = 1:Ntime
            if !missing[α, time] && flags[α, time]
                # Replace a gap in the data with the interpolated value
                V[α, time] = W[α, time]
            end
            if !missing[α, time] && abs(diff[α, time]) > replacement_threshold * σ
                # Replace a visibility that seems to be an outlier
                V[α, time] = W[α, time]
            end
        end
    end
    V
end

function _getmmodes!(output, V, hierarchy, config, frequency)
    Ntime = size(V, 2)
    if config.option == "odd"
        # select only odd numbered integrations
        W  = @view V[:, 1:2:end]
        dϕ = 0.0
    elseif config.option == "even"
        # select only even numbered integrations
        W  = @view V[:, 2:2:end]
        dϕ = -2π/Ntime
    elseif config.option == "day" || config.option == "night"
        # select only integrations from the day/night-time
        # (and apply a Blackman-Harris window function)
        # TODO change the definition of day/night from being hard coded
        sunrise = 755
        sunset  = 3745

        if config.option == "day"
            N = sunset - sunrise + 1
            W = circshift(V, (0, 1-sunrise))
            dϕ = -2π/Ntime * (sunrise-1)
        else
            N = config.integrations_per_day - (sunset - sunrise + 1)
            W = circshift(V, (0,  -sunset))
            dϕ = -2π/Ntime * sunset
        end
        W[:, N+1:end] = 0

        for n = 0:N-1
            W[:, n+1] .*= (0.35875 - 0.48829cos((2π*n)/(N-1))
                                   + 0.14128cos((4π*n)/(N-1))
                                   - 0.01168cos((6π*n)/(N-1)))
        end
    else
        W  = V
        dϕ = 0.0
    end
    # put time on the fast axis
    transposed_array = permutedims(W, (2, 1))
    # compute the m-modes
    compute!(MModes, output, hierarchy, transposed_array, frequency; dϕ=dϕ)
end

function flag_mmodes!(measured, project, config)
    # flag m-modes that differ too much from a prediction
    path = Project.workspace(project)
    predicted = BPJSpec.load(joinpath(path, config.flagging_mmodes))
    _flag(measured, predicted) = _flag_mmodes(measured, predicted, config.flagging_threshold)
    output = ProgressBar(measured)
    @. output = _flag(measured, predicted)
end

function _flag_mmodes(measured, predicted, threshold)
    diff  = abs.(measured .- predicted)
    flags = (measured .== 0) .| (predicted .== 0)
    σ = median(diff[.!flags])
    flags .|= diff .> threshold*σ
    measured[flags] = 0
    measured
end

end

