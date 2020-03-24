#!/bin/bash
source /opt/intel/inteloneapi/setvars.sh #> setvars.log
rm -rf dpct_output
dpct --cuda-include-path=$CUDA_INCLUDE_DIR --keep-original-code src/vector_add.cu
make -j`nproc`
