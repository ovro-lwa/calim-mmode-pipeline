module Driver

using CasaCore.Tables
using JLD2
using ProgressMeter
using TTCal

include("../../pipeline/lib/Common.jl");  using .Common
include("../../pipeline/lib/DADA2MS.jl"); using .DADA2MS

function getautos(spws::AbstractVector, name)
    for spw in spws
        getautos(spw, name)
    end
end

function getautos(spw::Integer, name)
    dadas = listdadas(spw, name)
    Ntime = length(dadas)
    Nfreq = 109
    autos = zeros(2, Nfreq, 256, Ntime)

    pool  = CachingPool(workers())
    queue = collect(1:Ntime)

    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))

    jldopen(joinpath(getdir(spw, name), "auto-correlations.jld2"), "w") do file
        metadata_list = Vector{TTCal.Metadata}(Ntime)
        @sync for worker in workers()
            @async while length(queue) > 0
                index = pop!(queue)
                _autos, _metadata = remotecall_fetch(_getautos, pool, name, dadas[index])
                autos[:, :, :, index] = _autos
                metadata_list[index]  = _metadata
                increment()
            end
        end
        master_metadata = metadata_list[1]
        for metadata in metadata_list[2:end]
            TTCal.merge!(master_metadata, metadata, axis=:time)
        end
        file["metadata"] = master_metadata
        for ant = 1:256
            file[@sprintf("%03d", 2ant-1)] = autos[1, :, ant, :]
            file[@sprintf("%03d", 2ant-0)] = autos[2, :, ant, :]
        end
    end
    nothing
end

function _getautos(name, dada)
    local autos, metadata
    try
        ms = dada2ms(dada, name)
        raw_data = ms["DATA"] :: Array{Complex128, 3}
        metadata = TTCal.Metadata(ms)
        autos = zeros(2, Nfreq(metadata), Nant(metadata))

        # find the auto-correlations
        α = 1
        keep = [true; false; false; true]
        for ant1 = 1:Nant(metadata), ant2 = ant1:Nant(metadata)
            if ant1 == ant2
                autos[:, :, ant1] = abs.(raw_data[keep, :, α])
            end
            α += 1
        end
        Tables.delete(ms)
    catch exception
        println(dada)
        println(exception)
        rethrow(exception)
    end
    autos, metadata
end

end

