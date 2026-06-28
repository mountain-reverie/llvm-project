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
