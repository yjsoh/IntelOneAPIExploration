# Cuda2dpcpp

*`devcloud_build.sh` requires special instruction!*

## `cudabin` usage

```bash
./cudabin vector_size iteration
```

## Makefile

* Makefile targets
  * all: Wrapper for target `main`.
  * main: Used to create binary on devcloud. See `devcloud_build.sh`.
  * cudabin: Creates cuda binary to run on local GPU.
  * dpbin: Creates oneAPI binary to run on local machine.

* Make main
Works on the devcloud.

```bash
make all
```

* Create bin for cudabin
```bash
make cudabin
```

* Create bin for dpcpp
  * Prerequisite:
  `dpct_output/vector_add.dp.cpp`
    * How to generate it:
  `dpct --cuda-include-path=/path/to/cuda/include vector_add.cu`
  * Prerequisite: cuda header files `include/`
    * Unzip the `cuda10.1_include.tar`
    * Properly set the path to the `include` folder.
  * Prerequisite: Properly set `LD_LIBRARY_PATH`
    * Should include path to the inteloneapi.
    * Typically
    `/opt/intel/inteloneapi/compiler/2021.1-beta04/linux/compiler/lib/intel64`

```bash
make dpbin
```

## Script

### `cuda_run.sh`
This script runs the cuda binary.
Automatically runs the script from 2<sup>3</sup> to 2<sup>20</sup> vector size.
It prints out csv format to stdout.

```csv
Malloc,VectorAdd,Memcpy,Free,VectorSize
106560462,1158754052,12982,53864,8
41857474,1158700265,11987,50873,16
41344561,1138774573,13503,64634,32
```

### `devcloud_build.sh`
Script used as a parameter to `qsub` on devcloud. Builds the `bin/vector_add`.
1. Untar `cuda10.1_include.tar`.
1. `--cuda-include-path=/path/to/IntelOneAPIExploration/cuda2dpcpp/include`
Should be updated to the correct path.

### `devcloud_run.sh`
Script used as a parameter to `qsub` on devcloud. Runs the `bin/vector_add`.

### `q`
Script used to submit job on devcloud.

Usage.
```bash
./q devcloud_build.sh
```

```bash
./q devcloud_run.sh
```
