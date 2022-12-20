module Driver

using CasaCore.Tables
using CasaCore.Measures
using FileIO, JLD2
using ProgressMeter
using BPJSpec
using TTCal
using Unitful
using YAML

include("Project.jl")
include("CreateMeasurementSet.jl")
include("WSClean.jl")
include("TTCalDatasets.jl")
using .TTCalDatasets

struct Config
    input      :: String
    output_measurement_set :: String
    output_coherencies     :: String
    metadata   :: String
    components :: Int
end

function load(file)
    dict = YAML.load(open(file))
    Config(dict["input"],
           dict["output-measurement-set"],
           dict["output-coherencies"],
           dict["metadata"],
           dict["components"])
end

function go(project_file, wsclean_file, config_file)
    wsclean = WSClean.load(wsclean_file)
    project = Project.load(project_file)
    config  = load(config_file)
    fitrfi(project, wsclean, config)
end

function fitrfi(project, wsclean, config)
    path = Project.workspace(project)
    dataset = smear(project, config)
    ms = CreateMeasurementSet.create(dataset, joinpath(path, config.output_measurement_set*".ms"))
    #ms = Tables.open(joinpath(path, config.output_measurement_set*".ms"), write=true)
    #dataset = TTCal.Dataset(ms)
    residuals, coherencies = peel(dataset, config.components)

    # Image each of the removed components
    for (idx, coherency) in enumerate(coherencies)
        TTCal.write(ms, coherency, column="CORRECTED_DATA")
        try
            WSClean.run(wsclean, ms, joinpath(path, config.output_measurement_set*"-component-$idx"))
        catch
        end
        Tables.open(ms, write=true)
    end

    # Image the residuals
    TTCal.write(ms, residuals, column="CORRECTED_DATA")
    try
        WSClean.run(wsclean, ms, joinpath(path, config.output_measurement_set*"-residuals"))
    catch
    end

    Project.save(project, config.output_coherencies, "coherencies", coherencies)
    Tables.close(ms)
end

function smear(project, config)
    path = Project.workspace(project)
    metadata = Project.load(project, config.metadata, "metadata")
    visibilities = BPJSpec.load(joinpath(path, config.input))
    accumulation = zeros(Complex128, 2, Nfreq(metadata), Nbase(metadata))

    queue = collect(1:Ntime(metadata))
    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))

    @sync for worker in workers()
        @async begin
            input = RemoteChannel()
            future = remotecall(remote_worker_loop, worker, input, metadata, visibilities)
            try
                while length(queue) > 0
                    integration = shift!(queue)
                    put!(input, integration)
                    increment()
                end
            finally
                put!(input, 0)
            end
            _accumulation = fetch(future) :: Array{Complex128, 3}
            accumulation .+= _accumulation
        end
    end
    accumulation ./= Ntime(metadata)
    array_to_ttcal(accumulation, metadata, 1, TTCal.Dual)
end

function remote_worker_loop(input, metadata, visibilities)
    output = zeros(Complex128, 2, Nfreq(metadata), Nbase(metadata))
    while true
        integration = take!(input) :: Int
        integration == 0 && break
        output .+= visibilities[integration]
    end
    output
end

function peel(dataset, N)
    zenith = Direction(dir"AZEL", 0u"°", 90u"°")
    flat   = TTCal.PowerLaw(1, 0, 0, 0, 10u"MHz", [0.0])
    dummy  = TTCal.Source("dummy", TTCal.Point(zenith, flat))
    sky = TTCal.SkyModel(fill(dummy, N))
    residuals = deepcopy(dataset)
    calibrations = TTCal.peel!(residuals, TTCal.ConstantBeam(), sky, quiet=false)
    coherencies  = compute_coherencies(dataset.metadata, sky, calibrations)
    residuals, coherencies
end

function compute_coherencies(metadata, sky, calibrations)
    function f(s, c)
        coherency = genvis(metadata, TTCal.ConstantBeam(), s, polarization=TTCal.Dual)
        TTCal.corrupt!(coherency, c)
    end
    f.(sky.sources, calibrations)
end

end

