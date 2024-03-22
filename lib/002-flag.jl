# Summary of flagging strategy
# ============================
# 1. Manually inspect the antenna reports and pick out all the truly egregious antennas.
# 2. Look for impulsive events in the auto-correlations.
# 3. Compute the channel difference 2ν₂ - ν₁ - ν₃ to cancel out the sky emission.
#    ->

# NOTE: Time-dependent gain fluctuations are calibrated in this routine as well. For the OVRO-LWA
# this generally manifests as 15 minute-period sawtooth amplitude fluctuations due to the HVAC
# cycles. The exact period is variable (typically 15 to 17 minutes) presumably due to fluctuations
# in the ambient environmental temperature.
#
# I have decided to calibrate these gain fluctuations in the flagging routine, because this is the
# earliest routine that has a complete view of each baseline as a function of time, and I'd like to
# calibrate these fluctuations as early as possible. I do not want to introduce an additional
# routine, because it is faster (and less disk space) to just handle it all at once with the flags.

module Driver

using FileIO, JLD2
using ProgressMeter
using TTCal
using BPJSpec
using Dierckx
using Unitful # for ustrip
using YAML

include("Project.jl")
include("FlagDefinitions.jl"); using .FlagDefinitions

struct Config
    input            :: String
    input_transposed :: String
    output           :: String
    output_flags     :: String
    metadata         :: String
    a_priori_antenna_flags  :: Vector{Int}
    a_priori_baseline_flags :: Vector{Tuple{Int, Int}}
    a_priori_channel_flags  :: Vector{Int}
    autocorrelation_impulsive_threshold        :: Float64
    integration_rms_threshold                  :: Float64
    visibility_amplitude_threshold             :: Float64
    channel_baseline_constant_offset_threshold :: Float64
    flag_autocorrelations :: Bool
    smooth_sawtooth :: Bool
end

function load(file)
    dict = YAML.load(open(file))

    do_the_splits(s) = (s′ = split(s, "&"); (parse(Int, s′[1]), parse(Int, s′[2])))
    a_priori_antenna_flags  = get(dict, "a-priori-antenna-flags", Int[])
    a_priori_baseline_flags = haskey(dict, "a-priori-baseline-flags") ?
                                do_the_splits.(dict["a-priori-baseline-flags"]) :
                                Tuple{Int, Int}[]
    a_priori_channel_flags  = get(dict, "a-priori-channel-flags", Int[])

    Config(dict["input"],
           dict["input-transposed"],
           get(dict, "output", ""),
           dict["output-flags"],
           dict["metadata"],
           a_priori_antenna_flags,
           a_priori_baseline_flags,
           a_priori_channel_flags,
           get(dict, "autocorrelation-impulsive-threshold", 0.0),
           get(dict, "integration-rms-threshold", 0.0),
           get(dict, "visibility-amplitude-threshold", 0.0),
           get(dict, "channel-baseline-constant-offset-threshold", 0.0),
           get(dict, "flag-autocorrelations", false),
           get(dict, "smooth-sawtooth", false))
end

function go(project_file, config_file)
    project = Project.load(project_file)
    config  = load(config_file)
    flag(project, config)
end

function flag(project, config)
    path     = Project.workspace(project)
    println(path)
    metadata = Project.load(project, config.metadata, "metadata")

    
    flags = Flags(metadata)

    try
        flags = Project.load(project, config.output_flags, "flags")
    catch
        
        println("Applying a-priori flags")
        a_priori_flags!(flags, config, metadata)
        Project.save(project, config.output_flags*"-apriori", "flags", flags)

        if config.flag_autocorrelations
            println("Flagging auto-correlations")
            flag_autos!(flags, config, metadata)
        end

        use_transposed_visibilities = (config.smooth_sawtooth
                                   || config.visibility_amplitude_threshold > 0
                                   || config.channel_baseline_constant_offset_threshold > 0)
        # use_transposed_visibilities = false
        if use_transposed_visibilities
            println("Working feverishly on the transposed visibilities")
            transposed_visibilities = BPJSpec.load(joinpath(path, config.input_transposed))
            process_transposed_visibilities!(flags, transposed_visibilities, metadata, config)
        end

        #use_regular_visibilities = false
        #if use_regular_visibilities
        #    visibilities = BPJSpec.load(joinpath(path, config.input))
        #    process_regular_visibilities!(flags, visibilities, metadata, config)
        #end

        #println("Widening flags")
        #Project.save(project, config.output_flags*"-unwidened", "flags", flags)
        #@time widen!(flags, config)

        println("Saving the new flags")
        Project.save(project, config.output_flags, "flags", flags)
        flags = Project.load(project, config.output_flags, "flags")
    end

    if config.output != ""
        println("Applying the new flags")
        #flags = Project.load(project, config.output_flags*"-unwidened", "flags")
        input  = BPJSpec.load(joinpath(path, config.input))
        output = similar(input, MultipleFiles(joinpath(path, config.output)))
        Project.set_stripe_count(project, config.output, 1)
        write_output(project, flags, input, output, metadata)
    end
    println("Done Applying New Flags")
    flags = Project.load(project, config.output_flags, "flags")
    flags
end

function write_output(project, flags, input, output, metadata)
    queue = collect(1:Ntime(metadata))
    pool  = CachingPool(workers())
    lck = ReentrantLock()
    prg = Progress(length(queue))
    increment() = (lock(lck); next!(prg); unlock(lck))

    function _write(index)
        raw_data = input[index]
        apply!(raw_data, flags, index)
        output[index] = raw_data
    end

    @sync for worker in workers()
        @async while length(queue) > 0
            index = shift!(queue)
            remotecall_wait(_write, pool, index)
            increment()
        end
    end
end

"Zero out all flagged visibilities in an array with dimensions Npol × Nfreq × Nbase"
function apply!(data, flags, time)
    bits = permutedims(flags.bits[:, :, time], (2, 1))
    xx = @view data[1, :, :]
    yy = @view data[2, :, :]
    xx[bits] = 0
    yy[bits] = 0
    # Smooth out the sawtooth
    Nant = size(flags.sawtooth, 3)
    for β = 1:size(xx, 1)
        for ant1 = 1:Nant
            s1 = flags.sawtooth[time, β, ant1]
            s1 == 0 && continue
            for ant2 = ant1:Nant
                s2 = flags.sawtooth[time, β, ant2]
                s2 == 0 && continue
                α = Project.baseline_index(Nant, ant1, ant2)
                xx[β, α] /= s1 * s2
                yy[β, α] /= s1 * s2
            end
        end
    end
    data
end

"Zero out all flagged visibilities in an array with dimensions Nbase × Ntime"
function apply_to_transpose!(data, flags, frequency)
    bits = flags.bits[:, frequency, :]
    data[bits] = 0
    # Smooth out the sawtooth
    Nant = size(flags.sawtooth, 3)
    for idx = 1:size(data, 2)
        for ant1 = 1:Nant
            s1 = flags.sawtooth[idx, frequency, ant1]
            s1 == 0 && continue
            for ant2 = ant1:Nant
                s2 = flags.sawtooth[idx, frequency, ant2]
                s2 == 0 && continue
                α = Project.baseline_index(Nant, ant1, ant2)
                data[α, idx] /= s1 * s2
            end
        end
    end
    data
end

"Apply a pre-existing list of flags."
function a_priori_flags!(flags, config, metadata)
    α = 1
    prg = Progress(Nbase(metadata))
    for ant1 = 1:Nant(metadata), ant2 = ant1:Nant(metadata)
        if ((ant1 in config.a_priori_antenna_flags)
                || (ant2 in config.a_priori_antenna_flags)
                || ((ant1, ant2) in config.a_priori_baseline_flags)
                || ((ant2, ant1) in config.a_priori_baseline_flags))
            flag_baseline!(flags, α)
        end
        α += 1
        next!(prg)
    end
    for β in config.a_priori_channel_flags
        flag_channel!(flags, β)
    end
    flags
end

"Flag all of the auto-correlations."
function flag_autos!(flags, config, metadata)
    α = 1
    prg = Progress(Nant(metadata))
    for ant1 = 1:Nant(metadata), ant2 = ant1:Nant(metadata)
        if ant1 == ant2
            flag_baseline!(flags, α)
            next!(prg)
        end
        α += 1
    end
    flags
end

function extract_autocorrelations(visibilities, metadata)
    output = zeros(Ntime(metadata), Nant(metadata))
    α = 1
    for ant1 = 1:Nant(metadata), ant2 = ant1:Nant(metadata)
        if ant1 == ant2
            output[:, ant1] = real.(visibilities[α, :])
        end
        α += 1
    end
    output
end

baseline_lengths(metadata) = ustrip.([norm(metadata.positions[ant1] - metadata.positions[ant2])
                                     for ant1 = 1:Nant(metadata) for ant2 = ant1:Nant(metadata)])

"Use the transposed visibilities to smooth the auto-correlations and find flags."
function process_transposed_visibilities!(flags, transposed_visibilities, metadata, config)
    # We are sweeping through frequency channels with a window size of three. This means that we
    # have three channels loaded at any one time. If a problem is detected, we don't bother trying
    # to guess which of the three channels is the problem, we just flag all three of them. If we are
    # not careful, that means when we slide the window over once, two of the three channels are
    # already flagged and we will, by default, flag this new channel without ever really looking at
    # it. Oops! So we need to be careful to make sure flags don't propagate themselves in this
    # manner!

    function load(β)
        # When we're loading the visibilities, we'll take care of some quick flags that only require
        # one channel at a time. These can write directly into the master list of flags because
        # we're only flagging one channel at a time and therefore they can't propagate through
        # frequency channels.
        V = transposed_visibilities[β]
        _preexisting_flags!(flags, V, β)
        A = extract_autocorrelations(V, metadata)
        process_autocorrelations!(flags, A, metadata, config, β)
        output = apply_to_transpose!(V, flags, β)
        output
    end

    function find_flags(V1, V2, V3, Δ)
        # In this function we only identify the (baseline, time) pairs that we would like to flag
        # for these three frequency channels, we don't output anything yet. Or else we risk the
        # wrath of the flag propagation gods. Tremble in fear!!!

        bits = BitArray(size(V1))
        bits[:] = false

        Δ .= difference_from_middle.(V1, V2, V3)

        threshold = config.visibility_amplitude_threshold
        if threshold > 0
            for iteration = 1:3
                _visibility_amplitude_flags!(bits, Δ, threshold)
                Δ[bits] = 0
            end
        end

        threshold = config.channel_baseline_constant_offset_threshold
        if threshold > 0
            _constant_offset_flags!(bits, Δ, threshold)
            Δ[bits] = 0
        end

        threshold = config.integration_rms_threshold
        if threshold > 0
            _integration_rms_flags!(bits, Δ, threshold)
            Δ[bits] = 0
        end

        bits
    end

    function output!(flags, channel, Δ, bits, measure_rms=true)
        # only call this function to output the updated flags once we are completely done looking at
        # this channel (ie. it won't be used in any more differences)
        measure_rms && (flags.channel_difference_rms[channel] = rms(Δ))
        flags.bits[:, channel, :] .|= bits
    end

    prg = Progress(Nfreq(metadata) - 2)
    range = 1:3
    V1 = load(1)
    V2 = load(2)
    V3 = load(3)
    Δ  = similar(V1)
    bits = find_flags(V1, V2, V3, Δ)
    V1bits = deepcopy(bits)
    V2bits = deepcopy(bits)
    V3bits = deepcopy(bits)
    output!(flags, 1, Δ, V1bits)
    next!(prg)

    while last(range) < Nfreq(metadata)
        range += 1
        V1 = V2
        V2 = V3
        V3 = load(last(range))
        V1bits = V2bits
        V2bits = V3bits
        V3bits = find_flags(V1, V2, V3, Δ)
        V1bits .|= V3bits # give new flags to first channel
        V2bits .|= V3bits # give new flags to second channel as well
        output!(flags, first(range), Δ, V1bits)
        next!(prg)
    end

    output!(flags, range[2], Δ, V2bits, false)
    output!(flags, range[3], Δ, V3bits, false)

    flags
end

function process_autocorrelations!(flags, autos, metadata, config, β)
    threshold = config.autocorrelation_impulsive_threshold
    if threshold > 0
        _flag_autocorrelation_timeseries!(flags, autos, threshold, β)
    end
    if config.smooth_sawtooth
        _measure_sawtooth_fluctuations!(flags, autos, β)
    end
end

"Find the pre-existing flags so that we can have a complete list."
function _preexisting_flags!(flags, V, β)
    bits = V .== 0
    flags.bits[:, β, :] .|= bits
end

"Flag antennas that have spikes in the autocorrelation timeseries."
function _flag_autocorrelation_timeseries!(flags, autos, threshold, β)
    Ntime, Nant = size(autos)
    for ant = 1:Nant
        x = @view autos[:, ant]
        f = Driver.threshold_flag(x, Driver.rms, 5, scale=75, iterations=2)
        if any(f)
            x[f] = 0
            baselines = Project.baseline_index.(Nant, ant, 1:Nant)
            flag_baseline_channel_integration!(flags, baselines, β, f)
        end
    end
end

"Flag all baselines in integrations that have enhanced RMS across all baselines."
function _integration_rms_flags!(bits, Δ, threshold)
    Nbase, Ntime = size(Δ)
    σ = [rms(@view Δ[:, idx]) for idx = 1:Ntime]
    new_bits = threshold_flag(σ, mad, threshold, scale=1000, iterations=2)
    for α = 1:Nbase
        bits[α, :] .|= new_bits
    end
end

"""
Compare the individual visibility amplitude to the global RMS.

After taking differences, we should be left with just noise. So we can measure the RMS of the noise
and flag any visibilities that are large compared to this RMS. A typical value for the threshold
here is `5` to avoid flagging too many visibilities due to thermal noise.
"""
function _visibility_amplitude_flags!(bits, Δ, threshold)
    new_bits = abs.(Δ) .> threshold * rms(Δ)
    bits .|= new_bits
end

"""
Compare the time-averaged visibilities to the per-baseline RMS.

Real sky emission tends to get smeared away by the sky rotation and we've differenced in frequency
to cancel out a lot of this emission ahead of time. Therefore what remains should be noise unless
there is some terrestrial component to the visibilities (like RFI or common-mode pickup). We will
therefore flag baselines where the time-averaged visibilities are a large fraction of the RMS (note
that math says that the RMS is always larger than the amplitude of the time-averaged visibilities,
so the `threshold` here should be between 0 and 1.
"""
function _constant_offset_flags!(bits, Δ, threshold)
    Nbase = size(Δ, 1)
    for α = 1:Nbase
        δ = @view Δ[α, :]
        ratio = abs(avg(δ) / rms(δ))
        if is_this_baseline_unusual(ratio, threshold)
            bits[α, :] = true
        end
    end
end

"""
Extend flags when a baseline is commonly flagged in a given integration or channel.
"""
function widen!(flags, config)
    Nbase, Nfreq, Ntime = size(flags.bits)
    for idx = 1:Ntime
        _widen_frequency(flags, idx)
    end
    for β = 1:Nfreq
        _widen_time(flags, β)
    end
end

function _widen_frequency(flags, idx)
    bits = @view flags.bits[:, :, idx]
    Nbase, Nfreq = size(bits)
    # How many frequency channels is each baseline flagged in?
    count = sum(bits, 2)
    # Flag the baseline for the entire integration if it crosses a threshold.
    for α in find(count .> 0.25 * Nfreq)
        flag_baseline_integration!(flags, α, idx)
    end
end

function _widen_time(flags, β)
    bits = @view flags.bits[:, β, :]
    Nbase, Ntime = size(bits)
    # How many integrations is each baseline flagged in?
    flagged = sum(bits, 2)
    # Flag the baseline for the entire frequency channel if it crosses a threshold.
    for α in find(flagged .> 0.25 * Ntime)
        flag_baseline_channel!(flags, α, β)
    end
end

"Get a list of all unusual baselines given the data for baselines of similar lengths."
function find_unusual_baselines(lengths, data, cutoff)
    Nbase = length(data)
    find(α -> is_this_baseline_unusual(data[α], cutoff), 1:Nbase)
end

function is_this_baseline_unusual(value, cutoff)
    value == 0   && return false # already flagged
    isnan(value) && return false # already flagged
    value > cutoff
end

"A general purpose function for finding outliers to a curve after fitting with a spline."
function threshold_flag(data, reduction, threshold; window_size=0, scale=10, iterations=2)
    x = 1:length(data)
    y = abs.(data)
    flags = y .== 0
    original_flags = copy(flags)

    for iteration = 1:iterations
        unflagged_x = x[.!flags]

        #Seems to be a problem with the knots being greater than unflagged x with the new array?? Attempting basic fix
        if(length(unflagged_x) > 3)

            unflagged_y = y[.!flags]
            knots  = unflagged_x[2:scale:end-1]

            spline = Spline1D(unflagged_x, unflagged_y, knots)
            deviation = y .- spline.(x)

            if window_size != 0
                σ = windowed(reduction, deviation, window_size)
            else
                σ = reduction(deviation)
            end
            new_flags = deviation .> threshold .* σ
            flags     = new_flags .| original_flags
        else
            new_flags = flags .== flags
            flags = new_flags
            println("Flag Everything") #If there isn't enough data to fit a spline just flag the whole baseline.
        end
    end

    flags
end

function windowed(reduction, deviation, window_size)
    # TODO: this is a naive algorithm O(length(deviation) × complexity of reduction)
    N = length(deviation)
    output = similar(deviation)
    for idx = 1:N
        window = max(1, idx-window_size):min(N, idx+window_size)
        output[idx] = reduction(view(deviation, window))
    end
end

"We're flagging data by setting it to zero. This computes the mean after discarding all zeros."
function mean_no_zero(data)
    mean_no_zero(identity, data)
end

function mean_no_zero(predicate::Function, data)
    S = mapreduce(predicate, +, data)
    C = mapreduce(iszero,    +, data)
    L = length(data)
    ifelse(L == C, zero(typeof(S)), S / (L - C))
end

function median_no_zero(predicate::Function, data)
    selection = data .!= 0
    median(predicate.(@view data[selection]))
end

mad(vector) = median_no_zero(abs, vector)
rms(vector) = sqrt(mean_no_zero(abs2, vector))
avg(vector) = mean_no_zero(vector)

doc"""
One key component of our analysis here is that we are computing differences that look like $-ν₁ +
2ν₂ - ν₃$. This is effectively a second derivative with respect to frequency, but does a better job
canceling out the power-law sky emission than the first derivative operator.

However, there are times where any of these channels may be flagged. We want the following behavior.

- **Either of the end points is flagged** - revert to the first derivative operator with the
remaining two channels
- **The middle point is flagged** - revert to the first derivative operator with the remaining two
channels
- **Both of the end points are flagged** - this channel should probably be flagged too, but that
should be the job of an explicit widening of the flags. We'll return `zero` here to exclude this
data point from the analysis.
- **The midpoint and one end point is flagged** - we cannot judge whether the remaining end point
should be flagged, but we'll return `zero` here to exclude this data point from the analysis
- **All three data points are flagged** - return `zero` to exclude this data point from
consideration

Note that we will use a multiplicative factor so that thermal noise maintains the same amplitude
between the first and second derivative operators.
"""
function difference_from_middle(x, y, z)
    xok = x != 0
    yok = y != 0
    zok = z != 0
    if xok & yok & zok
        return 2*y - x - z
    elseif xok & yok
        return √3 * (y - x)
    elseif xok & zok
        return √3 * (z - x)
    elseif yok & zok
        return √3 * (z - y)
    else
        return zero(typeof(x))
    end
end

"""
The AC unit in the electronics shelter seems to turn on/off every 15 minutes or so. This leads to
gain variations on 15 minute timescales that manifests as a sawtooth pattern in the gains.
"""
function _measure_sawtooth_fluctuations!(flags, autos, β)
    Ntime, Nant = size(autos)
    for ant = 1:Nant
        x = @view autos[:, ant]
        y = convolve_with_gaussian(x, 201)
        flags.sawtooth[:, β, ant] = sqrt.(x ./ y)
    end
    flags
end

"Convolve the input signal with a Gaussian of a given width."
function convolve_with_gaussian(x, width)
    N = length(x)
    w = (width - 1) ÷ 2
    kernel = exp.(-0.5 * (linspace(-3, 3, width+1)).^2)
    numerator   = zeros(N)
    denominator = zeros(N)
    for t1 = 1:N
        range = (-w:w) + t1
        range = max(1, range[1]):min(N, range[end])
        for t2 in range
            if x[t2] != 0
                idx = t2 - t1 + w + 1
                numerator[t1]   += x[t2] * kernel[idx]
                denominator[t1] += kernel[idx]
            end
        end
    end
    numerator ./= denominator
    numerator
end

end

