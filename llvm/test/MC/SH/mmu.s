# RUN: llvm-mc -triple=sh -show-encoding %s | FileCheck %s

# TLB operations
ldtlb
# CHECK: ldtlb {{.*}}encoding: [0x00,0x38]
ldtlb.rn
# CHECK: ldtlb.rn {{.*}}encoding: [0x00,0x78]

# MMU control register read (J-core extensions)
stc TSBPTR, r0
# CHECK: stc tsbptr, r0 {{.*}}encoding: [0x00,0x43]
stc TSBPTR, r5
# CHECK: stc tsbptr, r5 {{.*}}encoding: [0x05,0x43]
stc TSBPTR, r15
# CHECK: stc tsbptr, r15 {{.*}}encoding: [0x0f,0x43]

# Note: stc PTEH/PTEL/ASIDR are isAsmParserOnly aliases encoding to
# SH4A movli.l/movco.l instructions; assembler accepts them:
stc PTEH, r0
# CHECK: stc pteh, r0 {{.*}}encoding: [0x00,0x53]
stc PTEH, r3
# CHECK: stc pteh, r3 {{.*}}encoding: [0x03,0x53]
stc PTEL, r0
# CHECK: stc ptel, r0 {{.*}}encoding: [0x00,0x63]
stc PTEL, r7
# CHECK: stc ptel, r7 {{.*}}encoding: [0x07,0x63]
stc ASIDR, r0
# CHECK: stc asidr, r0 {{.*}}encoding: [0x00,0x73]
stc ASIDR, r12
# CHECK: stc asidr, r12 {{.*}}encoding: [0x0c,0x73]
