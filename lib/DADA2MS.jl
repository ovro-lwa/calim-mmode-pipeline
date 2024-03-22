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
    dates :: Vector{String}
    files :: Dict{Int, Vector{String}} # subband mapped to list of dada files
end

function load(file)
    dict = YAML.load(open(file))
    files = Dict{Int, Vector{String}}()
    Config(dict["utmzone"], dict["antfile"], dict["polswap"],
           dict["datadir"], dict["prefix"], dict["dates"],  files)
end

function load!(config::Config, subband)
    files_all = []
    for d in config.dates
        path = joinpath(config.datadir, d)
        files = readdir(path)
        filter!(files) do file
            (startswith(file, config.prefix) & endswith(file, ".ms"))
        end
        sort!(files)
        for idx = 1:length(files)
            files[idx] = joinpath(path, files[idx])
        end
        files_all = [files_all; files]
        println(length(files))
    end
    config.files[subband] = files_all
    files_all
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

