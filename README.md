## Debug linking error

### Pre-requirements

csmith:`https://github.com/csmith-project/csmith.git`


### Reproduce the bug
Run the following command:
```shell
clang 20.c  -g -O0 -Xclang -disable-O0-optnone -Xclang -disable-llvm-passes -emit-llvm -fPIE -c -o 8.bc
opt -passes='function(loop(loop-unroll-and-jam,loop-flatten,no-op-loopnest,loop-interchange))' 8.bc -o 8.optbc
llc -filetype=obj 8.optbc -o 8.o
clang 8.o -o 8.out
```

We got outputs:
```
/usr/bin/ld: 8.o: relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIE
clang-16: error: linker command failed with exit code 1 (use -v to see invocation)
```

### Path to solution
As the messages shows that the object file is not compiled with PIE (Position Idependent Code), so we need to compile with PIE flag.
As we have already pass the `-fPIE` to clang, so it might be that llc is not compile the llvm's IR with PIE.
So run 
```shell
llc --help > tmp.txt
```
and search `PIE` and `position`,
we find the help info with the following text:
```
  --relocation-model=<value>                                            - Choose relocation model
    =static                                                             -   Non-relocatable code
    =pic                                                                -   Fully relocatable, position independent code
    =dynamic-no-pic                                                     -   Relocatable external references, non-relocatable code
    =ropi                                                               -   Code and read-only data relocatable, accessed PC-relative
    =rwpi                                                               -   Read-write data relocatable, accessed relative to static base
    =ropi-rwpi                                                          -   Combination of ropi and rwpi
  --run-pass=<pass-name>                                                - Run compiler only for specified passes (comma separated list)
```
Then just add `--relocation-model=pic` to the llc.

### Solution

```shell
clang 20.c  -g -O0 -Xclang -disable-O0-optnone -Xclang -disable-llvm-passes -emit-llvm -fPIE -c -o 8.bc
opt -passes='function(loop(loop-unroll-and-jam,loop-flatten,no-op-loopnest,loop-interchange))' 8.bc -o 8.optbc
llc -filetype=obj --relocation-model=pic 8.optbc -o 8.o
clang 8.o -o 8.out
```