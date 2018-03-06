# Sneaking cosmology onto the All-Sky Transient Monitor

Despite the name of the machine, we'd like to do some cosmological data analysis on the ASTM.
This pipeline wraps around TTCal and BPJSpec to analyze data generated by the OVRO-LWA.

## Directory Structure

* `bin/` contains executable scripts that are used by the pipeline
* `contrib/` contains useful files that are nice to have, but are not essential for the operation of the pipeline
* `etc/` contains essential logs of array operation (including antenna reports) and global pipeline configuration (if any)
* `lib/` contains libraries of functionality that do the bulk of the heavy lifting
* `projects/` contains descriptions and configuration files for individual projects

## Quick Start

```
cd projects/<project name>
make
```

## Essential Packages

| Name    | Documentation                                |
|---------|----------------------------------------------|
| TTCal   | http://mweastwood.info/TTCal.jl/             |
| BPJSpec | http://mweastwood.info/BPJSpec.jl/latest/    |
| DADA2MS | https://github.com/sabourke/dada2ms          |
| WSClean | https://sourceforge.net/p/wsclean/wiki/Home/ |
