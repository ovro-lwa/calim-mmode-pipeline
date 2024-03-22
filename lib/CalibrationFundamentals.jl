# This module contains code that is shared between 003-calibrate.jl and 041-recalibrate.jl
module CalibrationFundamentals

export read_raw_visibilities
export create_test_image
export apply_the_calibration

using BPJSpec
using TTCal
using ProgressMeter

using ..Project
using ..TTCalDatasets
using ..WSClean
using ..CreateMeasurementSet

function read_raw_visibilities(input, metadata, channels, integrations)
    TTCal.slice!(metadata, integrations, axis=:time)
    TTCal.slice!(metadata, channels,     axis=:frequency)
    dataset = TTCal.Dataset(metadata, polarization=TTCal.Dual)
    for (i, j) in enumerate(integrations)
        array_to_ttcal!(dataset, input[j], channels, i, TTCal.Dual)
    end
    dataset
end

function create_test_image(project, wsclean, config, calibration)
    myindex = round(Int, middle(config.integrations))
    println("Creating a sample test image ($myindex)")
    path = Project.workspace(project)
    metadata = Project.load(project, config.metadata, "metadata")
    input = BPJSpec.load(joinpath(path, config.input))
    array = input[myindex]
    T = size(array, 1) == 2 ? TTCal.Dual : TTCal.Full
    dataset = array_to_ttcal(array, metadata, myindex, T)
    applycal!(dataset, calibration)
    ms = CreateMeasurementSet.create(dataset, joinpath(path, config.test_image*".ms"))
    WSClean.run(wsclean, ms, joinpath(path, config.test_image))
end

function apply_the_calibration(project, config, calibration)
    path = Project.workspace(project)
    Project.set_stripe_count(project, config.output, 1)
    metadata = Project.load(project, config.metadata, "metadata")
    input  = BPJSpec.load(joinpath(path, config.input))
    output = create(BPJSpec.SimpleBlockArray{Complex128, 3},
                    MultipleFiles(joinpath(path, config.output)), Ntime(metadata))
    
    queue = collect(1:Ntime(metadata))
    pool  = CachingPool(workers())
    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))

    @sync for worker in workers()
        @async while length(queue) > 0
            index = shift!(queue)
            remotecall_wait(_apply_the_calibration, pool,
                            input, output, metadata, calibration, index)
            increment()
        end
    end
end

function _apply_the_calibration(input, output, metadata, calibration, index)
    array = input[index]
    T = size(array, 1) == 2 ? TTCal.Dual : TTCal.Full
    dataset = array_to_ttcal(array, metadata, index, T)
    applycal!(dataset, calibration)
    output[index] = ttcal_to_array(dataset)
end

end

