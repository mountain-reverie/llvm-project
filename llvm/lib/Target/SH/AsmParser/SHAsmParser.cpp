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
  enum KindTy { k_Token, k_Register, k_Immediate, k_MemDec, k_MemR0Idx } Kind;

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

  bool isToken()    const override { return Kind == k_Token; }
  bool isReg()      const override { return Kind == k_Register; }
  bool isImm()      const override { return Kind == k_Immediate; }
  bool isSHImm()    const { return Kind == k_Immediate; }
  bool isMem()      const override { return false; }
  bool isMemDec()   const { return Kind == k_MemDec; }
  bool isMemR0Idx() const { return Kind == k_MemR0Idx; }

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

  bool parseOperand(OperandVector &Operands, StringRef Mnemonic = "");
  MCRegister matchRegisterByName(StringRef Name);

  // Custom operand parse methods (invoked by generated MatchOperandParserImpl).
  ParseStatus parseMemDec(OperandVector &Operands);
  ParseStatus parseMemR0Idx(OperandVector &Operands);

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

// parseMemR0Idx — matches @(r0,rN) where rN is a GPR.
// Only called by MatchOperandParserImpl when the matcher expects MCK_MemR0Idx.
// Does NOT match @(r0,gbr) — that's a fixed literal token form.
ParseStatus SHAsmParser::parseMemR0Idx(OperandVector &Operands) {
  if (Parser.getTok().isNot(AsmToken::At))
    return ParseStatus::NoMatch;
  // Peek: next must be '('
  const AsmToken &Next = Parser.getLexer().peekTok();
  if (Next.isNot(AsmToken::LParen))
    return ParseStatus::NoMatch;
  SMLoc S = Parser.getTok().getLoc();
  Parser.Lex(); // eat '@'
  Parser.Lex(); // eat '('
  // Expect 'r0'
  if (Parser.getTok().isNot(AsmToken::Identifier) ||
      Parser.getTok().getString().lower() != "r0")
    return ParseStatus::NoMatch;
  Parser.Lex(); // eat 'r0'
  if (Parser.getTok().isNot(AsmToken::Comma))
    return ParseStatus::NoMatch;
  Parser.Lex(); // eat ','
  // Expect a GPR (not gbr — that case is handled as fixed literal tokens)
  MCRegister Reg;
  SMLoc RS, RE;
  if (!tryParseRegister(Reg, RS, RE).isSuccess())
    return ParseStatus::NoMatch; // let parseOperand handle @(r0,gbr) etc.
  if (Parser.getTok().isNot(AsmToken::RParen))
    return Error(Parser.getTok().getLoc(), "expected ')' in @(r0,rN)"),
           ParseStatus::Failure;
  Parser.Lex(); // eat ')'
  Operands.push_back(SHOperand::createMemR0Idx(Reg, S, RE));
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

    // Check for @(r0,...) — either @(r0,gbr) fixed form or @(r0,rN) custom.
    // The custom @(r0,rN) case is handled by parseMemR0Idx via MatchOperandParserImpl
    // BEFORE parseOperand is called, so we only reach here for @(r0,gbr).
    // The matcher expects two literal tokens: "@(r0" and "gbr)".
    if (Next.is(AsmToken::LParen)) {
      SMLoc AtLoc = Parser.getTok().getLoc();
      Parser.Lex(); // eat '@'
      Parser.Lex(); // eat '('
      if (Parser.getTok().is(AsmToken::Identifier) &&
          Parser.getTok().getString().lower() == "r0") {
        SMLoc R0Loc = Parser.getTok().getLoc();
        Parser.Lex(); // eat 'r0'
        if (Parser.getTok().is(AsmToken::Comma)) {
          Parser.Lex(); // eat ','
          if (Parser.getTok().is(AsmToken::Identifier) &&
              Parser.getTok().getString().lower() == "gbr") {
            SMLoc GbrLoc = Parser.getTok().getLoc();
            Parser.Lex(); // eat 'gbr'
            if (Parser.getTok().is(AsmToken::RParen)) {
              Parser.Lex(); // eat ')'
              // Matcher expects two tokens: "@(r0" and "gbr)"
              Operands.push_back(SHOperand::createToken("@(r0", AtLoc));
              Operands.push_back(SHOperand::createToken("gbr)", GbrLoc));
              return false;
            }
          }
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
