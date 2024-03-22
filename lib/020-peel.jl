module Driver

using CasaCore.Measures
using JLD2
using ProgressMeter
using BPJSpec
using TTCal
using YAML

include("Project.jl")
include("WSClean.jl")
include("TTCalDatasets.jl")
using .TTCalDatasets

struct Strategy
    category          :: String
    minimum_elevation :: Float64
    minimum_flux      :: Float64
end

struct Config
    input    :: String
    output   :: String
    output_residuals :: String
    metadata :: String
    skymodel :: String
    strategy :: Dict{String, Strategy}
end

function load(file)
    dict = YAML.load(open(file))
    strategy = Dict{String, Strategy}()
    for (source, _strategy) in dict["strategy"]
        strategy[source] = Strategy(_strategy["category"],
                                    get(_strategy, "minimum-elevation", 0.0),
                                    get(_strategy, "minimum-flux", 0.0))
    end
    Config(dict["input"],
           dict["output"],
           dict["output-residuals"],
           dict["metadata"],
           joinpath(dirname(file), dict["sky-model"]),
           strategy)
end

function go(project_file, config_file; integration=0, what=false)
    project = Project.load(project_file)
    config  = load(config_file)
    if what
        what_did_peeling_remove(project, config, integration)
    else
        if integration == 0
            peel(project, config)
        else
            test(project, config, integration)
        end
    end
end

function peel(project, config)
    Project.set_stripe_count(project, config.output, 1)
    path = Project.workspace(project)
    sky  = readsky(config.skymodel)
    input    = BPJSpec.load(joinpath(path, config.input))
    output   = similar(input, MultipleFiles(joinpath(path, config.output)))
    metadata = Project.load(project, config.metadata, "metadata")

    residuals = Dict(source.name => zeros(Nfreq(metadata), Ntime(metadata))
                     for source in sky.sources)

    pool  = CachingPool(workers())
    queue = collect(1:Ntime(metadata))
    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))

    function closure(index)
        peel_and_measure_residuals!(input, output, metadata, sky, config, index)
    end
    @sync for worker in workers()
        @async while length(queue) > 0
            index = shift!(queue)
            _residuals = remotecall_fetch(closure, pool, index)
            fill_in_residuals!(residuals, _residuals, index)
            increment()
        end
    end

    Project.save(project, config.output_residuals, "residuals", residuals)
end

function test(project, config, integration)
    path = Project.workspace(project)
    sky  = readsky(config.skymodel)
    input    = BPJSpec.load(joinpath(path, config.input))
    metadata = Project.load(project, config.metadata, "metadata")
    wsclean  = WSClean.Config("uniform", 0.0, 8)

    println("# no source removal")
    dataset = peel_dry_run!(input, metadata, sky, config, integration;
                            dopeeling=false, dosubtraction=false, istest=true)
    WSClean.run(wsclean, dataset,
                joinpath(path, "tmp", @sprintf("peeling-test-%05d-1", integration)),
                mspath=joinpath(path, "tmp", @sprintf("peeling-test-%05d-1.ms", integration)),
                deletems=false)

    println("# only peeling")
    dataset = peel_dry_run!(input, metadata, sky, config, integration;
                            dopeeling=true, dosubtraction=false, istest=true)
    WSClean.run(wsclean, dataset,
                joinpath(path, "tmp", @sprintf("peeling-test-%05d-2", integration)),
                mspath=joinpath(path, "tmp", @sprintf("peeling-test-%05d-2.ms", integration)),
                deletems=false)

    println("# full source removal")
    dataset = peel_dry_run!(input, metadata, sky, config, integration;
                            dopeeling=true, dosubtraction=true, istest=true)
    WSClean.run(wsclean, dataset,
                joinpath(path, "tmp", @sprintf("peeling-test-%05d-3", integration)),
                mspath=joinpath(path, "tmp", @sprintf("peeling-test-%05d-3.ms", integration)),
                deletems=false)
end

function what_did_peeling_remove(project, config, integration)
    path = Project.workspace(project)
    sky  = readsky(config.skymodel)
    input    = BPJSpec.load(joinpath(path, config.input))
    metadata = Project.load(project, config.metadata, "metadata")
    wsclean  = WSClean.Config("uniform", 0.0, 8)

    # Run a copy of the peeling routine
    array = input[integration]
    T = size(array, 1) == 2 ? TTCal.Dual : TTCal.Full
    dataset = array_to_ttcal(array, metadata, integration, T)
    frame    = ReferenceFrame(dataset.metadata)
    @show getfield.(sky.sources, :name)
    filter!(sky.sources) do source
        TTCal.isabovehorizon(frame, source)
    end
    @show getfield.(sky.sources, :name)
    measure_sky!(sky, dataset)
    @show getfield.(sky.sources, :name)
    bright, medium, faint = partition(dataset.metadata, config, sky)

    (print("1: "); foreach(s->print(s.name, ", "), bright.sources); println())
    (print("2: "); foreach(s->print(s.name, ", "), medium.sources); println())
    (print("3: "); foreach(s->print(s.name, ", "),  faint.sources); println())

    subtract!(dataset, medium)
    calibrations = peel!(dataset, bright, true)
    add!(dataset, medium)

    println("Imaging")
    basename = @sprintf("peeling-residuals-%05d", integration)
    @time WSClean.run(wsclean, dataset, joinpath(path, "tmp", basename))
    for (calibration, source) in zip(calibrations, bright.sources)
        println("* ", source.name)
        @time model = genvis(dataset.metadata, TTCal.ConstantBeam(), source,
                             polarization=TTCal.Dual)
        @time TTCal.corrupt!(model, calibration)
        @time WSClean.run(wsclean, model, joinpath(path, "tmp", basename*"-"*source.name))
    end
end

function fill_in_residuals!(residuals, _residuals, index)
    for name in keys(_residuals)
        residuals[name][:, index] = _residuals[name]
    end
end

function peel_and_measure_residuals!(input, output, metadata, sky, config, index)
    # TODO: before-after residuals? position measuring???
    result = peel_dry_run!(input, metadata, sky, config, index)
    output[index] =  ttcal_to_array(result)#convert(Array{Complex{Float32},3}, ttcal_to_array(result))
    residuals = Dict(source.name => getfield.(TTCal.getspec(result, source), :I)
                     for source in sky.sources)
    residuals
end

function peel_dry_run!(input, metadata, sky, config, index;
                       dopeeling=true, dosubtraction=true, istest=false)
    array = input[index]
    T = size(array, 1) == 2 ? TTCal.Dual : TTCal.Full
    dataset = array_to_ttcal(array, metadata, index, T)
    if !all(array .== 0)
        do_the_source_removal!(dataset, sky, config, dopeeling, dosubtraction, istest)
    end
    dataset
end

function do_the_source_removal!(dataset, sky, config, dopeeling, dosubtraction, istest)
    sky = deepcopy(sky) # don't modify the user's copy of `sky`
    frame = ReferenceFrame(dataset.metadata)
    filter!(sky.sources) do source
        TTCal.isabovehorizon(frame, source)
    end
    measure_sky!(sky, dataset)
    bright, medium, faint = partition(dataset.metadata, config, sky)
    istest && (print("1: "); foreach(s->print(s.name, ", "), bright.sources); println())
    istest && (print("2: "); foreach(s->print(s.name, ", "), medium.sources); println())
    istest && (print("3: "); foreach(s->print(s.name, ", "),  faint.sources); println())

    # peel bright sources
    if dopeeling
        subtract!(dataset, medium)
        calibrations = peel!(dataset, bright, istest)
        add!(dataset, medium)

        # check to see if peeled sources were actually peeled
        #for (source, calibration) in zip(bright.sources, calibrations)
        #    model = genvis(dataset.metadata, TTCal.ConstantBeam(), source, polarization=TTCal.Dual)
        #    flux  = TTCal.getflux(model, source).I
        #    TTCal.corrupt!(model, calibration)
        #    flux′ = TTCal.getflux(model, source).I
        #    if abs(flux - flux′) > 0.1abs(flux)
        #        TTCal.add!(dataset, model)
        #        push!(medium.sources, source)
        #    end
        #end
    end

    if dosubtraction
        # subtract medium sources
        measure_sky!(medium, dataset)
        subtract!(dataset, medium)

        # subtract faint sources
        measure_sky!(faint, dataset)
        subtract!(dataset, faint)
    end

    #residuals = Dict(source.name => getfield.(TTCal.getspec(result, source), :I)
    #                 for source in sky.sources)
    if istest
        # IMPORTANT
        # TTCal doesn't yet account for flagged channels in its flux calculation. At the moment
        # flagged channels essentially vote for zero flux, so this function will underestimate the
        # amount of flux a source has. This is acceptable for now because this is just debug output,
        # but Michael should really fix this. Elsewhere we're using the `mean_no_zero` function to
        # circumvent it.
        residuals = Dict(source.name => TTCal.getflux(dataset, source).I
                         for source in sky.sources)
        @show residuals
    end

    dataset
end

function measure_sky!(sky::TTCal.SkyModel, dataset)
    N = length(sky.sources)
    for idx = 1:N
        source = sky.sources[idx]
        # fit for position
        source = fitvis(dataset, source)
        # fit for flux
        measured_spectrum = getspec(dataset, source)
        model_spectrum = TTCal.total_flux.(source, dataset.metadata.frequencies)
        scale = mean_no_zero(a.I / b.I for (a, b) in zip(measured_spectrum, model_spectrum))
        source = scale*source
        sky.sources[idx] = source
    end
end

function mean_no_zero(data)
    S = sum(data)
    C = mapreduce(iszero, +, data)
    L = length(data)
    ifelse(L == C, zero(typeof(S)), S / (L - C))
end

function add!(dataset, sky)
    if length(sky.sources) > 0
        model = genvis(dataset.metadata, TTCal.ConstantBeam(), sky, polarization=TTCal.Dual)
        TTCal.add!(dataset, model)
    end
end

function subtract!(dataset, sky)
    if length(sky.sources) > 0
        model = genvis(dataset.metadata, TTCal.ConstantBeam(), sky, polarization=TTCal.Dual)
        TTCal.subtract!(dataset, model)
    end
end

function peel!(dataset, sky, istest)
    if length(sky.sources) > 0
        calibrations = TTCal.peel!(dataset, TTCal.ConstantBeam(), sky, quiet=!istest,
                                   collapse_frequency=false)
    else
        calibrations = TTCal.Calibration[]
    end
    calibrations
end

function categorize(strategy, frame, metadata, source)
    my_strategy = strategy[source.name]
    if my_strategy.category == "bright"
        return categorize_bright(my_strategy, frame, metadata, source)
    elseif my_strategy.category == "faint"
        return categorize_faint(my_strategy, frame, metadata, source)
    elseif my_strategy.category == "skip"
        return "skip", 0.0
    else
        error("no categorization strategy for ($(my_strategy.category))")
    end
end

function categorize_bright(strategy, frame, metadata, source)
    flux = TTCal.total_flux.(source, metadata.frequencies) |> mean
    any_flux  = flux.I ≥ 30
    high_flux = flux.I ≥ strategy.minimum_flux
    high_elevation = TTCal.isabovehorizon(frame, source,
                                          threshold=deg2rad(strategy.minimum_elevation))
    if high_elevation && high_flux
        return "bright", flux.I
    elseif any_flux
        return "medium", flux.I
    else
        return "skip", flux.I
    end
end

function categorize_faint(strategy, frame, metadata, source)
    flux = TTCal.total_flux.(source, metadata.frequencies) |> mean
    any_flux  = flux.I ≥ 30
    high_flux = flux.I ≥ strategy.minimum_flux
    high_elevation = TTCal.isabovehorizon(frame, source,
                                          threshold=deg2rad(strategy.minimum_elevation))
    if high_elevation && high_flux
        return "medium", flux.I
    elseif any_flux
        return "faint", flux.I
    else
        return "skip", flux.I
    end
end

function partition(metadata, config, sky)
    # We have three categories for how sources are removed:
    #  1) peel them (for very bright sources)
    #  2) subtract them before peeling (for sources in the middle)
    #  3) subtract them after peeling (for faint sources)
    # The second category is important because reasonably bright sources can interfere with the
    # peeling process if the flux of the two sources is comparable. For example, Cas A near the
    # horizon can create problems for trying to peel Vir A.
    bright = Int[]
    medium = Int[]
    faint  = Int[]
    bright_flux = Float64[]
    medium_flux = Float64[]
    faint_flux  = Float64[]
    frame = ReferenceFrame(metadata)
    N = length(sky.sources)
    for idx = 1:N
        source = sky.sources[idx]
        category, flux = categorize(config.strategy, frame, metadata, source)
        if category == "bright"
            push!(bright, idx)
            push!(bright_flux, flux)
        elseif category == "medium"
            push!(medium, idx)
            push!(medium_flux, flux)
        elseif category == "faint"
            push!(faint, idx)
            push!(faint_flux, flux)
        elseif category == "skip"
            # skip this source
        else
            error("unknown category ($category)")
        end
    end

    # Upgrade sources between categories if they are brighter than the faintest source in the above
    # category.
    if length(bright_flux) > 0
        move = medium_flux .> minimum(bright_flux)
        append!(bright,      medium[move])
        append!(bright_flux, medium_flux[move])
        medium      = medium[.!move]
        medium_flux = medium_flux[.!move]
    end

    if length(medium_flux) > 0
        move = faint_flux .> minimum(medium_flux)
        append!(medium,      faint[move])
        append!(medium_flux, faint_flux[move])
        faint      = faint[.!move]
        faint_flux = faint_flux[.!move]
    end

    # Downgrade bright sources that are much fainter than the brightest source (this can cause
    # problems for peeling).
    if length(bright_flux) > 0
        move = 10 .* bright_flux .< maximum(bright_flux)
        append!(medium,      bright[move])
        append!(medium_flux, bright_flux[move])
        bright      = bright[.!move]
        bright_flux = bright_flux[.!move]
    end

    # Sort the bright sources in order of decreasing flux (this will determine the order in which
    # they are peeled).
    order = sortperm(bright_flux, rev=true)
    bright      = bright[order]
    bright_flux = bright_flux[order]

    bright_sky = TTCal.SkyModel(sky.sources[bright])
    medium_sky = TTCal.SkyModel(sky.sources[medium])
    faint_sky  = TTCal.SkyModel(sky.sources[faint])
    bright_sky, medium_sky, faint_sky
end

end

