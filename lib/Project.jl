"""
    module Project

This module includes functions for working with OVRO-LWA datasets on the ASTM.
"""
module Project

using JLD2
using YAML

struct ProjectMetadata
    name :: String
    hidden :: String
end

function load(file)
    dict = YAML.load(open(file))
    ProjectMetadata(dict["name"], joinpath(dirname(file), ".pipeline"))
end

function workspace(metadata::ProjectMetadata)
    path = joinpath("/data09/xhall_mmode_analysis/workspace/17", metadata.name)
    isdir(path) || mkpath(path)
    path
end

function temp()
    path = "/data09/xhall_mmode_analysis/temp"
    isdir(path) || mkpath(path)
    path
end

lib() = @__DIR__
bin() = normpath(lib(), "..", "bin")

function touch(metadata, filename)
    isdir(metadata.hidden) || mkpath(metadata.hidden)
    Base.touch(joinpath(metadata.hidden, filename))
end

function set_stripe_count(project, directory, N)
    path = joinpath(workspace(project), directory)
    isdir(path) || mkpath(path)
    #run(`lfs setstripe -c $N $path`)
end

function load(project, filename, objectname)
    jldopen(joinpath(workspace(project), filename*".jld2"), false, false, false, IOStream) do file
        return file[objectname]
    end
end

function save(project, filename, objectname, object)
    jldopen(joinpath(workspace(project), filename*".jld2"), true, true, true, IOStream) do file
        file[objectname] = object
    end
end

function rm(project, filename)
    path = joinpath(workspace(project), filename)
    if isdir(path)
        Base.rm(path, recursive=true)
    else
        Base.rm(path)
    end
end

Nant2Nbase(Nant) = (Nant*(Nant+1))÷2
Nbase2Nant(Nbase) = round(Int, (sqrt(1+8Nbase)-1)/2)

function baseline_index(Nant, ant1, ant2)
    if ant1 ≤ ant2
        return _baseline_index(Nant, ant1, ant2)
    else
        return _baseline_index(Nant, ant2, ant1)
    end
end

function _baseline_index(Nant, ant1, ant2)
    ((ant1-1)*(2Nant-(ant1-2)))÷2 + (ant2-ant1+1)
end

end

