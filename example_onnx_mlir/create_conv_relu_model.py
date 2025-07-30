#!/usr/bin/env python3

import torch
import torch.nn as nn
import onnx

class ConvReluModel(nn.Module):
    def __init__(self):
        super(ConvReluModel, self).__init__()
        self.conv = nn.Conv2d(in_channels=3, out_channels=16, kernel_size=3, padding=1)
        self.relu = nn.ReLU()
    
    def forward(self, x):
        x = self.conv(x)
        x = self.relu(x)
        return x

def create_onnx_model():
    # Create the model
    model = ConvReluModel()
    model.eval()
    
    # Create dummy input
    dummy_input = torch.randn(1, 3, 32, 32)
    
    # Export to ONNX
    torch.onnx.export(
        model,
        dummy_input,
        "conv_relu_model.onnx",
        export_params=True,
        opset_version=11,
        do_constant_folding=True,
        input_names=['input'],
        output_names=['output'],
        dynamic_axes={
            'input': {0: 'batch_size'},
            'output': {0: 'batch_size'}
        }
    )
    
    print("ONNX model created successfully!")
    print("Model saved as: conv_relu_model.onnx")
    
    # Verify the model
    onnx_model = onnx.load("conv_relu_model.onnx")
    onnx.checker.check_model(onnx_model)
    print("ONNX model verification passed!")
    
    # Print model info
    print(f"Model inputs: {[input.name for input in onnx_model.graph.input]}")
    print(f"Model outputs: {[output.name for output in onnx_model.graph.output]}")
    print(f"Number of nodes: {len(onnx_model.graph.node)}")

if __name__ == "__main__":
    create_onnx_model() 