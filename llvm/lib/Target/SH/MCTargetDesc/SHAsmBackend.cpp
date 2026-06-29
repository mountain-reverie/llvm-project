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
#include "llvm/MC/MCAssembler.h"
#include "llvm/MC/MCContext.h"
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
        {"fixup_sh_pcrel8_w", 8, 8, 0},        // R_SH_DIR8WPZ: mov.w @(disp,pc)
        {"fixup_sh_pcrel8_l", 8, 8, 0},        // R_SH_DIR8WPL: mov.l @(disp,pc), mova
        {"fixup_sh_pcrel8_branch", 8, 8, 0},   // R_SH_DIR8WPN: bt/bf (disp8)
        {"fixup_sh_pcrel12_branch", 4, 12, 0}, // R_SH_IND12W: bra/bsr (disp12)
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
    case SH::fixup_sh_pcrel8_l - FirstTargetFixupKind: {
      // target = ((P+4) & ~3) + disp*4  =>  disp = (SVal - 4 + (P & 3)) / 4
      int64_t P = static_cast<int64_t>(
          Asm->getFragmentOffset(F) + Fixup.getOffset());
      Encoded = (SVal - 4 + (P & 3)) / 4;
      if (Encoded < 0 || Encoded > 255) {
        getContext().reportError(Fixup.getLoc(),
                                 "fixup_sh_pcrel8_l displacement out of range");
        return;
      }
      break;
    }
    case SH::fixup_sh_pcrel8_branch - FirstTargetFixupKind:
      // bt/bf/bt.s/bf.s: target = (PC+4) + disp*2 => disp = (S+A-P - 4)/2
      Encoded = (SVal - 4) / 2;
      if (Encoded < -128 || Encoded > 127) {
        getContext().reportError(Fixup.getLoc(),
                                 "branch target out of range (disp8)");
        return;
      }
      break; // 8-bit field written by the trailing Data[off+1] store
    case SH::fixup_sh_pcrel12_branch - FirstTargetFixupKind: {
      // bra/bsr: target = (PC+4) + disp*2 => disp = (S+A-P - 4)/2 (signed 12-bit)
      Encoded = (SVal - 4) / 2;
      if (Encoded < -2048 || Encoded > 2047) {
        getContext().reportError(Fixup.getLoc(),
                                 "branch target out of range (disp12)");
        return;
      }
      // Data points to the first byte of the instruction (Contents + fixup_offset).
      // 12-bit field: opcode nibble in bits 15-12, disp in bits 11-0.
      Data[0] = (Data[0] & 0xF0) | ((Encoded >> 8) & 0x0F);
      Data[1] = static_cast<uint8_t>(Encoded & 0xFF);
      return;
    }
    default:
      return;
    }
    // Data points to the first byte of the instruction (Contents + fixup_offset).
    // Displacement is in byte 1 (low byte of the big-endian 2-byte instruction).
    Data[1] = static_cast<uint8_t>(Encoded & 0xFF);
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
