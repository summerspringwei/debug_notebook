#include <iostream>
#include <cmath>
#include <vector>

template <typename VALUETYPE>
VALUETYPE four_level_example(int N) {
    // Setup reciprocal box as identity (for simplicity)
    VALUETYPE rec_box[9] = {
        1.0, 0.0, 0.0,
        0.0, 1.0, 0.0,
        0.0, 0.0, 1.0
    };

    VALUETYPE sum = 0;
    int mm[3];

    // Four nested loops, symmetric around 0
    for (mm[0] = -N; mm[0] <= N; ++mm[0]) {
        for (mm[1] = -N; mm[1] <= N; ++mm[1]) {
            for (mm[2] = -N; mm[2] <= N; ++mm[2]) {
                for (int extra = -N; extra <= N; ++extra) {
                    // Compute reciprocal vector rm = mm * rec_box
                    VALUETYPE rm[3] = {0, 0, 0};
                    for (int dd = 0; dd < 3; ++dd) {
                        rm[0] += mm[dd] * rec_box[dd * 3 + 0];
                        rm[1] += mm[dd] * rec_box[dd * 3 + 1];
                        rm[2] += mm[dd] * rec_box[dd * 3 + 2];
                    }

                    // Squared magnitude
                    VALUETYPE mm2 = rm[0] * rm[0] + rm[1] * rm[1] + rm[2] * rm[2] + extra * extra;

                    // Contribution to sum
                    if (mm2 > 1e-12) { // avoid div by zero
                        sum += std::exp(-mm2) / mm2;
                    }
                }
            }
        }
    }

    return sum;
}

int main() {
    int N = 9;  // small size for demo
    float result = four_level_example<float>(N);
    std::cout << "Result = " << result << std::endl;
    return 0;
}