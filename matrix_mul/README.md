# Matrix Multiplication

## Scripts

Before running: `TARGET` variable is set for all scripts except `q`.
Changing the value of this variable will run different source file.
The value should be either `dpcpp` or `mkl` for now.

* `buildNrun.sh`
* `build.sh`
  Replace `%%SIZE%%` with the intended matrix size. Then `make` the source file.
* `run.sh`
* `q`

## Source files

* `matrix_mul_dpcpp.cpp`
    Original Data Pararell C++ (DPCPP) version.
* `matrix_mul_dpcpp.cpp.template`
    Generic version with `%%SIZE%%` to be replaced.
* `matrix_mul_mkl.cpp`
    Original Math Kernel Library (MKL) version.
* `matrix_mul_mkl.cpp.template`
    Generic version with `%%SIZE%%` to be replaced.
