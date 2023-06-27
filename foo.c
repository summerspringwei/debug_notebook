#include <stdio.h>
#include <memory.h>
#include <stdlib.h>

void bar(float* a, int n){
    for(int i=1; i<n; ++i){
        a[i] += a[i-1];
    }
};

void foo(x) {
    float* a = (float*)malloc(20);
    if(x) {
        bar(a, 20);
    }
};

int main(int argc, char* argv[]) {
    int x;
    scanf("%d", &x);
    foo(x);
    return 0;
}