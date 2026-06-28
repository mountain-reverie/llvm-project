//===-- SHELFObjectWriter.cpp - SH ELF Writer -----------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/SHFixupKinds.h"
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
    // Relocation type values from binutils include/elf/sh.h.
    switch (Fixup.getKind()) {
    case MCFixupKind(SH::fixup_sh_pcrel8_w):
      return 6; // R_SH_DIR8WPZ: PC-relative, byte/2, zero-extended
    case MCFixupKind(SH::fixup_sh_pcrel8_l):
      return 5; // R_SH_DIR8WPL: PC-relative, byte/4, longword-aligned base
    default:
      return 0; // R_SH_NONE
    }
  }
};

} // end anonymous namespace

std::unique_ptr<MCObjectTargetWriter>
llvm::createSHELFObjectWriter(uint8_t OSABI) {
  return std::make_unique<SHELFObjectWriter>(OSABI);
}
