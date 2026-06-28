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
#include "llvm/Support/ErrorHandling.h"

using namespace llvm;

namespace {

class SHAsmBackend : public MCAsmBackend {
public:
  SHAsmBackend()
      : MCAsmBackend(llvm::endianness::big) {}

  MCFixupKindInfo getFixupKindInfo(MCFixupKind Kind) const override {
    // Name, TargetOffset (bits from MSB in big-endian), TargetSize (bits), Flags
    // SH 2-byte instructions: displacement is byte 1 (low byte, big-endian).
    // TargetOffset=8 means 8 bits from the instruction's MSB = byte index 1.
    const static MCFixupKindInfo Infos[SH::NumTargetFixupKinds] = {
        {"fixup_sh_pcrel8_w", 8, 8, 0}, // R_SH_DIR8WPZ: mov.w @(disp,pc)
        {"fixup_sh_pcrel8_l", 8, 8, 0}, // R_SH_DIR8WPL: mov.l @(disp,pc), mova
    };
    if (Kind < FirstTargetFixupKind)
      return MCAsmBackend::getFixupKindInfo(Kind);
    assert(unsigned(Kind - FirstTargetFixupKind) < SH::NumTargetFixupKinds &&
           "Invalid kind!");
    return Infos[Kind - FirstTargetFixupKind];
  }

  void applyFixup(const MCFragment &F, const MCFixup &Fixup,
                  const MCValue &Target, uint8_t *Data, uint64_t Value,
                  bool IsResolved) override {
    // Record relocation for external symbols (and internally for any unresolved).
    maybeAddReloc(F, Fixup, Target, Value, IsResolved);
    if (!IsResolved)
      return;
    MCFixupKind Kind = Fixup.getKind();
    if (Kind < FirstTargetFixupKind)
      return;
    // Value = S + A - P (PC-relative, P = fixup instruction address).
    // Compute encoded displacement field.
    int64_t SVal = static_cast<int64_t>(Value);
    int64_t Encoded;
    switch (unsigned(Kind) - unsigned(FirstTargetFixupKind)) {
    case SH::fixup_sh_pcrel8_w - FirstTargetFixupKind:
      // target = (PC + 4) + disp*2  =>  disp = (S+A-P - 4) / 2
      Encoded = (SVal - 4) / 2;
      break;
    case SH::fixup_sh_pcrel8_l - FirstTargetFixupKind:
      // target = ((PC+4) & ~3) + disp*4
      // Assume instruction is 4-byte aligned (common case): disp = (SVal-4)/4
      Encoded = (SVal - 4) / 4;
      break;
    default:
      return;
    }
    // Write to byte 1 of the big-endian 2-byte instruction word.
    Data[Fixup.getOffset() + 1] = static_cast<uint8_t>(Encoded & 0xFF);
  }

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
