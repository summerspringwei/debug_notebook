
# How to compile MLIR to binary file? A step-by-step guide.

We start from one example files `conv_relu.mlir`.

> Lower the checked mlir to low-level `affine` mlir. 
Note the sequence of the passes are extremly important. We can enable the pass one-by-one to see the effects. 
For example, run `mlir-opt conv_relu.mlir --one-shot-bufferize -convert-linalg-to-affine-loops`, we can see that the `linalg` ops are now converted to `affine.for` loops.

(1) `--one-shot-bufferize` We should first convert `tensor` to `bufferization.to_memref`

(2) `-convert-linalg-to-affine-loops` **key step. Lower high-level linalg op to low-level affine-loops**

**End-to-end example**
```bash

mlir-opt conv_relu.mlir --one-shot-bufferize="bufferize-function-boundaries" -convert-linalg-to-affine-loops -convert-linalg-to-loops   --lower-affine   --convert-scf-to-cf   --convert-arith-to-llvm   --convert-func-to-llvm --finalize-memref-to-llvm --reconcile-unrealized-casts -o conv_relu_lowered.mlir

mlir-translate --mlir-to-llvmir conv_relu_lowered.mlir -o conv_relu.ll
```

**Note, we use llvm-20.0, version mismatch may cause compilation errors**