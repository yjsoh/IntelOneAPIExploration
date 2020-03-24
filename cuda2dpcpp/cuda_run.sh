#!/bin/bash
echo "Malloc,VectorAdd,Memcpy,Free,VectorSize"
for i in {3..20}; do
    ./cudabin $(( 1 << $i )) 1000000
done
