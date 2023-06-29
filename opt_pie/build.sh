set -xe
clang 20.c  -g -O0 -Xclang -disable-O0-optnone -Xclang -disable-llvm-passes -emit-llvm -c -o 8.bc
opt -passes='function(loop(loop-unroll-and-jam,loop-flatten,no-op-loopnest,loop-interchange))' 8.bc -o 8.optbc
llc -filetype=obj --relocation-model=pic 8.optbc -o 8.o
clang 8.o -o 8.out
