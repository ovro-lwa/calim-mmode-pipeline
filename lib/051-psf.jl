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
    inputalm :: String
    observationmatrix :: String
    output :: String
    metadata :: String
end

function load(file)
    dict = YAML.load(open(file))
    Config(
    dict["input"],
    dict["input-alm"],
    dict["input-observation-matrix"],
    dict["output"],
    dict["metadata"],
    )
end

function go(project_file, config_file)
    println(config_file)
    project = Project.load(project_file)
    config  = load(config_file)
    psf(project, config)
end

function psf(project, config)
    local lmax, mmax
    path = Project.workspace(project)
    alm = Project.load(project, config.input, "alm")
    metadata = Project.load(project, config.metadata, "metadata")
    lmax = mmax = alm.mmax
    nside = 2048
    pixels, peak, major, minor, angle = compute(project, metadata, lmax, mmax, config, nside)
    jldopen(joinpath(path, config.output*".jld2"), "w") do file
        file["lmax"]   = lmax
        file["mmax"]   = mmax
        file["nside"]  = nside
        file["pixels"] = pixels
        file["peak"]   = peak
        file["major"]  = major
        file["minor"]  = minor
        file["angle"]  = angle
    end
end

function compute(project, metadata, lmax, mmax, config, nside)
    pixels = find_healpix_rings(nside)
    responsibilities = distribute_responsibilities(mmax)
    @time load_observation_matrix(Project.workspace(project), config, responsibilities)

    N = length(pixels)
    peak  = zeros(N)
    major = zeros(N)
    minor = zeros(N)
    angle = zeros(N)

    prg = Progress(N)
    for idx = 1:N
        pixel = pixels[idx]
        θ, ϕ = LibHealpix.pix2ang_ring(nside, pixel)
        alm = psf_alm(θ, ϕ, lmax, mmax, responsibilities)
        map = alm2map(alm, nside)
        peak[idx], major[idx], minor[idx], angle[idx] = psf_properties(map, pixel)
        next!(prg)
    end

    pixels, peak, major, minor, angle
end

function create_map(alm::MBlockVector, metadata, nside)
    lmax = mmax = alm.mmax
    _alm = Alm(Complex128, lmax, mmax)
    for m = 1:lmax
        block = alm[m]
        for l = m:mmax
            @lm _alm[l, m] = block[l - m + 1]
        end
    end
    alm2map(_alm, nside)
end

function psf_alm(θ, ϕ, lmax, mmax, responsibilities)
    alm = pointsource_alm(θ, ϕ, lmax, mmax)
    observe_og!(alm, responsibilities)
    alm
end

function psf_properties(map, pixel; extent=1)
    vec = LibHealpix.pix2vec_ring(map.nside, pixel)
    img = postage_stamp(map, pixel; extent=extent)

    # Compute the peak value of the PSF
    peak = map[pixel]
    img ./= peak

    # Compute the major and minor axes
    xgrid = linspace(-deg2rad(extent), +deg2rad(extent), 1001)
    ygrid = linspace(-deg2rad(extent), +deg2rad(extent), 1001)
    keep_y, keep_x = findn(img .> 0.5)
    count = length(keep_x)
    x = xgrid[keep_x]
    y = ygrid[keep_y]
    A = [x y]
    U, S, V = svd(A)
    major_axis = V[:, 1]
    minor_axis = V[:, 2]
    major_scale = S[1]
    minor_scale = S[2]

    # Compute the FWHM by assuming all pixels > 0.5 fill an elliptical aperture
    dΩ = ((2extent)^2 / (180/π)^2) / (length(xgrid)*length(ygrid))
    Ω = count * dΩ

    C = sqrt(Ω/(π*major_scale*minor_scale))
    major_hwhm = C*major_scale
    minor_hwhm = C*minor_scale
    major_fwhm = 2major_hwhm
    minor_fwhm = 2minor_hwhm
    major_σ = major_fwhm/(2sqrt(2log(2)))
    minor_σ = minor_fwhm/(2sqrt(2log(2)))
    angle = atan2(major_axis[1], major_axis[2])

    major_σ = 60rad2deg(major_σ)
    minor_σ = 60rad2deg(minor_σ)
    angle = rad2deg(angle)

    peak, major_σ, minor_σ, angle
end

"Starting pixel of each Healpix ring."
function find_healpix_rings(nside)
    nring  = nside2nring(nside)
    pixels = [LibHealpix.ring_info2(nside, ring)[1] for ring = 1:nring]
    # discard pixels below -30 dec
    filter!(pixels) do pixel
        θ, ϕ = LibHealpix.pix2ang_ring(nside, pixel)
        θ < deg2rad(120)
    end
end

end