; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+bmi,+bmi2 | FileCheck %s --check-prefixes=CHECK,X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+bmi,+bmi2 | FileCheck %s --check-prefixes=CHECK,X64

define i32 @bzhi32(i32 %x, i32 %y)   {
; X86-LABEL: bzhi32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    addl %ecx, %ecx
; X86-NEXT:    bzhil %eax, %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: bzhi32:
; X64:       # %bb.0:
; X64-NEXT:    addl %edi, %edi
; X64-NEXT:    bzhil %esi, %edi, %eax
; X64-NEXT:    retq
  %x1 = add i32 %x, %x
  %tmp = tail call i32 @llvm.x86.bmi.bzhi.32(i32 %x1, i32 %y)
  ret i32 %tmp
}

define i32 @bzhi32_load(i32* %x, i32 %y)   {
; X86-LABEL: bzhi32_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    bzhil %eax, (%ecx), %eax
; X86-NEXT:    retl
;
; X64-LABEL: bzhi32_load:
; X64:       # %bb.0:
; X64-NEXT:    bzhil %esi, (%rdi), %eax
; X64-NEXT:    retq
  %x1 = load i32, i32* %x
  %tmp = tail call i32 @llvm.x86.bmi.bzhi.32(i32 %x1, i32 %y)
  ret i32 %tmp
}

declare i32 @llvm.x86.bmi.bzhi.32(i32, i32)

define i32 @pdep32(i32 %x, i32 %y)   {
; X86-LABEL: pdep32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    addl %ecx, %ecx
; X86-NEXT:    pdepl %ecx, %eax, %eax
; X86-NEXT:    retl
;
; X64-LABEL: pdep32:
; X64:       # %bb.0:
; X64-NEXT:    addl %esi, %esi
; X64-NEXT:    pdepl %esi, %edi, %eax
; X64-NEXT:    retq
  %y1 = add i32 %y, %y
  %tmp = tail call i32 @llvm.x86.bmi.pdep.32(i32 %x, i32 %y1)
  ret i32 %tmp
}

define i32 @pdep32_load(i32 %x, i32* %y)   {
; X86-LABEL: pdep32_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    pdepl (%eax), %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: pdep32_load:
; X64:       # %bb.0:
; X64-NEXT:    pdepl (%rsi), %edi, %eax
; X64-NEXT:    retq
  %y1 = load i32, i32* %y
  %tmp = tail call i32 @llvm.x86.bmi.pdep.32(i32 %x, i32 %y1)
  ret i32 %tmp
}

declare i32 @llvm.x86.bmi.pdep.32(i32, i32)

define i32 @pext32(i32 %x, i32 %y)   {
; X86-LABEL: pext32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    addl %ecx, %ecx
; X86-NEXT:    pextl %ecx, %eax, %eax
; X86-NEXT:    retl
;
; X64-LABEL: pext32:
; X64:       # %bb.0:
; X64-NEXT:    addl %esi, %esi
; X64-NEXT:    pextl %esi, %edi, %eax
; X64-NEXT:    retq
  %y1 = add i32 %y, %y
  %tmp = tail call i32 @llvm.x86.bmi.pext.32(i32 %x, i32 %y1)
  ret i32 %tmp
}

define i32 @pext32_load(i32 %x, i32* %y)   {
; X86-LABEL: pext32_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    pextl (%eax), %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: pext32_load:
; X64:       # %bb.0:
; X64-NEXT:    pextl (%rsi), %edi, %eax
; X64-NEXT:    retq
  %y1 = load i32, i32* %y
  %tmp = tail call i32 @llvm.x86.bmi.pext.32(i32 %x, i32 %y1)
  ret i32 %tmp
}

declare i32 @llvm.x86.bmi.pext.32(i32, i32)

define i32 @mulx32(i32 %x, i32 %y, i32* %p)   {
; X86-LABEL: mulx32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    addl %edx, %edx
; X86-NEXT:    addl %eax, %eax
; X86-NEXT:    mulxl %eax, %eax, %edx
; X86-NEXT:    movl %edx, (%ecx)
; X86-NEXT:    retl
;
; X64-LABEL: mulx32:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    addl %edi, %edi
; X64-NEXT:    addl %esi, %esi
; X64-NEXT:    imulq %rdi, %rsi
; X64-NEXT:    movq %rsi, %rax
; X64-NEXT:    shrq $32, %rax
; X64-NEXT:    movl %eax, (%rdx)
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    retq
  %x1 = add i32 %x, %x
  %y1 = add i32 %y, %y
  %x2 = zext i32 %x1 to i64
  %y2 = zext i32 %y1 to i64
  %r1 = mul i64 %x2, %y2
  %h1 = lshr i64 %r1, 32
  %h  = trunc i64 %h1 to i32
  %l  = trunc i64 %r1 to i32
  store i32 %h, i32* %p
  ret i32 %l
}

define i32 @mulx32_load(i32 %x, i32* %y, i32* %p)   {
; X86-LABEL: mulx32_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    addl %edx, %edx
; X86-NEXT:    mulxl (%eax), %eax, %edx
; X86-NEXT:    movl %edx, (%ecx)
; X86-NEXT:    retl
;
; X64-LABEL: mulx32_load:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    addl %edi, %edi
; X64-NEXT:    movl (%rsi), %eax
; X64-NEXT:    imulq %rax, %rdi
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    shrq $32, %rax
; X64-NEXT:    movl %eax, (%rdx)
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    retq
  %x1 = add i32 %x, %x
  %y1 = load i32, i32* %y
  %x2 = zext i32 %x1 to i64
  %y2 = zext i32 %y1 to i64
  %r1 = mul i64 %x2, %y2
  %h1 = lshr i64 %r1, 32
  %h  = trunc i64 %h1 to i32
  %l  = trunc i64 %r1 to i32
  store i32 %h, i32* %p
  ret i32 %l
}
