; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mattr=+avx512f | FileCheck %s  --check-prefix=CHECK --check-prefix=KNL
; RUN: llc < %s -mattr=+avx512f,+avx512vl,+avx512bw,+avx512dq | FileCheck %s  --check-prefix=CHECK --check-prefix=SKX

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @foo64(i1 zeroext %i) #0 {
; CHECK-LABEL: foo64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzbl %dil, %eax
; CHECK-NEXT:    orq $-2, %rax
; CHECK-NEXT:    retq
  br label %bb

bb:
  %z = zext i1 %i to i64
  %v = or i64 %z, -2
  br label %end

end:
  ret i64 %v
}

define i16 @foo16(i1 zeroext %i) #0 {
; CHECK-LABEL: foo16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzbl %dil, %eax
; CHECK-NEXT:    orl $65534, %eax # imm = 0xFFFE
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq
  br label %bb

bb:
  %z = zext i1 %i to i16
  %v = or i16 %z, -2
  br label %end

end:
  ret i16 %v
}

define i16 @foo16_1(i1 zeroext %i, i32 %j) #0 {
; CHECK-LABEL: foo16_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzbl %dil, %eax
; CHECK-NEXT:    orl $2, %eax
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq
  br label %bb

bb:
  %z = zext i1 %i to i16
  %v = or i16 %z, 2
  br label %end

end:
  ret i16 %v
}

define i32 @foo32(i1 zeroext %i) #0 {
; CHECK-LABEL: foo32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzbl %dil, %eax
; CHECK-NEXT:    orl $-2, %eax
; CHECK-NEXT:    retq
  br label %bb

bb:
  %z = zext i1 %i to i32
  %v = or i32 %z, -2
  br label %end

end:
  ret i32 %v
}

define i8 @foo8(i1 zeroext %i) #0 {
; CHECK-LABEL: foo8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orb $-2, %dil
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    retq
  br label %bb

bb:
  %z = zext i1 %i to i8
  %v = or i8 %z, -2
  br label %end

end:
  ret i8 %v
}

