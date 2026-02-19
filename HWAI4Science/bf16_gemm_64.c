// bf16_gemm_64.c
// Example: BF16 GEMM for M=N=K=64 using AVX-512 float code path.
// Note: this converts BF16 -> float32 then does float GEMM with AVX-512 FMAs.
// VDPBF16PS (AVX-512 BF16) is the hardware instruction to accelerate bf16 directly;
// compilers may expose bf16 intrinsics or you can emit the instruction in asm.

#include <immintrin.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

// Convert a single bfloat16 (uint16_t) -> float (IEEE 754) via bit manipulation
static inline float bf16_to_float(uint16_t bf) {
    uint32_t u = ((uint32_t)bf) << 16; // move bf16 bits into high half of float32
    float f;
    memcpy(&f, &u, sizeof(f)); // type-punning without UB
    return f;
}

// Convert entire 64x64 matrix from bf16 (uint16_t) to float
static void convert_bf16_to_float_matrix(const uint16_t src[64][64], float dst[64][64]) {
    for (int i = 0; i < 64; ++i) {
        for (int j = 0; j < 64; ++j) {
            dst[i][j] = bf16_to_float(src[i][j]);
        }
    }
}

// BF16 GEMM via float32 AVX-512 kernel:
// C = A * B + C
// A_f, B_f are float32 64x64 arrays (converted from bf16 prior).
static void gemm64_avx512_f32(const float A_f[64][64], const float B_f[64][64], float C[64][64]) {
    // initialize C (assume C already contains initial values; here we zero it)
    for (int i = 0; i < 64; ++i)
        for (int j = 0; j < 64; ++j)
            C[i][j] = 0.0f;

    // We will iterate i (rows of A / rows of C), k (inner), and vectorize across j (columns)
    // Vector width: 16 floats per __m512
    for (int i = 0; i < 64; ++i) {
        for (int k = 0; k < 64; ++k) {
            // broadcast A[i][k] to vector
            __m512 a_ik_vec = _mm512_set1_ps(A_f[i][k]);

            // process 16 columns at a time (64 columns total)
            for (int j = 0; j < 64; j += 16) {
                // load B[k][j..j+15]
                const float *bptr = &B_f[k][j];
                __m512 b_vec = _mm512_loadu_ps(bptr);

                // load C[i][j..j+15]
                float *cptr = &C[i][j];
                __m512 c_vec = _mm512_loadu_ps(cptr);

                // c_vec += a_ik_vec * b_vec
                c_vec = _mm512_fmadd_ps(a_ik_vec, b_vec, c_vec);

                // store back
                _mm512_storeu_ps(cptr, c_vec);
            }
        }
    }
}

// Small helper to print a submatrix for debug
static void print_C(const float C[64][64], int maxr, int maxc) {
    for (int i = 0; i < maxr; ++i) {
        for (int j = 0; j < maxc; ++j) {
            printf("%8.3f ", C[i][j]);
        }
        printf("\n");
    }
}

int main(void) {
    // Example input: A and B in bf16 (uint16_t). Here we create simple test data.
    static uint16_t A_bf16[64][64];
    static uint16_t B_bf16[64][64];

    // Example: fill with small values in bf16 representation:
    // We'll set A[i][k] = (float)(i+k) and B[k][j] = (float)(k+j), convert to bf16 bit patterns.
    // To make bf16 bit patterns we convert float->bits and drop low 16 bits.
    for (int i = 0; i < 64; ++i) {
        for (int k = 0; k < 64; ++k) {
            float af = (float)(i + k + 1) * 0.01f;
            uint32_t bits;
            memcpy(&bits, &af, sizeof(bits));
            // keep top 16 bits as bf16
            A_bf16[i][k] = (uint16_t)(bits >> 16);
        }
    }
    for (int k = 0; k < 64; ++k) {
        for (int j = 0; j < 64; ++j) {
            float bf = (float)(k + j + 1) * 0.02f;
            uint32_t bits;
            memcpy(&bits, &bf, sizeof(bits));
            B_bf16[k][j] = (uint16_t)(bits >> 16);
        }
    }

    // Convert BF16 -> float32
    static float A_f[64][64];
    static float B_f[64][64];
    convert_bf16_to_float_matrix(A_bf16, A_f);
    convert_bf16_to_float_matrix(B_bf16, B_f);

    // Output matrix
    static float C[64][64];
    for (int i = 0; i < 64; ++i)
        for (int j = 0; j < 64; ++j)
            C[i][j] = 0.0f;

    // Perform GEMM
    gemm64_avx512_f32(A_f, B_f, C);

    // Print a small corner of C for verification
    printf("C[0..7][0..7]:\n");
    print_C(C, 8, 8);

    return 0;
}