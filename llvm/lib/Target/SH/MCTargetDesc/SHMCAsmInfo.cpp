//===- SHMCAsmInfo.cpp - SH asm properties --------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "SHMCAsmInfo.h"
#include "llvm/MC/MCTargetOptions.h"
#include "llvm/TargetParser/Triple.h"

using namespace llvm;

void SHELFMCAsmInfo::anchor() {}

SHELFMCAsmInfo::SHELFMCAsmInfo(const Triple &TheTriple,
                                const MCTargetOptions &Options)
    : MCAsmInfoELF(Options) {
  IsLittleEndian = false; // big-endian
  CommentString = "!";
  Data16bitsDirective = "\t.short\t";
  Data32bitsDirective = "\t.long\t";
  ZeroDirective = "\t.zero\t";
  SupportsDebugInformation = true;
  ExceptionsType = ExceptionHandling::None;
}
