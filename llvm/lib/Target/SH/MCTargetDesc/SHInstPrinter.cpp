//===-- SHInstPrinter.cpp - Convert SH MCInst to assembly syntax -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "SHInstPrinter.h"
#include "SHMCTargetDesc.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "asm-printer"

#define GET_INSTRUCTION_NAME
#define PRINT_ALIAS_INSTR
#include "SHGenAsmWriter.inc"

void SHInstPrinter::printRegName(raw_ostream &OS, MCRegister Reg) {
  OS << getRegisterName(Reg);
}

void SHInstPrinter::printInst(const MCInst *MI, uint64_t Address,
                              StringRef Annot, const MCSubtargetInfo &STI,
                              raw_ostream &O) {
  if (!printAliasInstr(MI, Address, O))
    printInstruction(MI, Address, O);
  printAnnotation(O, Annot);
}

void SHInstPrinter::printOperand(const MCInst *MI, int opNum, raw_ostream &O) {
  const MCOperand &MO = MI->getOperand(opNum);
  if (MO.isReg()) {
    O << getRegisterName(MO.getReg());
    return;
  }
  if (MO.isImm()) {
    O << '#' << MO.getImm();
    return;
  }
  assert(MO.isExpr() && "Unknown operand kind in printOperand");
  MAI.printExpr(O, *MO.getExpr());
}

void SHInstPrinter::printOperand(const MCInst *MI, int opNum,
                                 const MCSubtargetInfo &STI, raw_ostream &O) {
  printOperand(MI, opNum, O);
}

void SHInstPrinter::printMemDec(const MCInst *MI, int OpNo, raw_ostream &O) {
  O << "@-" << getRegisterName(MI->getOperand(OpNo).getReg());
}

void SHInstPrinter::printMemR0Idx(const MCInst *MI, int OpNo, raw_ostream &O) {
  O << "@(r0," << getRegisterName(MI->getOperand(OpNo).getReg()) << ")";
}

void SHInstPrinter::printMemR0Fixed(const MCInst *MI, int OpNo, raw_ostream &O) {
  O << "@r0";
}

void SHInstPrinter::printMemDecR15(const MCInst *MI, int OpNo, raw_ostream &O) {
  O << "@-r15";
}

void SHInstPrinter::printMemIncR15(const MCInst *MI, int OpNo, raw_ostream &O) {
  O << "@r15+";
}

void SHInstPrinter::printDisp(const MCInst *MI, int OpNo, raw_ostream &O) {
  O << MI->getOperand(OpNo).getImm();
}
