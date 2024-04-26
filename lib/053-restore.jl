module Driver

using BPJSpec
using CasaCore.Measures
using JLD2
using LibHealpix
using ProgressMeter
using TTCal
using Unitful, UnitfulAstro
using YAML
using StaticArrays

include("Project.jl")
include("Cleaning.jl"); using .Cleaning

struct Config
    input :: String
    inputpsf :: String
    output :: String
    metadata :: String
end

function load(file)
    dict = YAML.load(open(file))
    Config(
    dict["input"],
    dict["input-psf"],
    dict["output"],
    dict["metadata"],
    )
end

function go(project_file, config_file)
    project = Project.load(project_file)
    config  = load(config_file)
    restore(project, config)
end

function restore(project, config)
    path = Project.workspace(project)
    metadata = Project.load(project, config.metadata, "metadata")

    local pixels, peak, major, minor, angle
    jldopen(joinpath(path, config.inputpsf*".jld2"), "r") do file
        pixels = file["pixels"]
        peak   = file["peak"]
        major  = file["major"]
        minor  = file["minor"]
        angle  = file["angle"]
    end

    local residual_alm, degraded_alm, components
    jldopen(joinpath(path, "052-clean", "state-00001.jld2"), "r") do file
        residual_alm = file["residual_alm"]
        degraded_alm = file["degraded_alm"]
        components   = file["components"]
    end

    restored_alm = residual_alm + degraded_alm
    restored_map = alm2map(restored_alm, 2048)
    writehealpix(joinpath(path, config.output*"-residuals.fits"), restored_map, replace=true)

    restore!(restored_map, components, pixels, peak, major, minor, angle)

    writehealpix(joinpath(path, config.output*".fits"), restored_map, replace=true)
    writehealpix(joinpath(path, config.output*"-galactic.fits"),
                 rotate_to_galactic(restored_map, metadata), coordsys="G", replace=true)
    #writehealpix(joinpath(getdir(spw), "$target-$dataset-j2000.fits"),
    #             MModes.rotate_to_j2000(spw, dataset, restored_map), replace=true)
end

function restore!(restored_map, components, ringstart, peak, major, minor, angle)
    pixels = find(components)
    N = length(pixels)
    prg = Progress(N)
    for pixel in pixels
        ring = searchsortedlast(ringstart, pixel)
        vec  = LibHealpix.pix2vec(restored_map, pixel)
        θ, ϕ = LibHealpix.vec2ang(vec)
        north = SVector(0, 0, 1)
        north -= dot(north, vec)*vec
        north /= norm(north)
        east = cross(north, vec)
        amplitude = components[pixel]*peak[ring]
        disc = query_disc(restored_map, θ, ϕ, deg2rad(1))
        for disc_pixel in disc
            disc_vec = LibHealpix.pix2vec(restored_map, disc_pixel)
            x = asind(dot(disc_vec, east)) * 60
            y = asind(dot(disc_vec, north)) * 60
            value = gaussian(x, y, amplitude, major[ring], minor[ring], deg2rad(angle[ring]))
            restored_map[disc_pixel] += value
        end
        next!(prg)
    end
end

function rotate_to_galactic(map, metadata)
    x = Direction(dir"ITRF", 1, 0, 0)
    y = Direction(dir"ITRF", 0, 1, 0)
    z = Direction(dir"ITRF", 0, 0, 1)

    frame = ReferenceFrame(metadata)
    ξ = measure(frame, x, dir"GALACTIC")
    η = measure(frame, y, dir"GALACTIC")
    ζ = measure(frame, z, dir"GALACTIC")

    output = RingHealpixMap(eltype(map), map.nside)
    for idx = 1:length(map)
        vec = LibHealpix.pix2vec(map, idx)
        dir = Direction(dir"GALACTIC", vec.x, vec.y, vec.z)
        θ =  acos(dot(dir, ζ))
        ϕ = atan2(dot(dir, η), dot(dir, ξ))
        output[idx] = LibHealpix.interpolate(map, θ, ϕ)
    end
    output
end

end