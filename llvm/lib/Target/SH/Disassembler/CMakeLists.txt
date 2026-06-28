add_llvm_component_library(LLVMSHDisassembler
  SHDisassembler.cpp

  LINK_COMPONENTS
  MCDisassembler
  MC
  SHInfo
  Support

  ADD_TO_COMPONENT
  SH
  )
