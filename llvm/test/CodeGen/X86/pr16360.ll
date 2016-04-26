; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-pc-linux | FileCheck %s

define i64 @foo(i32 %sum) {
; CHECK-LABEL: foo:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    shrl $2, %eax
; CHECK-NEXT:    orl $-67108864, %eax # imm = 0xFFFFFFFFFC000000
; CHECK-NEXT:    movl $1073741823, %edx # imm = 0x3FFFFFFF
; CHECK-NEXT:    retl
entry:
  %conv = sext i32 %sum to i64
  %shr = lshr i64 %conv, 2
  %or = or i64 4611686018360279040, %shr
  ret i64 %or
}
