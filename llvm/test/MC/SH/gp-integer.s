# RUN: llvm-mc -triple=sh -show-encoding %s | FileCheck %s

# Register-register move
mov r1, r2
# CHECK: mov r1, r2 {{.*}}encoding: [0x62,0x13]

# Immediate move (sign-extended 8-bit)
mov #0, r0
# CHECK: mov #0, r0 {{.*}}encoding: [0xe0,0x00]
mov #127, r1
# CHECK: mov #127, r1 {{.*}}encoding: [0xe1,0x7f]
mov #-128, r2
# CHECK: mov #-128, r2 {{.*}}encoding: [0xe2,0x80]
mov #-1, r3
# CHECK: mov #-1, r3 {{.*}}encoding: [0xe3,0xff]

# Arithmetic
add r0, r1
# CHECK: add r0, r1 {{.*}}encoding: [0x31,0x0c]
add #1, r0
# CHECK: add #1, r0 {{.*}}encoding: [0x70,0x01]
sub r0, r1
# CHECK: sub r0, r1 {{.*}}encoding: [0x31,0x08]
neg r0, r1
# CHECK: neg r0, r1 {{.*}}encoding: [0x61,0x0b]

# Multiply/divide
mul.l r0, r1
# CHECK: mul.l r0, r1 {{.*}}encoding: [0x01,0x07]
muls.w r0, r1
# CHECK: muls.w r0, r1 {{.*}}encoding: [0x21,0x0f]
mulu.w r0, r1
# CHECK: mulu.w r0, r1 {{.*}}encoding: [0x21,0x0e]
dmuls.l r0, r1
# CHECK: dmuls.l r0, r1 {{.*}}encoding: [0x31,0x0d]
dmulu.l r0, r1
# CHECK: dmulu.l r0, r1 {{.*}}encoding: [0x31,0x05]
div0s r0, r1
# CHECK: div0s r0, r1 {{.*}}encoding: [0x21,0x07]
div0u
# CHECK: div0u {{.*}}encoding: [0x00,0x19]
div1 r0, r1
# CHECK: div1 r0, r1 {{.*}}encoding: [0x31,0x04]
dt r0
# CHECK: dt r0 {{.*}}encoding: [0x40,0x10]

# Logic
and r0, r1
# CHECK: and r0, r1 {{.*}}encoding: [0x21,0x09]
or r0, r1
# CHECK: or r0, r1 {{.*}}encoding: [0x21,0x0b]
xor r0, r1
# CHECK: xor r0, r1 {{.*}}encoding: [0x21,0x0a]
not r0, r1
# CHECK: not r0, r1 {{.*}}encoding: [0x61,0x07]
tst r0, r1
# CHECK: tst r0, r1 {{.*}}encoding: [0x21,0x08]

# Shifts
shll r0
# CHECK: shll r0 {{.*}}encoding: [0x40,0x00]
shlr r0
# CHECK: shlr r0 {{.*}}encoding: [0x40,0x01]
shar r0
# CHECK: shar r0 {{.*}}encoding: [0x40,0x21]
shll2 r0
# CHECK: shll2 r0 {{.*}}encoding: [0x40,0x08]
shlr2 r0
# CHECK: shlr2 r0 {{.*}}encoding: [0x40,0x09]
shll8 r0
# CHECK: shll8 r0 {{.*}}encoding: [0x40,0x18]
shlr8 r0
# CHECK: shlr8 r0 {{.*}}encoding: [0x40,0x19]
shll16 r0
# CHECK: shll16 r0 {{.*}}encoding: [0x40,0x28]
shlr16 r0
# CHECK: shlr16 r0 {{.*}}encoding: [0x40,0x29]
shld r0, r1
# CHECK: shld r0, r1 {{.*}}encoding: [0x41,0x0d]
shad r0, r1
# CHECK: shad r0, r1 {{.*}}encoding: [0x41,0x0c]

# Rotate
rotl r0
# CHECK: rotl r0 {{.*}}encoding: [0x40,0x04]
rotr r0
# CHECK: rotr r0 {{.*}}encoding: [0x40,0x05]
rotcl r0
# CHECK: rotcl r0 {{.*}}encoding: [0x40,0x24]
rotcr r0
# CHECK: rotcr r0 {{.*}}encoding: [0x40,0x25]

# Extension and byte-swap
exts.b r0, r1
# CHECK: exts.b r0, r1 {{.*}}encoding: [0x61,0x0e]
exts.w r0, r1
# CHECK: exts.w r0, r1 {{.*}}encoding: [0x61,0x0f]
extu.b r0, r1
# CHECK: extu.b r0, r1 {{.*}}encoding: [0x61,0x0c]
extu.w r0, r1
# CHECK: extu.w r0, r1 {{.*}}encoding: [0x61,0x0d]
swap.b r0, r1
# CHECK: swap.b r0, r1 {{.*}}encoding: [0x61,0x08]
swap.w r0, r1
# CHECK: swap.w r0, r1 {{.*}}encoding: [0x61,0x09]

# Compare
cmp/eq #0, r0
# CHECK: cmp/eq #0, r0 {{.*}}encoding: [0x88,0x00]
cmp/eq r0, r1
# CHECK: cmp/eq r0, r1 {{.*}}encoding: [0x31,0x00]
cmp/hs r0, r1
# CHECK: cmp/hs r0, r1 {{.*}}encoding: [0x31,0x02]
cmp/ge r0, r1
# CHECK: cmp/ge r0, r1 {{.*}}encoding: [0x31,0x03]
cmp/hi r0, r1
# CHECK: cmp/hi r0, r1 {{.*}}encoding: [0x31,0x06]
cmp/gt r0, r1
# CHECK: cmp/gt r0, r1 {{.*}}encoding: [0x31,0x07]

# Miscellaneous
movt r0
# CHECK: movt r0 {{.*}}encoding: [0x00,0x29]
nop
# CHECK: nop {{.*}}encoding: [0x00,0x09]
