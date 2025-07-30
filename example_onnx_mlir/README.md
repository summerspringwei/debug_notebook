# ONNX MLIR Conv+ReLU Example

A simple example demonstrating how to use ONNX MLIR to compile a neural network model with a convolution layer followed by a ReLU activation.

## Overview

This example shows the complete pipeline from PyTorch model to compiled executable:

1. **Create ONNX Model** - PyTorch model → ONNX format
2. **Convert to MLIR** - ONNX → MLIR representation  
3. **Compile to LLVM IR** - MLIR → LLVM IR
4. **Generate Executable** - LLVM IR → Shared library (.so)

## Model Architecture

- **Input**: 1×3×32×32 tensor (batch_size, channels, height, width)
- **Conv2d**: 3×3 kernel, 16 output channels, padding=1
- **ReLU**: Activation function
- **Output**: 1×16×32×32 tensor

## Prerequisites

- Docker
- Python 3 with PyTorch and ONNX
- Linux/macOS

## Quick Start

**run step by step:**
   ```bash
   # Create ONNX model
   python3 create_conv_relu_model.py
   
   # Convert to MLIR
   docker run --rm --entrypoint="" -v $(pwd):/workspace -w /workspace onnxmlir/onnx-mlir:latest \
       bash -c "onnx-mlir --EmitMLIR --printIR conv_relu_model.onnx > conv_relu_model.mlir"
   
   # Compile to LLVM IR
   docker run --rm --entrypoint="" -v $(pwd):/workspace -w /workspace onnxmlir/onnx-mlir:latest \
       bash -c "onnx-mlir --EmitLLVMIR --printIR conv_relu_model.onnx > conv_relu_model.ll"
   
   # Generate shared library
   docker run --rm --entrypoint="" -v $(pwd):/workspace -w /workspace onnxmlir/onnx-mlir:latest \
       bash -c "onnx-mlir --EmitLib conv_relu_model.onnx"
   ```
