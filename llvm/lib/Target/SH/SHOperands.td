//===-- SHOperands.td - SH subtarget features / predicates -*- tablegen -*-===//

def FeatureSH1  : SubtargetFeature<"sh1","HasSH1","true","SH1 ISA">;
def FeatureSH2  : SubtargetFeature<"sh2","HasSH2","true","SH2 ISA">;
def FeatureSH2E : SubtargetFeature<"sh2e","HasSH2E","true","SH2E ISA">;
def FeatureSH3  : SubtargetFeature<"sh3","HasSH3","true","SH3 ISA">;
def FeatureSH3E : SubtargetFeature<"sh3e","HasSH3E","true","SH3E ISA">;
def FeatureSH2A : SubtargetFeature<"sh2a","HasSH2A","true","SH2A ISA">;
def FeatureSH4  : SubtargetFeature<"sh4","HasSH4","true","SH4 ISA">;
def FeatureSH4A : SubtargetFeature<"sh4a","HasSH4A","true","SH4A ISA">;
def FeatureJ1   : SubtargetFeature<"j1","HasJ1","true","J1 core">;
def FeatureJ2   : SubtargetFeature<"j2","HasJ2","true","J2 core">;
def FeatureJ4   : SubtargetFeature<"j4","HasJ4","true","J4 core">;

def HasSH1  : Predicate<"Subtarget->hasSH1()">;
def HasSH2  : Predicate<"Subtarget->hasSH2()">;
def HasSH2E : Predicate<"Subtarget->hasSH2E()">;
def HasSH3  : Predicate<"Subtarget->hasSH3()">;
def HasSH3E : Predicate<"Subtarget->hasSH3E()">;
def HasSH2A : Predicate<"Subtarget->hasSH2A()">;
def HasSH4  : Predicate<"Subtarget->hasSH4()">;
def HasSH4A : Predicate<"Subtarget->hasSH4A()">;
def HasJ1   : Predicate<"Subtarget->hasJ1()">;
def HasJ2   : Predicate<"Subtarget->hasJ2()">;
def HasJ4   : Predicate<"Subtarget->hasJ4()">;

// Immediate operand for SH (AsmParser match + default print/decode).
def SHImmAsmOperand : AsmOperandClass {
  let Name = "SHImm";
  let RenderMethod = "addImmOperands";
}
def SHImm : Operand<i32> {
  let ParserMatchClass = SHImmAsmOperand;
}

// Pre-decrement memory operand @-Rn (holds the base register).
def MemDecAsmOperand : AsmOperandClass {
  let Name = "MemDec";
  let ParserMethod = "parseMemDec";
  let RenderMethod = "addRegOperands";
}
// R0-indexed memory operand @(R0,Rn) (holds the index register).
def MemR0IdxAsmOperand : AsmOperandClass {
  let Name = "MemR0Idx";
  let ParserMethod = "parseMemR0Idx";
  let RenderMethod = "addRegOperands";
}

def MemDec : RegisterOperand<GPR> {
  let ParserMatchClass = MemDecAsmOperand;
  let PrintMethod = "printMemDec";
  let DecoderMethod = "decodeGPRAsMem";
}
def MemR0Idx : RegisterOperand<GPR> {
  let ParserMatchClass = MemR0IdxAsmOperand;
  let PrintMethod = "printMemR0Idx";
  let DecoderMethod = "decodeGPRAsMem";
}

// Fixed-register constrained memory operands (no encoding bits).
// @r0 — used by cas.l Rm,Rn,@R0.
def MemR0FixedAsmOperand : AsmOperandClass {
  let Name = "MemR0Fixed";
  let ParserMethod = "parseMemR0Fixed";
  let RenderMethod = "addMemR0FixedOperands";
}
// @-r15 — used by movml.l/movmu.l Rm,@-R15.
def MemDecR15AsmOperand : AsmOperandClass {
  let Name = "MemDecR15";
  // No ParserMethod: falls back to parseOperand (produces k_MemDec(R15)).
  let RenderMethod = "addRegOperands";
}
// @r15+ — used by movml.l/movmu.l @R15+,Rn.
def MemIncR15AsmOperand : AsmOperandClass {
  let Name = "MemIncR15";
  let ParserMethod = "parseMemIncR15";
  let RenderMethod = "addMemIncR15Operands";
}

def MemR0Fixed : Operand<i32> {
  let ParserMatchClass = MemR0FixedAsmOperand;
  let PrintMethod = "printMemR0Fixed";
  let DecoderMethod = "decodeMemR0Fixed";
}
def MemDecR15 : Operand<i32> {
  let ParserMatchClass = MemDecR15AsmOperand;
  let PrintMethod = "printMemDecR15";
  let DecoderMethod = "decodeMemDecR15";
}
def MemIncR15 : Operand<i32> {
  let ParserMatchClass = MemIncR15AsmOperand;
  let PrintMethod = "printMemIncR15";
  let DecoderMethod = "decodeMemIncR15";
}

// Scaled displacement operands. The AsmParser stores the BYTE offset;
// the encoder divides by the scale factor, the decoder multiplies back.
// Each operand class has a per-class AsmOperandClass for range+scale validation.

class SHDispAsmOperand<string N, string Pred> : AsmOperandClass {
  let Name = N;
  let RenderMethod = "addImmOperands";
  let DiagnosticType = "InvalidDisp";
  let PredicateMethod = Pred;
}

def Memdisp_b4AsmOperand : SHDispAsmOperand<"Memdisp_b4", "isMemdisp_b4">;
def Memdisp_w4AsmOperand : SHDispAsmOperand<"Memdisp_w4", "isMemdisp_w4">;
def Memdisp_l4AsmOperand : SHDispAsmOperand<"Memdisp_l4", "isMemdisp_l4">;
def Gbrdisp_b8AsmOperand : SHDispAsmOperand<"Gbrdisp_b8", "isGbrdisp_b8">;
def Gbrdisp_w8AsmOperand : SHDispAsmOperand<"Gbrdisp_w8", "isGbrdisp_w8">;
def Gbrdisp_l8AsmOperand : SHDispAsmOperand<"Gbrdisp_l8", "isGbrdisp_l8">;
def Pcdisp_w8AsmOperand  : SHDispAsmOperand<"Pcdisp_w8",  "isPcdisp_w8">;
def Pcdisp_l8AsmOperand  : SHDispAsmOperand<"Pcdisp_l8",  "isPcdisp_l8">;
def Memdisp_b12AsmOperand : SHDispAsmOperand<"Memdisp_b12", "isMemdisp_b12">;
def Memdisp_w12AsmOperand : SHDispAsmOperand<"Memdisp_w12", "isMemdisp_w12">;
def Memdisp_l12AsmOperand : SHDispAsmOperand<"Memdisp_l12", "isMemdisp_l12">;

class SHDispOperand<AsmOperandClass MC, string scale> : Operand<i32> {
  let ParserMatchClass = MC;
  let PrintMethod = "printDisp";
  let EncoderMethod = "getDisp_s"#scale;
  let DecoderMethod = "decodeDisp_s"#scale;
}

// 4-bit displacement fields, scaled by access size.
def memdisp_b4 : SHDispOperand<Memdisp_b4AsmOperand, "1">;
def memdisp_w4 : SHDispOperand<Memdisp_w4AsmOperand, "2">;
def memdisp_l4 : SHDispOperand<Memdisp_l4AsmOperand, "4">;
// 12-bit displacement fields (two-word SH-2A instructions), scaled by access size.
def memdisp_b12 : SHDispOperand<Memdisp_b12AsmOperand, "1">;
def memdisp_w12 : SHDispOperand<Memdisp_w12AsmOperand, "2">;
def memdisp_l12 : SHDispOperand<Memdisp_l12AsmOperand, "4">;
// 8-bit displacement fields for GBR-relative addressing.
def gbrdisp_b8 : SHDispOperand<Gbrdisp_b8AsmOperand, "1">;
def gbrdisp_w8 : SHDispOperand<Gbrdisp_w8AsmOperand, "2">;
def gbrdisp_l8 : SHDispOperand<Gbrdisp_l8AsmOperand, "4">;
// 8-bit displacement fields for PC-relative addressing.
// Dedicated encoder methods emit a fixup when the operand is a symbol.
class SHPCDispOperand<AsmOperandClass MC, string scale, string enc> : Operand<i32> {
  let ParserMatchClass = MC;
  let PrintMethod = "printDisp";
  let EncoderMethod = enc;
  let DecoderMethod = "decodeDisp_s"#scale;
}
def pcdisp_w8  : SHPCDispOperand<Pcdisp_w8AsmOperand, "2", "getPCDisp_s2">;
def pcdisp_l8  : SHPCDispOperand<Pcdisp_l8AsmOperand, "4", "getPCDisp_s4">;

