__global__ void gemv(float* weights, float* d_input, float* d_temp) {
    int warp_idx = threadIdx.x / 32;
    int lane_idx = threadIdx.x % 32;
    int col_idx = (blockIdx.x % 8) * 32 + lane_idx;
    if (warp_idx == 0) {
        d_temp[col_idx] = 0;
    }
    __syncthreads();

    float temp = 0;
    int rs = 32 * warp_idx, re = row_start_idx + 32;
    for (int row_idx = rs; row_idx < re; row_idx += 32) {
        temp += weights[row_idx * 32 + col_idx] * d_input[row_idx];
    }
    atomicAdd(&d_temp[col_idx], temp);
}


__global__ void gemv(float* weights, float* d_input, float* d_temp) {
    for(blockIdx.x = 0; blockIdx.x < 8; blockIdx.x++) {
        for (threadIdx.x = 0; threadIdx.x < 32; threadIdx.x++) {
            int warp_idx = threadIdx.x / 32;
            int lane_idx = threadIdx.x % 32;
            int col_idx = (blockIdx.x % 8) * 32 + lane_idx;
            if (warp_idx == 0) {
                d_temp[col_idx] = 0;
            }
        }
        // __syncthreads();
        for (threadIdx.x = 0; threadIdx.x < 32; threadIdx.x++) {
            int warp_idx = threadIdx.x / 32;
            int lane_idx = threadIdx.x % 32;
            int col_idx = (blockIdx.x % 8) * 32 + lane_idx;
            float temp = 0;
            int rs = 32 * (threadIdx.x / 32), re = row_start_idx + 32;
            for (int row_idx = 32 * (threadIdx.x / 32); row_idx < re; row_idx++) {
                temp += weights[row_idx * 32 + (blockIdx.x % 8) * 32 + threadIdx.x % 32] * d_input[row_idx];
            }
            atomicAdd(&d_temp[col_idx], temp);
        }
    }
}

