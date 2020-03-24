//==============================================================
// Copyright � 2019 Intel Corporation
//
// SPDX-License-Identifier: MIT
// =============================================================

#include <cuda.h>
#include <stdio.h>
#include <assert.h>
#include <time.h>

static long long timediff(struct timespec &start, struct timespec &end)
{
    return (end.tv_sec - start.tv_sec) * 1e9 + (end.tv_nsec - start.tv_nsec);
}

__global__ void VecAdd(float* A, float* B, float* C, int N)
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    if (i < N)
        C[i] = A[i] + B[i];
}

#define lap clock_gettime(CLOCK_MONOTONIC, &now); \
printf("%lld,", timediff(start, now)); \
start = now;

int main(int argc, char *argv[])
{
    if(argc != 3) {
        fprintf(stderr, "%s vector_size iteration\n", argv[0]);
        exit(-1);
    }

    size_t vector_size = atoll(argv[1]);
    size_t iteration = atoll(argv[2]);
    struct timespec start;
    struct timespec now;
    float *d_A, *d_B, *d_C;

    clock_gettime(CLOCK_MONOTONIC, &start);

    cudaMalloc(&d_A, vector_size*sizeof(float));
    cudaMalloc(&d_B, vector_size*sizeof(float));
    cudaMalloc(&d_C, vector_size*sizeof(float));

    lap;

    for(size_t i = 0; i < iteration; i++) {
        int threadsPerBlock = 256;
        int blocksPerGrid = (vector_size + threadsPerBlock - 1) / threadsPerBlock;
        VecAdd<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, vector_size);
        //cudaError_t err = cudaGetLastError();
        //if (err != cudaSuccess) {
        //    fprintf(stderr, "Error: %s\n", cudaGetErrorString(err));
        //    break;
        //}
    }

    lap;

    float *Result = (float*) malloc(sizeof(float) * vector_size);
    cudaMemcpy(Result, d_C, vector_size*sizeof(float), cudaMemcpyDeviceToHost);

    lap;

    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    free(Result);

    lap;

    printf("%lu\n", vector_size);

    return 0;
}
