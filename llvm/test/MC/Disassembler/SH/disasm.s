# RUN: llvm-mc -triple=sh -disassemble %s | FileCheck %s

# GP integer
[0x62,0x13]
# CHECK: mov r1, r2
[0xe0,0x00]
# CHECK: mov #0, r0
[0xe1,0x7f]
# CHECK: mov #127, r1
[0x31,0x0c]
# CHECK: add r0, r1
[0x70,0x01]
# CHECK: add #1, r0
[0x31,0x08]
# CHECK: sub r0, r1
[0x21,0x09]
# CHECK: and r0, r1
[0x21,0x0b]
# CHECK: or r0, r1
[0x21,0x0a]
# CHECK: xor r0, r1
[0x61,0x07]
# CHECK: not r0, r1
[0x40,0x00]
# CHECK: shll r0
[0x40,0x01]
# CHECK: shlr r0
[0x40,0x10]
# CHECK: dt r0
[0x61,0x08]
# CHECK: swap.b r0, r1
[0x61,0x09]
# CHECK: swap.w r0, r1
[0x31,0x00]
# CHECK: cmp/eq r0, r1
[0x31,0x06]
# CHECK: cmp/hi r0, r1
[0x00,0x09]
# CHECK: nop
[0x00,0x29]
# CHECK: movt r0

# Branches and control flow
[0x00,0x23]
# CHECK: braf r0
[0x0f,0x23]
# CHECK: braf r15
[0x40,0x2b]
# CHECK: jmp @r0
[0x40,0x0b]
# CHECK: jsr @r0
[0x00,0x0b]
# CHECK: rts
[0x00,0x2b]
# CHECK: rte
[0x00,0x08]
# CHECK: clrt
[0x00,0x18]
# CHECK: sett

# System/barrier
[0x00,0xab]
# CHECK: synco
[0x00,0x38]
# CHECK: ldtlb
[0x00,0x78]
# CHECK: ldtlb.rn
[0x00,0x02]
# CHECK: stc sr, r0
[0x00,0x43]
# CHECK: stc tsbptr, r0
[0x00,0x53]
# CHECK: stc pteh, r0

# isAsmParserOnly aliases: stc ptel/asidr disassemble to SH4A mnemonics
[0x00,0x63]
# CHECK: movli.l @r0, r0
[0x00,0x73]
# CHECK: movco.l r0, @r0

# FP
[0xf1,0x00]
# CHECK: fadd fr0, fr1
[0xf1,0x01]
# CHECK: fsub fr0, fr1
[0xf1,0x04]
# CHECK: fcmp/eq fr0, fr1
[0xf0,0x8d]
# CHECK: fldi0 fr0
[0xf0,0x9d]
# CHECK: fldi1 fr0
[0xf0,0x1d]
# CHECK: flds fr0, fpul
[0xf0,0x0d]
# CHECK: fsts fpul, fr0
# fabs/fneg/fsqrt on fr0 share encoding with double-prec DR0 — disassembles as DR form
[0xf0,0x5d]
# CHECK: fabs dr0
[0xf0,0x4d]
# CHECK: fneg dr0

# CP0 coprocessor (J-core, disassembles as cp0 mnemonics)
[0x40,0x89]
# CHECK: clds cp0_r0, cp0_com
[0x40,0xc9]
# CHECK: csts cp0_com, cp0_r0
[0x40,0x88]
# CHECK: lds r0, cp0_com
[0x40,0xc8]
# CHECK: sts cp0_com, r0

# CPI aliases: lds/sts cpi_com disassemble to fpul mnemonics
[0x40,0x5a]
# CHECK: lds r0, fpul
[0x00,0x5a]
# CHECK: sts fpul, r0
