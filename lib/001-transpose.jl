module Driver

using ProgressMeter
using TTCal
using BPJSpec
using Unitful
using YAML

include("Project.jl")

struct Config
    input  :: String
    output :: String
    metadata :: String
    polarization :: String
end

function load(file)
    dict = YAML.load(open(file))
    Config(dict["input"],
           dict["output"],
           dict["metadata"],
           get(dict, "polarization", "I"))
end

function go(project_file, config_file)
    project = Project.load(project_file)
    config  = load(config_file)
    transpose(project, config)
    Project.touch(project, config.output)
end

function transpose(project, config)
    path = Project.workspace(project)
    metadata = Project.load(project, config.metadata, "metadata")
    isdir(joinpath(path, config.output)) || mkpath(joinpath(path, config.output))

    ν  = metadata.frequencies
    Δν = fill(24u"kHz", length(ν))
    output = create(FBlockMatrix, MultipleFiles(joinpath(path, config.output)), ν, Δν)

    # Open all of the files
    input = BPJSpec.load(joinpath(path, config.input))
    temp_files = [open(joinpath(Project.temp(), @sprintf("%04d.temp", β)), "w+")
                        for β = 1:Nfreq(metadata)]
    #temp_files = [open(joinpath(path, config.output, @sprintf("%04d.temp", β)), "r")
    #                    for β = 1:Nfreq(metadata)]

    prg = Progress(Nfreq(metadata))
    for β = 1:Nfreq(metadata)
        write(temp_files[β], zeros(Complex128, Nbase(metadata), Ntime(metadata)))
        next!(prg)
    end

    prg = Progress(Ntime(metadata))
    for idx = 1:Ntime(metadata)
        _transpose(temp_files, input, idx, config.polarization)
        next!(prg)
    end
    normalize!(output, project, config, metadata)

    foreach(close, temp_files)
    for β = 1:Nfreq(metadata)
        rm(joinpath(Project.temp(), @sprintf("%04d.temp", β)), force=true)
    end
end

function _transpose(temp_files, input, idx, polarization)
    data = input[idx]
    for β = 1:length(temp_files)
        xx = view(data, 1, β, :)
        yy = view(data, 2, β, :)
        pack!(temp_files[β], xx, yy, idx, polarization)
    end
    nothing
end

function pack!(temp_file, xx, yy, idx, polarization)
    Nbase = length(xx)
    offset = Nbase*(idx-1)*sizeof(Complex128)
    if polarization == "I"
        output = 0.5 .* (xx .+ yy)
    elseif polarization == "xx"
        output = copy(xx)
    elseif polarization == "yy"
        output = copy(yy)
    else
        error("uknown polarization")
    end
    seek(temp_file, offset)
    write(temp_file, output)
    nothing
end

function normalize!(output, project, config, metadata)
    size = (Nbase(metadata), Ntime(metadata))
    path = joinpath(Project.workspace(project), config.output)

    queue = collect(1:Nfreq(metadata))
    pool  = CachingPool(workers())
    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))

    @sync for worker in workers()
        @async while length(queue) > 0
            frequency = shift!(queue)
            remotecall_wait(_normalize!, pool, output, path, size, frequency)
            increment()
        end
    end
end

function _normalize!(output, path, size, frequency)
    open(joinpath(Project.temp(), @sprintf("%04d.temp", frequency)), "r") do temp_file
        data = read(temp_file, Complex128, size)
        output[frequency] = data
        finalize(data)
    end
    nothing
end

end

