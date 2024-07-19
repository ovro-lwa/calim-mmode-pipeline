module Driver

using BPJSpec
using CasaCore.Measures
using JLD2
using LibHealpix
using ProgressMeter
using TTCal
using Unitful, UnitfulAstro
using YAML

include("Project.jl")
include("Cleaning.jl"); using .Cleaning

struct Config
    input :: String
    inputpsf :: String
    observationmatrix :: String
    output :: String
    transfermatrix :: String
end

struct PSF
    pixels :: Vector{Int}
    peak   :: Vector{Float64}
    major  :: Vector{Float64}
    minor  :: Vector{Float64}
    angle  :: Vector{Float64}
end

struct State
    lmax  :: Int
    mmax  :: Int
    nside :: Int
    # unit vectors
    x :: RingHealpixMap{Float64}
    y :: RingHealpixMap{Float64}
    z :: RingHealpixMap{Float64}
    # residuals
    residual_alm :: Alm{Complex128}
    residual_map :: RingHealpixMap{Float64}
    degraded_alm :: Alm{Complex128}
    # clean components
    components :: RingHealpixMap{Float64} # current list of clean components
    mask       :: Vector{Int}             # mask for selecting clean components
    # additional information
    # * which worker owns which block of the observation matrix
    responsibilities :: Dict{Int, StepRange{Int, Int}}
    # * list of workers that are present locally (fast communication)
    local_workers    :: Vector{Int}
    # * convolution kernel for degrading the resolution
    gaussian_kernel  :: Alm{Complex128}
end

function load(file)
    dict = YAML.load(open(file))
    Config(
    dict["input"],
    dict["input-psf"],
    dict["input-observation-matrix"],
    dict["output"],
    dict["transfer-matrix"]
    )
end

function go(project_file, config_file)
    project = Project.load(project_file)
    config  = load(config_file)
    clean(project, config)
end

function clean(project, config)
    path = Project.workspace(project)
    clean_path = joinpath(path, "052-clean")
    isdir(clean_path) || mkdir(clean_path)

    local psf, lmax, mmax, nside
    jldopen(joinpath(path, config.inputpsf*".jld2"), "r") do file
        psf = PSF(file["pixels"], file["peak"], file["major"], file["minor"], file["angle"])
        lmax  = file["lmax"]
        mmax  = file["mmax"]
        nside = file["nside"]
    end

    local alm
    _alm = Project.load(project, config.input, "alm")
    lmax = mmax = _alm.mmax
    alm = Alm(Complex128, lmax, mmax)
    for m = 1:lmax, l = m:mmax
        @lm alm[l, m] = _alm[m][l - m + 1]
    end

    println("* Loading the observation matrix")
    responsibilities = distribute_responsibilities(mmax)
    @time load_observation_matrix(path, config, responsibilities)

    println("* Removing the diffuse emission")
    @time gaussian_kernel = gaussian_alm(1, alm.lmax, alm.mmax)
    @time degraded_alm = convolve(alm, gaussian_kernel)
    @time degraded_map = alm2map(degraded_alm, 2048)
    @time residual_alm = alm - degraded_alm
    @time residual_map = alm2map(residual_alm, nside)
    writehealpix(joinpath(clean_path, "diffuse-component.fits"),  degraded_map, replace=true)
    writehealpix(joinpath(clean_path, "starting-residuals.fits"), residual_map, replace=true)

    println("* Starting the cleaning procedure")
    @time x, y, z = unit_vectors(nside)
    @time mask = create_mask(x, y, z)
    components = RingHealpixMap(Float64, nside)
    state = State(lmax, mmax, nside, x, y, z,
                  residual_alm, residual_map, degraded_alm,
                  components, mask, responsibilities, local_workers(), gaussian_kernel)

    #file = jldopen(joinpath(path, "052-clean", "state-01024.jld2"), "r")
    #state = State(lmax, mmax, nside, x, y, z,
    #              file["residual_alm"], alm2map(file["residual_alm"], nside), file["degraded_alm"],
    #              file["components"], file["mask"], responsibilities, local_workers(), gaussian_kernel)
    #close(file)
    
    major_iterations = 4096
    minor_iterations = 1024
    _clean(state, psf, major_iterations, minor_iterations, clean_path)
end

function _clean(state, psf, major_iterations, minor_iterations, path)
    for iter = 1:major_iterations
        println("================")
        @printf("Iteration #%05d\n", iter)
        println("time = ", now())
        println("stddev = ", std(state.residual_map[state.mask]))
        println("mean = ", mean(state.residual_map[state.mask]))
        pixels = major_iteration!(state, psf, minor_iterations)
        mod(iter, 64) == 0 && in_progress_output(state, path, iter, pixels)
    end
end

function in_progress_output(state, path, iter, pixels)
    println("...writing maps...")
    iterstr = @sprintf("%05d", iter)
    filename = "residual-map-$iterstr.fits"
    writehealpix(joinpath(path, filename), state.residual_map, replace=true)
    filename = "clean-components-$iterstr.fits"
    writehealpix(joinpath(path, filename), state.components, replace=true)
    filename = "degraded-map-$iterstr.fits"
    degraded_map = alm2map(state.degraded_alm, state.nside)
    writehealpix(joinpath(path, filename), degraded_map, replace=true)
    jldopen(joinpath(path, "state-$iterstr.jld2"), "w") do file
        file["residual_alm"] = state.residual_alm
        file["degraded_alm"] = state.degraded_alm
        file["components"]   = state.components
        file["mask"]         = state.mask
        file["component_pixels_ind"] = pixels
    end
end

function major_iteration!(state, psf, minor_iterations)
    println("* selecting pixels")
    @time pixels = select_pixels(state, minor_iterations)
    println("* computing spherical harmonics")
    @time alm = compute_spherical_harmonics(state, psf, pixels)
    model_map = alm2map(alm, 2048)
    #writehealpix("/lustre/xhall/workspace/73MHz_solstice/2017-rainy-day-power-spectrum/052-clean/model_map.fits", model_map, replace=true)
    println("* corrupting spherical harmonics")
    @time alm = corrupt_spherical_harmonics(state, alm)
    corrputed_map = alm2map(alm, 2048)
    #writehealpix("/lustre/xhall/workspace/73MHz_solstice/2017-rainy-day-power-spectrum/052-clean/corrputed_map.fits", corrputed_map, replace=true)
    println("* removing clean components")
    @time remove_clean_components!(state, alm)
    return pixels
end

function create_mask(x, y, z)
    N = length(x)
    mask = RingHealpixMap(Bool, x.nside)
    for pixel = 1:N
        declination = acosd(z[pixel])
        if declination > -30
            mask[pixel] = true
        else
            mask[pixel] = false
        end
    end
    pixels = collect(1:N)
    pixels[mask]
end

function select_pixels(state, minor_iterations)
    select_pixels(state.residual_map, state.mask, state.x, state.y, state.z, minor_iterations)
end

function select_pixels(residual_map, mask, x, y, z, minor_iterations)
    #println("Write Map Check")
    #writehealpix(joinpath("/lustre/xhall/workspace/73MHz_solstice/2017-rainy-day-power-spectrum/052-clean", "starting-residuals-select-pixels.fits"), residual_map, replace=true)
    
    N = length(residual_map)
    values = abs2.(residual_map[mask])
    order  = sortperm(values)
    pixels = mask[order]
    selected = Int[]
    while length(selected) < minor_iterations
        @label top
        # take the pixel with the largest absolute value
        pixel = pop!(pixels)
        # verify we're not too close to other already selected pixels
        for other in selected
            dotproduct = x[pixel]*x[other] + y[pixel]*y[other] + z[pixel]*z[other]
            # in rare cases it seems like this dot product can fall just outside of the domain
            # of acos due to floating point precision, so we will clamp the result to ensure
            # that we don't get a DomainError
            dotproduct = clamp(dotproduct, -1, 1)
            distance = acosd(dotproduct)
            distance < 3 && @goto top
        end
        push!(selected, pixel)
    end
    sort!(selected)
end

function compute_spherical_harmonics(state, psf, pixels)
    compute_spherical_harmonics(state.residual_alm, state.residual_map,
                                state.components, psf, pixels, state.local_workers)
end

function compute_spherical_harmonics(residual_alm, residual_map,
                                     components, psf, pixels, local_workers)
    lmax  = residual_alm.lmax
    mmax  = residual_alm.mmax
    nside = residual_map.nside

    getring(pixel) = searchsortedlast(psf.pixels, pixel)
    fluxes = residual_map[pixels]
    peaks  = psf.peak[getring.(pixels)]
    scales = 0.15 .* fluxes ./ peaks
    components[pixels] .+= scales

    model = Alm(Complex128, lmax, mmax)
    function add(alm)
        model .+= alm
    end

    N = length(local_workers)
    @sync for (idx, worker) in enumerate(local_workers)
        @async begin
            my_pixels = pixels[idx:N:end]
            my_scales = scales[idx:N:end]
            alm = remotecall_fetch(compute_spherical_harmonics_worker, worker,
                                   lmax, mmax, nside, my_pixels, my_scales)
            add(alm)
        end
    end

    model
end

function compute_spherical_harmonics_worker(lmax, mmax, nside, pixels, scales)
    alm = Alm(Complex128, lmax, mmax)
    for (pixel, scale) in zip(pixels, scales)
        θ, ϕ = LibHealpix.pix2ang_ring(nside, pixel)
        alm .+= scale .* pointsource_alm(θ, ϕ, lmax, mmax)
    end
    alm
end

function corrupt_spherical_harmonics(state, alm)
    observe_og!(alm, state.responsibilities)
end

function remove_clean_components!(state, corrupted_alm)
    remove_clean_components!(state.residual_alm, state.degraded_alm,
                             state.gaussian_kernel, corrupted_alm,
                             state.residual_map)
end

function remove_clean_components!(residual_alm, degraded_alm,
                                  gaussian_kernel, corrupted_alm,
                                  residual_map)
    degraded_corrupted_alm = convolve(corrupted_alm, gaussian_kernel)
    residual_corrupted_alm = corrupted_alm - degraded_corrupted_alm
    residual_alm .-= residual_corrupted_alm
    degraded_alm .-= degraded_corrupted_alm
    residual_map .= alm2map(residual_alm, residual_map.nside)
end

end