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
  // Marker — no target-specific fixups yet.
  LastTargetFixupKind = FirstTargetFixupKind,
  NumTargetFixupKinds = LastTargetFixupKind - FirstTargetFixupKind
};

} // namespace SH
} // namespace llvm

#endif // LLVM_LIB_TARGET_SH_MCTARGETDESC_SHFIXUPKINDS_H
