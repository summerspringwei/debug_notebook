
# How to compile MLIR to binary file? A step-by-step guide.

We provide two example files `conv_relu.mlir` and `conv_affine.mlir`.

> 2. Lower the checked mlir to low-level `affine` mlir. Note the sequence of the passes are extremly important. We can enable the pass one-by-one to see the effects. For example, run `mlir-opt conv_relu.mlir --one-shot-bufferize -convert-linalg-to-affine-loops`, we can see that the `linalg` ops are now converted to `affine.for` loops.
> > (1) `--one-shot-bufferize` We should first convert `tensor` to `bufferization.to_memref`
> > (2) `-convert-linalg-to-affine-loops` **key step. Lower high-level linalg op to low-level affine-loops**

We can show the transformed IR after each pass, e.g.:
```bash
/home/xiachunwei/Software/llvm-project-release/myrelease-20.0/bin/mlir-opt conv_relu.mlir --one-shot-bufferize="bufferize-function-boundaries" -convert-linalg-to-affine-loops
```

**End-to-end example**
```bash

/home/xiachunwei/Software/llvm-project-release/myrelease-20.0/bin/mlir-opt conv_relu.mlir --one-shot-bufferize="bufferize-function-boundaries" -convert-linalg-to-affine-loops -convert-linalg-to-loops   --lower-affine   --convert-scf-to-cf   --convert-arith-to-llvm   --convert-func-to-llvm --finalize-memref-to-llvm --reconcile-unrealized-casts -o conv_relu_lowered.mlir

/home/xiachunwei/Software/llvm-project-release/myrelease-20.0/bin/mlir-translate --mlir-to-llvmir conv_relu_lowered.mlir -o conv_relu.ll
```
