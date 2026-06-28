//===-- SH.td - SH target description ----------------------*- tablegen -*-===//

include "llvm/Target/Target.td"

include "SHRegisterInfo.td"
include "SHOperands.td"
include "SHInstrInfo.td"
include "SHInstrAliases.td"

def SHInstrInfo : InstrInfo;

def SHAsmParser : AsmParser;
def SHAsmWriter : AsmWriter;

def SH : Target {
  let InstructionSet = SHInstrInfo;
  let AssemblyParsers = [SHAsmParser];
  let AssemblyWriters = [SHAsmWriter];
}

def : ProcessorModel<"generic", NoSchedModel, [FeatureJ2]>;

defm SHPtrRemap : RemapAllTargetPseudoPointerOperands<GPR>;
