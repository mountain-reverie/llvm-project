//===-- SHMCCodeEmitter.cpp - Convert SH code to machine code -------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/SHFixupKinds.h"
#include "SHMCTargetDesc.h"
#include "llvm/MC/MCCodeEmitter.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCFixup.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstrDesc.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/Support/EndianStream.h"

using namespace llvm;

#define DEBUG_TYPE "mccodeemitter"

namespace {

class SHMCCodeEmitter : public MCCodeEmitter {
  const MCInstrInfo &MCII;
  MCContext &Ctx;

public:
  SHMCCodeEmitter(const MCInstrInfo &MCII, MCContext &Ctx)
      : MCII(MCII), Ctx(Ctx) {}
  SHMCCodeEmitter(const SHMCCodeEmitter &) = delete;
  SHMCCodeEmitter &operator=(const SHMCCodeEmitter &) = delete;
  ~SHMCCodeEmitter() override = default;

  void encodeInstruction(const MCInst &MI, SmallVectorImpl<char> &CB,
                         SmallVectorImpl<MCFixup> &Fixups,
                         const MCSubtargetInfo &STI) const override;

  uint64_t getBinaryCodeForInstr(const MCInst &MI,
                                 SmallVectorImpl<MCFixup> &Fixups,
                                 const MCSubtargetInfo &STI) const;

  unsigned getMachineOpValue(const MCInst &MI, const MCOperand &MO,
                             SmallVectorImpl<MCFixup> &Fixups,
                             const MCSubtargetInfo &STI) const;

  // Scaled displacement encoders: encode byte-offset / scale.
  unsigned getDisp_s1(const MCInst &MI, unsigned OpNo,
                      SmallVectorImpl<MCFixup> &Fixups,
                      const MCSubtargetInfo &STI) const {
    return static_cast<unsigned>(MI.getOperand(OpNo).getImm()) / 1;
  }
  unsigned getDisp_s2(const MCInst &MI, unsigned OpNo,
                      SmallVectorImpl<MCFixup> &Fixups,
                      const MCSubtargetInfo &STI) const {
    return static_cast<unsigned>(MI.getOperand(OpNo).getImm()) / 2;
  }
  unsigned getDisp_s4(const MCInst &MI, unsigned OpNo,
                      SmallVectorImpl<MCFixup> &Fixups,
                      const MCSubtargetInfo &STI) const {
    return static_cast<unsigned>(MI.getOperand(OpNo).getImm()) / 4;
  }

  // PC-relative displacement encoders: handle both concrete immediates and
  // symbol expressions. For a symbol, push a fixup and emit 0.
  unsigned getPCDisp_s2(const MCInst &MI, unsigned OpNo,
                        SmallVectorImpl<MCFixup> &Fixups,
                        const MCSubtargetInfo &STI) const {
    const MCOperand &MO = MI.getOperand(OpNo);
    if (MO.isImm())
      return static_cast<unsigned>(MO.getImm()) / 2;
    // Symbol expression: emit a fixup and return 0 for the displacement field.
    assert(MO.isExpr() && "Expected immediate or expression");
    Fixups.push_back(MCFixup::create(0, MO.getExpr(),
                                     MCFixupKind(SH::fixup_sh_pcrel8_w),
                                     /*PCRel=*/true));
    return 0;
  }

  unsigned getPCDisp_s4(const MCInst &MI, unsigned OpNo,
                        SmallVectorImpl<MCFixup> &Fixups,
                        const MCSubtargetInfo &STI) const {
    const MCOperand &MO = MI.getOperand(OpNo);
    if (MO.isImm())
      return static_cast<unsigned>(MO.getImm()) / 4;
    // Symbol expression: emit a fixup and return 0 for the displacement field.
    assert(MO.isExpr() && "Expected immediate or expression");
    Fixups.push_back(MCFixup::create(0, MO.getExpr(),
                                     MCFixupKind(SH::fixup_sh_pcrel8_l),
                                     /*PCRel=*/true));
    return 0;
  }

  unsigned getBranchDisp8(const MCInst &MI, unsigned OpNo,
                          SmallVectorImpl<MCFixup> &Fixups,
                          const MCSubtargetInfo &STI) const {
    const MCOperand &MO = MI.getOperand(OpNo);
    if (MO.isImm())
      return static_cast<unsigned>(static_cast<int>(MO.getImm()) / 2) & 0xFF;
    assert(MO.isExpr() && "Expected immediate or expression");
    Fixups.push_back(MCFixup::create(0, MO.getExpr(),
                                     MCFixupKind(SH::fixup_sh_pcrel8_branch),
                                     /*PCRel=*/true));
    return 0;
  }

  unsigned getBranchDisp12(const MCInst &MI, unsigned OpNo,
                           SmallVectorImpl<MCFixup> &Fixups,
                           const MCSubtargetInfo &STI) const {
    const MCOperand &MO = MI.getOperand(OpNo);
    if (MO.isImm())
      return static_cast<unsigned>(static_cast<int>(MO.getImm()) / 2) & 0xFFF;
    assert(MO.isExpr() && "Expected immediate or expression");
    Fixups.push_back(MCFixup::create(0, MO.getExpr(),
                                     MCFixupKind(SH::fixup_sh_pcrel12_branch),
                                     /*PCRel=*/true));
    return 0;
  }
};

} // end anonymous namespace

void SHMCCodeEmitter::encodeInstruction(const MCInst &MI,
                                        SmallVectorImpl<char> &CB,
                                        SmallVectorImpl<MCFixup> &Fixups,
                                        const MCSubtargetInfo &STI) const {
  uint64_t Bits = getBinaryCodeForInstr(MI, Fixups, STI);
  unsigned Size = MCII.get(MI.getOpcode()).getSize();
  if (Size == 2)
    support::endian::write<uint16_t>(CB, static_cast<uint16_t>(Bits),
                                     llvm::endianness::big);
  else
    support::endian::write<uint32_t>(CB, static_cast<uint32_t>(Bits),
                                     llvm::endianness::big);
}

unsigned SHMCCodeEmitter::getMachineOpValue(const MCInst &MI,
                                            const MCOperand &MO,
                                            SmallVectorImpl<MCFixup> &Fixups,
                                            const MCSubtargetInfo &STI) const {
  if (MO.isReg())
    return Ctx.getRegisterInfo()->getEncodingValue(MO.getReg());
  if (MO.isImm())
    return static_cast<unsigned>(MO.getImm());
  llvm_unreachable("Unhandled expression in getMachineOpValue");
}

#include "SHGenMCCodeEmitter.inc"

MCCodeEmitter *llvm::createSHMCCodeEmitter(const MCInstrInfo &MCII,
                                           MCContext &Ctx) {
  return new SHMCCodeEmitter(MCII, Ctx);
}
