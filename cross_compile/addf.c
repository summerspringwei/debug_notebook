#include <stdio.h>

// Function to add two float numbers
float addTwoFloats(float num1, float num2) {
    return num1 + num2;
}

int main() {
    float num1, num2, num3, sum;

    // Input the three float numbers
    printf("Enter three float numbers:\n");
    scanf("%f %f %f", &num1, &num2, &num3);

    // Call the addTwoFloats function twice to add three numbers
    sum = addTwoFloats(num1, num2);
    sum = addTwoFloats(sum, num3);

    // Display the result
    printf("Sum of three float numbers: %.2f\n", sum);

    return 0;
}