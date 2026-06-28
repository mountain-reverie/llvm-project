add_llvm_component_group(SH)

set(LLVM_TARGET_DEFINITIONS SH.td)

tablegen(LLVM SHGenAsmMatcher.inc    -gen-asm-matcher)
tablegen(LLVM SHGenAsmWriter.inc     -gen-asm-writer)
tablegen(LLVM SHGenDisassemblerTables.inc -gen-disassembler)
tablegen(LLVM SHGenInstrInfo.inc     -gen-instr-info)
tablegen(LLVM SHGenMCCodeEmitter.inc -gen-emitter)
tablegen(LLVM SHGenRegisterInfo.inc  -gen-register-info)
tablegen(LLVM SHGenSubtargetInfo.inc -gen-subtarget)

add_public_tablegen_target(SHCommonTableGen)

# Stub codegen library so that cmake component expansion (LLVM-Config.cmake)
# finds LLVMSHCodeGen when a tool links ${LLVM_TARGETS_TO_BUILD}.
add_llvm_target(SHCodeGen
  SHTargetMachineStub.cpp

  LINK_COMPONENTS
  SHDesc
  SHInfo
  MC
  Support

  ADD_TO_COMPONENT
  SH
  )

add_subdirectory(TargetInfo)
add_subdirectory(MCTargetDesc)
add_subdirectory(AsmParser)
add_subdirectory(Disassembler)
