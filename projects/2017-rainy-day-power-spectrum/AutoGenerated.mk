# This file was auto-generated. Do not edit directly!

.pipeline/030-m-modes-calibrated-all: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-calibrated-all.yml \
		.pipeline/001-calibrated-transposed-data \
		.pipeline/002-flagged-calibrated-data \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,4)

.pipeline/030-m-modes-interpolated-calibrated-all: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-calibrated-all.yml \
		.pipeline/001-calibrated-transposed-data \
		.pipeline/002-flagged-calibrated-data \
		.pipeline/032-predicted-visibilities-calibrated \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-calibrated-all: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-calibrated-all.yml \
		.pipeline/030-m-modes-interpolated-calibrated-all \
		.pipeline/030-m-modes-interpolated-calibrated-all
	$(call launch-remote,1)

.pipeline/031-dirty-map-calibrated-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-calibrated-all.yml \
		.pipeline/030-m-modes-calibrated-all \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,4)

.pipeline/031-dirty-channel-maps-calibrated-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-calibrated-all.yml \
		.pipeline/030-m-modes-calibrated-all \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-calibrated-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-calibrated-all.yml \
		.pipeline/033-transfer-flags-calibrated-all \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,8)

.pipeline/031-dirty-channel-maps-interpolated-calibrated-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-calibrated-all.yml \
		.pipeline/033-transfer-flags-calibrated-all \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-calibrated-all: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-calibrated-all.yml \
		.pipeline/033-transfer-flags-calibrated-all
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-calibrated-all: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-all.yml \
		.pipeline/101-averaged-m-modes-calibrated-all \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-calibrated-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-calibrated-all.yml \
		.pipeline/103-full-rank-compression-calibrated-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-all-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-all-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-all-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-all-extreme.yml \
		.pipeline/112-foreground-filter-calibrated-all-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-all-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-all-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-all-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-all-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-all-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-all-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-all-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-all-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-all-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-all-moderate.yml \
		.pipeline/112-foreground-filter-calibrated-all-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-all-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-all-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-all-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-all-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-all-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-all-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-all-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-all-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-all-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-all-mild.yml \
		.pipeline/112-foreground-filter-calibrated-all-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-all-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-all-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-all-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-all-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-all-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-all-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-all-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-all-none.yml \
		.pipeline/103-full-rank-compression-calibrated-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-all-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-all-none.yml \
		.pipeline/112-foreground-filter-calibrated-all-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-all-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-all-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-all-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-all-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-all-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-all-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-none-cylindrical
	$(launch)

.pipeline/030-m-modes-calibrated-odd: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-calibrated-odd.yml \
		.pipeline/001-calibrated-transposed-data \
		.pipeline/002-flagged-calibrated-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-calibrated-odd: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-calibrated-odd.yml \
		.pipeline/001-calibrated-transposed-data \
		.pipeline/002-flagged-calibrated-data \
		.pipeline/032-predicted-visibilities-calibrated \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-calibrated-odd: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-calibrated-odd.yml \
		.pipeline/030-m-modes-interpolated-calibrated-all \
		.pipeline/030-m-modes-interpolated-calibrated-odd
	$(call launch-remote,1)

.pipeline/031-dirty-map-calibrated-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-calibrated-odd.yml \
		.pipeline/030-m-modes-calibrated-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-calibrated-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-calibrated-odd.yml \
		.pipeline/030-m-modes-calibrated-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-calibrated-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-calibrated-odd.yml \
		.pipeline/033-transfer-flags-calibrated-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-calibrated-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-calibrated-odd.yml \
		.pipeline/033-transfer-flags-calibrated-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-calibrated-odd: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-calibrated-odd.yml \
		.pipeline/033-transfer-flags-calibrated-odd
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-calibrated-odd: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-odd.yml \
		.pipeline/101-averaged-m-modes-calibrated-odd \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-odd
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-calibrated-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-calibrated-odd.yml \
		.pipeline/103-full-rank-compression-calibrated-odd
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-odd-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-odd-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-odd-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-odd-extreme.yml \
		.pipeline/112-foreground-filter-calibrated-odd-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-odd-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-odd-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-odd-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-odd-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-odd-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-odd-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-odd-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-odd-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-odd-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-odd-moderate.yml \
		.pipeline/112-foreground-filter-calibrated-odd-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-odd-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-odd-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-odd-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-odd-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-odd-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-odd-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-odd-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-odd-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-odd-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-odd-mild.yml \
		.pipeline/112-foreground-filter-calibrated-odd-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-odd-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-odd-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-odd-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-odd-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-odd-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-odd-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-odd-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-odd-none.yml \
		.pipeline/103-full-rank-compression-calibrated-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-odd-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-odd-none.yml \
		.pipeline/112-foreground-filter-calibrated-odd-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-odd-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-odd-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-odd-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-odd-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-odd-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-odd-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-none-cylindrical
	$(launch)

.pipeline/030-m-modes-calibrated-even: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-calibrated-even.yml \
		.pipeline/001-calibrated-transposed-data \
		.pipeline/002-flagged-calibrated-data \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-calibrated-even: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-calibrated-even.yml \
		.pipeline/001-calibrated-transposed-data \
		.pipeline/002-flagged-calibrated-data \
		.pipeline/032-predicted-visibilities-calibrated \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-calibrated-even: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-calibrated-even.yml \
		.pipeline/030-m-modes-interpolated-calibrated-all \
		#.pipeline/030-m-modes-interpolated-calibrated-even
	$(call launch-remote,1)

.pipeline/031-dirty-map-calibrated-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-calibrated-even.yml \
		.pipeline/030-m-modes-calibrated-even \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-calibrated-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-calibrated-even.yml \
		.pipeline/030-m-modes-calibrated-even \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-calibrated-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-calibrated-even.yml \
		.pipeline/033-transfer-flags-calibrated-even \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-calibrated-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-calibrated-even.yml \
		.pipeline/033-transfer-flags-calibrated-even \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-calibrated-even: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-calibrated-even.yml \
		.pipeline/033-transfer-flags-calibrated-even
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-calibrated-even: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-even.yml \
		.pipeline/101-averaged-m-modes-calibrated-even \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-even
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-calibrated-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-calibrated-even.yml \
		.pipeline/103-full-rank-compression-calibrated-even
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-even-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-even-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-even-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-even-extreme.yml \
		.pipeline/112-foreground-filter-calibrated-even-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-even-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-even-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-even-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-even-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-even-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-even-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-even-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-even-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-even-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-even-moderate.yml \
		.pipeline/112-foreground-filter-calibrated-even-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-even-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-even-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-even-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-even-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-even-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-even-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-even-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-even-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-even-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-even-mild.yml \
		.pipeline/112-foreground-filter-calibrated-even-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-even-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-even-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-even-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-even-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-even-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-even-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-even-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-even-none.yml \
		.pipeline/103-full-rank-compression-calibrated-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-even-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-even-none.yml \
		.pipeline/112-foreground-filter-calibrated-even-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-even-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-even-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-even-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-even-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-even-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-even-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-none-cylindrical
	$(launch)

.pipeline/030-m-modes-calibrated-day: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-calibrated-day.yml \
		.pipeline/001-calibrated-transposed-data \
		.pipeline/002-flagged-calibrated-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-calibrated-day: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-calibrated-day.yml \
		.pipeline/001-calibrated-transposed-data \
		.pipeline/002-flagged-calibrated-data \
		.pipeline/032-predicted-visibilities-calibrated \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-calibrated-day: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-calibrated-day.yml \
		.pipeline/030-m-modes-interpolated-calibrated-all \
		.pipeline/030-m-modes-interpolated-calibrated-day
	$(call launch-remote,1)

.pipeline/031-dirty-map-calibrated-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-calibrated-day.yml \
		.pipeline/030-m-modes-calibrated-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-calibrated-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-calibrated-day.yml \
		.pipeline/030-m-modes-calibrated-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-calibrated-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-calibrated-day.yml \
		.pipeline/033-transfer-flags-calibrated-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-calibrated-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-calibrated-day.yml \
		.pipeline/033-transfer-flags-calibrated-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-calibrated-day: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-calibrated-day.yml \
		.pipeline/033-transfer-flags-calibrated-day
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-calibrated-day: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-day.yml \
		.pipeline/101-averaged-m-modes-calibrated-day \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-day
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-calibrated-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-calibrated-day.yml \
		.pipeline/103-full-rank-compression-calibrated-day
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-day-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-day-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-day-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-day-extreme.yml \
		.pipeline/112-foreground-filter-calibrated-day-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-day-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-day-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-day-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-day-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-day-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-day-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-day-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-day-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-day-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-day-moderate.yml \
		.pipeline/112-foreground-filter-calibrated-day-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-day-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-day-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-day-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-day-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-day-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-day-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-day-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-day-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-day-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-day-mild.yml \
		.pipeline/112-foreground-filter-calibrated-day-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-day-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-day-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-day-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-day-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-day-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-day-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-day-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-day-none.yml \
		.pipeline/103-full-rank-compression-calibrated-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-day-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-day-none.yml \
		.pipeline/112-foreground-filter-calibrated-day-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-day-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-day-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-day-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-day-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-day-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-day-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-none-cylindrical
	$(launch)

.pipeline/030-m-modes-calibrated-night: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-calibrated-night.yml \
		.pipeline/001-calibrated-transposed-data \
		.pipeline/002-flagged-calibrated-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-calibrated-night: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-calibrated-night.yml \
		.pipeline/001-calibrated-transposed-data \
		.pipeline/002-flagged-calibrated-data \
		.pipeline/032-predicted-visibilities-calibrated \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-calibrated-night: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-calibrated-night.yml \
		.pipeline/030-m-modes-interpolated-calibrated-all \
		.pipeline/030-m-modes-interpolated-calibrated-night
	$(call launch-remote,1)

.pipeline/031-dirty-map-calibrated-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-calibrated-night.yml \
		.pipeline/030-m-modes-calibrated-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-calibrated-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-calibrated-night.yml \
		.pipeline/030-m-modes-calibrated-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-calibrated-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-calibrated-night.yml \
		.pipeline/033-transfer-flags-calibrated-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-calibrated-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-calibrated-night.yml \
		.pipeline/033-transfer-flags-calibrated-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-calibrated-night: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-calibrated-night.yml \
		.pipeline/033-transfer-flags-calibrated-night
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-calibrated-night: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-night.yml \
		.pipeline/101-averaged-m-modes-calibrated-night \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-night
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-calibrated-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-calibrated-night.yml \
		.pipeline/103-full-rank-compression-calibrated-night
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-night-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-night-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-night-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-night-extreme.yml \
		.pipeline/112-foreground-filter-calibrated-night-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-night-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-night-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-night-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-night-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-night-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-night-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-night-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-night-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-night-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-night-moderate.yml \
		.pipeline/112-foreground-filter-calibrated-night-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-night-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-night-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-night-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-night-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-night-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-night-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-night-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-night-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-night-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-night-mild.yml \
		.pipeline/112-foreground-filter-calibrated-night-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-night-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-night-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-night-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-night-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-night-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-night-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-night-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-night-none.yml \
		.pipeline/103-full-rank-compression-calibrated-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-night-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-night-none.yml \
		.pipeline/112-foreground-filter-calibrated-night-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-night-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-night-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-night-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-night-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-night-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-night-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-none-cylindrical
	$(launch)

.pipeline/030-m-modes-interpolated-calibrated-xx: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-calibrated-xx.yml \
		.pipeline/001-calibrated-transposed-data-xx \
		.pipeline/002-flagged-calibrated-data \
		.pipeline/032-predicted-visibilities-calibrated \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/033-transfer-flags-calibrated-xx: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-calibrated-xx.yml \
		.pipeline/030-m-modes-interpolated-calibrated-all \
		.pipeline/030-m-modes-interpolated-calibrated-xx
	$(call launch-remote,1)

.pipeline/031-dirty-map-calibrated-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-calibrated-xx.yml \
		.pipeline/030-m-modes-calibrated-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-calibrated-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-calibrated-xx.yml \
		.pipeline/030-m-modes-calibrated-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-calibrated-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-calibrated-xx.yml \
		.pipeline/033-transfer-flags-calibrated-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-calibrated-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-calibrated-xx.yml \
		.pipeline/033-transfer-flags-calibrated-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-calibrated-xx: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-calibrated-xx.yml \
		.pipeline/033-transfer-flags-calibrated-xx
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-calibrated-xx: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-xx.yml \
		.pipeline/101-averaged-m-modes-calibrated-xx \
		.pipeline/101-averaged-transfer-matrix-xx \
		.pipeline/102-noise-covariance-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-calibrated-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-calibrated-xx.yml \
		.pipeline/103-full-rank-compression-calibrated-xx
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-xx-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-xx-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-xx-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-xx-extreme.yml \
		.pipeline/112-foreground-filter-calibrated-xx-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-xx-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-xx-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-xx-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-xx-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-xx-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-xx-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-xx-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-xx-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-xx-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-xx-moderate.yml \
		.pipeline/112-foreground-filter-calibrated-xx-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-xx-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-xx-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-xx-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-xx-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-xx-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-xx-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-xx-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-xx-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-xx-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-xx-mild.yml \
		.pipeline/112-foreground-filter-calibrated-xx-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-xx-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-xx-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-xx-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-xx-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-xx-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-xx-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-xx-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-xx-none.yml \
		.pipeline/103-full-rank-compression-calibrated-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-xx-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-xx-none.yml \
		.pipeline/112-foreground-filter-calibrated-xx-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-xx-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-xx-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-xx-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-xx-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-xx-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-xx-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-none-cylindrical
	$(launch)

.pipeline/030-m-modes-interpolated-calibrated-yy: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-calibrated-yy.yml \
		.pipeline/001-calibrated-transposed-data-yy \
		.pipeline/002-flagged-calibrated-data \
		.pipeline/032-predicted-visibilities-calibrated \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/033-transfer-flags-calibrated-yy: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-calibrated-yy.yml \
		.pipeline/030-m-modes-interpolated-calibrated-all \
		.pipeline/030-m-modes-interpolated-calibrated-yy
	$(call launch-remote,1)

.pipeline/031-dirty-map-calibrated-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-calibrated-yy.yml \
		.pipeline/030-m-modes-calibrated-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-calibrated-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-calibrated-yy.yml \
		.pipeline/030-m-modes-calibrated-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-calibrated-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-calibrated-yy.yml \
		.pipeline/033-transfer-flags-calibrated-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-calibrated-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-calibrated-yy.yml \
		.pipeline/033-transfer-flags-calibrated-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-calibrated-yy: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-calibrated-yy.yml \
		.pipeline/033-transfer-flags-calibrated-yy
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-calibrated-yy: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-yy.yml \
		.pipeline/101-averaged-m-modes-calibrated-yy \
		.pipeline/101-averaged-transfer-matrix-yy \
		.pipeline/102-noise-covariance-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-calibrated-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-calibrated-yy.yml \
		.pipeline/103-full-rank-compression-calibrated-yy
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-yy-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-yy-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-yy-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-yy-extreme.yml \
		.pipeline/112-foreground-filter-calibrated-yy-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-yy-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-yy-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-yy-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-yy-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-yy-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-yy-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-yy-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-yy-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-yy-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-yy-moderate.yml \
		.pipeline/112-foreground-filter-calibrated-yy-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-yy-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-yy-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-yy-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-yy-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-yy-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-yy-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-yy-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-yy-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-yy-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-yy-mild.yml \
		.pipeline/112-foreground-filter-calibrated-yy-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-yy-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-yy-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-yy-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-yy-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-yy-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-yy-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-yy-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-yy-none.yml \
		.pipeline/103-full-rank-compression-calibrated-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-calibrated-yy-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-calibrated-yy-none.yml \
		.pipeline/112-foreground-filter-calibrated-yy-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-calibrated-yy-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-yy-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-yy-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-yy-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-yy-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-yy-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-none-cylindrical
	$(launch)

.pipeline/032-predicted-visibilities-calibrated: \
		$(LIB)/032-predict-visibilities.jl project.yml generated-config-files/032-predict-visibilities-calibrated.yml \
		.pipeline/031-dirty-map-calibrated-all \
		.pipeline/100-transfer-matrix
	$(call launch-remote,2)

.pipeline/033-transfer-flags-calibrated: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-predicted-calibrated.yml \
		.pipeline/030-m-modes-interpolated-calibrated-all \
		.pipeline/032-predicted-visibilities-calibrated
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-predicted-calibrated: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-predicted-calibrated.yml \
		.pipeline/033-transfer-flags-calibrated
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-predicted-calibrated: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-predicted-calibrated.yml \
		.pipeline/101-averaged-m-modes-predicted-calibrated \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-predicted-calibrated-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-calibrated-extreme.yml \
		.pipeline/103-full-rank-compression-predicted-calibrated \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-calibrated-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-calibrated-extreme-spherical.yml \
		.pipeline/112-foreground-filter-predicted-calibrated-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-calibrated-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-calibrated-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-calibrated-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-predicted-calibrated-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-calibrated-moderate.yml \
		.pipeline/103-full-rank-compression-predicted-calibrated \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-calibrated-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-calibrated-moderate-spherical.yml \
		.pipeline/112-foreground-filter-predicted-calibrated-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-calibrated-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-calibrated-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-calibrated-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-predicted-calibrated-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-calibrated-mild.yml \
		.pipeline/103-full-rank-compression-predicted-calibrated \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-calibrated-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-calibrated-mild-spherical.yml \
		.pipeline/112-foreground-filter-predicted-calibrated-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-calibrated-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-calibrated-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-calibrated-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-predicted-calibrated-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-calibrated-none.yml \
		.pipeline/103-full-rank-compression-predicted-calibrated \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-calibrated-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-calibrated-none-spherical.yml \
		.pipeline/112-foreground-filter-predicted-calibrated-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-calibrated-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-calibrated-none-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-calibrated-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-calibrated-small-gain-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-calibrated-small-gain-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-calibrated
	$(launch)

.pipeline/103-full-rank-compression-calibrated-small-gain-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-small-gain-errors.yml \
		.pipeline/101-averaged-m-modes-calibrated-small-gain-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-small-gain-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-small-gain-errors-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-small-gain-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-small-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-small-gain-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-small-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-small-gain-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-small-gain-errors-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-small-gain-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-small-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-small-gain-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-small-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-small-gain-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-small-gain-errors-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-small-gain-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-small-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-small-gain-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-small-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-small-gain-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-small-gain-errors-none.yml \
		.pipeline/103-full-rank-compression-calibrated-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-small-gain-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-small-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-small-gain-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-small-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-calibrated-medium-gain-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-calibrated-medium-gain-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-calibrated
	$(launch)

.pipeline/103-full-rank-compression-calibrated-medium-gain-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-medium-gain-errors.yml \
		.pipeline/101-averaged-m-modes-calibrated-medium-gain-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-medium-gain-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-medium-gain-errors-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-medium-gain-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-medium-gain-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-medium-gain-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-medium-gain-errors-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-medium-gain-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-medium-gain-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-medium-gain-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-medium-gain-errors-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-medium-gain-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-medium-gain-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-medium-gain-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-medium-gain-errors-none.yml \
		.pipeline/103-full-rank-compression-calibrated-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-medium-gain-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-medium-gain-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-calibrated-large-gain-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-calibrated-large-gain-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-calibrated
	$(launch)

.pipeline/103-full-rank-compression-calibrated-large-gain-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-large-gain-errors.yml \
		.pipeline/101-averaged-m-modes-calibrated-large-gain-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-large-gain-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-large-gain-errors-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-large-gain-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-large-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-large-gain-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-large-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-large-gain-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-large-gain-errors-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-large-gain-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-large-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-large-gain-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-large-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-large-gain-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-large-gain-errors-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-large-gain-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-large-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-large-gain-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-large-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-large-gain-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-large-gain-errors-none.yml \
		.pipeline/103-full-rank-compression-calibrated-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-large-gain-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-large-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-large-gain-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-large-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-calibrated-small-bandpass-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-calibrated-small-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-calibrated
	$(launch)

.pipeline/103-full-rank-compression-calibrated-small-bandpass-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-small-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-calibrated-small-bandpass-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-small-bandpass-errors-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-small-bandpass-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-small-bandpass-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-small-bandpass-errors-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-small-bandpass-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-small-bandpass-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-small-bandpass-errors-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-small-bandpass-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-small-bandpass-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-small-bandpass-errors-none.yml \
		.pipeline/103-full-rank-compression-calibrated-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-small-bandpass-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-small-bandpass-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-small-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-small-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-calibrated-medium-bandpass-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-calibrated-medium-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-calibrated
	$(launch)

.pipeline/103-full-rank-compression-calibrated-medium-bandpass-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-medium-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-calibrated-medium-bandpass-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-medium-bandpass-errors-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-medium-bandpass-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-medium-bandpass-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-medium-bandpass-errors-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-medium-bandpass-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-medium-bandpass-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-medium-bandpass-errors-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-medium-bandpass-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-medium-bandpass-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-medium-bandpass-errors-none.yml \
		.pipeline/103-full-rank-compression-calibrated-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-medium-bandpass-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-medium-bandpass-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-medium-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-medium-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-calibrated-large-bandpass-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-calibrated-large-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-calibrated
	$(launch)

.pipeline/103-full-rank-compression-calibrated-large-bandpass-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-large-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-calibrated-large-bandpass-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-large-bandpass-errors-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-large-bandpass-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-large-bandpass-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-large-bandpass-errors-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-large-bandpass-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-large-bandpass-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-large-bandpass-errors-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-large-bandpass-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-large-bandpass-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-large-bandpass-errors-none.yml \
		.pipeline/103-full-rank-compression-calibrated-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-large-bandpass-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-large-bandpass-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-large-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-large-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-none-cylindrical
	$(launch)

.pipeline/032-predicted-visibilities-calibrated-error: \
		$(LIB)/301-mess-with-noise.jl project.yml generated-config-files/301-mess-with-noise-calibrated-sidereal-noise.yml \
		.pipeline/032-predicted-visibilities-calibrated
	$(launch)

.pipeline/030-m-modes-calibrated-sidereal-noise: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-calibrated-sidereal-noise.yml \
		.pipeline/032-predicted-visibilities-calibrated-sidereal-noise \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-calibrated-sidereal-noise: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-calibrated-sidereal-noise.yml \
		.pipeline/033-transfer-flags-calibrated-sidereal-noise
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-calibrated-sidereal-noise: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-sidereal-noise.yml \
		.pipeline/101-averaged-m-modes-calibrated-sidereal-noise \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-sidereal-noise
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-sidereal-noise-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-sidereal-noise-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-sidereal-noise-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-sidereal-noise-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-sidereal-noise-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-sidereal-noise-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-sidereal-noise-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-sidereal-noise-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-sidereal-noise-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-sidereal-noise-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-sidereal-noise-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-sidereal-noise-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-sidereal-noise-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-sidereal-noise-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-sidereal-noise-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-sidereal-noise-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-sidereal-noise-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-sidereal-noise-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-sidereal-noise-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-sidereal-noise-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-sidereal-noise-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-sidereal-noise-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-sidereal-noise-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-sidereal-noise-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-sidereal-noise-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-sidereal-noise-none.yml \
		.pipeline/103-full-rank-compression-calibrated-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-sidereal-noise-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-sidereal-noise-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-sidereal-noise-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-sidereal-noise-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-sidereal-noise-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-sidereal-noise-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-none-cylindrical
	$(launch)

.pipeline/032-predicted-visibilities-calibrated-error: \
		$(LIB)/301-mess-with-noise.jl project.yml generated-config-files/301-mess-with-noise-calibrated-constant-noise.yml \
		.pipeline/032-predicted-visibilities-calibrated
	$(launch)

.pipeline/030-m-modes-calibrated-constant-noise: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-calibrated-constant-noise.yml \
		.pipeline/032-predicted-visibilities-calibrated-constant-noise \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-calibrated-constant-noise: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-calibrated-constant-noise.yml \
		.pipeline/033-transfer-flags-calibrated-constant-noise
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-calibrated-constant-noise: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-calibrated-constant-noise.yml \
		.pipeline/101-averaged-m-modes-calibrated-constant-noise \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-constant-noise
	$(call launch-remote,1)

.pipeline/112-foreground-filter-calibrated-constant-noise-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-constant-noise-extreme.yml \
		.pipeline/103-full-rank-compression-calibrated-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-constant-noise-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-constant-noise-extreme-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-constant-noise-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-constant-noise-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-constant-noise-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-constant-noise-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-constant-noise-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-constant-noise-moderate.yml \
		.pipeline/103-full-rank-compression-calibrated-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-constant-noise-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-constant-noise-moderate-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-constant-noise-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-constant-noise-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-constant-noise-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-constant-noise-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-constant-noise-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-constant-noise-mild.yml \
		.pipeline/103-full-rank-compression-calibrated-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-constant-noise-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-constant-noise-mild-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-constant-noise-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-constant-noise-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-constant-noise-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-constant-noise-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-calibrated-constant-noise-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-calibrated-constant-noise-none.yml \
		.pipeline/103-full-rank-compression-calibrated-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-calibrated-constant-noise-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-constant-noise-none-spherical.yml \
		.pipeline/112-foreground-filter-calibrated-constant-noise-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-calibrated-constant-noise-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-calibrated-constant-noise-none-cylindrical.yml \
		.pipeline/112-foreground-filter-calibrated-constant-noise-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-none-cylindrical
	$(launch)

.pipeline/030-m-modes-peeled-all: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-peeled-all.yml \
		.pipeline/001-peeled-transposed-data \
		.pipeline/002-flagged-peeled-data \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,2)

.pipeline/030-m-modes-interpolated-peeled-all: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-peeled-all.yml \
		.pipeline/001-peeled-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-peeled \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-peeled-all: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-peeled-all.yml \
		.pipeline/030-m-modes-interpolated-peeled-all \
		.pipeline/030-m-modes-interpolated-peeled-all
	$(call launch-remote,1)

.pipeline/031-dirty-map-peeled-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-peeled-all.yml \
		.pipeline/030-m-modes-peeled-all \
		#.pipeline/100-transfer-matrix
	$(call launch-remote,16)

.pipeline/031-dirty-channel-maps-peeled-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-peeled-all.yml \
		.pipeline/030-m-modes-peeled-all \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-peeled-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-peeled-all.yml \
		.pipeline/033-transfer-flags-peeled-all \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-peeled-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-peeled-all.yml \
		.pipeline/033-transfer-flags-peeled-all \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-peeled-all: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-peeled-all.yml \
		.pipeline/033-transfer-flags-peeled-all
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-peeled-all: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-all.yml \
		.pipeline/101-averaged-m-modes-peeled-all \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-peeled-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-peeled-all.yml \
		.pipeline/103-full-rank-compression-peeled-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-all-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-all-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-all-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-all-extreme.yml \
		.pipeline/112-foreground-filter-peeled-all-extreme
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-all-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-all-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-all-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-all-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-all-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-all-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-all-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-all-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-all-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-all-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-all-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-all-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-all-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-all-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-all-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-all-moderate.yml \
		.pipeline/112-foreground-filter-peeled-all-moderate
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-all-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-all-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-all-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-all-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-all-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-all-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-all-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-all-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-all-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-all-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-all-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-all-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-all-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-all-mild.yml \
		.pipeline/103-full-rank-compression-peeled-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-all-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-all-mild.yml \
		.pipeline/112-foreground-filter-peeled-all-mild
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-all-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-all-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-all-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-all-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-all-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-all-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-all-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-all-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-all-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-all-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-all-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-all-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-all-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-all-none.yml \
		.pipeline/103-full-rank-compression-peeled-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-all-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-all-none.yml \
		.pipeline/112-foreground-filter-peeled-all-none
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-all-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-all-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-all-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-all-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-all-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-all-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-all-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-all-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-all-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-all-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-all-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-all-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-none-cylindrical
	$(launch)

.pipeline/030-m-modes-peeled-odd: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-peeled-odd.yml \
		.pipeline/001-peeled-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-peeled-odd: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-peeled-odd.yml \
		.pipeline/001-peeled-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-peeled \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-peeled-odd: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-peeled-odd.yml \
		.pipeline/030-m-modes-interpolated-peeled-all \
		.pipeline/030-m-modes-interpolated-peeled-odd
	$(call launch-remote,1)

.pipeline/031-dirty-map-peeled-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-peeled-odd.yml \
		.pipeline/030-m-modes-peeled-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-peeled-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-peeled-odd.yml \
		.pipeline/030-m-modes-peeled-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-peeled-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-peeled-odd.yml \
		.pipeline/033-transfer-flags-peeled-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-peeled-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-peeled-odd.yml \
		.pipeline/033-transfer-flags-peeled-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-peeled-odd: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-peeled-odd.yml \
		.pipeline/033-transfer-flags-peeled-odd
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-peeled-odd: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-odd.yml \
		.pipeline/101-averaged-m-modes-peeled-odd \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-odd
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-peeled-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-peeled-odd.yml \
		.pipeline/103-full-rank-compression-peeled-odd
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-odd-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-odd-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-odd-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-odd-extreme.yml \
		.pipeline/112-foreground-filter-peeled-odd-extreme
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-odd-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-odd-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-odd-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-odd-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-odd-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-odd-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-odd-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-odd-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-odd-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-odd-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-odd-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-odd-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-odd-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-odd-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-odd-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-odd-moderate.yml \
		.pipeline/112-foreground-filter-peeled-odd-moderate
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-odd-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-odd-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-odd-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-odd-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-odd-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-odd-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-odd-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-odd-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-odd-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-odd-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-odd-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-odd-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-odd-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-odd-mild.yml \
		.pipeline/103-full-rank-compression-peeled-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-odd-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-odd-mild.yml \
		.pipeline/112-foreground-filter-peeled-odd-mild
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-odd-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-odd-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-odd-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-odd-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-odd-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-odd-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-odd-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-odd-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-odd-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-odd-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-odd-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-odd-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-odd-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-odd-none.yml \
		.pipeline/103-full-rank-compression-peeled-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-odd-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-odd-none.yml \
		.pipeline/112-foreground-filter-peeled-odd-none
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-odd-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-odd-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-odd-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-odd-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-odd-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-odd-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-odd-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-odd-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-odd-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-odd-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-odd-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-odd-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-none-cylindrical
	$(launch)

.pipeline/030-m-modes-peeled-even: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-peeled-even.yml \
		.pipeline/001-peeled-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-peeled-even: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-peeled-even.yml \
		.pipeline/001-peeled-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-peeled \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-peeled-even: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-peeled-even.yml \
		.pipeline/030-m-modes-interpolated-peeled-all \
		.pipeline/030-m-modes-interpolated-peeled-even
	$(call launch-remote,1)

.pipeline/031-dirty-map-peeled-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-peeled-even.yml \
		.pipeline/030-m-modes-peeled-even \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-peeled-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-peeled-even.yml \
		.pipeline/030-m-modes-peeled-even \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-peeled-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-peeled-even.yml \
		.pipeline/033-transfer-flags-peeled-even \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-peeled-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-peeled-even.yml \
		.pipeline/033-transfer-flags-peeled-even \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-peeled-even: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-peeled-even.yml \
		.pipeline/033-transfer-flags-peeled-even
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-peeled-even: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-even.yml \
		.pipeline/101-averaged-m-modes-peeled-even \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-even
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-peeled-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-peeled-even.yml \
		.pipeline/103-full-rank-compression-peeled-even
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-even-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-even-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-even-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-even-extreme.yml \
		.pipeline/112-foreground-filter-peeled-even-extreme
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-even-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-even-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-even-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-even-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-even-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-even-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-even-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-even-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-even-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-even-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-even-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-even-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-even-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-even-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-even-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-even-moderate.yml \
		.pipeline/112-foreground-filter-peeled-even-moderate
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-even-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-even-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-even-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-even-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-even-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-even-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-even-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-even-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-even-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-even-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-even-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-even-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-even-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-even-mild.yml \
		.pipeline/103-full-rank-compression-peeled-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-even-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-even-mild.yml \
		.pipeline/112-foreground-filter-peeled-even-mild
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-even-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-even-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-even-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-even-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-even-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-even-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-even-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-even-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-even-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-even-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-even-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-even-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-even-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-even-none.yml \
		.pipeline/103-full-rank-compression-peeled-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-even-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-even-none.yml \
		.pipeline/112-foreground-filter-peeled-even-none
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-even-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-even-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-even-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-even-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-even-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-even-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-even-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-even-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-even-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-even-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-even-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-even-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-none-cylindrical
	$(launch)

.pipeline/030-m-modes-peeled-day: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-peeled-day.yml \
		.pipeline/001-peeled-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-peeled-day: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-peeled-day.yml \
		.pipeline/001-peeled-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-peeled \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-peeled-day: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-peeled-day.yml \
		.pipeline/030-m-modes-interpolated-peeled-all \
		.pipeline/030-m-modes-interpolated-peeled-day
	$(call launch-remote,1)

.pipeline/031-dirty-map-peeled-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-peeled-day.yml \
		.pipeline/030-m-modes-peeled-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-peeled-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-peeled-day.yml \
		.pipeline/030-m-modes-peeled-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-peeled-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-peeled-day.yml \
		.pipeline/033-transfer-flags-peeled-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-peeled-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-peeled-day.yml \
		.pipeline/033-transfer-flags-peeled-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-peeled-day: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-peeled-day.yml \
		.pipeline/033-transfer-flags-peeled-day
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-peeled-day: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-day.yml \
		.pipeline/101-averaged-m-modes-peeled-day \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-day
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-peeled-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-peeled-day.yml \
		.pipeline/103-full-rank-compression-peeled-day
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-day-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-day-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-day-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-day-extreme.yml \
		.pipeline/112-foreground-filter-peeled-day-extreme
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-day-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-day-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-day-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-day-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-day-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-day-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-day-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-day-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-day-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-day-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-day-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-day-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-day-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-day-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-day-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-day-moderate.yml \
		.pipeline/112-foreground-filter-peeled-day-moderate
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-day-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-day-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-day-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-day-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-day-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-day-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-day-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-day-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-day-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-day-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-day-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-day-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-day-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-day-mild.yml \
		.pipeline/103-full-rank-compression-peeled-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-day-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-day-mild.yml \
		.pipeline/112-foreground-filter-peeled-day-mild
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-day-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-day-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-day-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-day-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-day-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-day-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-day-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-day-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-day-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-day-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-day-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-day-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-day-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-day-none.yml \
		.pipeline/103-full-rank-compression-peeled-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-day-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-day-none.yml \
		.pipeline/112-foreground-filter-peeled-day-none
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-day-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-day-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-day-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-day-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-day-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-day-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-day-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-day-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-day-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-day-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-day-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-day-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-none-cylindrical
	$(launch)

.pipeline/030-m-modes-peeled-night: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-peeled-night.yml \
		.pipeline/001-peeled-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-peeled-night: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-peeled-night.yml \
		.pipeline/001-peeled-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-peeled \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-peeled-night: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-peeled-night.yml \
		.pipeline/030-m-modes-interpolated-peeled-all \
		.pipeline/030-m-modes-interpolated-peeled-night
	$(call launch-remote,1)

.pipeline/031-dirty-map-peeled-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-peeled-night.yml \
		.pipeline/030-m-modes-peeled-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-peeled-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-peeled-night.yml \
		.pipeline/030-m-modes-peeled-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-peeled-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-peeled-night.yml \
		.pipeline/033-transfer-flags-peeled-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-peeled-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-peeled-night.yml \
		.pipeline/033-transfer-flags-peeled-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-peeled-night: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-peeled-night.yml \
		.pipeline/033-transfer-flags-peeled-night
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-peeled-night: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-night.yml \
		.pipeline/101-averaged-m-modes-peeled-night \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-night
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-peeled-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-peeled-night.yml \
		.pipeline/103-full-rank-compression-peeled-night
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-night-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-night-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-night-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-night-extreme.yml \
		.pipeline/112-foreground-filter-peeled-night-extreme
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-night-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-night-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-night-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-night-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-night-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-night-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-night-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-night-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-night-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-night-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-night-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-night-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-night-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-night-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-night-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-night-moderate.yml \
		.pipeline/112-foreground-filter-peeled-night-moderate
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-night-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-night-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-night-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-night-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-night-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-night-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-night-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-night-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-night-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-night-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-night-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-night-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-night-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-night-mild.yml \
		.pipeline/103-full-rank-compression-peeled-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-night-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-night-mild.yml \
		.pipeline/112-foreground-filter-peeled-night-mild
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-night-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-night-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-night-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-night-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-night-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-night-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-night-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-night-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-night-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-night-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-night-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-night-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-night-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-night-none.yml \
		.pipeline/103-full-rank-compression-peeled-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-night-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-night-none.yml \
		.pipeline/112-foreground-filter-peeled-night-none
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-night-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-night-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-night-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-night-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-night-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-night-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-night-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-night-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-night-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-night-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-night-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-night-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-none-cylindrical
	$(launch)

.pipeline/030-m-modes-interpolated-peeled-xx: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-peeled-xx.yml \
		.pipeline/001-peeled-transposed-data-xx \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-peeled \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/033-transfer-flags-peeled-xx: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-peeled-xx.yml \
		.pipeline/030-m-modes-interpolated-peeled-all \
		.pipeline/030-m-modes-interpolated-peeled-xx
	$(call launch-remote,1)

.pipeline/031-dirty-map-peeled-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-peeled-xx.yml \
		.pipeline/030-m-modes-peeled-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-peeled-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-peeled-xx.yml \
		.pipeline/030-m-modes-peeled-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-peeled-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-peeled-xx.yml \
		.pipeline/033-transfer-flags-peeled-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-peeled-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-peeled-xx.yml \
		.pipeline/033-transfer-flags-peeled-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-peeled-xx: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-peeled-xx.yml \
		.pipeline/033-transfer-flags-peeled-xx
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-peeled-xx: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-xx.yml \
		.pipeline/101-averaged-m-modes-peeled-xx \
		.pipeline/101-averaged-transfer-matrix-xx \
		.pipeline/102-noise-covariance-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-peeled-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-peeled-xx.yml \
		.pipeline/103-full-rank-compression-peeled-xx
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-xx-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-xx-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-xx-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-xx-extreme.yml \
		.pipeline/112-foreground-filter-peeled-xx-extreme
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-xx-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-xx-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-xx-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-xx-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-xx-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-xx-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-xx-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-xx-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-xx-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-xx-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-xx-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-xx-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-xx-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-xx-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-xx-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-xx-moderate.yml \
		.pipeline/112-foreground-filter-peeled-xx-moderate
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-xx-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-xx-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-xx-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-xx-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-xx-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-xx-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-xx-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-xx-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-xx-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-xx-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-xx-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-xx-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-xx-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-xx-mild.yml \
		.pipeline/103-full-rank-compression-peeled-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-xx-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-xx-mild.yml \
		.pipeline/112-foreground-filter-peeled-xx-mild
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-xx-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-xx-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-xx-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-xx-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-xx-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-xx-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-xx-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-xx-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-xx-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-xx-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-xx-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-xx-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-xx-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-xx-none.yml \
		.pipeline/103-full-rank-compression-peeled-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-xx-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-xx-none.yml \
		.pipeline/112-foreground-filter-peeled-xx-none
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-xx-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-xx-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-xx-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-xx-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-xx-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-xx-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-xx-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-xx-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-xx-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-xx-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-xx-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-xx-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-none-cylindrical
	$(launch)

.pipeline/030-m-modes-interpolated-peeled-yy: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-peeled-yy.yml \
		.pipeline/001-peeled-transposed-data-yy \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-peeled \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/033-transfer-flags-peeled-yy: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-peeled-yy.yml \
		.pipeline/030-m-modes-interpolated-peeled-all \
		.pipeline/030-m-modes-interpolated-peeled-yy
	$(call launch-remote,1)

.pipeline/031-dirty-map-peeled-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-peeled-yy.yml \
		.pipeline/030-m-modes-peeled-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-peeled-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-peeled-yy.yml \
		.pipeline/030-m-modes-peeled-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-peeled-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-peeled-yy.yml \
		.pipeline/033-transfer-flags-peeled-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-peeled-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-peeled-yy.yml \
		.pipeline/033-transfer-flags-peeled-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-peeled-yy: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-peeled-yy.yml \
		.pipeline/033-transfer-flags-peeled-yy
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-peeled-yy: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-yy.yml \
		.pipeline/101-averaged-m-modes-peeled-yy \
		.pipeline/101-averaged-transfer-matrix-yy \
		.pipeline/102-noise-covariance-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-peeled-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-peeled-yy.yml \
		.pipeline/103-full-rank-compression-peeled-yy
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-yy-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-yy-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-yy-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-yy-extreme.yml \
		.pipeline/112-foreground-filter-peeled-yy-extreme
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-yy-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-yy-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-yy-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-yy-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-yy-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-yy-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-yy-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-yy-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-yy-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-yy-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-yy-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-yy-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-yy-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-yy-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-yy-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-yy-moderate.yml \
		.pipeline/112-foreground-filter-peeled-yy-moderate
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-yy-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-yy-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-yy-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-yy-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-yy-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-yy-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-yy-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-yy-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-yy-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-yy-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-yy-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-yy-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-yy-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-yy-mild.yml \
		.pipeline/103-full-rank-compression-peeled-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-yy-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-yy-mild.yml \
		.pipeline/112-foreground-filter-peeled-yy-mild
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-yy-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-yy-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-yy-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-yy-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-yy-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-yy-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-yy-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-yy-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-yy-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-yy-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-yy-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-yy-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-yy-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-yy-none.yml \
		.pipeline/103-full-rank-compression-peeled-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-peeled-yy-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-peeled-yy-none.yml \
		.pipeline/112-foreground-filter-peeled-yy-none
	$(call launch-remote,1)

.pipeline/121-fisher-matrix-yy-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-yy-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-yy-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-yy-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-yy-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-yy-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-yy-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-yy-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-yy-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-yy-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-yy-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-yy-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-none-cylindrical
	$(launch)

.pipeline/032-predicted-visibilities-peeled: \
		$(LIB)/032-predict-visibilities.jl project.yml generated-config-files/032-predict-visibilities-peeled.yml \
		.pipeline/031-dirty-map-peeled-all \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-peeled: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-predicted-peeled.yml \
		.pipeline/030-m-modes-interpolated-peeled-all \
		.pipeline/032-predicted-visibilities-peeled
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-predicted-peeled: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-predicted-peeled.yml \
		.pipeline/033-transfer-flags-peeled
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-predicted-peeled: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-predicted-peeled.yml \
		.pipeline/101-averaged-m-modes-predicted-peeled \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-predicted-peeled-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-peeled-extreme.yml \
		.pipeline/103-full-rank-compression-predicted-peeled \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-peeled-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-peeled-extreme-spherical.yml \
		.pipeline/112-foreground-filter-predicted-peeled-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-peeled-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-peeled-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-peeled-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-predicted-peeled-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-peeled-moderate.yml \
		.pipeline/103-full-rank-compression-predicted-peeled \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-peeled-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-peeled-moderate-spherical.yml \
		.pipeline/112-foreground-filter-predicted-peeled-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-peeled-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-peeled-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-peeled-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-predicted-peeled-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-peeled-mild.yml \
		.pipeline/103-full-rank-compression-predicted-peeled \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-peeled-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-peeled-mild-spherical.yml \
		.pipeline/112-foreground-filter-predicted-peeled-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-peeled-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-peeled-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-peeled-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-predicted-peeled-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-peeled-none.yml \
		.pipeline/103-full-rank-compression-predicted-peeled \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-peeled-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-peeled-none-spherical.yml \
		.pipeline/112-foreground-filter-predicted-peeled-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-peeled-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-peeled-none-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-peeled-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-peeled-small-gain-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-peeled-small-gain-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-peeled
	$(launch)

.pipeline/103-full-rank-compression-peeled-small-gain-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-small-gain-errors.yml \
		.pipeline/101-averaged-m-modes-peeled-small-gain-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-small-gain-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-small-gain-errors-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-small-gain-errors-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-small-gain-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-small-gain-errors-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-small-gain-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-small-gain-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-small-gain-errors-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-small-gain-errors-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-small-gain-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-small-gain-errors-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-small-gain-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-small-gain-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-small-gain-errors-mild.yml \
		.pipeline/103-full-rank-compression-peeled-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-small-gain-errors-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-small-gain-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-small-gain-errors-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-small-gain-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-small-gain-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-small-gain-errors-none.yml \
		.pipeline/103-full-rank-compression-peeled-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-small-gain-errors-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-small-gain-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-small-gain-errors-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-small-gain-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-peeled-medium-gain-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-peeled-medium-gain-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-peeled
	$(launch)

.pipeline/103-full-rank-compression-peeled-medium-gain-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-medium-gain-errors.yml \
		.pipeline/101-averaged-m-modes-peeled-medium-gain-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-medium-gain-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-medium-gain-errors-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-medium-gain-errors-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-medium-gain-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-medium-gain-errors-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-medium-gain-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-medium-gain-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-medium-gain-errors-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-medium-gain-errors-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-medium-gain-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-medium-gain-errors-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-medium-gain-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-medium-gain-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-medium-gain-errors-mild.yml \
		.pipeline/103-full-rank-compression-peeled-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-medium-gain-errors-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-medium-gain-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-medium-gain-errors-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-medium-gain-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-medium-gain-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-medium-gain-errors-none.yml \
		.pipeline/103-full-rank-compression-peeled-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-medium-gain-errors-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-medium-gain-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-medium-gain-errors-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-medium-gain-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-peeled-large-gain-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-peeled-large-gain-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-peeled
	$(launch)

.pipeline/103-full-rank-compression-peeled-large-gain-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-large-gain-errors.yml \
		.pipeline/101-averaged-m-modes-peeled-large-gain-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-large-gain-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-large-gain-errors-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-large-gain-errors-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-large-gain-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-large-gain-errors-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-large-gain-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-large-gain-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-large-gain-errors-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-large-gain-errors-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-large-gain-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-large-gain-errors-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-large-gain-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-large-gain-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-large-gain-errors-mild.yml \
		.pipeline/103-full-rank-compression-peeled-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-large-gain-errors-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-large-gain-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-large-gain-errors-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-large-gain-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-large-gain-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-large-gain-errors-none.yml \
		.pipeline/103-full-rank-compression-peeled-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-large-gain-errors-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-large-gain-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-large-gain-errors-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-large-gain-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-peeled-small-bandpass-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-peeled-small-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-peeled
	$(launch)

.pipeline/103-full-rank-compression-peeled-small-bandpass-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-small-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-peeled-small-bandpass-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-small-bandpass-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-small-bandpass-errors-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-small-bandpass-errors-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-small-bandpass-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-small-bandpass-errors-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-small-bandpass-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-small-bandpass-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-small-bandpass-errors-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-small-bandpass-errors-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-small-bandpass-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-small-bandpass-errors-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-small-bandpass-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-small-bandpass-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-small-bandpass-errors-mild.yml \
		.pipeline/103-full-rank-compression-peeled-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-small-bandpass-errors-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-small-bandpass-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-small-bandpass-errors-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-small-bandpass-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-small-bandpass-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-small-bandpass-errors-none.yml \
		.pipeline/103-full-rank-compression-peeled-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-small-bandpass-errors-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-small-bandpass-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-small-bandpass-errors-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-small-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-small-bandpass-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-small-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-small-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-peeled-medium-bandpass-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-peeled-medium-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-peeled
	$(launch)

.pipeline/103-full-rank-compression-peeled-medium-bandpass-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-medium-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-peeled-medium-bandpass-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-medium-bandpass-errors-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-medium-bandpass-errors-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-medium-bandpass-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-medium-bandpass-errors-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-medium-bandpass-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-medium-bandpass-errors-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-medium-bandpass-errors-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-medium-bandpass-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-medium-bandpass-errors-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-medium-bandpass-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-medium-bandpass-errors-mild.yml \
		.pipeline/103-full-rank-compression-peeled-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-medium-bandpass-errors-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-medium-bandpass-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-medium-bandpass-errors-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-medium-bandpass-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-medium-bandpass-errors-none.yml \
		.pipeline/103-full-rank-compression-peeled-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-medium-bandpass-errors-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-medium-bandpass-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-medium-bandpass-errors-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-medium-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-medium-bandpass-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-medium-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-medium-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-peeled-large-bandpass-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-peeled-large-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-peeled
	$(launch)

.pipeline/103-full-rank-compression-peeled-large-bandpass-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-large-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-peeled-large-bandpass-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-large-bandpass-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-large-bandpass-errors-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-large-bandpass-errors-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-large-bandpass-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-large-bandpass-errors-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-large-bandpass-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-large-bandpass-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-large-bandpass-errors-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-large-bandpass-errors-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-large-bandpass-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-large-bandpass-errors-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-large-bandpass-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-large-bandpass-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-large-bandpass-errors-mild.yml \
		.pipeline/103-full-rank-compression-peeled-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-large-bandpass-errors-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-large-bandpass-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-large-bandpass-errors-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-large-bandpass-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-large-bandpass-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-large-bandpass-errors-none.yml \
		.pipeline/103-full-rank-compression-peeled-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-large-bandpass-errors-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-large-bandpass-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-large-bandpass-errors-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-large-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-large-bandpass-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-large-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-large-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-none-cylindrical
	$(launch)

.pipeline/032-predicted-visibilities-peeled-error: \
		$(LIB)/301-mess-with-noise.jl project.yml generated-config-files/301-mess-with-noise-peeled-sidereal-noise.yml \
		.pipeline/032-predicted-visibilities-peeled
	$(launch)

.pipeline/030-m-modes-peeled-sidereal-noise: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-peeled-sidereal-noise.yml \
		.pipeline/032-predicted-visibilities-peeled-sidereal-noise \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-peeled-sidereal-noise: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-peeled-sidereal-noise.yml \
		.pipeline/033-transfer-flags-peeled-sidereal-noise
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-peeled-sidereal-noise: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-sidereal-noise.yml \
		.pipeline/101-averaged-m-modes-peeled-sidereal-noise \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-sidereal-noise
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-sidereal-noise-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-sidereal-noise-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-sidereal-noise-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-sidereal-noise-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-sidereal-noise-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-sidereal-noise-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-sidereal-noise-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-sidereal-noise-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-sidereal-noise-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-sidereal-noise-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-sidereal-noise-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-sidereal-noise-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-sidereal-noise-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-sidereal-noise-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-sidereal-noise-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-sidereal-noise-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-sidereal-noise-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-sidereal-noise-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-sidereal-noise-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-sidereal-noise-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-sidereal-noise-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-sidereal-noise-mild.yml \
		.pipeline/103-full-rank-compression-peeled-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-sidereal-noise-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-sidereal-noise-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-sidereal-noise-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-sidereal-noise-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-sidereal-noise-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-sidereal-noise-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-sidereal-noise-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-sidereal-noise-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-sidereal-noise-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-sidereal-noise-none.yml \
		.pipeline/103-full-rank-compression-peeled-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-sidereal-noise-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-sidereal-noise-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-sidereal-noise-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-sidereal-noise-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-sidereal-noise-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-sidereal-noise-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-sidereal-noise-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-sidereal-noise-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-sidereal-noise-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-none-cylindrical
	$(launch)

.pipeline/032-predicted-visibilities-peeled-error: \
		$(LIB)/301-mess-with-noise.jl project.yml generated-config-files/301-mess-with-noise-peeled-constant-noise.yml \
		.pipeline/032-predicted-visibilities-peeled
	$(launch)

.pipeline/030-m-modes-peeled-constant-noise: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-peeled-constant-noise.yml \
		.pipeline/032-predicted-visibilities-peeled-constant-noise \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-peeled-constant-noise: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-peeled-constant-noise.yml \
		.pipeline/033-transfer-flags-peeled-constant-noise
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-peeled-constant-noise: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-peeled-constant-noise.yml \
		.pipeline/101-averaged-m-modes-peeled-constant-noise \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-constant-noise
	$(call launch-remote,1)

.pipeline/112-foreground-filter-peeled-constant-noise-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-constant-noise-extreme.yml \
		.pipeline/103-full-rank-compression-peeled-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-constant-noise-extreme-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-constant-noise-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-extreme \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-constant-noise-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-constant-noise-extreme-spherical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-extreme-spherical
	$(launch)

.pipeline/121-fisher-matrix-constant-noise-extreme-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-constant-noise-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-constant-noise-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-constant-noise-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-constant-noise-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-constant-noise-moderate.yml \
		.pipeline/103-full-rank-compression-peeled-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-constant-noise-moderate-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-constant-noise-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-moderate \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-constant-noise-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-constant-noise-moderate-spherical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-moderate-spherical
	$(launch)

.pipeline/121-fisher-matrix-constant-noise-moderate-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-constant-noise-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,4)

.pipeline/122-quadratic-estimator-peeled-constant-noise-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-constant-noise-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-constant-noise-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-constant-noise-mild.yml \
		.pipeline/103-full-rank-compression-peeled-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-constant-noise-mild-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-constant-noise-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-mild \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-constant-noise-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-constant-noise-mild-spherical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-mild-spherical
	$(launch)

.pipeline/121-fisher-matrix-constant-noise-mild-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-constant-noise-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-peeled-constant-noise-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-constant-noise-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-peeled-constant-noise-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-peeled-constant-noise-none.yml \
		.pipeline/103-full-rank-compression-peeled-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/121-fisher-matrix-constant-noise-none-spherical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-constant-noise-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-none \
		.pipeline/120-basis-covariance-matrices-spherical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-constant-noise-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-constant-noise-none-spherical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-none-spherical
	$(launch)

.pipeline/121-fisher-matrix-constant-noise-none-cylindrical: \
		$(LIB)/121-fisher-matrix.jl project.yml generated-config-files/121-fisher-matrix-constant-noise-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-none \
		.pipeline/120-basis-covariance-matrices-cylindrical
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-peeled-constant-noise-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-peeled-constant-noise-none-cylindrical.yml \
		.pipeline/112-foreground-filter-peeled-constant-noise-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-none-cylindrical
	$(launch)

.pipeline/030-m-modes-recalibrated-all: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-recalibrated-all.yml \
		.pipeline/001-recalibrated-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-recalibrated-all: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-recalibrated-all.yml \
		.pipeline/001-recalibrated-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-recalibrated \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-recalibrated-all: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-recalibrated-all.yml \
		.pipeline/030-m-modes-interpolated-recalibrated-all \
		.pipeline/030-m-modes-interpolated-recalibrated-all
	$(call launch-remote,1)

.pipeline/031-dirty-map-recalibrated-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-recalibrated-all.yml \
		.pipeline/030-m-modes-recalibrated-all \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-recalibrated-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-recalibrated-all.yml \
		.pipeline/030-m-modes-recalibrated-all \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-recalibrated-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-recalibrated-all.yml \
		.pipeline/033-transfer-flags-recalibrated-all \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-recalibrated-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-recalibrated-all.yml \
		.pipeline/033-transfer-flags-recalibrated-all \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-recalibrated-all: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-recalibrated-all.yml \
		.pipeline/033-transfer-flags-recalibrated-all
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-recalibrated-all: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-all.yml \
		.pipeline/101-averaged-m-modes-recalibrated-all \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-recalibrated-all: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-recalibrated-all.yml \
		.pipeline/103-full-rank-compression-recalibrated-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-all-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-all-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-all-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-all-extreme.yml \
		.pipeline/112-foreground-filter-recalibrated-all-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-all-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-all-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-all-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-all-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-all-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-all-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-all-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-all-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-all-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-all-moderate.yml \
		.pipeline/112-foreground-filter-recalibrated-all-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-all-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-all-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-all-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-all-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-all-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-all-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-all-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-all-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-all-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-all-mild.yml \
		.pipeline/112-foreground-filter-recalibrated-all-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-all-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-all-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-all-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-all-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-all-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-all-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-all-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-all-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-all \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-all-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-all-none.yml \
		.pipeline/112-foreground-filter-recalibrated-all-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-all-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-all-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-all-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-all-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-all-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-all-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-none-cylindrical
	$(launch)

.pipeline/030-m-modes-recalibrated-odd: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-recalibrated-odd.yml \
		.pipeline/001-recalibrated-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-recalibrated-odd: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-recalibrated-odd.yml \
		.pipeline/001-recalibrated-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-recalibrated \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-recalibrated-odd: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-recalibrated-odd.yml \
		.pipeline/030-m-modes-interpolated-recalibrated-all \
		.pipeline/030-m-modes-interpolated-recalibrated-odd
	$(call launch-remote,1)

.pipeline/031-dirty-map-recalibrated-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-recalibrated-odd.yml \
		.pipeline/030-m-modes-recalibrated-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-recalibrated-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-recalibrated-odd.yml \
		.pipeline/030-m-modes-recalibrated-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-recalibrated-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-recalibrated-odd.yml \
		.pipeline/033-transfer-flags-recalibrated-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-recalibrated-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-recalibrated-odd.yml \
		.pipeline/033-transfer-flags-recalibrated-odd \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-recalibrated-odd: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-recalibrated-odd.yml \
		.pipeline/033-transfer-flags-recalibrated-odd
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-recalibrated-odd: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-odd.yml \
		.pipeline/101-averaged-m-modes-recalibrated-odd \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-odd
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-recalibrated-odd: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-recalibrated-odd.yml \
		.pipeline/103-full-rank-compression-recalibrated-odd
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-odd-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-odd-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-odd-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-odd-extreme.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-odd-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-odd-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-odd-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-odd-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-odd-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-odd-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-odd-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-odd-moderate.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-odd-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-odd-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-odd-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-odd-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-odd-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-odd-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-odd-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-odd-mild.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-odd-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-odd-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-odd-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-odd-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-odd-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-odd-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-odd \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-odd-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-odd-none.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-odd-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-odd-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-odd-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-odd-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-odd-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-odd-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-odd-none-cylindrical
	$(launch)

.pipeline/030-m-modes-recalibrated-even: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-recalibrated-even.yml \
		.pipeline/001-recalibrated-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-recalibrated-even: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-recalibrated-even.yml \
		.pipeline/001-recalibrated-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-recalibrated \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-recalibrated-even: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-recalibrated-even.yml \
		.pipeline/030-m-modes-interpolated-recalibrated-all \
		.pipeline/030-m-modes-interpolated-recalibrated-even
	$(call launch-remote,1)

.pipeline/031-dirty-map-recalibrated-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-recalibrated-even.yml \
		.pipeline/030-m-modes-recalibrated-even \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-recalibrated-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-recalibrated-even.yml \
		.pipeline/030-m-modes-recalibrated-even \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-recalibrated-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-recalibrated-even.yml \
		.pipeline/033-transfer-flags-recalibrated-even \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-recalibrated-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-recalibrated-even.yml \
		.pipeline/033-transfer-flags-recalibrated-even \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-recalibrated-even: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-recalibrated-even.yml \
		.pipeline/033-transfer-flags-recalibrated-even
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-recalibrated-even: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-even.yml \
		.pipeline/101-averaged-m-modes-recalibrated-even \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-even
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-recalibrated-even: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-recalibrated-even.yml \
		.pipeline/103-full-rank-compression-recalibrated-even
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-even-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-even-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-even-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-even-extreme.yml \
		.pipeline/112-foreground-filter-recalibrated-even-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-even-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-even-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-even-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-even-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-even-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-even-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-even-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-even-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-even-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-even-moderate.yml \
		.pipeline/112-foreground-filter-recalibrated-even-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-even-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-even-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-even-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-even-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-even-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-even-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-even-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-even-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-even-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-even-mild.yml \
		.pipeline/112-foreground-filter-recalibrated-even-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-even-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-even-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-even-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-even-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-even-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-even-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-even-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-even-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-even \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-even-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-even-none.yml \
		.pipeline/112-foreground-filter-recalibrated-even-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-even-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-even-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-even-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-even-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-even-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-even-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-even-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-even-none-cylindrical
	$(launch)

.pipeline/030-m-modes-recalibrated-day: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-recalibrated-day.yml \
		.pipeline/001-recalibrated-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-recalibrated-day: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-recalibrated-day.yml \
		.pipeline/001-recalibrated-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-recalibrated \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-recalibrated-day: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-recalibrated-day.yml \
		.pipeline/030-m-modes-interpolated-recalibrated-all \
		.pipeline/030-m-modes-interpolated-recalibrated-day
	$(call launch-remote,1)

.pipeline/031-dirty-map-recalibrated-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-recalibrated-day.yml \
		.pipeline/030-m-modes-recalibrated-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-recalibrated-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-recalibrated-day.yml \
		.pipeline/030-m-modes-recalibrated-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-recalibrated-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-recalibrated-day.yml \
		.pipeline/033-transfer-flags-recalibrated-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-recalibrated-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-recalibrated-day.yml \
		.pipeline/033-transfer-flags-recalibrated-day \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-recalibrated-day: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-recalibrated-day.yml \
		.pipeline/033-transfer-flags-recalibrated-day
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-recalibrated-day: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-day.yml \
		.pipeline/101-averaged-m-modes-recalibrated-day \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-day
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-recalibrated-day: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-recalibrated-day.yml \
		.pipeline/103-full-rank-compression-recalibrated-day
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-day-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-day-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-day-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-day-extreme.yml \
		.pipeline/112-foreground-filter-recalibrated-day-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-day-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-day-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-day-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-day-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-day-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-day-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-day-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-day-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-day-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-day-moderate.yml \
		.pipeline/112-foreground-filter-recalibrated-day-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-day-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-day-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-day-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-day-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-day-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-day-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-day-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-day-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-day-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-day-mild.yml \
		.pipeline/112-foreground-filter-recalibrated-day-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-day-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-day-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-day-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-day-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-day-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-day-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-day-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-day-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-day \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-day-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-day-none.yml \
		.pipeline/112-foreground-filter-recalibrated-day-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-day-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-day-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-day-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-day-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-day-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-day-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-day-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-day-none-cylindrical
	$(launch)

.pipeline/030-m-modes-recalibrated-night: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-recalibrated-night.yml \
		.pipeline/001-recalibrated-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/030-m-modes-interpolated-recalibrated-night: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-recalibrated-night.yml \
		.pipeline/001-recalibrated-transposed-data \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-recalibrated \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-recalibrated-night: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-recalibrated-night.yml \
		.pipeline/030-m-modes-interpolated-recalibrated-all \
		.pipeline/030-m-modes-interpolated-recalibrated-night
	$(call launch-remote,1)

.pipeline/031-dirty-map-recalibrated-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-recalibrated-night.yml \
		.pipeline/030-m-modes-recalibrated-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-recalibrated-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-recalibrated-night.yml \
		.pipeline/030-m-modes-recalibrated-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-recalibrated-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-recalibrated-night.yml \
		.pipeline/033-transfer-flags-recalibrated-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-recalibrated-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-recalibrated-night.yml \
		.pipeline/033-transfer-flags-recalibrated-night \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-recalibrated-night: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-recalibrated-night.yml \
		.pipeline/033-transfer-flags-recalibrated-night
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-recalibrated-night: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-night.yml \
		.pipeline/101-averaged-m-modes-recalibrated-night \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-night
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-recalibrated-night: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-recalibrated-night.yml \
		.pipeline/103-full-rank-compression-recalibrated-night
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-night-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-night-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-night-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-night-extreme.yml \
		.pipeline/112-foreground-filter-recalibrated-night-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-night-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-night-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-night-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-night-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-night-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-night-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-night-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-night-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-night-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-night-moderate.yml \
		.pipeline/112-foreground-filter-recalibrated-night-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-night-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-night-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-night-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-night-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-night-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-night-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-night-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-night-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-night-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-night-mild.yml \
		.pipeline/112-foreground-filter-recalibrated-night-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-night-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-night-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-night-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-night-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-night-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-night-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-night-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-night-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-night \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-night-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-night-none.yml \
		.pipeline/112-foreground-filter-recalibrated-night-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-night-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-night-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-night-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-night-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-night-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-night-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-night-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-night-none-cylindrical
	$(launch)

.pipeline/030-m-modes-interpolated-recalibrated-xx: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-recalibrated-xx.yml \
		.pipeline/001-recalibrated-transposed-data-xx \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-recalibrated \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/033-transfer-flags-recalibrated-xx: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-recalibrated-xx.yml \
		.pipeline/030-m-modes-interpolated-recalibrated-all \
		.pipeline/030-m-modes-interpolated-recalibrated-xx
	$(call launch-remote,1)

.pipeline/031-dirty-map-recalibrated-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-recalibrated-xx.yml \
		.pipeline/030-m-modes-recalibrated-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-recalibrated-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-recalibrated-xx.yml \
		.pipeline/030-m-modes-recalibrated-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-recalibrated-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-recalibrated-xx.yml \
		.pipeline/033-transfer-flags-recalibrated-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-recalibrated-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-recalibrated-xx.yml \
		.pipeline/033-transfer-flags-recalibrated-xx \
		.pipeline/100-transfer-matrix-xx
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-recalibrated-xx: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-recalibrated-xx.yml \
		.pipeline/033-transfer-flags-recalibrated-xx
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-recalibrated-xx: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-xx.yml \
		.pipeline/101-averaged-m-modes-recalibrated-xx \
		.pipeline/101-averaged-transfer-matrix-xx \
		.pipeline/102-noise-covariance-matrix-xx
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-recalibrated-xx: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-recalibrated-xx.yml \
		.pipeline/103-full-rank-compression-recalibrated-xx
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-xx-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-xx-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-xx-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-xx-extreme.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-xx-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-xx-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-xx-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-xx-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-xx-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-xx-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-xx-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-xx-moderate.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-xx-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-xx-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-xx-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-xx-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-xx-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-xx-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-xx-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-xx-mild.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-xx-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-xx-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-xx-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-xx-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-xx-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-xx-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-xx \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-xx-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-xx-none.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-xx-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-xx-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-xx-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-xx-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-xx-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-xx-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-xx-none-cylindrical
	$(launch)

.pipeline/030-m-modes-interpolated-recalibrated-yy: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-interpolated-recalibrated-yy.yml \
		.pipeline/001-recalibrated-transposed-data-yy \
		.pipeline/002-flagged-peeled-data \
		.pipeline/032-predicted-visibilities-recalibrated \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/033-transfer-flags-recalibrated-yy: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-recalibrated-yy.yml \
		.pipeline/030-m-modes-interpolated-recalibrated-all \
		.pipeline/030-m-modes-interpolated-recalibrated-yy
	$(call launch-remote,1)

.pipeline/031-dirty-map-recalibrated-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-recalibrated-yy.yml \
		.pipeline/030-m-modes-recalibrated-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-recalibrated-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-recalibrated-yy.yml \
		.pipeline/030-m-modes-recalibrated-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-map-interpolated-recalibrated-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-interpolated-recalibrated-yy.yml \
		.pipeline/033-transfer-flags-recalibrated-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-channel-maps-interpolated-recalibrated-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-channels-interpolated-recalibrated-yy.yml \
		.pipeline/033-transfer-flags-recalibrated-yy \
		.pipeline/100-transfer-matrix-yy
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-recalibrated-yy: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-recalibrated-yy.yml \
		.pipeline/033-transfer-flags-recalibrated-yy
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-recalibrated-yy: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-yy.yml \
		.pipeline/101-averaged-m-modes-recalibrated-yy \
		.pipeline/101-averaged-transfer-matrix-yy \
		.pipeline/102-noise-covariance-matrix-yy
	$(call launch-remote,1)

.pipeline/031-dirty-map-compressed-recalibrated-yy: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-compressed-recalibrated-yy.yml \
		.pipeline/103-full-rank-compression-recalibrated-yy
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-yy-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-yy-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-yy-extreme: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-yy-extreme.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-extreme
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-yy-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-yy-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-yy-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-yy-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-yy-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-yy-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-yy-moderate: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-yy-moderate.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-moderate
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-yy-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-yy-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-yy-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-yy-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-yy-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-yy-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-yy-mild: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-yy-mild.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-mild
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-yy-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-yy-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-yy-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-yy-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-yy-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-yy-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-yy \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/031-dirty-map-filtered-recalibrated-yy-none: \
		$(LIB)/031-tikhonov.jl project.yml generated-config-files/031-tikhonov-filtered-recalibrated-yy-none.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-none
	$(call launch-remote,1)

.pipeline/122-quadratic-estimator-recalibrated-yy-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-yy-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-yy-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-yy-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-yy-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-yy-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-yy-none-cylindrical
	$(launch)

.pipeline/032-predicted-visibilities-recalibrated: \
		$(LIB)/032-predict-visibilities.jl project.yml generated-config-files/032-predict-visibilities-recalibrated.yml \
		.pipeline/031-dirty-map-recalibrated-all \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/033-transfer-flags-recalibrated: \
		$(LIB)/033-transfer-flags.jl project.yml generated-config-files/033-transfer-flags-predicted-recalibrated.yml \
		.pipeline/030-m-modes-interpolated-recalibrated-all \
		.pipeline/032-predicted-visibilities-recalibrated
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-predicted-recalibrated: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-predicted-recalibrated.yml \
		.pipeline/033-transfer-flags-recalibrated
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-predicted-recalibrated: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-predicted-recalibrated.yml \
		.pipeline/101-averaged-m-modes-predicted-recalibrated \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-predicted-recalibrated-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-recalibrated-extreme.yml \
		.pipeline/103-full-rank-compression-predicted-recalibrated \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-recalibrated-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-recalibrated-extreme-spherical.yml \
		.pipeline/112-foreground-filter-predicted-recalibrated-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-recalibrated-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-recalibrated-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-recalibrated-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-predicted-recalibrated-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-recalibrated-moderate.yml \
		.pipeline/103-full-rank-compression-predicted-recalibrated \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-recalibrated-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-recalibrated-moderate-spherical.yml \
		.pipeline/112-foreground-filter-predicted-recalibrated-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-recalibrated-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-recalibrated-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-recalibrated-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-predicted-recalibrated-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-recalibrated-mild.yml \
		.pipeline/103-full-rank-compression-predicted-recalibrated \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-recalibrated-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-recalibrated-mild-spherical.yml \
		.pipeline/112-foreground-filter-predicted-recalibrated-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-recalibrated-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-recalibrated-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-recalibrated-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-predicted-recalibrated-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-predicted-recalibrated-none.yml \
		.pipeline/103-full-rank-compression-predicted-recalibrated \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-predicted-recalibrated-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-recalibrated-none-spherical.yml \
		.pipeline/112-foreground-filter-predicted-recalibrated-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-all-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-predicted-recalibrated-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-predicted-recalibrated-none-cylindrical.yml \
		.pipeline/112-foreground-filter-predicted-recalibrated-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-all-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-recalibrated-small-gain-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-recalibrated-small-gain-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-recalibrated
	$(launch)

.pipeline/103-full-rank-compression-recalibrated-small-gain-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-small-gain-errors.yml \
		.pipeline/101-averaged-m-modes-recalibrated-small-gain-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-small-gain-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-small-gain-errors-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-small-gain-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-small-gain-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-small-gain-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-small-gain-errors-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-small-gain-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-small-gain-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-small-gain-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-small-gain-errors-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-small-gain-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-small-gain-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-small-gain-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-small-gain-errors-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-small-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-small-gain-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-gain-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-small-gain-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-gain-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-recalibrated-medium-gain-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-recalibrated-medium-gain-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-recalibrated
	$(launch)

.pipeline/103-full-rank-compression-recalibrated-medium-gain-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-medium-gain-errors.yml \
		.pipeline/101-averaged-m-modes-recalibrated-medium-gain-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-medium-gain-errors-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-medium-gain-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-medium-gain-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-medium-gain-errors-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-medium-gain-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-medium-gain-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-medium-gain-errors-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-medium-gain-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-medium-gain-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-medium-gain-errors-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-medium-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-medium-gain-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-gain-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-medium-gain-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-gain-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-recalibrated-large-gain-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-recalibrated-large-gain-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-recalibrated
	$(launch)

.pipeline/103-full-rank-compression-recalibrated-large-gain-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-large-gain-errors.yml \
		.pipeline/101-averaged-m-modes-recalibrated-large-gain-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-large-gain-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-large-gain-errors-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-large-gain-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-gain-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-large-gain-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-gain-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-gain-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-large-gain-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-large-gain-errors-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-large-gain-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-gain-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-large-gain-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-gain-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-gain-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-large-gain-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-large-gain-errors-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-large-gain-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-gain-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-large-gain-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-gain-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-gain-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-large-gain-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-large-gain-errors-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-large-gain-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-large-gain-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-gain-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-gain-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-large-gain-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-gain-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-gain-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-gain-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-recalibrated-small-bandpass-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-recalibrated-small-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-recalibrated
	$(launch)

.pipeline/103-full-rank-compression-recalibrated-small-bandpass-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-small-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-recalibrated-small-bandpass-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-small-bandpass-errors-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-small-bandpass-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-small-bandpass-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-small-bandpass-errors-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-small-bandpass-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-small-bandpass-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-small-bandpass-errors-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-small-bandpass-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-small-bandpass-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-small-bandpass-errors-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-small-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-small-bandpass-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-small-bandpass-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-small-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-small-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-small-bandpass-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-recalibrated-medium-bandpass-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-recalibrated-medium-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-recalibrated
	$(launch)

.pipeline/103-full-rank-compression-recalibrated-medium-bandpass-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-medium-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-recalibrated-medium-bandpass-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-medium-bandpass-errors-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-medium-bandpass-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-medium-bandpass-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-medium-bandpass-errors-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-medium-bandpass-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-medium-bandpass-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-medium-bandpass-errors-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-medium-bandpass-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-medium-bandpass-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-medium-bandpass-errors-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-medium-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-medium-bandpass-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-medium-bandpass-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-medium-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-medium-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-medium-bandpass-errors-none-cylindrical
	$(launch)

.pipeline/101-averaged-m-modes-recalibrated-large-bandpass-errors: \
		$(LIB)/300-mess-with-gains.jl project.yml generated-config-files/300-mess-with-gains-recalibrated-large-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-predicted-recalibrated
	$(launch)

.pipeline/103-full-rank-compression-recalibrated-large-bandpass-errors: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-large-bandpass-errors.yml \
		.pipeline/101-averaged-m-modes-recalibrated-large-bandpass-errors \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-all
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-large-bandpass-errors-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-large-bandpass-errors-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-bandpass-errors-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-large-bandpass-errors-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-bandpass-errors-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-large-bandpass-errors-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-large-bandpass-errors-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-bandpass-errors-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-large-bandpass-errors-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-bandpass-errors-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-large-bandpass-errors-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-large-bandpass-errors-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-bandpass-errors-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-large-bandpass-errors-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-bandpass-errors-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-large-bandpass-errors-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-large-bandpass-errors \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-large-bandpass-errors-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-bandpass-errors-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-large-bandpass-errors-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-large-bandpass-errors-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-large-bandpass-errors-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-large-bandpass-errors-none-cylindrical
	$(launch)

.pipeline/032-predicted-visibilities-recalibrated-error: \
		$(LIB)/301-mess-with-noise.jl project.yml generated-config-files/301-mess-with-noise-recalibrated-sidereal-noise.yml \
		.pipeline/032-predicted-visibilities-recalibrated
	$(launch)

.pipeline/030-m-modes-recalibrated-sidereal-noise: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-recalibrated-sidereal-noise.yml \
		.pipeline/032-predicted-visibilities-recalibrated-sidereal-noise \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-recalibrated-sidereal-noise: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-recalibrated-sidereal-noise.yml \
		.pipeline/033-transfer-flags-recalibrated-sidereal-noise
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-recalibrated-sidereal-noise: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-sidereal-noise.yml \
		.pipeline/101-averaged-m-modes-recalibrated-sidereal-noise \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-sidereal-noise
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-sidereal-noise-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-sidereal-noise-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-sidereal-noise-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-sidereal-noise-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-sidereal-noise-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-sidereal-noise-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-sidereal-noise-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-sidereal-noise-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-sidereal-noise-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-sidereal-noise-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-sidereal-noise-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-sidereal-noise-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-sidereal-noise-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-sidereal-noise-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-sidereal-noise-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-sidereal-noise-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-sidereal-noise-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-sidereal-noise-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-sidereal-noise-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-sidereal-noise-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-sidereal-noise-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-sidereal-noise-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-sidereal-noise-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-sidereal-noise-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-sidereal-noise-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-sidereal-noise-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-sidereal-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-sidereal-noise-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-sidereal-noise-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-sidereal-noise-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-sidereal-noise-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-sidereal-noise-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-sidereal-noise-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-sidereal-noise-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-sidereal-noise-none-cylindrical
	$(launch)

.pipeline/032-predicted-visibilities-recalibrated-error: \
		$(LIB)/301-mess-with-noise.jl project.yml generated-config-files/301-mess-with-noise-recalibrated-constant-noise.yml \
		.pipeline/032-predicted-visibilities-recalibrated
	$(launch)

.pipeline/030-m-modes-recalibrated-constant-noise: \
		$(LIB)/030-getmmodes.jl project.yml generated-config-files/030-getmmodes-recalibrated-constant-noise.yml \
		.pipeline/032-predicted-visibilities-recalibrated-constant-noise \
		.pipeline/100-transfer-matrix
	$(call launch-remote,1)

.pipeline/101-averaged-m-modes-recalibrated-constant-noise: \
		$(LIB)/101-average-channels.jl project.yml generated-config-files/101-average-channels-m-modes-recalibrated-constant-noise.yml \
		.pipeline/033-transfer-flags-recalibrated-constant-noise
	$(call launch-remote,1)

.pipeline/103-full-rank-compression-recalibrated-constant-noise: \
		$(LIB)/103-full-rank-compress.jl project.yml generated-config-files/103-full-rank-compress-recalibrated-constant-noise.yml \
		.pipeline/101-averaged-m-modes-recalibrated-constant-noise \
		.pipeline/101-averaged-transfer-matrix \
		.pipeline/102-noise-covariance-matrix-constant-noise
	$(call launch-remote,1)

.pipeline/112-foreground-filter-recalibrated-constant-noise-extreme: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-constant-noise-extreme.yml \
		.pipeline/103-full-rank-compression-recalibrated-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-constant-noise-extreme-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-constant-noise-extreme-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-constant-noise-extreme \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-extreme-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-constant-noise-extreme-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-constant-noise-extreme-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-constant-noise-extreme \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-extreme-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-constant-noise-moderate: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-constant-noise-moderate.yml \
		.pipeline/103-full-rank-compression-recalibrated-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-constant-noise-moderate-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-constant-noise-moderate-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-constant-noise-moderate \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-moderate-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-constant-noise-moderate-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-constant-noise-moderate-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-constant-noise-moderate \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-moderate-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-constant-noise-mild: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-constant-noise-mild.yml \
		.pipeline/103-full-rank-compression-recalibrated-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-constant-noise-mild-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-constant-noise-mild-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-constant-noise-mild \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-mild-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-constant-noise-mild-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-constant-noise-mild-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-constant-noise-mild \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-mild-cylindrical
	$(launch)

.pipeline/112-foreground-filter-recalibrated-constant-noise-none: \
		$(LIB)/112-foreground-filter.jl project.yml generated-config-files/112-foreground-filter-recalibrated-constant-noise-none.yml \
		.pipeline/103-full-rank-compression-recalibrated-constant-noise \
		.pipeline/110-foreground-covariance-matrix \
		.pipeline/111-signal-covariance-matrix
	$(call launch-remote,2)

.pipeline/122-quadratic-estimator-recalibrated-constant-noise-none-spherical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-constant-noise-none-spherical.yml \
		.pipeline/112-foreground-filter-recalibrated-constant-noise-none \
		.pipeline/120-basis-covariance-matrices-spherical \
		.pipeline/121-fisher-matrix-constant-noise-none-spherical
	$(launch)

.pipeline/122-quadratic-estimator-recalibrated-constant-noise-none-cylindrical: \
		$(LIB)/122-quadratic-estimator.jl project.yml generated-config-files/122-quadratic-estimator-recalibrated-constant-noise-none-cylindrical.yml \
		.pipeline/112-foreground-filter-recalibrated-constant-noise-none \
		.pipeline/120-basis-covariance-matrices-cylindrical \
		.pipeline/121-fisher-matrix-constant-noise-none-cylindrical
	$(launch)

