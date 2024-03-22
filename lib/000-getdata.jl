module Driver

using CasaCore.Tables
using CasaCore.Measures
using JLD2
using ProgressMeter
using TTCal
using BPJSpec
using YAML

include("Project.jl")
include("DADA2MS.jl")

struct Config
    output          :: String
    output_metadata :: String
    subbands        :: Dict{Int, Vector{Int}}
    times           :: Vector{Int}
    keep            :: Vector{Bool} # which polarizations to keep
    accumulate      :: Bool # whether to accumulate the visibilities (time smearing)
end

function load(file, dada2ms)
    dict = YAML.load(open(file))
    subbands = Dict{Int, Vector{Int}}()
    for (key, value) in dict["subbands"]
        subband = key
        if value == "all"
            subbands[subband] = collect(1:192)
        elseif value isa Int
            subbands[subband] = [value]
        else
            subbands[subband] = value
        end
        # load the list of files for each subband
        DADA2MS.load!(dada2ms, subband)
    end
    if haskey(dict, "times")
        if dict["times"] isa AbstractString
            endpoints = parse.(Int, split(dict["times"], ":"))
            times = collect(endpoints[1]:endpoints[2])
        else
            times = dict["times"]
        end
    else
        times = collect(1:DADA2MS.number(dada2ms))
    end
    keep  = get(dict, "pol", [true, false, false, true]) #xx, xy? ,yx? , yy
    accumulate = get(dict, "accumulate", false)
    Config(dict["output"], dict["output_metadata"], subbands, times, keep, accumulate)
end

function go(project_file, dada2ms_file, config_file)
    project = Project.load(project_file)
    dada2ms = DADA2MS.load(dada2ms_file)
    config  = load(config_file, dada2ms)
    if config.accumulate
        getdata_accumulate(project, dada2ms, config)
    else
        getdata(project, dada2ms, config)
    end
    Project.touch(project, config.output)
end

function getdata(project, dada2ms, config)
    queue = collect(1:length(config.times))
    pool  = CachingPool(workers())
    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))

    path = Project.workspace(project)
    Project.set_stripe_count(project, config.output, 1)
    output = create(BPJSpec.SimpleBlockArray{Complex128, 3},
                    MultipleFiles(joinpath(path, config.output)), length(queue))
    metadata = Vector{TTCal.Metadata}(length(queue))

    @sync for worker in workers()
        @async while length(queue) > 0
            index = shift!(queue)
            time  = config.times[index]
            _metadata = remotecall_fetch(getdata!, pool, output, dada2ms, config, index, time)
            metadata[index] = _metadata
            increment()
        end
    end

    master_metadata = metadata[1]
    for _metadata in metadata[2:end]
        TTCal.merge!(master_metadata, _metadata, axis=:time)
    end
    Project.save(project, config.output_metadata, "metadata", master_metadata)

    nothing
end

function getdata!(output, dada2ms, config, index, time)
    data, metadata = internal_getdata(dada2ms, config, time)
    output[index] = data
    metadata
end

function getdata_accumulate(project, dada2ms, config)
    warn("accumulating visibilities by averaging over time")

    queue = collect(1:length(config.times))
    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))

    path = Project.workspace(project)
    data, metadata = internal_getdata(dada2ms, config, shift!(queue))
    increment()

    @sync for worker in workers()
        @async while length(queue) > 0
            input  = RemoteChannel()
            output = RemoteChannel()
            remotecall(getdata_accumulate_remote_processing_loop, worker,
                       input, output, dada2ms, config, size(data))

            try
                while length(queue) > 0
                    put!(input, shift!(queue))
                    take!(output) # wait for the operation to finish
                    increment()
                end
            finally
                put!(input, 0)
                data .+= take!(output)
            end
        end
    end

    Project.save(project, config.output, "data", data)
    Project.save(project, config.output_metadata, "metadata", metadata)

    nothing
end

function getdata_accumulate_remote_processing_loop(input, output, dada2ms, config, size)
    data = zeros(Complex128, size)
    while true
        idx = take!(input)
        if idx == 0
            put!(output, data)
            break
        else
            data .+= internal_getdata(dada2ms, config, idx)[1]
            put!(output, nothing)
        end
    end
end

function internal_getdata(dada2ms, config, index)
    subbands = sort(collect(keys(config.subbands)))
    data, metadata = get_data(dada2ms, config, first(subbands), index)
    for subband in subbands[2:end]
        _data, _metadata = get_data(dada2ms, config, subband, index)
        data = cat(2, data, _data)
        TTCal.merge!(metadata, _metadata, axis=:frequency)
    end
    data, metadata
end

function get_data(dada2ms, config, subband, index)
    channels = config.subbands[subband]
    ms = DADA2MS.run(dada2ms, subband, index)
    raw_data = convert(Array{Complex{Float64},3},ms["CORRECTED_DATA"] :: Array{Complex64, 3})
    metadata = TTCal.Metadata(ms)
    TTCal.slice!(metadata, channels, axis=:frequency)
    data = raw_data[config.keep, channels, :]
    data, metadata
end

##function internal_getdata(dada2ms, config, index)
##    subbands = sort(collect(keys(config.subbands)))
##    data, metadata = run_dada2ms(dada2ms, config, first(subbands), index)
##    for subband in subbands[2:end]
##        _data, _metadata = run_dada2ms(dada2ms, config, subband, index)
##        data = cat(2, data, _data)
##        TTCal.merge!(metadata, _metadata, axis=:frequency)
##    end
##    data, metadata
##end
##
##function run_dada2ms(dada2ms, config, subband, index)
##    channels = config.subbands[subband]
##    ms = DADA2MS.run(dada2ms, subband, index)
##    raw_data = ms["DATA"] :: Array{Complex128, 3}
##    metadata = TTCal.Metadata(ms)
##    TTCal.slice!(metadata, channels, axis=:frequency)
##    data = raw_data[config.keep, channels, :]
##    Tables.delete(ms)
##    data, metadata
##end

end

