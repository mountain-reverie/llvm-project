//===-- SHInstrAliases.td - SH assembly InstAliases --------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
// Bare-symbol aliases for PC-relative load/mova instructions.
// These allow `mov.l sym, rN` as shorthand for `mov.l @(sym, pc), rN`.

def : InstAlias<"mov.l $sym, $rn", (MOV_L_MemPC_GPR pcdisp_l8:$sym, GPR:$rn)>;
def : InstAlias<"mov.w $sym, $rn", (MOV_W_MemPC_GPR pcdisp_w8:$sym, GPR:$rn)>;
def : InstAlias<"mova $sym, r0",   (MOVA_MemPC_R0Fixed pcdisp_l8:$sym)>;
