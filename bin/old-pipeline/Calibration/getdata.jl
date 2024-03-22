function getdata_defaults(spw, dataset)
    dadas = listdadas(spw, dataset)
    getdata(spw, 50:60, 1:length(dadas), dataset)
end

function getdata_middle_channel(spw, dataset)
    dadas = listdadas(spw, dataset)
    getdata(spw, 55:55, 1:length(dadas), dataset)
end

function getdata(spw, channels, range, dataset)
    dadas = listdadas(spw, dataset)[range]
    Ntime = length(range)
    Nfreq = length(channels)
    meta  = getmeta(spw, dataset)
    meta.channels = meta.channels[channels]

    pool  = CachingPool(workers())
    queue = collect(1:Ntime)

    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))

    path = joinpath(getdir(spw), dataset)
    isdir(path) || mkpath(path)
    @show path
    jldopen(joinpath(path, "raw-visibilities.jld2"), "w") do file
        file["metadata"] = meta
        times = zeros(Ntime)
        @sync for worker in workers()
            @async while length(queue) > 0
                integration = pop!(queue)
                dada = dadas[integration]
                time, data = remotecall_fetch(getdata_do_the_work, pool, dataset, dada, channels)
                getdata_write_to_disk(file, integration, data)
                times[integration] = time
                increment()
            end
        end
        file["times"] = times
    end
    nothing
end

function getdata_write_to_disk(file, integration, data)
    objectname = @sprintf("%06d", integration)
    file[objectname] = data
end

function getdata_do_the_work(dataset, dada, channels)
    local time, output
    try
        ms, path = dada2ms(dada, dataset)
        data = ms["DATA"] :: Array{Complex128, 3}
        time = ms["TIME", 1] :: Float64
        # discard the xy and yx correlations because we don't really have the information to
        # calibrate them (no polarization calibration)
        keep = [true; false; false; true]
        output = data[keep, channels, :]
        Tables.delete(ms)
    catch exception
        # oops, something broke
        println(dada)
        println(exception)
        time   = NaN
        output = nothing
    end
    time, output
end

