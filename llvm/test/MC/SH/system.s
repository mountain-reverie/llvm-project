# RUN: llvm-mc -triple=sh -show-encoding %s | FileCheck %s

# Barrier and cache
synco
# CHECK: synco {{.*}}encoding: [0x00,0xab]
ldtlb
# CHECK: ldtlb {{.*}}encoding: [0x00,0x38]
movca.l r0, @r0
# CHECK: movca.l r0, @r0 {{.*}}encoding: [0x00,0xc3]
movca.l r0, @r15
# CHECK: movca.l r0, @r15 {{.*}}encoding: [0x0f,0xc3]
ocbi @r0
# CHECK: ocbi @r0 {{.*}}encoding: [0x00,0x93]
ocbp @r0
# CHECK: ocbp @r0 {{.*}}encoding: [0x00,0xa3]
ocbwb @r0
# CHECK: ocbwb @r0 {{.*}}encoding: [0x00,0xb3]
pref @r0
# CHECK: pref @r0 {{.*}}encoding: [0x00,0x83]
tas.b @r0
# CHECK: tas.b @r0 {{.*}}encoding: [0x40,0x1b]
sleep
# CHECK: sleep {{.*}}encoding: [0x00,0x1b]
trapa #0
# CHECK: trapa #0 {{.*}}encoding: [0xc3,0x00]

# Control register read (STC)
stc SR, r0
# CHECK: stc sr, r0 {{.*}}encoding: [0x00,0x02]
stc GBR, r0
# CHECK: stc gbr, r0 {{.*}}encoding: [0x00,0x12]
stc VBR, r0
# CHECK: stc vbr, r0 {{.*}}encoding: [0x00,0x22]
stc SSR, r0
# CHECK: stc ssr, r0 {{.*}}encoding: [0x00,0x32]
stc SPC, r0
# CHECK: stc spc, r0 {{.*}}encoding: [0x00,0x42]
stc DBR, r0
# CHECK: stc dbr, r0 {{.*}}encoding: [0x00,0xfa]
stc TBR, r0
# CHECK: stc tbr, r0 {{.*}}encoding: [0x00,0x4a]

# Control register write (LDC)
ldc r0, SR
# CHECK: ldc r0, sr {{.*}}encoding: [0x40,0x0e]
ldc r0, GBR
# CHECK: ldc r0, gbr {{.*}}encoding: [0x40,0x1e]
ldc r0, VBR
# CHECK: ldc r0, vbr {{.*}}encoding: [0x40,0x2e]
ldc r0, SSR
# CHECK: ldc r0, ssr {{.*}}encoding: [0x40,0x3e]
ldc r0, SPC
# CHECK: ldc r0, spc {{.*}}encoding: [0x40,0x4e]
ldc r0, DBR
# CHECK: ldc r0, dbr {{.*}}encoding: [0x40,0xfa]

# System register transfer (STS/LDS)
sts MACH, r0
# CHECK: sts mach, r0 {{.*}}encoding: [0x00,0x0a]
sts MACL, r0
# CHECK: sts macl, r0 {{.*}}encoding: [0x00,0x1a]
sts PR, r0
# CHECK: sts pr, r0 {{.*}}encoding: [0x00,0x2a]
lds r0, MACH
# CHECK: lds r0, mach {{.*}}encoding: [0x40,0x0a]
lds r0, MACL
# CHECK: lds r0, macl {{.*}}encoding: [0x40,0x1a]
lds r0, PR
# CHECK: lds r0, pr {{.*}}encoding: [0x40,0x2a]

# J-core background debug halt
bgnd
# CHECK: bgnd {{.*}}encoding: [0x00,0x3b]
