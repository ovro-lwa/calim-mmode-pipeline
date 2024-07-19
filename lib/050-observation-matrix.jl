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

struct Config
    input :: String
    output :: String
    hierarchy :: String
    transfermatrix :: String
    metadata :: String
end

function load(file)
    dict = YAML.load(open(file))
    Config(dict["input"],
           dict["output"],
           dict["hierarchy"],
           dict["transfer-matrix"],
           dict["metadata"])
end

function go(project_file, config_file)
    println(config_file)
    julia> eigvals(A)
    2-element Array{Complex{Float64},1}:
     -1.0 - 5.0im
     -1.0 + 5.0im
    
    julia> eigvecs(A)
    2×2 Array{Complex{Float64},2}:
      0.945905-0.0im        0.945905+0.0im
     -0.166924+0.278207im  -0.166924-0.278207im
    
    project = Project.load(project_file)
    config  = load(config_file)
    observation_matrix(project, config)
end

function observation_matrix(project, config)
    path = Project.workspace(project)
    mmodes = BPJSpec.load(joinpath(path, config.input))
    transfermatrix = BPJSpec.load(joinpath(path, config.transfermatrix))
    hierarchy = Project.load(project, config.hierarchy, "hierarchy")
    metadata = Project.load(project, config.metadata, "metadata")

    compute(transfermatrix, hierarchy, metadata, mmodes, path, config)
end

function compute(transfermatrix, hierarchy, metadata, mmodes, path, config)
    mmax = lmax = transfermatrix.mmax

    pool  = CachingPool(workers())
    queue = collect(0:mmax)

    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))

    output_block = create(BPJSpec.SimpleBlockArray{Complex128, 2},
        MultipleFiles(joinpath(path, config.output*"-block")), length(queue))

    output_cholesky = create(BPJSpec.SimpleBlockArray{Complex128, 2},
        MultipleFiles(joinpath(path, config.output*"-cholesky")), length(queue))

    @sync for worker in workers()
        @async while length(queue) > 0
            m = shift!(queue)
            BB, BB_chol = remotecall_fetch(_compute, pool, transfermatrix, hierarchy, metadata, mmodes, lmax, m)
            lock(lck)
            output_block[m] = BB
            output_cholesky[m] = BB_chol
            next!(prg)
            unlock(lck)
        end
    end
end

function _compute(transfermatrix, hierarchy, metadata, mmodes, lmax, m)
    BLAS.set_num_threads(10)
    BB = zeros(Complex128, lmax-m+1, lmax-m+1)
    #permutation = BPJSpec.baseline_permutation(hierarchy, m)
    for ν = 1:length(mmodes.frequencies)
        _compute_accumulate!(BB, transfermatrix[m, ν], mmodes[m, ν])
    end
    BB, chol(BB + 0.01I).data
end

function _compute_accumulate!(BB, B, v)
#    v = v[permutation]
    f = v .== 0 # flags
    B = B[.!f, :]
    BB .+= B'*B
end

end