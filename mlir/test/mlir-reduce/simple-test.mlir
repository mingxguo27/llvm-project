// UNSUPPORTED: -windows-
// RUN: mlir-reduce %s -test %S/test.sh -pass-test function

func @simple1(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>) {
  cond_br %arg0, ^bb1, ^bb2
^bb1:
  br ^bb3(%arg1 : memref<2xf32>)
^bb2:
  %0 = alloc() : memref<2xf32>
  br ^bb3(%0 : memref<2xf32>)
^bb3(%1: memref<2xf32>):
  return
}
