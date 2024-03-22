module Driver

using BPJSpec
using TTCal
using ProgressMeter
using QuadGK
using Unitful
using YAML

include("Project.jl")

struct Config
    input          :: String
    output_alm     :: String
    output_mmodes  :: String
    output_visibilities :: String
    metadata       :: String
    hierarchy      :: String
    transfermatrix :: String
    spectral_index :: Float64
    integrations_per_day :: Int
end

function load(file)
    dict = YAML.load(open(file))
    Config(dict["input"],
           dict["output-alm"],
           dict["output-mmodes"],
           dict["output-visibilities"],
           dict["metadata"],
           dict["hierarchy"],
           dict["transfer-matrix"],
           dict["spectral-index"],
           dict["integrations-per-day"])
end

function go(project_file, config_file)
    project = Project.load(project_file)
    config  = load(config_file)
    predict(project, config)
end

function predict(project, config)
    path = Project.workspace(project)
    transfermatrix = BPJSpec.load(joinpath(path, config.transfermatrix))
    input_alm      = Project.load(project, config.input, "alm")

    ν  = transfermatrix.frequencies
    Δν = transfermatrix.bandwidth
    mmax = transfermatrix.mmax

    alm    = create(MFBlockVector, MultipleFiles(joinpath(path, config.output_alm)),    mmax, ν, Δν)
    #alm = BPJSpec.load(joinpath(path, config.output_alm))

    mmodes = create(MFBlockVector, MultipleFiles(joinpath(path, config.output_mmodes)), mmax, ν, Δν)
    #mmodes = BPJSpec.load(joinpath(path, config.output_mmodes))

    visibilities = create(FBlockMatrix, MultipleFiles(joinpath(path, config.output_visibilities)),
                          ν, Δν)

    metadata  = Project.load(project, config.metadata,  "metadata")
    hierarchy = Project.load(project, config.hierarchy, "hierarchy")
    Project.set_stripe_count(project, config.output_alm,          1)
    Project.set_stripe_count(project, config.output_mmodes,       1)
    Project.set_stripe_count(project, config.output_visibilities, 1)

    index2alm(input_alm, alm, metadata, config.spectral_index)
    alm2mmodes(transfermatrix, alm, mmodes)
    mmodes2visibilities(mmodes, visibilities, metadata, hierarchy, config.integrations_per_day)
end

function index2alm(input_alm, output_alm, metadata, spectral_index)
    # Take an input set of spherical harmonics and scale it by some spectral index. We will assume
    # that the input spherical harmonics are integrated over some bandwidth, and so we will
    # normalize the output spherical harmonics so that integrating over this bandwidth gives the
    # correct result.
    ν  = ustrip.(uconvert.(u"MHz", metadata.frequencies))
    ν1 = minimum(ν)
    ν2 = maximum(ν)
    Δν = ν2 - ν1
    normalization  = quadgk(ν -> ν^spectral_index, ν1, ν2) |> first
    normalization /= Δν

    prg = Progress(output_alm.mmax+1)
    for m = 0:output_alm.mmax
        block = input_alm[m]
        for β = 1:Nfreq(metadata)
            output_alm[m, β] = block .* ν[β]^spectral_index/normalization
        end
        next!(prg)
    end
end

function alm2mmodes(transfermatrix, alm, mmodes)
    progressbar = ProgressBar(mmodes)
    @. progressbar = transfermatrix * alm
end

function mmodes2visibilities(mmodes, visibilities, metadata, hierarchy, Ntime)
    queue = collect(1:Nfreq(metadata))
    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))
    @sync for worker in workers()
        @async while length(queue) > 0
            β = shift!(queue)
            remotecall_wait(_mmodes2visibilities, worker,
                            mmodes, visibilities, hierarchy,
                            Ntime, Nbase(metadata), β)
            increment()
        end
    end
end

function _mmodes2visibilities(mmodes, visibilities, hierarchy, Ntime, Nbase, β)
    packed_mmodes = pack_mmodes(mmodes, hierarchy, Ntime, Nbase, β)
    planned_fft = plan_fft(packed_mmodes, 1)
    output = Ntime .* (planned_fft \ packed_mmodes)
    visibilities[β] = permutedims(output, (2, 1))
end

function pack_mmodes(mmodes, hierarchy, Ntime, Nbase, β)
    output = zeros(Complex128, Ntime, Nbase)

    # m = 0
    block = mmodes[0, β]
    for (α, α′) in enumerate(BPJSpec.baseline_permutation(hierarchy, 0))
        output[1, α′] = block[α]
    end

    # m > 0
    for m = 1:mmodes.mmax
        block = mmodes[m, β]
        for (α, α′) in enumerate(BPJSpec.baseline_permutation(hierarchy, m))
            α1 = 2α-1 # positive m
            α2 = 2α-0 # negative m
            output[      m+1, α′] =      block[α1]
            output[Ntime+1-m, α′] = conj(block[α2])
        end
    end

    output
end

end

