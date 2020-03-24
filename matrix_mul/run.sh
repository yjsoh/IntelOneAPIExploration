#!/bin/bash
source /opt/intel/inteloneapi/setvars.sh
echo "########## Executing the run"
#TARGET=dpcpp
TARGET=mkl
./matrix_mul_$TARGET
echo "########## Done with the run"
