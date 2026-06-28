//===- SHMCAsmInfo.h - SH asm properties -----------------------*- C++ -*--===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_SH_MCTARGETDESC_SHMCASMINFO_H
#define LLVM_LIB_TARGET_SH_MCTARGETDESC_SHMCASMINFO_H

#include "llvm/MC/MCAsmInfoELF.h"

namespace llvm {

class Triple;
class MCTargetOptions;

class SHELFMCAsmInfo : public MCAsmInfoELF {
  void anchor() override;

public:
  explicit SHELFMCAsmInfo(const Triple &TheTriple,
                          const MCTargetOptions &Options);
};

} // end namespace llvm

#endif // LLVM_LIB_TARGET_SH_MCTARGETDESC_SHMCASMINFO_H
