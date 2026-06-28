//===-- SHAsmParser.cpp - Parse SH assembly to MCInst instructions --------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/SHMCTargetDesc.h"
#include "TargetInfo/SHTargetInfo.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCParser/AsmLexer.h"
#include "llvm/MC/MCParser/MCAsmParser.h"
#include "llvm/MC/MCParser/MCParsedAsmOperand.h"
#include "llvm/MC/MCParser/MCTargetAsmParser.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Compiler.h"
#include "llvm/Support/SMLoc.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {

class SHOperand : public MCParsedAsmOperand {
  enum KindTy { k_Token, k_Register, k_Immediate } Kind;

  SMLoc StartLoc, EndLoc;

  struct TokOp { const char *Data; unsigned Length; };
  struct RegOp { MCRegister Reg; };
  struct ImmOp { const MCExpr *Val; };

  union {
    TokOp Tok;
    RegOp Reg;
    ImmOp Imm;
  };

public:
  SHOperand(KindTy K) : Kind(K) {}

  bool isToken() const override { return Kind == k_Token; }
  bool isReg()   const override { return Kind == k_Register; }
  bool isImm()   const override { return Kind == k_Immediate; }
  bool isMem()   const override { return false; }

  MCRegister getReg() const override {
    assert(Kind == k_Register);
    return Reg.Reg;
  }
  const MCExpr *getImm() const {
    assert(Kind == k_Immediate);
    return Imm.Val;
  }
  StringRef getToken() const {
    assert(Kind == k_Token);
    return StringRef(Tok.Data, Tok.Length);
  }

  SMLoc getStartLoc() const override { return StartLoc; }
  SMLoc getEndLoc()   const override { return EndLoc; }

  void print(raw_ostream &OS, const MCAsmInfo &) const override {
    if (Kind == k_Token) OS << "Tok:" << getToken();
    else if (Kind == k_Register) OS << "Reg:" << getReg().id();
    else OS << "Imm";
    OS << '\n';
  }

  void addRegOperands(MCInst &Inst, unsigned N) const {
    assert(N == 1);
    Inst.addOperand(MCOperand::createReg(getReg()));
  }
  void addImmOperands(MCInst &Inst, unsigned N) const {
    assert(N == 1);
    const MCExpr *E = getImm();
    if (const MCConstantExpr *CE = dyn_cast<MCConstantExpr>(E))
      Inst.addOperand(MCOperand::createImm(CE->getValue()));
    else
      Inst.addOperand(MCOperand::createExpr(E));
  }

  static std::unique_ptr<SHOperand> createToken(StringRef Str, SMLoc S) {
    auto Op = std::make_unique<SHOperand>(k_Token);
    Op->Tok.Data   = Str.data();
    Op->Tok.Length = Str.size();
    Op->StartLoc = S;
    Op->EndLoc   = S;
    return Op;
  }
  static std::unique_ptr<SHOperand> createReg(MCRegister Reg, SMLoc S, SMLoc E) {
    auto Op = std::make_unique<SHOperand>(k_Register);
    Op->Reg.Reg = Reg;
    Op->StartLoc = S;
    Op->EndLoc   = E;
    return Op;
  }
  static std::unique_ptr<SHOperand> createImm(const MCExpr *Val, SMLoc S, SMLoc E) {
    auto Op = std::make_unique<SHOperand>(k_Immediate);
    Op->Imm.Val = Val;
    Op->StartLoc = S;
    Op->EndLoc   = E;
    return Op;
  }
};

class SHAsmParser : public MCTargetAsmParser {
  MCAsmParser &Parser;

#define GET_ASSEMBLER_HEADER
#include "SHGenAsmMatcher.inc"

  bool matchAndEmitInstruction(SMLoc IDLoc, unsigned &Opcode,
                               OperandVector &Operands, MCStreamer &Out,
                               uint64_t &ErrorInfo,
                               bool MatchingInlineAsm) override;
  bool parseRegister(MCRegister &Reg, SMLoc &StartLoc, SMLoc &EndLoc) override;
  ParseStatus tryParseRegister(MCRegister &Reg, SMLoc &StartLoc,
                               SMLoc &EndLoc) override;
  bool parseInstruction(ParseInstructionInfo &Info, StringRef Name,
                        SMLoc NameLoc, OperandVector &Operands) override;
  ParseStatus parseDirective(AsmToken DirectiveID) override {
    return ParseStatus::NoMatch;
  }

  bool parseOperand(OperandVector &Operands);
  MCRegister matchRegisterByName(StringRef Name);

public:
  SHAsmParser(const MCSubtargetInfo &STI, MCAsmParser &Parser,
              const MCInstrInfo &MII)
      : MCTargetAsmParser(STI, MII), Parser(Parser) {
    setAvailableFeatures(ComputeAvailableFeatures(getSTI().getFeatureBits()));
  }
};

} // end anonymous namespace

MCRegister SHAsmParser::matchRegisterByName(StringRef Name) {
  StringRef Lower = Name.lower();
  if (!Lower.consume_front("r"))
    return MCRegister();
  unsigned N;
  if (Lower.getAsInteger(10, N) || N > 15)
    return MCRegister();
  return MCRegister(SH::R0 + N);
}

bool SHAsmParser::parseRegister(MCRegister &Reg, SMLoc &StartLoc,
                                SMLoc &EndLoc) {
  if (tryParseRegister(Reg, StartLoc, EndLoc).isFailure())
    return Error(StartLoc, "expected register");
  return false;
}

ParseStatus SHAsmParser::tryParseRegister(MCRegister &Reg, SMLoc &StartLoc,
                                          SMLoc &EndLoc) {
  const AsmToken &Tok = Parser.getTok();
  if (Tok.isNot(AsmToken::Identifier))
    return ParseStatus::NoMatch;
  StartLoc = Tok.getLoc();
  EndLoc   = Tok.getEndLoc();
  MCRegister R = matchRegisterByName(Tok.getString());
  if (!R.isValid())
    return ParseStatus::NoMatch;
  Reg = R;
  Parser.Lex();
  return ParseStatus::Success;
}

bool SHAsmParser::parseOperand(OperandVector &Operands) {
  SMLoc S = Parser.getTok().getLoc();

  MCRegister Reg;
  SMLoc E;
  if (tryParseRegister(Reg, S, E).isSuccess()) {
    Operands.push_back(SHOperand::createReg(Reg, S, E));
    return false;
  }

  const MCExpr *Expr;
  if (!Parser.parseExpression(Expr)) {
    Operands.push_back(SHOperand::createImm(Expr, S, Parser.getTok().getLoc()));
    return false;
  }

  return Error(S, "unknown operand");
}

bool SHAsmParser::parseInstruction(ParseInstructionInfo &Info, StringRef Name,
                                   SMLoc NameLoc, OperandVector &Operands) {
  Operands.push_back(SHOperand::createToken(Name, NameLoc));

  if (Parser.getTok().is(AsmToken::EndOfStatement))
    return false;

  if (parseOperand(Operands))
    return true;

  while (Parser.getTok().is(AsmToken::Comma)) {
    Parser.Lex();
    if (parseOperand(Operands))
      return true;
  }

  if (Parser.getTok().isNot(AsmToken::EndOfStatement))
    return Error(Parser.getTok().getLoc(), "unexpected token in instruction");
  return false;
}

bool SHAsmParser::matchAndEmitInstruction(SMLoc IDLoc, unsigned &Opcode,
                                          OperandVector &Operands,
                                          MCStreamer &Out,
                                          uint64_t &ErrorInfo,
                                          bool MatchingInlineAsm) {
  MCInst Inst;
  unsigned Result =
      MatchInstructionImpl(Operands, Inst, ErrorInfo, MatchingInlineAsm);
  switch (Result) {
  case Match_Success:
    Out.emitInstruction(Inst, getSTI());
    return false;
  case Match_MissingFeature:
    return Error(IDLoc, "instruction requires an unavailable feature");
  case Match_MnemonicFail:
    return Error(IDLoc, "unrecognized instruction mnemonic");
  case Match_InvalidOperand: {
    SMLoc ErrLoc = IDLoc;
    if (ErrorInfo != ~0ULL && ErrorInfo < Operands.size())
      ErrLoc = Operands[ErrorInfo]->getStartLoc();
    return Error(ErrLoc, "invalid operand for instruction");
  }
  default:
    return Error(IDLoc, "unknown match error");
  }
}

#define GET_REGISTER_MATCHER
#define GET_MATCHER_IMPLEMENTATION
#include "SHGenAsmMatcher.inc"

extern "C" LLVM_ABI LLVM_EXTERNAL_VISIBILITY void
LLVMInitializeSHAsmParser() {
  RegisterMCAsmParser<SHAsmParser> X(getTheSHTarget());
}
