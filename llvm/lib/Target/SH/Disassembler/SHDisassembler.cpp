//===- SHDisassembler.cpp - Disassembler for SH ---------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/SHMCTargetDesc.h"
#include "TargetInfo/SHTargetInfo.h"
#include "llvm/MC/MCDecoder.h"
#include "llvm/MC/MCDecoderOps.h"
#include "llvm/MC/MCDisassembler/MCDisassembler.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/Compiler.h"
#include "llvm/Support/Endian.h"

using namespace llvm;
using namespace llvm::MCD;

#define DEBUG_TYPE "sh-disassembler"

typedef MCDisassembler::DecodeStatus DecodeStatus;

namespace {

class SHDisassembler : public MCDisassembler {
public:
  SHDisassembler(const MCSubtargetInfo &STI, MCContext &Ctx)
      : MCDisassembler(STI, Ctx) {}
  ~SHDisassembler() override = default;

  DecodeStatus getInstruction(MCInst &Instr, uint64_t &Size,
                              ArrayRef<uint8_t> Bytes, uint64_t Address,
                              raw_ostream &CStream) const override;
};

} // end anonymous namespace

static MCDisassembler *createSHDisassembler(const Target &T,
                                             const MCSubtargetInfo &STI,
                                             MCContext &Ctx) {
  return new SHDisassembler(STI, Ctx);
}

extern "C" LLVM_ABI LLVM_EXTERNAL_VISIBILITY void
LLVMInitializeSHDisassembler() {
  TargetRegistry::RegisterMCDisassembler(getTheSHTarget(),
                                          createSHDisassembler);
}

// R0..R15 sequential in SH namespace
static const MCPhysReg GPRDecoderTable[16] = {
    SH::R0,  SH::R1,  SH::R2,  SH::R3,
    SH::R4,  SH::R5,  SH::R6,  SH::R7,
    SH::R8,  SH::R9,  SH::R10, SH::R11,
    SH::R12, SH::R13, SH::R14, SH::R15,
};

static DecodeStatus DecodeGPRRegisterClass(MCInst &Inst, unsigned RegNo,
                                           uint64_t Address,
                                           const MCDisassembler *Decoder) {
  if (RegNo >= 16)
    return MCDisassembler::Fail;
  Inst.addOperand(MCOperand::createReg(GPRDecoderTable[RegNo]));
  return MCDisassembler::Success;
}

// Used by MemDec and MemR0Idx operands: decode RegNo -> register operand.
static DecodeStatus decodeGPRAsMem(MCInst &Inst, unsigned RegNo,
                                   uint64_t Address,
                                   const MCDisassembler *Decoder) {
  return DecodeGPRRegisterClass(Inst, RegNo, Address, Decoder);
}

// Instruction-level decoders for fixed-register memory forms. The implicit
// register (@R0 / @-R15 / @R15+) has no encoding bits, so these decode the GPR
// field(s) directly and add the implicit operand as imm(0) (matching the
// parser; the printer supplies the @r0/@-r15/@r15+ text).
static DecodeStatus decodeCasFixed(MCInst &Inst, unsigned Insn, uint64_t Address,
                                   const MCDisassembler *Decoder) {
  // cas.l Rm,Rn,@R0 : 0010 nnnn mmmm 0011 ; operands (rm, rn, @r0)
  DecodeGPRRegisterClass(Inst, (Insn >> 4) & 0xF, Address, Decoder); // rm
  DecodeGPRRegisterClass(Inst, (Insn >> 8) & 0xF, Address, Decoder); // rn
  Inst.addOperand(MCOperand::createImm(0));                          // @r0
  return MCDisassembler::Success;
}
static DecodeStatus decodeMovMemDecR15(MCInst &Inst, unsigned Insn,
                                       uint64_t Address,
                                       const MCDisassembler *Decoder) {
  // movml.l/movmu.l Rm,@-R15 : 0100 mmmm 1111 000x ; operands (rm, @-r15)
  DecodeGPRRegisterClass(Inst, (Insn >> 8) & 0xF, Address, Decoder); // rm
  Inst.addOperand(MCOperand::createReg(SH::R15));                    // @-r15
  return MCDisassembler::Success;
}
static DecodeStatus decodeMovMemIncR15(MCInst &Inst, unsigned Insn,
                                       uint64_t Address,
                                       const MCDisassembler *Decoder) {
  // movml.l/movmu.l @R15+,Rn : 0100 nnnn 1111 010x ; operands (@r15+, rn)
  Inst.addOperand(MCOperand::createImm(0));                          // @r15+
  DecodeGPRRegisterClass(Inst, (Insn >> 8) & 0xF, Address, Decoder); // rn
  return MCDisassembler::Success;
}

static DecodeStatus decodeDisp_s1(MCInst &Inst, unsigned Val, uint64_t Address,
                                  const MCDisassembler *Dec) {
  Inst.addOperand(MCOperand::createImm(Val * 1));
  return MCDisassembler::Success;
}
static DecodeStatus decodeDisp_s2(MCInst &Inst, unsigned Val, uint64_t Address,
                                  const MCDisassembler *Dec) {
  Inst.addOperand(MCOperand::createImm(Val * 2));
  return MCDisassembler::Success;
}
static DecodeStatus decodeDisp_s4(MCInst &Inst, unsigned Val, uint64_t Address,
                                  const MCDisassembler *Dec) {
  Inst.addOperand(MCOperand::createImm(Val * 4));
  return MCDisassembler::Success;
}

// Branch displacement decoders: sign-extend and scale by 2.
// Branch displacement decoders: sign-extend the field and scale ×2, emitting a
// PC-relative displacement immediate (not an absolute target — `-disassemble`
// has no base symbol). This is the complete decoder; its correctness is
// verified by the branch disassembly smoke + round-trip oracle.
static DecodeStatus decodeBranchDisp8(MCInst &Inst, unsigned Val,
                                      uint64_t Address,
                                      const MCDisassembler *Dec) {
  int8_t SVal = static_cast<int8_t>(Val & 0xFF);
  Inst.addOperand(MCOperand::createImm(SVal * 2));
  return MCDisassembler::Success;
}
static DecodeStatus decodeBranchDisp12(MCInst &Inst, unsigned Val,
                                       uint64_t Address,
                                       const MCDisassembler *Dec) {
  // Sign-extend 12-bit field.
  int32_t SVal = static_cast<int32_t>(Val << 20) >> 20;
  Inst.addOperand(MCOperand::createImm(SVal * 2));
  return MCDisassembler::Success;
}

#include "SHGenDisassemblerTables.inc"

DecodeStatus SHDisassembler::getInstruction(MCInst &Instr, uint64_t &Size,
                                             ArrayRef<uint8_t> Bytes,
                                             uint64_t Address,
                                             raw_ostream &CStream) const {
  if (Bytes.size() >= 4) {
    uint32_t Insn32 = (uint32_t(support::endian::read16be(Bytes.data())) << 16) |
                      support::endian::read16be(Bytes.data() + 2);
    DecodeStatus S = decodeInstruction(DecoderTableSH32, Instr, Insn32, Address, this, STI);
    if (S != MCDisassembler::Fail) { Size = 4; return S; }
  }
  if (Bytes.size() >= 2) {
    uint16_t Insn16 = support::endian::read16be(Bytes.data());
    Size = 2;
    return decodeInstruction(DecoderTableSH16, Instr, Insn16, Address, this, STI);
  }
  Size = 0;
  return MCDisassembler::Fail;
}
