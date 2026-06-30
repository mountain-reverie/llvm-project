# RUN: llvm-mc -triple=sh -show-encoding %s | FileCheck %s

# Indirect branches (register)
braf r0
# CHECK: braf r0 {{.*}}encoding: [0x00,0x23]
braf r15
# CHECK: braf r15 {{.*}}encoding: [0x0f,0x23]
bsrf r0
# CHECK: bsrf r0 {{.*}}encoding: [0x00,0x03]
bsrf r15
# CHECK: bsrf r15 {{.*}}encoding: [0x0f,0x03]
jmp @r0
# CHECK: jmp @r0 {{.*}}encoding: [0x40,0x2b]
jmp @r15
# CHECK: jmp @r15 {{.*}}encoding: [0x4f,0x2b]
jsr @r0
# CHECK: jsr @r0 {{.*}}encoding: [0x40,0x0b]
jsr @r15
# CHECK: jsr @r15 {{.*}}encoding: [0x4f,0x0b]

# Return instructions
rts
# CHECK: rts {{.*}}encoding: [0x00,0x0b]
rte
# CHECK: rte {{.*}}encoding: [0x00,0x2b]

# Condition flags
clrt
# CHECK: clrt {{.*}}encoding: [0x00,0x08]
sett
# CHECK: sett {{.*}}encoding: [0x00,0x18]
clrs
# CHECK: clrs {{.*}}encoding: [0x00,0x48]
sets
# CHECK: sets {{.*}}encoding: [0x00,0x58]
clrmac
# CHECK: clrmac {{.*}}encoding: [0x00,0x28]
