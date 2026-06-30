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
    case MCFixupKind(SH::fixup_sh_pcrel8_branch):
      return ELF::R_SH_DIR8WPN;
    case MCFixupKind(SH::fixup_sh_pcrel12_branch):
      return ELF::R_SH_IND12W;
    case MCFixupKind(SH::fixup_sh_pcrel8_w):
      return ELF::R_SH_DIR8WPZ;
    case MCFixupKind(SH::fixup_sh_pcrel8_l):
      return ELF::R_SH_DIR8WPL;
    default:
      return ELF::R_SH_NONE;
    }
  }
};

} // end anonymous namespace

std::unique_ptr<MCObjectTargetWriter>
llvm::createSHELFObjectWriter(uint8_t OSABI) {
  return std::make_unique<SHELFObjectWriter>(OSABI);
}
