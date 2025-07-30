module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.mlir.global private constant @__constant_1x1x3x3xf32(dense<1.000000e+00> : tensor<1x1x3x3xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<1 x array<1 x array<3 x array<3 x f32>>>>
  llvm.mlir.global private constant @__constant_1x1x7x7xf32(dense<[[[[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00, 5.000000e+00, 6.000000e+00, 7.000000e+00], [8.000000e+00, 9.000000e+00, 1.000000e+01, 1.100000e+01, 1.200000e+01, 1.300000e+01, 1.400000e+01], [1.500000e+01, 1.600000e+01, 1.700000e+01, 1.800000e+01, 1.900000e+01, 2.000000e+01, 2.100000e+01], [2.200000e+01, 2.300000e+01, 2.400000e+01, 2.500000e+01, 2.600000e+01, 2.700000e+01, 2.800000e+01], [2.900000e+01, 3.000000e+01, 3.100000e+01, 3.200000e+01, 3.300000e+01, 3.400000e+01, 3.500000e+01], [3.600000e+01, 3.700000e+01, 3.800000e+01, 3.900000e+01, 4.000000e+01, 4.100000e+01, 4.200000e+01], [4.300000e+01, 4.400000e+01, 4.500000e+01, 4.600000e+01, 4.700000e+01, 4.800000e+01, 4.900000e+01]]]]> : tensor<1x1x7x7xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<1 x array<1 x array<7 x array<7 x f32>>>>
  llvm.func @conv2d_nchw_fchw(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: i64, %arg11: !llvm.ptr, %arg12: !llvm.ptr, %arg13: i64, %arg14: i64, %arg15: i64, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64, %arg21: i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %1 = llvm.insertvalue %arg11, %0[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %2 = llvm.insertvalue %arg12, %1[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %3 = llvm.insertvalue %arg13, %2[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %4 = llvm.insertvalue %arg14, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %5 = llvm.insertvalue %arg18, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %6 = llvm.insertvalue %arg15, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %7 = llvm.insertvalue %arg19, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %8 = llvm.insertvalue %arg16, %7[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %9 = llvm.insertvalue %arg20, %8[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %10 = llvm.insertvalue %arg17, %9[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %11 = llvm.insertvalue %arg21, %10[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %12 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %13 = llvm.insertvalue %arg0, %12[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %14 = llvm.insertvalue %arg1, %13[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %15 = llvm.insertvalue %arg2, %14[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %16 = llvm.insertvalue %arg3, %15[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %17 = llvm.insertvalue %arg7, %16[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %18 = llvm.insertvalue %arg4, %17[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %19 = llvm.insertvalue %arg8, %18[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %20 = llvm.insertvalue %arg5, %19[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %21 = llvm.insertvalue %arg9, %20[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %22 = llvm.insertvalue %arg6, %21[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %23 = llvm.insertvalue %arg10, %22[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %24 = llvm.mlir.constant(1 : index) : i64
    %25 = llvm.mlir.constant(1 : index) : i64
    %26 = llvm.mlir.constant(5 : index) : i64
    %27 = llvm.mlir.constant(5 : index) : i64
    %28 = llvm.mlir.constant(1 : index) : i64
    %29 = llvm.mlir.constant(25 : index) : i64
    %30 = llvm.mlir.constant(25 : index) : i64
    %31 = llvm.mlir.constant(25 : index) : i64
    %32 = llvm.mlir.zero : !llvm.ptr
    %33 = llvm.getelementptr %32[%31] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %34 = llvm.ptrtoint %33 : !llvm.ptr to i64
    %35 = llvm.mlir.constant(64 : index) : i64
    %36 = llvm.add %34, %35 : i64
    %37 = llvm.call @malloc(%36) : (i64) -> !llvm.ptr
    %38 = llvm.ptrtoint %37 : !llvm.ptr to i64
    %39 = llvm.mlir.constant(1 : index) : i64
    %40 = llvm.sub %35, %39 : i64
    %41 = llvm.add %38, %40 : i64
    %42 = llvm.urem %41, %35  : i64
    %43 = llvm.sub %41, %42 : i64
    %44 = llvm.inttoptr %43 : i64 to !llvm.ptr
    %45 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %46 = llvm.insertvalue %37, %45[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %47 = llvm.insertvalue %44, %46[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %48 = llvm.mlir.constant(0 : index) : i64
    %49 = llvm.insertvalue %48, %47[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %50 = llvm.insertvalue %24, %49[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %51 = llvm.insertvalue %25, %50[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %52 = llvm.insertvalue %26, %51[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %53 = llvm.insertvalue %27, %52[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %54 = llvm.insertvalue %30, %53[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %55 = llvm.insertvalue %29, %54[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %56 = llvm.insertvalue %27, %55[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %57 = llvm.insertvalue %28, %56[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %58 = llvm.mlir.constant(0 : index) : i64
    %59 = llvm.mlir.constant(1 : index) : i64
    %60 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%58 : i64)
  ^bb1(%61: i64):  // 2 preds: ^bb0, ^bb20
    %62 = llvm.icmp "slt" %61, %59 : i64
    llvm.cond_br %62, ^bb2, ^bb21
  ^bb2:  // pred: ^bb1
    %63 = llvm.mlir.constant(0 : index) : i64
    %64 = llvm.mlir.constant(1 : index) : i64
    %65 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb3(%63 : i64)
  ^bb3(%66: i64):  // 2 preds: ^bb2, ^bb19
    %67 = llvm.icmp "slt" %66, %64 : i64
    llvm.cond_br %67, ^bb4, ^bb20
  ^bb4:  // pred: ^bb3
    %68 = llvm.mlir.constant(0 : index) : i64
    %69 = llvm.mlir.constant(5 : index) : i64
    %70 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb5(%68 : i64)
  ^bb5(%71: i64):  // 2 preds: ^bb4, ^bb18
    %72 = llvm.icmp "slt" %71, %69 : i64
    llvm.cond_br %72, ^bb6, ^bb19
  ^bb6:  // pred: ^bb5
    %73 = llvm.mlir.constant(0 : index) : i64
    %74 = llvm.mlir.constant(5 : index) : i64
    %75 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb7(%73 : i64)
  ^bb7(%76: i64):  // 2 preds: ^bb6, ^bb17
    %77 = llvm.icmp "slt" %76, %74 : i64
    llvm.cond_br %77, ^bb8, ^bb18
  ^bb8:  // pred: ^bb7
    %78 = llvm.mlir.constant(0 : index) : i64
    %79 = llvm.mlir.constant(1 : index) : i64
    %80 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb9(%78 : i64)
  ^bb9(%81: i64):  // 2 preds: ^bb8, ^bb16
    %82 = llvm.icmp "slt" %81, %79 : i64
    llvm.cond_br %82, ^bb10, ^bb17
  ^bb10:  // pred: ^bb9
    %83 = llvm.mlir.constant(0 : index) : i64
    %84 = llvm.mlir.constant(3 : index) : i64
    %85 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb11(%83 : i64)
  ^bb11(%86: i64):  // 2 preds: ^bb10, ^bb15
    %87 = llvm.icmp "slt" %86, %84 : i64
    llvm.cond_br %87, ^bb12, ^bb16
  ^bb12:  // pred: ^bb11
    %88 = llvm.mlir.constant(0 : index) : i64
    %89 = llvm.mlir.constant(3 : index) : i64
    %90 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb13(%88 : i64)
  ^bb13(%91: i64):  // 2 preds: ^bb12, ^bb14
    %92 = llvm.icmp "slt" %91, %89 : i64
    llvm.cond_br %92, ^bb14, ^bb15
  ^bb14:  // pred: ^bb13
    %93 = llvm.add %71, %86 : i64
    %94 = llvm.add %76, %91 : i64
    %95 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %96 = llvm.extractvalue %23[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %97 = llvm.getelementptr %95[%96] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %98 = llvm.extractvalue %23[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %99 = llvm.mul %61, %98 : i64
    %100 = llvm.extractvalue %23[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %101 = llvm.mul %81, %100 : i64
    %102 = llvm.add %99, %101 : i64
    %103 = llvm.extractvalue %23[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %104 = llvm.mul %93, %103 : i64
    %105 = llvm.add %102, %104 : i64
    %106 = llvm.extractvalue %23[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %107 = llvm.mul %94, %106 : i64
    %108 = llvm.add %105, %107 : i64
    %109 = llvm.getelementptr %97[%108] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %110 = llvm.load %109 : !llvm.ptr -> f32
    %111 = llvm.extractvalue %11[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %112 = llvm.extractvalue %11[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %113 = llvm.getelementptr %111[%112] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %114 = llvm.extractvalue %11[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %115 = llvm.mul %66, %114 : i64
    %116 = llvm.extractvalue %11[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %117 = llvm.mul %81, %116 : i64
    %118 = llvm.add %115, %117 : i64
    %119 = llvm.extractvalue %11[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %120 = llvm.mul %86, %119 : i64
    %121 = llvm.add %118, %120 : i64
    %122 = llvm.extractvalue %11[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %123 = llvm.mul %91, %122 : i64
    %124 = llvm.add %121, %123 : i64
    %125 = llvm.getelementptr %113[%124] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %126 = llvm.load %125 : !llvm.ptr -> f32
    %127 = llvm.extractvalue %57[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %128 = llvm.mlir.constant(25 : index) : i64
    %129 = llvm.mul %61, %128 : i64
    %130 = llvm.mlir.constant(25 : index) : i64
    %131 = llvm.mul %66, %130 : i64
    %132 = llvm.add %129, %131 : i64
    %133 = llvm.mlir.constant(5 : index) : i64
    %134 = llvm.mul %71, %133 : i64
    %135 = llvm.add %132, %134 : i64
    %136 = llvm.add %135, %76 : i64
    %137 = llvm.getelementptr %127[%136] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %138 = llvm.load %137 : !llvm.ptr -> f32
    %139 = llvm.fmul %110, %126  : f32
    %140 = llvm.fadd %138, %139  : f32
    %141 = llvm.extractvalue %57[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %142 = llvm.mlir.constant(25 : index) : i64
    %143 = llvm.mul %61, %142 : i64
    %144 = llvm.mlir.constant(25 : index) : i64
    %145 = llvm.mul %66, %144 : i64
    %146 = llvm.add %143, %145 : i64
    %147 = llvm.mlir.constant(5 : index) : i64
    %148 = llvm.mul %71, %147 : i64
    %149 = llvm.add %146, %148 : i64
    %150 = llvm.add %149, %76 : i64
    %151 = llvm.getelementptr %141[%150] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %140, %151 : f32, !llvm.ptr
    %152 = llvm.add %91, %90 : i64
    llvm.br ^bb13(%152 : i64)
  ^bb15:  // pred: ^bb13
    %153 = llvm.add %86, %85 : i64
    llvm.br ^bb11(%153 : i64)
  ^bb16:  // pred: ^bb11
    %154 = llvm.add %81, %80 : i64
    llvm.br ^bb9(%154 : i64)
  ^bb17:  // pred: ^bb9
    %155 = llvm.add %76, %75 : i64
    llvm.br ^bb7(%155 : i64)
  ^bb18:  // pred: ^bb7
    %156 = llvm.add %71, %70 : i64
    llvm.br ^bb5(%156 : i64)
  ^bb19:  // pred: ^bb5
    %157 = llvm.add %66, %65 : i64
    llvm.br ^bb3(%157 : i64)
  ^bb20:  // pred: ^bb3
    %158 = llvm.add %61, %60 : i64
    llvm.br ^bb1(%158 : i64)
  ^bb21:  // pred: ^bb1
    llvm.return %57 : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
  }
  llvm.func @relu(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %5 = llvm.insertvalue %arg7, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %7 = llvm.insertvalue %arg8, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %8 = llvm.insertvalue %arg5, %7[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %9 = llvm.insertvalue %arg9, %8[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %10 = llvm.insertvalue %arg6, %9[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %11 = llvm.insertvalue %arg10, %10[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %12 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %13 = llvm.mlir.constant(1 : index) : i64
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.mlir.constant(5 : index) : i64
    %16 = llvm.mlir.constant(5 : index) : i64
    %17 = llvm.mlir.constant(1 : index) : i64
    %18 = llvm.mlir.constant(25 : index) : i64
    %19 = llvm.mlir.constant(25 : index) : i64
    %20 = llvm.mlir.constant(25 : index) : i64
    %21 = llvm.mlir.zero : !llvm.ptr
    %22 = llvm.getelementptr %21[%20] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %23 = llvm.ptrtoint %22 : !llvm.ptr to i64
    %24 = llvm.mlir.constant(64 : index) : i64
    %25 = llvm.add %23, %24 : i64
    %26 = llvm.call @malloc(%25) : (i64) -> !llvm.ptr
    %27 = llvm.ptrtoint %26 : !llvm.ptr to i64
    %28 = llvm.mlir.constant(1 : index) : i64
    %29 = llvm.sub %24, %28 : i64
    %30 = llvm.add %27, %29 : i64
    %31 = llvm.urem %30, %24  : i64
    %32 = llvm.sub %30, %31 : i64
    %33 = llvm.inttoptr %32 : i64 to !llvm.ptr
    %34 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %35 = llvm.insertvalue %26, %34[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %36 = llvm.insertvalue %33, %35[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %37 = llvm.mlir.constant(0 : index) : i64
    %38 = llvm.insertvalue %37, %36[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %39 = llvm.insertvalue %13, %38[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %40 = llvm.insertvalue %14, %39[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %41 = llvm.insertvalue %15, %40[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %42 = llvm.insertvalue %16, %41[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %43 = llvm.insertvalue %19, %42[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %44 = llvm.insertvalue %18, %43[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %45 = llvm.insertvalue %16, %44[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %46 = llvm.insertvalue %17, %45[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %47 = llvm.mlir.constant(0 : index) : i64
    %48 = llvm.mlir.constant(1 : index) : i64
    %49 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%47 : i64)
  ^bb1(%50: i64):  // 2 preds: ^bb0, ^bb11
    %51 = llvm.icmp "slt" %50, %48 : i64
    llvm.cond_br %51, ^bb2, ^bb12
  ^bb2:  // pred: ^bb1
    %52 = llvm.mlir.constant(0 : index) : i64
    %53 = llvm.mlir.constant(1 : index) : i64
    %54 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb3(%52 : i64)
  ^bb3(%55: i64):  // 2 preds: ^bb2, ^bb10
    %56 = llvm.icmp "slt" %55, %53 : i64
    llvm.cond_br %56, ^bb4, ^bb11
  ^bb4:  // pred: ^bb3
    %57 = llvm.mlir.constant(0 : index) : i64
    %58 = llvm.mlir.constant(5 : index) : i64
    %59 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb5(%57 : i64)
  ^bb5(%60: i64):  // 2 preds: ^bb4, ^bb9
    %61 = llvm.icmp "slt" %60, %58 : i64
    llvm.cond_br %61, ^bb6, ^bb10
  ^bb6:  // pred: ^bb5
    %62 = llvm.mlir.constant(0 : index) : i64
    %63 = llvm.mlir.constant(5 : index) : i64
    %64 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb7(%62 : i64)
  ^bb7(%65: i64):  // 2 preds: ^bb6, ^bb8
    %66 = llvm.icmp "slt" %65, %63 : i64
    llvm.cond_br %66, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %67 = llvm.extractvalue %11[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %68 = llvm.extractvalue %11[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %69 = llvm.getelementptr %67[%68] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %70 = llvm.extractvalue %11[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %71 = llvm.mul %50, %70 : i64
    %72 = llvm.extractvalue %11[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %73 = llvm.mul %55, %72 : i64
    %74 = llvm.add %71, %73 : i64
    %75 = llvm.extractvalue %11[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %76 = llvm.mul %60, %75 : i64
    %77 = llvm.add %74, %76 : i64
    %78 = llvm.extractvalue %11[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %79 = llvm.mul %65, %78 : i64
    %80 = llvm.add %77, %79 : i64
    %81 = llvm.getelementptr %69[%80] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %82 = llvm.load %81 : !llvm.ptr -> f32
    %83 = llvm.fcmp "ogt" %82, %12 : f32
    %84 = llvm.select %83, %82, %12 : i1, f32
    %85 = llvm.extractvalue %46[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %86 = llvm.mlir.constant(25 : index) : i64
    %87 = llvm.mul %50, %86 : i64
    %88 = llvm.mlir.constant(25 : index) : i64
    %89 = llvm.mul %55, %88 : i64
    %90 = llvm.add %87, %89 : i64
    %91 = llvm.mlir.constant(5 : index) : i64
    %92 = llvm.mul %60, %91 : i64
    %93 = llvm.add %90, %92 : i64
    %94 = llvm.add %93, %65 : i64
    %95 = llvm.getelementptr %85[%94] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %84, %95 : f32, !llvm.ptr
    %96 = llvm.add %65, %64 : i64
    llvm.br ^bb7(%96 : i64)
  ^bb9:  // pred: ^bb7
    %97 = llvm.add %60, %59 : i64
    llvm.br ^bb5(%97 : i64)
  ^bb10:  // pred: ^bb5
    %98 = llvm.add %55, %54 : i64
    llvm.br ^bb3(%98 : i64)
  ^bb11:  // pred: ^bb3
    %99 = llvm.add %50, %49 : i64
    llvm.br ^bb1(%99 : i64)
  ^bb12:  // pred: ^bb1
    llvm.return %46 : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.constant(7 : index) : i64
    %3 = llvm.mlir.constant(7 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(49 : index) : i64
    %6 = llvm.mlir.constant(49 : index) : i64
    %7 = llvm.mlir.constant(49 : index) : i64
    %8 = llvm.mlir.zero : !llvm.ptr
    %9 = llvm.getelementptr %8[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %10 = llvm.ptrtoint %9 : !llvm.ptr to i64
    %11 = llvm.mlir.addressof @__constant_1x1x7x7xf32 : !llvm.ptr
    %12 = llvm.getelementptr %11[0, 0, 0, 0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x array<1 x array<7 x array<7 x f32>>>>
    %13 = llvm.mlir.constant(3735928559 : index) : i64
    %14 = llvm.inttoptr %13 : i64 to !llvm.ptr
    %15 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %16 = llvm.insertvalue %14, %15[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %17 = llvm.insertvalue %12, %16[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %18 = llvm.mlir.constant(0 : index) : i64
    %19 = llvm.insertvalue %18, %17[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %20 = llvm.insertvalue %0, %19[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %21 = llvm.insertvalue %1, %20[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %22 = llvm.insertvalue %2, %21[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %23 = llvm.insertvalue %3, %22[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %24 = llvm.insertvalue %6, %23[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %25 = llvm.insertvalue %5, %24[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %26 = llvm.insertvalue %3, %25[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %27 = llvm.insertvalue %4, %26[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %28 = llvm.mlir.constant(1 : index) : i64
    %29 = llvm.mlir.constant(1 : index) : i64
    %30 = llvm.mlir.constant(3 : index) : i64
    %31 = llvm.mlir.constant(3 : index) : i64
    %32 = llvm.mlir.constant(1 : index) : i64
    %33 = llvm.mlir.constant(9 : index) : i64
    %34 = llvm.mlir.constant(9 : index) : i64
    %35 = llvm.mlir.constant(9 : index) : i64
    %36 = llvm.mlir.zero : !llvm.ptr
    %37 = llvm.getelementptr %36[%35] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %38 = llvm.ptrtoint %37 : !llvm.ptr to i64
    %39 = llvm.mlir.addressof @__constant_1x1x3x3xf32 : !llvm.ptr
    %40 = llvm.getelementptr %39[0, 0, 0, 0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x array<1 x array<3 x array<3 x f32>>>>
    %41 = llvm.mlir.constant(3735928559 : index) : i64
    %42 = llvm.inttoptr %41 : i64 to !llvm.ptr
    %43 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %44 = llvm.insertvalue %42, %43[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %45 = llvm.insertvalue %40, %44[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %46 = llvm.mlir.constant(0 : index) : i64
    %47 = llvm.insertvalue %46, %45[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %48 = llvm.insertvalue %28, %47[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %49 = llvm.insertvalue %29, %48[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %50 = llvm.insertvalue %30, %49[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %51 = llvm.insertvalue %31, %50[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %52 = llvm.insertvalue %34, %51[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %53 = llvm.insertvalue %33, %52[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %54 = llvm.insertvalue %31, %53[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %55 = llvm.insertvalue %32, %54[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %56 = llvm.extractvalue %27[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %57 = llvm.extractvalue %27[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %58 = llvm.extractvalue %27[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %59 = llvm.extractvalue %27[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %60 = llvm.extractvalue %27[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %61 = llvm.extractvalue %27[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %62 = llvm.extractvalue %27[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %63 = llvm.extractvalue %27[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %64 = llvm.extractvalue %27[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %65 = llvm.extractvalue %27[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %66 = llvm.extractvalue %27[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %67 = llvm.extractvalue %55[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %68 = llvm.extractvalue %55[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %69 = llvm.extractvalue %55[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %70 = llvm.extractvalue %55[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %71 = llvm.extractvalue %55[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %72 = llvm.extractvalue %55[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %73 = llvm.extractvalue %55[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %74 = llvm.extractvalue %55[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %75 = llvm.extractvalue %55[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %76 = llvm.extractvalue %55[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %77 = llvm.extractvalue %55[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %78 = llvm.call @conv2d_nchw_fchw(%56, %57, %58, %59, %60, %61, %62, %63, %64, %65, %66, %67, %68, %69, %70, %71, %72, %73, %74, %75, %76, %77) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %79 = llvm.extractvalue %78[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %80 = llvm.extractvalue %78[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %81 = llvm.extractvalue %78[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %82 = llvm.extractvalue %78[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %83 = llvm.extractvalue %78[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %84 = llvm.extractvalue %78[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %85 = llvm.extractvalue %78[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %86 = llvm.extractvalue %78[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %87 = llvm.extractvalue %78[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %88 = llvm.extractvalue %78[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %89 = llvm.extractvalue %78[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %90 = llvm.call @relu(%79, %80, %81, %82, %83, %84, %85, %86, %87, %88, %89) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    llvm.return
  }
}

