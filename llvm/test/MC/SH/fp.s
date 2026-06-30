# RUN: llvm-mc -triple=sh -show-encoding %s | FileCheck %s

# Single-precision arithmetic
fadd fr0, fr1
# CHECK: fadd fr0, fr1 {{.*}}encoding: [0xf1,0x00]
fsub fr0, fr1
# CHECK: fsub fr0, fr1 {{.*}}encoding: [0xf1,0x01]
fmul fr0, fr1
# CHECK: fmul fr0, fr1 {{.*}}encoding: [0xf1,0x02]
fdiv fr0, fr1
# CHECK: fdiv fr0, fr1 {{.*}}encoding: [0xf1,0x03]
fabs fr0
# CHECK: fabs fr0 {{.*}}encoding: [0xf0,0x5d]
fneg fr0
# CHECK: fneg fr0 {{.*}}encoding: [0xf0,0x4d]
fsqrt fr0
# CHECK: fsqrt fr0 {{.*}}encoding: [0xf0,0x6d]

# Single-precision compare
fcmp/eq fr0, fr1
# CHECK: fcmp/eq fr0, fr1 {{.*}}encoding: [0xf1,0x04]
fcmp/gt fr0, fr1
# CHECK: fcmp/gt fr0, fr1 {{.*}}encoding: [0xf1,0x05]

# Single-precision move and load
fmov fr0, fr1
# CHECK: fmov fr0, fr1 {{.*}}encoding: [0xf1,0x0c]
fldi0 fr0
# CHECK: fldi0 fr0 {{.*}}encoding: [0xf0,0x8d]
fldi1 fr0
# CHECK: fldi1 fr0 {{.*}}encoding: [0xf0,0x9d]

# FPUL transfer
flds fr0, FPUL
# CHECK: flds fr0, fpul {{.*}}encoding: [0xf0,0x1d]
fsts FPUL, fr0
# CHECK: fsts fpul, fr0 {{.*}}encoding: [0xf0,0x0d]
ftrc fr0, FPUL
# CHECK: ftrc fr0, fpul {{.*}}encoding: [0xf0,0x3d]
float FPUL, fr0
# CHECK: float fpul, fr0 {{.*}}encoding: [0xf0,0x2d]

# Multiply-accumulate
fmac fr0, fr0, fr1
# CHECK: fmac fr0, fr0, fr1 {{.*}}encoding: [0xf1,0x0e]

# Mode toggle
frchg
# CHECK: frchg {{.*}}encoding: [0xfb,0xfd]
fschg
# CHECK: fschg {{.*}}encoding: [0xf3,0xfd]
