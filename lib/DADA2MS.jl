module DADA2MS

using CasaCore.Tables
using YAML

include("Project.jl")

struct Config
    utmzone :: Int
    antfile :: String
    polswap :: String
    datadir :: String
    prefix  :: String
    files :: Dict{Int, Vector{String}} # subband mapped to list of dada files
end

function load(file)
    dict = YAML.load(open(file))
    files = Dict{Int, Vector{String}}()
    Config(dict["utmzone"], dict["antfile"], dict["polswap"],
           dict["datadir"], dict["prefix"], files)
end

function load!(config::Config, subband)
    path = config.datadir
    files = readdir(path)
    filter!(files) do file
        startswith(file, config.prefix)
    end
    sort!(files)
    for idx = 1:length(files)
        files[idx] = joinpath(path, files[idx])
    end
    config.files[subband] = files
    files
end

number(config::Config) = length(first(values(config.files)))

function run(config::Config, dada::String)
    ms = joinpath(Project.temp(), dada)
    Tables.open(ascii(ms), write=false)
end

# function run(config::Config, dada::String)
#     ms = joinpath(Project.temp(), randstring(4)*"-"dotdada2dotms(basename(dada)))
#     Base.run(`dada2ms --utmzone $(config.utmzone) --antfile $(config.antfile) $dada $ms`)
#     if config.polswap != ""
#         cmd = joinpath(Project.bin(), config.polswap)
#         Base.run(`$(joinpath(Project.bin(), "swapped-polarization-fixes", config.polswap)) $ms`)
#     end
#     Tables.open(ascii(ms), write=true)
# end

run(config::Config, subband::Int, index::Int) = run(config, config.files[subband][index])

function dotdada2dotms(name)
    replace(name, ".dada", ".ms")
end

end

