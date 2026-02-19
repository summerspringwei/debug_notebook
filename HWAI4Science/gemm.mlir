func.func @gemm_armsme(%A: memref<64x64xf32>, %B: memref<64x64xf32>, %C: memref<64x64xf32>) {
  %c0 = arith.constant 0 : index
  %c16 = arith.constant 16 : index
  %c32 = arith.constant 32 : index
  %c48 = arith.constant 48 : index
  %c64 = arith.constant 64 : index
  
  // 初始化SME状态
  %zero = arith.constant 0.0 : f32
  // 按16x16 tile处理矩阵
  // i = 0, 16, 32, 48
  affine.for %i = 0 to 64 step 16 {
    // j = 0, 16, 32, 48  
    affine.for %j = 0 to 64 step 16 {
      // 初始化累加器 - 16x16 tile
      %acc = arm_sme.zero {tile_id = 0 : i32} : vector<[16]x[16]xf32>
      // K维度累加循环
      affine.for %k = 0 to 64 step 16 {
        // 加载A的tile (i:i+16, k:k+16)
        %a_tile = vector.load %A[%i, %k] : memref<64x64xf32>, vector<16x16xf32>
        // 加载B的tile (k:k+16, j:j+16) 
        %b_tile = vector.load %B[%k, %j] : memref<64x64xf32>, vector<16x16xf32>
        // SME矩阵乘法累加操作
        %acc = arm_sme.mopa_wide_4way {
          acc = %acc : vector<[16]x[16]xf32>,
          lhs = %a_tile : vector<16x16xf32>,
          rhs = %b_tile : vector<16x16xf32>,
          mask = vector.constant_mask [16, 16] : vector<16x16xi1>
        } -> vector<[16]x[16]xf32>
      }
      // 存储结果到C (i:i+16, j:j+16)
      vector.store %acc, %C[%i, %j] : memref<64x64xf32>, vector<[16]x[16]xf32>
    }
  }
  
  func.return
}

// 主函数用于测试
func.func @main() -> i32 {
  // 分配内存
  %A = memref.alloc() : memref<64x64xf32>
  %B = memref.alloc() : memref<64x64xf32>  
  %C = memref.alloc() : memref<64x64xf32>
  
  // 初始化矩阵A和B
  affine.for %i = 0 to 64 {
    affine.for %j = 0 to 64 {
      %val_a = arith.constant 1.0 : f32
      %val_b = arith.constant 2.0 : f32
      memref.store %val_a, %A[%i, %j] : memref<64x64xf32>
      memref.store %val_b, %B[%i, %j] : memref<64x64xf32>
    }
  }
  
  // 调用GEMM函数
  func.call @gemm_armsme(%A, %B, %C) : (memref<64x64xf32>, memref<64x64xf32>, memref<64x64xf32>) -> ()
  
  // 释放内存
  memref.dealloc %A : memref<64x64xf32>
  memref.dealloc %B : memref<64x64xf32>
  memref.dealloc %C : memref<64x64xf32>
  
  %result = arith.constant 0 : i32
  func.return %result : i32
}
