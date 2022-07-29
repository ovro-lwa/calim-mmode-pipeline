# Cosmology on the All-Sky Transient Monitor

Despite the name of the machine, we'd like to do some cosmological data analysis on the ASTM.
This pipeline wraps around TTCal and BPJSpec to analyze data generated by the OVRO-LWA.

## Directory Structure

* `bin/` contains executable scripts that are used by the pipeline
* `contrib/` contains useful files that are nice to have, but are not essential for the operation of
  the pipeline
* `etc/` contains essential logs of array operation (including antenna reports) and global pipeline
  configuration (if any)
* `lib/` contains libraries of functionality that do the bulk of the heavy lifting
* `projects/` contains descriptions and configuration files for individual projects

## Quick Start

```
cd projects/<project name>
make
```

## Essential Packages

| Name    | Documentation                                | Downlaod                               |
|---------|----------------------------------------------|----------------------------------------|
| TTCal   | http://mweastwood.info/TTCal.jl/             | https://github.com/ovro-lwa/TTCal.jl   |
| BPJSpec | http://mweastwood.info/BPJSpec.jl/latest/    | https://github.com/ovro-lwa/BPJSpec.jl |
| DADA2MS | https://github.com/sabourke/dada2ms          | https://github.com/ovro-lwa/dada2ms    |
| WSClean | https://sourceforge.net/p/wsclean/wiki/Home/ | https://github.com/ovro-lwa/wsclean    |
| LibHealPix | http://mweastwood.info/LibHealpix.jl/stable/ | https://github.com/Hallflower20/LibHealpix.jl    |

## Notes

* A lot of the code that currently lives in `bin/` isn't quite up-to-date.
* In theory, everything here should be reusable for new m-mode analysis projects. The dream is that
  you should only need to copy an existing directory within `projects/` and begin tuning the
  `Makefile` and configuration files.
* You should be using `make ... --dry-run` to check what will be run ahead of time.
* Use `make ... --touch` to skip over steps that shouldn't need to be run again. This is useful when
  you've made a cosmetic change that shouldn't impact the final results, and therefore you don't
  want to rerun every single analysis step potentially impacted by editing the given file.
* I promise `projects/2017-rainy-day-power-spectrum` has up-to-date configuration files, but it's
  possible the other projects have lagged behind as I've made changes.
* Please do reach out to me if you have any questions about how to use this pipeline.

