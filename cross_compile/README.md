## Get assembly code for different architecture with clang

1. Download release or build clang from source.

2. Get all the supported architectures:
```shell
llc --version
```

3. Specify the target in the compilation commond:
We use `arm64` as an example:
```shell
clang ./addf.c -S -target arm64 -O0 -o addf_arm64_O0.s
```
Then you can open `addf_arm64_O0.s` to check the assembly code of the source program.

4. I have attached two scripts `compile_host.sh` and `compile_armv7a.sh` to produce assembly for `x86_64` and `armv7a`, respectively.


## References
* [clang](https://clang.llvm.org)
* [cross compilation](https://clang.llvm.org/docs/CrossCompilation.html)