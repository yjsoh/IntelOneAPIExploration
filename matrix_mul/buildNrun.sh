#!/bin/bash
source /opt/intel/inteloneapi/setvars.sh #> setvars.log

TARGET=dpcpp
#TARGET=mkl
INPUT_FILE=./src/matrix_mul_$TARGET.cpp.template
OUTPUT_FILE=./src/matrix_mul_$TARGET.cpp

function build {
        echo "Converting %%SIZE%% variable to $1"
        sed "s:%%SIZE%%:$1:g" $INPUT_FILE > $OUTPUT_FILE
	make -j`nproc` build_$TARGET
}

function run {
	./matrix_mul_$TARGET
}

echo "INPUT_FILE is $INPUT_FILE"
echo "OUTPUT_FILE is $OUTPUT_FILE"

for i in {3..20}; do
    size=$(( 1 << $i ))
    build $size
    run
done

