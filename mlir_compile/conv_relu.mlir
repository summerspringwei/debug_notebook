#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @conv2d_nchw_fchw(%arg0: tensor<1x1x7x7xf32>, %arg1: tensor<1x1x3x3xf32>) -> tensor<1x1x5x5xf32> {
    %0 = bufferization.alloc_tensor() : tensor<1x1x5x5xf32>
    %1 = linalg.conv_2d_nchw_fchw ins(%arg0, %arg1 : tensor<1x1x7x7xf32>, tensor<1x1x3x3xf32>) outs(%0 : tensor<1x1x5x5xf32>) -> tensor<1x1x5x5xf32>
    return %1 : tensor<1x1x5x5xf32>
  }
  func.func @relu(%arg0: tensor<1x1x5x5xf32>) -> tensor<1x1x5x5xf32> {
    %0 = bufferization.alloc_tensor() : tensor<1x1x5x5xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<1x1x5x5xf32>) outs(%0 : tensor<1x1x5x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.cmpf ogt, %in, %cst : f32
      %3 = arith.select %2, %in, %cst : f32
      linalg.yield %3 : f32
    } -> tensor<1x1x5x5xf32>
    return %1 : tensor<1x1x5x5xf32>
  }
  func.func @main() {
    %cst = arith.constant dense<[[[[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00, 5.000000e+00, 6.000000e+00, 7.000000e+00], [8.000000e+00, 9.000000e+00, 1.000000e+01, 1.100000e+01, 1.200000e+01, 1.300000e+01, 1.400000e+01], [1.500000e+01, 1.600000e+01, 1.700000e+01, 1.800000e+01, 1.900000e+01, 2.000000e+01, 2.100000e+01], [2.200000e+01, 2.300000e+01, 2.400000e+01, 2.500000e+01, 2.600000e+01, 2.700000e+01, 2.800000e+01], [2.900000e+01, 3.000000e+01, 3.100000e+01, 3.200000e+01, 3.300000e+01, 3.400000e+01, 3.500000e+01], [3.600000e+01, 3.700000e+01, 3.800000e+01, 3.900000e+01, 4.000000e+01, 4.100000e+01, 4.200000e+01], [4.300000e+01, 4.400000e+01, 4.500000e+01, 4.600000e+01, 4.700000e+01, 4.800000e+01, 4.900000e+01]]]]> : tensor<1x1x7x7xf32>
    %cst_0 = arith.constant dense<1.000000e+00> : tensor<1x1x3x3xf32>
    %0 = call @conv2d_nchw_fchw(%cst, %cst_0) : (tensor<1x1x7x7xf32>, tensor<1x1x3x3xf32>) -> tensor<1x1x5x5xf32>
    %1 = call @relu(%0) : (tensor<1x1x5x5xf32>) -> tensor<1x1x5x5xf32>
    return
  }
}

