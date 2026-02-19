// int8_vnni_gemm_64.c
// Example GEMM: C = A * B (uint8 x int8 -> int32) using AVX-512 VNNI
// M = N = K = 64

#include <immintrin.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define M 64
#define N 64
#define K 64

// GEMM: C = A * B
// A: uint8_t [M][K]
// B: int8_t  [K][N]
// C: int32_t [M][N]
void gemm_u8s8s32_vnni(const uint8_t A[M][K],
                       const int8_t  B[K][N],
                       int32_t       C[M][N])
{
    // Zero initialize C
    memset(C, 0, sizeof(int32_t)*M*N);

    // We process N dimension in tiles of 16 (since each ZMM holds 16 int32 results)
    for (int i = 0; i < M; ++i) {
        for (int j = 0; j < N; j += 16) {
            // 16 int32 accumulators in a single ZMM register
            __m512i acc = _mm512_setzero_si512();

            for (int k = 0; k < K; k += 4) {
                // Load 4 bytes of A[i][k..k+3] as u8
                __m128i a_frag = _mm_loadu_si32(&A[i][k]); // load 4 bytes
                // Broadcast 4 bytes of A to fill 64-byte ZMM (replicated pattern)
                __m512i a_vec = _mm512_broadcastd_epi32(a_frag);

                // Load 64 bytes of B[k..k+3][j..j+15] (4x16 block of int8)
                __m512i b_vec = _mm512_loadu_si512(&B[k][j]);

                // VNNI dot-product accumulate: acc += a_vec(u8) * b_vec(s8)
                acc = _mm512_dpbusd_epi32(acc, a_vec, b_vec);
            }

            // Store result C[i][j..j+15]
            _mm512_storeu_si512(&C[i][j], acc);
        }
    }
}

// --- Simple test harness ---
int main(void)
{
    static uint8_t A[M][K];
    static int8_t  B[K][N];
    static int32_t C[M][N];

    // Initialize A and B with small values
    for (int i = 0; i < M; ++i)
        for (int k = 0; k < K; ++k)
            A[i][k] = (uint8_t)((i + k) & 0xFF);

    for (int k = 0; k < K; ++k)
        for (int j = 0; j < N; ++j)
            B[k][j] = (int8_t)(((k - j) & 0x7F) - 64);

    // Compute GEMM
    gemm_u8s8s32_vnni(A, B, C);

    // Print part of C for verification
    for (int i = 0; i < 8; ++i) {
        for (int j = 0; j < 8; ++j) {
            printf("%8d ", C[i][j]);
        }
        printf("\n");
    }
    return 0;
}