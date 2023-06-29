set -xe
export PATH="/home/xiachunwei/Software/llvm-project/mybuilddir/bin":$PATH
which opt
# rm foo.bc foo.optbc
clang -S -emit-llvm foo.c -o foo.bc
# opt -passes='no-op-module,cgscc(no-op-cgscc,function(no-op-function,loop(no-op-loop))),function(no-op-function,loop(no-op-loop))' foo.bc -o foo.optbc

# Wrong way
opt -passes='wholeprogramdevirt,loop(no-op-loopnest)' foo.bc -o foo.optbc

# Right way
# opt -passes='wholeprogramdevirt,function(loop(no-op-loopnest))' foo.bc -o foo.optbc

# Another example
# opt -passes='module(constmerge),function(loop(loop-unroll-and-jam))' foo.bc -o foo.optbc
