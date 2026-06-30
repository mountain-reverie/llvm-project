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

# PC-relative branches with external symbol (fixup path)
bra foo
# CHECK: bra foo {{.*}}encoding: [0b1010AAAA,A]
# CHECK-NEXT: {{.*}}fixup A - offset: 0, value: foo, kind: fixup_sh_pcrel12_branch
bsr foo
# CHECK: bsr foo {{.*}}encoding: [0b1011AAAA,A]
# CHECK-NEXT: {{.*}}fixup A - offset: 0, value: foo, kind: fixup_sh_pcrel12_branch
bt foo
# CHECK: bt foo {{.*}}encoding: [0x89,A]
# CHECK-NEXT: {{.*}}fixup A - offset: 0, value: foo, kind: fixup_sh_pcrel8_branch
bf foo
# CHECK: bf foo {{.*}}encoding: [0x8b,A]
# CHECK-NEXT: {{.*}}fixup A - offset: 0, value: foo, kind: fixup_sh_pcrel8_branch
bt/s foo
# CHECK: bt/s foo {{.*}}encoding: [0x8d,A]
# CHECK-NEXT: {{.*}}fixup A - offset: 0, value: foo, kind: fixup_sh_pcrel8_branch
bf/s foo
# CHECK: bf/s foo {{.*}}encoding: [0x8f,A]
# CHECK-NEXT: {{.*}}fixup A - offset: 0, value: foo, kind: fixup_sh_pcrel8_branch

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
