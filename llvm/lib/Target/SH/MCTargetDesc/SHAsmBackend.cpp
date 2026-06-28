//===-- SHAsmBackend.cpp - SH Assembler Backend ---------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/SHFixupKinds.h"
#include "MCTargetDesc/SHMCTargetDesc.h"
#include "llvm/MC/MCAsmBackend.h"
#include "llvm/MC/MCELFObjectWriter.h"
#include "llvm/MC/MCFixup.h"
#include "llvm/MC/MCObjectWriter.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/MC/MCValue.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/EndianStream.h"

using namespace llvm;

namespace {

class SHAsmBackend : public MCAsmBackend {
public:
  SHAsmBackend()
      : MCAsmBackend(llvm::endianness::big) {}

  void applyFixup(const MCFragment &, const MCFixup &, const MCValue &,
                  uint8_t *Data, uint64_t Value, bool IsResolved) override {}

  bool writeNopData(raw_ostream &OS, uint64_t Count,
                    const MCSubtargetInfo *STI) const override {
    // SH NOP is 0x0009 (2 bytes, big-endian: 0x00 0x09)
    if (Count % 2 != 0)
      return false;
    uint64_t NumNops = Count / 2;
    for (uint64_t i = 0; i != NumNops; ++i)
      support::endian::write<uint16_t>(OS, 0x0009, llvm::endianness::big);
    return true;
  }

  std::unique_ptr<MCObjectTargetWriter>
  createObjectTargetWriter() const override {
    return createSHELFObjectWriter(/*OSABI=*/0);
  }
};

} // end anonymous namespace

MCAsmBackend *llvm::createSHAsmBackend(const Target &T,
                                        const MCSubtargetInfo &STI,
                                        const MCRegisterInfo &MRI,
                                        const MCTargetOptions &Options) {
  return new SHAsmBackend();
}
