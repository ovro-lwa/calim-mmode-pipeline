# Julia Instalation

First download Julia 0.6.4 here:
https://julialang.org/downloads/oldreleases/

You cannot use Juliaup for version before 0.7 and 0.7 breaks some of the custom packages built by Michael.

# Environment Building

Before the 0.7 release there is not the fancy new package and environment builder. This means that you will have to manually build said environment by just adding the packages.

The base packages required by this program are:

```
Pkg.add("ProgressMeter")
Pkg.add("JLD2")
Pkg.add("ArgParse")
Pkg.add("Dierckx")
Pkg.add("DocOpt")
Pkg.add("Printf")
Pkg.add("YAML")
```

## Custom Packages

The custom ones that were built by Michael are:

```
Pkg.clone("https://github.com/Hallflower20/CasaCore.jl")
Pkg.clone("https://github.com/Hallflower20/LibHealpix.jl")
Pkg.clone("https://github.com/ovro-lwa/TTCal.jl")
Pkg.clone("https://github.com/ovro-lwa/BPJSpec.jl")
```

After cloning each of these packages make sure you build and test them to make sure they are working. LibHealpix will have one broken test this is ok.

## Casacore
In order to get CasaCore.jl working you will need to Casacore add it to the C and C++ include path and library path. On Calim these paths are:

```
export LIBRARY_PATH=/opt/lib:$LIBRARY_PATH

export CPLUS_INCLUDE_PATH=/opt/include:$CPLUS_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/opt/include/casacore:$CPLUS_INCLUDE_PATH
export C_INCLUDE_PATH=$CPLUS_INCLUDE_PATH
```

Inorder to install Casacore you can either compile it yourself or use a conda environment. Then you will have to link

If you don't want to add these to your .bashrc program you can always run Julia like it is ran in the makefile:

```
CPLUS_INCLUDE_PATH=/opt/include LIBRARY_PATH=/opt/lib /home/xhall/software/julia-0.6/bin/julia --color=yes -O3 --check-bounds=yes
```

## LibHealPix

Hopefully the internet archive never goes down, but in the unlikely event that it does LibHealPix won't be able to access its depedencies file. You can see where I've inserted it here:
https://github.com/Hallflower20/LibHealpix.jl/blob/master/deps/build.jl#L135

I've added the needed file to its own repo but was too lazy to just implement it to reference that.

https://github.com/Hallflower20/LibHealpix.jl/blob/master/dependencies-v0.2.3-0.tar.gz

# Swapped Polarization Fixes

If being used on a new machine you will have to recompile the code here:
https://github.com/ovro-lwa/calim-mmode-pipeline/tree/update/bin/swapped-polarization-fixes

You will need to change the directories and correct the compiler. When you are done you can run a standard make all and that will compile.

# dada2ms

There exists a dada2ms converter in this pipeline. You'll have to download and compile it yourself from source. Make sure you use the update version to work with modern casacore.

https://github.com/ovro-lwa/dada2ms/tree/update_to_new_casa

Once you download and compile it you will need to add it to your path variables.

```
export PATH="/home/xhall/mmode_old/dada2ms/:$PATH"
```

Or simply modify the command in DADA2MS.jl to point to the compiled version.

https://github.com/ovro-lwa/calim-mmode-pipeline/blob/update/lib/DADA2MS.jl#L42

Next we will change a .yml files.

https://github.com/ovro-lwa/calim-mmode-pipeline/blob/update/projects/2017-rainy-day-power-spectrum/dada2ms.yml

Whatever ant file you decide to use will need to be placed here. I should probably upload that into the dada2ms repo. You will also need to change your data directory to wherever it is.

# Running the Pipeline
The current pipeline that is being used is 2017-rainy-day-power-spectrum.

https://github.com/ovro-lwa/calim-mmode-pipeline/tree/update/projects/2017-rainy-day-power-spectrum

## Channel Changing
If you want to change the channel you are using go here change the 17 to a 14 or whatever the number of the file you are using is:
https://github.com/ovro-lwa/calim-mmode-pipeline/blob/update/projects/2017-rainy-day-power-spectrum/000-getdata.yml

## Working Directories

You will need to over a sizeable workspace (~1 TB) for the code to output everything. Place that directory here.

https://github.com/ovro-lwa/calim-mmode-pipeline/blob/update/lib/Project.jl#L22

In order for the program to work it will use temp files. Place a directory for the temp files here.

https://github.com/ovro-lwa/calim-mmode-pipeline/blob/update/lib/Project.jl#L28

## Julia Command in the Makefile

Link your Julia installation in the make file and place it here:

https://github.com/ovro-lwa/calim-mmode-pipeline/blob/update/projects/2017-rainy-day-power-spectrum/Makefile#L23

## Bugs

There still exists are ReadOnlyMemoryError that sometimes pops up while trying to use the flags. I still can't figure out what exactly causes this or how to really fix it. The currently solution is simply to run the code twice. I put in a try: except:. This basically means if the flags don't already exist in the working directory it will produce them. Then it will probably crash. Then re-run the program and instead of making the flags again it will just read them and this time for some reason not crash. I will work on a better method but this is the process in the mean time.

