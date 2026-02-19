#!/usr/bin/env python3
"""
ArmSME Dialect矩阵乘法示例代码
这个示例展示了如何使用MLIR的ArmSME dialect来执行矩阵乘法运算
"""

import mlir.ir as ir
import mlir.dialects.arm_sme as arm_sme
import mlir.dialects.vector as vector
import mlir.dialects.func as func
import mlir.dialects.memref as memref
import mlir.dialects.arith as arith
import mlir.dialects.affine as affine
from mlir import register_arm_sme_dialect
from mlir.ir import Context, Location

def create_armsme_matrix_multiply():
    """
    创建使用ArmSME dialect的矩阵乘法示例
    """
    with Context() as ctx, Location.unknown():
        # 注册必要的dialects
        register_arm_sme_dialect(ctx)
        
        # 定义模块
        module = ir.Module.create()
        
        with ir.InsertionPoint(module.body):
            # 定义矩阵乘法的函数签名
            # C = A * B，其中A是MxK，B是KxN，C是MxN
            M, K, N = 64, 64, 64  # 矩阵维度
            
            # 创建函数类型
            f32_type = ir.F32Type.get()
            memref_type_A = ir.MemRefType.get([M, K], f32_type)
            memref_type_B = ir.MemRefType.get([K, N], f32_type)
            memref_type_C = ir.MemRefType.get([M, N], f32_type)
            
            func_type = ir.FunctionType.get(
                inputs=[memref_type_A, memref_type_B, memref_type_C],
                results=[]
            )
            
            # 创建函数
            func_op = func.FuncOp("armsme_matrix_multiply", func_type)
            
            with ir.InsertionPoint(func_op.add_entry_block()):
                # 获取函数参数
                A, B, C = func_op.arguments
                
                # 初始化SME状态
                zero = arith.ConstantOp(f32_type, 0.0)
                
                # 定义SME tile大小 (通常是16x16 for fp32)
                tile_size = 16
                vector_type = ir.VectorType.get([tile_size, tile_size], f32_type)
                
                # 外层循环：按tile处理矩阵
                for i in range(0, M, tile_size):
                    for j in range(0, N, tile_size):
                        # 初始化累加器
                        acc = arm_sme.ZeroOp(vector_type)
                        
                        # 内层循环：K维度上的累加
                        for k in range(0, K, tile_size):
                            # 加载A的tile (i:i+16, k:k+16)
                            a_tile = vector.LoadOp(
                                vector_type,
                                A,
                                [i, k]
                            )
                            
                            # 加载B的tile (k:k+16, j:j+16)
                            b_tile = vector.LoadOp(
                                vector_type,
                                B,
                                [k, j]
                            )
                            
                            # 执行SME矩阵乘法累加
                            acc = arm_sme.MopaOp(
                                acc,
                                a_tile,
                                b_tile,
                                acc
                            )
                        
                        # 存储结果到C (i:i+16, j:j+16)
                        vector.StoreOp(
                            acc,
                            C,
                            [i, j]
                        )
                
                # 返回
                func.ReturnOp([])
        
        return module

def create_simplified_armsme_example():
    """
    创建一个简化的ArmSME示例，展示基本的SME操作
    """
    with Context() as ctx, Location.unknown():
        register_arm_sme_dialect(ctx)
        
        module = ir.Module.create()
        
        with ir.InsertionPoint(module.body):
            # 创建简单的向量乘法函数
            f32_type = ir.F32Type.get()
            vector_type = ir.VectorType.get([16], f32_type)
            
            func_type = ir.FunctionType.get(
                inputs=[vector_type, vector_type],
                results=[vector_type]
            )
            
            func_op = func.FuncOp("armsme_vector_multiply", func_type)
            
            with ir.InsertionPoint(func_op.add_entry_block()):
                a, b = func_op.arguments
                
                # 使用SME的向量乘法
                result = arm_sme.MulOp(vector_type, a, b)
                
                func.ReturnOp([result])
        
        return module

def print_mlir_code(module):
    """
    打印生成的MLIR代码
    """
    print("生成的MLIR ArmSME代码:")
    print("=" * 50)
    print(module)
    print("=" * 50)

if __name__ == "__main__":
    print("ArmSME Dialect矩阵乘法示例")
    print("=" * 60)
    
    # 生成并打印完整的矩阵乘法示例
    print("\n1. 完整的矩阵乘法示例:")
    matrix_multiply_module = create_armsme_matrix_multiply()
    print_mlir_code(matrix_multiply_module)
    
    # 生成并打印简化的示例
    print("\n2. 简化的向量乘法示例:")
    simple_module = create_simplified_armsme_example()
    print_mlir_code(simple_module)
    
    print("\n说明:")
    print("- ArmSME (Arm Scalable Matrix Extension) 是ARM的矩阵扩展指令集")
    print("- 支持高效的矩阵乘法运算，特别适合AI/ML工作负载")
    print("- SME提供16x16的tile支持，可以高效处理大矩阵运算")
    print("- 使用arm_sme.ZeroOp初始化累加器")
    print("- 使用arm_sme.MopaOp执行矩阵乘法累加操作")
