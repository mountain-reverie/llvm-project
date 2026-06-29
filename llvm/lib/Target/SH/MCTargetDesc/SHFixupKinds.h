//===-- SHFixupKinds.h - SH Specific Fixup Entries ----------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_SH_MCTARGETDESC_SHFIXUPKINDS_H
#define LLVM_LIB_TARGET_SH_MCTARGETDESC_SHFIXUPKINDS_H

#include "llvm/MC/MCFixup.h"

namespace llvm {
namespace SH {

enum Fixups {
  // R_SH_DIR8WPZ (6): PC-relative word-scaled 8-bit displacement (mov.w)
  fixup_sh_pcrel8_w = FirstTargetFixupKind,
  // R_SH_DIR8WPL (5): PC-relative longword-scaled 8-bit displacement (mov.l, mova)
  fixup_sh_pcrel8_l,
  // R_SH_DIR8WPN (3): PC-relative word-scaled 8-bit branch (bt/bf/bt.s/bf.s)
  fixup_sh_pcrel8_branch,
  // R_SH_IND12W (4): PC-relative word-scaled 12-bit branch (bra/bsr)
  fixup_sh_pcrel12_branch,
  NumTargetFixupKinds = fixup_sh_pcrel12_branch - FirstTargetFixupKind + 1
};

} // namespace SH
} // namespace llvm

#endif // LLVM_LIB_TARGET_SH_MCTARGETDESC_SHFIXUPKINDS_H
