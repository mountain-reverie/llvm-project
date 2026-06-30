//===-- SHTargetInfo.cpp - SH Target Implementation -----------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "TargetInfo/SHTargetInfo.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/Compiler.h"

using namespace llvm;

Target &llvm::getTheSHTarget() {
  static Target TheSHTarget;
  return TheSHTarget;
}

extern "C" LLVM_ABI LLVM_EXTERNAL_VISIBILITY void LLVMInitializeSHTargetInfo() {
  // Triple::sh: SH / J-core, big-endian (matches the J-core backend output).
  RegisterTarget<Triple::sh, /*HasJIT=*/false> X(
      getTheSHTarget(), "sh", "SH / J-core", "SH");
}
