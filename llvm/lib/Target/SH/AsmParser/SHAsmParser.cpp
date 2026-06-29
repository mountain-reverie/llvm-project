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
  enum KindTy {
    k_Token, k_Register, k_Immediate, k_MemDec, k_MemR0Idx,
    k_MemR0Fixed, k_MemIncR15
  } Kind;

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

  bool isToken()      const override { return Kind == k_Token; }
  bool isReg()        const override { return Kind == k_Register; }
  bool isImm()        const override { return Kind == k_Immediate; }
  bool isSHImm()      const { return Kind == k_Immediate; }
  bool isDisp()       const { return Kind == k_Immediate; }

  // Per-class displacement predicates. Non-constant expressions (symbols)
  // pass for pcdisp* (the fixup path handles range checking); all others
  // require a known constant in the valid range.
  bool isMemdisp_b4() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V >= 0 && V <= 15;
    }
    return false;
  }
  bool isMemdisp_w4() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V % 2 == 0 && V / 2 >= 0 && V / 2 <= 15;
    }
    return false;
  }
  bool isMemdisp_l4() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V % 4 == 0 && V / 4 >= 0 && V / 4 <= 15;
    }
    return false;
  }
  bool isGbrdisp_b8() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V >= 0 && V <= 255;
    }
    return false;
  }
  bool isGbrdisp_w8() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V % 2 == 0 && V / 2 >= 0 && V / 2 <= 255;
    }
    return false;
  }
  bool isGbrdisp_l8() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V % 4 == 0 && V / 4 >= 0 && V / 4 <= 255;
    }
    return false;
  }
  bool isPcdisp_w8() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V % 2 == 0 && V / 2 >= 0 && V / 2 <= 255;
    }
    return true; // non-constant expr: let fixup handle range
  }
  bool isPcdisp_l8() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V % 4 == 0 && V / 4 >= 0 && V / 4 <= 255;
    }
    return true; // non-constant expr: let fixup handle range
  }
  bool isBranchDisp8() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V % 2 == 0 && V / 2 >= -128 && V / 2 <= 127;
    }
    return true; // symbol expr: fixup handles range
  }
  bool isBranchDisp12() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V % 2 == 0 && V / 2 >= -2048 && V / 2 <= 2047;
    }
    return true; // symbol expr: fixup handles range
  }
  bool isMemdisp_b12() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V >= 0 && V <= 4095;
    }
    return false;
  }
  bool isMemdisp_w12() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V % 2 == 0 && V / 2 >= 0 && V / 2 <= 4095;
    }
    return false;
  }
  bool isMemdisp_l12() const {
    if (Kind != k_Immediate) return false;
    if (const auto *CE = dyn_cast<MCConstantExpr>(Imm.Val)) {
      int64_t V = CE->getValue();
      return V % 4 == 0 && V / 4 >= 0 && V / 4 <= 4095;
    }
    return false;
  }
  bool isMem()        const override { return false; }
  bool isMemDec()     const { return Kind == k_MemDec; }
  bool isMemR0Idx()   const { return Kind == k_MemR0Idx; }
  bool isMemR0Fixed() const { return Kind == k_MemR0Fixed; }
  bool isMemDecR15()  const { return Kind == k_MemDec && Reg.Reg == SH::R15; }
  bool isMemIncR15()  const { return Kind == k_MemIncR15; }

  MCRegister getReg() const override {
    assert(Kind == k_Register || Kind == k_MemDec || Kind == k_MemR0Idx);
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
    assert(Kind == k_Register || Kind == k_MemDec || Kind == k_MemR0Idx);
    Inst.addOperand(MCOperand::createReg(Reg.Reg));
  }
  void addMemR0FixedOperands(MCInst &Inst, unsigned N) const {
    assert(N == 1);
    Inst.addOperand(MCOperand::createImm(0));
  }
  void addMemIncR15Operands(MCInst &Inst, unsigned N) const {
    assert(N == 1);
    Inst.addOperand(MCOperand::createImm(0));
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
  static std::unique_ptr<SHOperand> createMemDec(MCRegister Reg, SMLoc S, SMLoc E) {
    auto Op = std::make_unique<SHOperand>(k_MemDec);
    Op->Reg.Reg = Reg;
    Op->StartLoc = S;
    Op->EndLoc   = E;
    return Op;
  }
  static std::unique_ptr<SHOperand> createMemR0Idx(MCRegister Reg, SMLoc S, SMLoc E) {
    auto Op = std::make_unique<SHOperand>(k_MemR0Idx);
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
  static std::unique_ptr<SHOperand> createMemR0Fixed(SMLoc S, SMLoc E) {
    auto Op = std::make_unique<SHOperand>(k_MemR0Fixed);
    Op->StartLoc = S;
    Op->EndLoc   = E;
    return Op;
  }
  static std::unique_ptr<SHOperand> createMemIncR15(SMLoc S, SMLoc E) {
    auto Op = std::make_unique<SHOperand>(k_MemIncR15);
    Op->StartLoc = S;
    Op->EndLoc   = E;
    return Op;
  }
};

class SHAsmParser : public MCTargetAsmParser {
  MCAsmParser &Parser;

#define GET_ASSEMBLER_HEADER
#include "SHGenAsmMatcher.inc"

public:
  enum {
#define GET_OPERAND_DIAGNOSTIC_TYPES
#include "SHGenAsmMatcher.inc"
  };

private:
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

  bool parseOperand(OperandVector &Operands, StringRef Mnemonic = "");
  MCRegister matchRegisterByName(StringRef Name);

  // Custom operand parse methods (invoked by generated MatchOperandParserImpl).
  ParseStatus parseMemDec(OperandVector &Operands);
  ParseStatus parseMemR0Idx(OperandVector &Operands);
  ParseStatus parseMemR0Fixed(OperandVector &Operands);
  ParseStatus parseMemIncR15(OperandVector &Operands);

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
  // Banked GPR: rN_bank (N = 0..7)
  StringRef Bank = Lower;
  if (Bank.consume_back("_bank")) {
    if (!Bank.getAsInteger(10, N) && N <= 7)
      return MCRegister(SH::R0_BANK + N);
    return MCRegister();
  }
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

// parseMemDec — matches @-rN, pushes a MemDec operand (for MemDec class).
// Only called by MatchOperandParserImpl when the matcher expects MCK_MemDec.
ParseStatus SHAsmParser::parseMemDec(OperandVector &Operands) {
  if (Parser.getTok().isNot(AsmToken::At))
    return ParseStatus::NoMatch;
  // Peek: next token must be '-'
  const AsmToken &Next = Parser.getLexer().peekTok();
  if (Next.isNot(AsmToken::Minus))
    return ParseStatus::NoMatch;
  SMLoc S = Parser.getTok().getLoc();
  Parser.Lex(); // eat '@'
  Parser.Lex(); // eat '-'
  MCRegister Reg;
  SMLoc RS, RE;
  if (!tryParseRegister(Reg, RS, RE).isSuccess())
    return Error(Parser.getTok().getLoc(), "expected register after '@-'"),
           ParseStatus::Failure;
  Operands.push_back(SHOperand::createMemDec(Reg, S, RE));
  return ParseStatus::Success;
}

// parseMemR0Idx — intentionally a no-op; all @(r0,rN)/@(r0,gbr) forms are
// handled by parseOperand so this custom parser never consumes tokens.
ParseStatus SHAsmParser::parseMemR0Idx(OperandVector &Operands) {
  return ParseStatus::NoMatch;
}

// parseMemR0Fixed — matches @r0 (without '+') for cas.l Rm,Rn,@R0.
// Only invoked for mnemonics that use MemR0Fixed (mnemonic-scoped via matcher).
ParseStatus SHAsmParser::parseMemR0Fixed(OperandVector &Operands) {
  if (Parser.getTok().isNot(AsmToken::At))
    return ParseStatus::NoMatch;
  const AsmToken &Next = Parser.getLexer().peekTok();
  if (!Next.is(AsmToken::Identifier) || Next.getString().lower() != "r0")
    return ParseStatus::NoMatch;
  SMLoc S = Parser.getTok().getLoc();
  Parser.Lex(); // eat '@'
  SMLoc E = Parser.getTok().getEndLoc();
  Parser.Lex(); // eat 'r0'
  // Reject @r0+ (that's @Rm+ with rm=0, not a MemR0Fixed form)
  if (Parser.getTok().is(AsmToken::Plus))
    return ParseStatus::NoMatch;
  Operands.push_back(SHOperand::createMemR0Fixed(S, E));
  return ParseStatus::Success;
}

// parseMemIncR15 — matches @r15+ for movml.l/movmu.l @R15+,Rn.
// Only invoked for mnemonics that use MemIncR15 (mnemonic-scoped via matcher).
ParseStatus SHAsmParser::parseMemIncR15(OperandVector &Operands) {
  if (Parser.getTok().isNot(AsmToken::At))
    return ParseStatus::NoMatch;
  const AsmToken &Next = Parser.getLexer().peekTok();
  if (!Next.is(AsmToken::Identifier) || Next.getString().lower() != "r15")
    return ParseStatus::NoMatch;
  SMLoc S = Parser.getTok().getLoc();
  Parser.Lex(); // eat '@'
  SMLoc E = Parser.getTok().getEndLoc();
  Parser.Lex(); // eat 'r15'
  if (Parser.getTok().isNot(AsmToken::Plus))
    return Error(Parser.getTok().getLoc(), "expected '+' after '@r15'"),
           ParseStatus::Failure;
  Parser.Lex(); // eat '+'
  Operands.push_back(SHOperand::createMemIncR15(S, E));
  return ParseStatus::Success;
}

bool SHAsmParser::parseOperand(OperandVector &Operands, StringRef Mnemonic) {
  SMLoc S = Parser.getTok().getLoc();

  // Immediate: '#' expr
  if (Parser.getTok().is(AsmToken::Hash)) {
    Parser.Lex(); // eat '#'
    const MCExpr *Expr;
    SMLoc IS = Parser.getTok().getLoc();
    if (Parser.parseExpression(Expr))
      return Error(IS, "expected immediate expression after '#'");
    Operands.push_back(SHOperand::createImm(Expr, S, Parser.getTok().getLoc()));
    return false;
  }

  // Handle '@' prefixed memory forms.
  if (Parser.getTok().is(AsmToken::At)) {
    // Peek ahead to decide which fixed-token form or custom operand to produce.
    // Save state for potential backtrack via custom parsers.
    // First try fixed forms that appear as literal tokens in AsmString:
    //   @-r15, @r15+, @r0, @(r0,gbr)
    // These must be produced as a single combined token string the matcher sees.
    //
    // Determine what follows '@':
    const AsmToken &Next = Parser.getLexer().peekTok();

    // @(...)  forms: @(r0,gbr), @(r0,rN), @(disp,gbr), @(disp,pc), @(disp,rN).
    if (Next.is(AsmToken::LParen)) {
      SMLoc AtLoc = Parser.getTok().getLoc();
      Parser.Lex(); // eat '@'
      Parser.Lex(); // eat '('

      // ── @(r0,...) ────────────────────────────────────────────────────────
      if (Parser.getTok().is(AsmToken::Identifier) &&
          Parser.getTok().getString().lower() == "r0") {
        Parser.Lex(); // eat 'r0'
        if (Parser.getTok().isNot(AsmToken::Comma))
          return Error(Parser.getTok().getLoc(), "expected ',' after r0 in @(r0,...)");
        Parser.Lex(); // eat ','
        if (Parser.getTok().is(AsmToken::Identifier)) {
          StringRef BaseStr = Parser.getTok().getString().lower();
          SMLoc BaseLoc = Parser.getTok().getLoc();
          if (BaseStr == "gbr") {
            Parser.Lex(); // eat 'gbr'
            if (Parser.getTok().isNot(AsmToken::RParen))
              return Error(Parser.getTok().getLoc(), "expected ')' in @(r0,gbr)");
            Parser.Lex(); // eat ')'
            Operands.push_back(SHOperand::createToken("@(r0", AtLoc));
            Operands.push_back(SHOperand::createToken("gbr)", BaseLoc));
            return false;
          }
          // @(r0,rN) — MemR0Idx operand
          MCRegister Reg;
          SMLoc RS, RE;
          if (tryParseRegister(Reg, RS, RE).isSuccess()) {
            if (Parser.getTok().isNot(AsmToken::RParen))
              return Error(Parser.getTok().getLoc(), "expected ')' in @(r0,rN)");
            Parser.Lex(); // eat ')'
            Operands.push_back(SHOperand::createMemR0Idx(Reg, AtLoc, RE));
            return false;
          }
        }
        return Error(Parser.getTok().getLoc(), "unrecognized @(r0,...) form");
      }

      // ── @(disp,...) ──────────────────────────────────────────────────────
      // Parse the displacement as an expression (byte offset written by user).
      const MCExpr *DispExpr;
      SMLoc DispS = Parser.getTok().getLoc();
      if (Parser.parseExpression(DispExpr))
        return Error(DispS, "expected displacement in @(disp,...)");
      if (Parser.getTok().isNot(AsmToken::Comma))
        return Error(Parser.getTok().getLoc(), "expected ',' after displacement");
      Parser.Lex(); // eat ','

      if (Parser.getTok().is(AsmToken::Identifier)) {
        StringRef BaseName = Parser.getTok().getString().lower();
        SMLoc BaseLoc = Parser.getTok().getLoc();
        if (BaseName == "gbr") {
          Parser.Lex(); // eat 'gbr'
          if (Parser.getTok().isNot(AsmToken::RParen))
            return Error(Parser.getTok().getLoc(), "expected ')' in @(disp,gbr)");
          Parser.Lex(); // eat ')'
          Operands.push_back(SHOperand::createToken("@(", AtLoc));
          Operands.push_back(SHOperand::createImm(DispExpr, DispS, BaseLoc));
          Operands.push_back(SHOperand::createToken("gbr)", BaseLoc));
          return false;
        }
        if (BaseName == "pc") {
          Parser.Lex(); // eat 'pc'
          if (Parser.getTok().isNot(AsmToken::RParen))
            return Error(Parser.getTok().getLoc(), "expected ')' in @(disp,pc)");
          Parser.Lex(); // eat ')'
          Operands.push_back(SHOperand::createToken("@(", AtLoc));
          Operands.push_back(SHOperand::createImm(DispExpr, DispS, BaseLoc));
          Operands.push_back(SHOperand::createToken("pc)", BaseLoc));
          return false;
        }
        // @(disp,rN)
        MCRegister Reg;
        SMLoc RS, RE;
        if (tryParseRegister(Reg, RS, RE).isSuccess()) {
          if (Parser.getTok().isNot(AsmToken::RParen))
            return Error(Parser.getTok().getLoc(), "expected ')' after @(disp,rN)");
          SMLoc RParenLoc = Parser.getTok().getLoc();
          Parser.Lex(); // eat ')'
          Operands.push_back(SHOperand::createToken("@(", AtLoc));
          Operands.push_back(SHOperand::createImm(DispExpr, DispS, RS));
          Operands.push_back(SHOperand::createReg(Reg, RS, RE));
          Operands.push_back(SHOperand::createToken(")", RParenLoc));
          return false;
        }
      }
      return Error(AtLoc, "unrecognized @(...) memory form");
    }

    // @-rN pre-decrement. The variable form is normally handled by parseMemDec
    // (custom parser invoked before this fallback); reaching here we build a
    // MemDec operand directly. (Fixed @-R15 for movml/movmu is deferred to a
    // later sub-phase — "@-r15" is ambiguous with variable @-Rn at rn=15.)
    if (Next.is(AsmToken::Minus)) {
      SMLoc AtLoc = Parser.getTok().getLoc();
      Parser.Lex(); // eat '@'
      Parser.Lex(); // eat '-'
      MCRegister Reg;
      SMLoc RS, RE;
      if (tryParseRegister(Reg, RS, RE).isSuccess()) {
        Operands.push_back(SHOperand::createMemDec(Reg, AtLoc, RE));
        return false;
      }
      return Error(Parser.getTok().getLoc(), "expected register after '@-'");
    }

    // @rN or @rN+ (variable indirect / post-increment): approach-A literal '@'
    // token + register operand (+ '+'). No fixed-register special-casing — the
    // fixed forms @R0/@R15+ are deferred (textually identical to @Rm/@Rm+ at
    // base r0/r15, which the literal-text scheme cannot disambiguate).
    SMLoc AtLoc = Parser.getTok().getLoc();
    Parser.Lex(); // eat '@'
    MCRegister Reg;
    SMLoc RS, RE;
    if (tryParseRegister(Reg, RS, RE).isSuccess()) {
      Operands.push_back(SHOperand::createToken("@", AtLoc));
      Operands.push_back(SHOperand::createReg(Reg, RS, RE));
      if (Parser.getTok().is(AsmToken::Plus)) {
        Operands.push_back(SHOperand::createToken("+", Parser.getTok().getLoc()));
        Parser.Lex();
      }
      return false;
    }
    return Error(Parser.getTok().getLoc(), "expected register after '@'");
  }

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
  // SH mnemonics such as cmp/eq, cmp/pl, cmp/str contain '/', which the generic
  // lexer does not fold into the mnemonic identifier. Reconstruct the full
  // mnemonic by consuming trailing "/<suffix>" sequences (the characters are
  // contiguous in the source buffer, so a single StringRef spans them).
  // Note: `Name` is a lowercased std::string copy (not a StringRef into the
  // source buffer), so span the mnemonic from the source via NameLoc, which
  // points at the mnemonic start in the (stable) source buffer. SH source is
  // lowercase by convention, so the spanned text matches the matcher table.
  StringRef FullName = Name;
  const char *Begin = NameLoc.getPointer();
  while (Begin && Parser.getTok().is(AsmToken::Slash)) {
    Parser.Lex(); // eat '/'
    if (Parser.getTok().isNot(AsmToken::Identifier))
      return Error(Parser.getTok().getLoc(), "expected mnemonic suffix after '/'");
    StringRef Suf = Parser.getTok().getIdentifier();
    FullName = StringRef(Begin, Suf.data() + Suf.size() - Begin);
    Parser.Lex(); // eat suffix
  }
  Operands.push_back(SHOperand::createToken(FullName, NameLoc));

  if (Parser.getTok().is(AsmToken::EndOfStatement))
    return false;

  // Try generated custom-operand parser first, fall back to generic parseOperand.
  auto parseOne = [&]() -> bool {
    ParseStatus Res = MatchOperandParserImpl(Operands, FullName, /*isPredicable=*/false);
    if (Res.isSuccess()) return false;
    if (Res.isFailure()) return true;
    return parseOperand(Operands, FullName);
  };

  if (parseOne())
    return true;

  while (Parser.getTok().is(AsmToken::Comma)) {
    Parser.Lex();
    if (parseOne())
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
