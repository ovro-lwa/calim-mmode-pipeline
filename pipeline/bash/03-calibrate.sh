#!/bin/bash

set -eux

JULIA=julia-0.5.0

cd `dirname $0`/../..
$JULIA -e \
    "include(\"pipeline/Pipeline.jl\"); Pipeline.calibrate($1, \"$2\")"
