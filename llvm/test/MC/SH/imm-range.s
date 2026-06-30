# RUN: not llvm-mc -triple=sh %s 2>&1 | FileCheck %s

# Immediate operand out of 8-bit signed range — must be rejected
mov #9999, r0
# CHECK: error:
