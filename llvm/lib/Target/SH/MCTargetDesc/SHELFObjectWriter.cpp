//===-- SHELFObjectWriter.cpp - SH ELF Writer -----------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "SHMCTargetDesc.h"
#include "llvm/BinaryFormat/ELF.h"
#include "llvm/MC/MCELFObjectWriter.h"
#include "llvm/MC/MCFixup.h"
#include "llvm/MC/MCObjectWriter.h"
#include "llvm/MC/MCValue.h"

using namespace llvm;

namespace {

class SHELFObjectWriter : public MCELFObjectTargetWriter {
public:
  SHELFObjectWriter(uint8_t OSABI)
      : MCELFObjectTargetWriter(/*Is64Bit=*/false, OSABI, ELF::EM_SH,
                                /*HasRelocationAddend=*/false) {}

  ~SHELFObjectWriter() override = default;

protected:
  unsigned getRelocType(const MCFixup &Fixup, const MCValue &Target,
                        bool IsPCRel) const override {
    return 0; // R_SH_NONE
  }
};

} // end anonymous namespace

std::unique_ptr<MCObjectTargetWriter>
llvm::createSHELFObjectWriter(uint8_t OSABI) {
  return std::make_unique<SHELFObjectWriter>(OSABI);
}
