def MOV_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mov\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_Imm_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{7-0} = imm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn);
  let AsmString = "mov\t${imm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOVI20_Imm_GPR : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<20> imm;
  bits<4> rn;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 0;
  let Inst{28} = 0;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 0;
  let Inst{23-20} = imm{19-16};
  let Inst{15-0} = imm{15-0};
  let Inst{27-24} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn);
  let AsmString = "movi20\t${imm}, ${rn}";
  let Predicates = [HasSH2A];
}

def MOVI20S_Imm_GPR : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<20> imm;
  bits<4> rn;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 0;
  let Inst{28} = 0;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{23-20} = imm{19-16};
  let Inst{15-0} = imm{15-0};
  let Inst{27-24} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn);
  let AsmString = "movi20s\t${imm}, ${rn}";
  let Predicates = [HasSH2A];
}

def MOVA_MemPC_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 1;
  let Inst{9} = 1;
  let Inst{8} = 1;
  let Inst{7-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins pcdisp_l8:$disp);
  let AsmString = "mova\t@(${disp}, pc), r0";
  let Predicates = [HasSH1];
}

def MOV_W_MemPC_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 1;
  let Inst{7-0} = disp;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins pcdisp_w8:$disp, GPR:$rn);
  let AsmString = "mov.w\t@(${disp}, pc), ${rn}";
  let Predicates = [HasSH1];
}

def MOV_L_MemPC_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 1;
  let Inst{7-0} = disp;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins pcdisp_l8:$disp, GPR:$rn);
  let AsmString = "mov.l\t@(${disp}, pc), ${rn}";
  let Predicates = [HasSH1];
}

def MOV_B_MemReg_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mov.b\t@${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_W_MemReg_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mov.w\t@${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_L_MemReg_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mov.l\t@${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_B_GPR_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mov.b\t${rm}, @${rn}";
  let Predicates = [HasSH1];
}

def MOV_W_GPR_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mov.w\t${rm}, @${rn}";
  let Predicates = [HasSH1];
}

def MOV_L_GPR_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mov.l\t${rm}, @${rn}";
  let Predicates = [HasSH1];
}

def MOV_B_MemPostInc_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mov.b\t@${rm}+, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_W_MemPostInc_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mov.w\t@${rm}+, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_L_MemPostInc_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mov.l\t@${rm}+, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_B_GPR_MemPreDec : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, MemDec:$rn);
  let AsmString = "mov.b\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_W_GPR_MemPreDec : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, MemDec:$rn);
  let AsmString = "mov.w\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_L_GPR_MemPreDec : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, MemDec:$rn);
  let AsmString = "mov.l\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_B_MemPreDec_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rm);
  let AsmString = "mov.b\t${rm}, r0";
  let Predicates = [HasSH2A];
}

def MOV_W_MemPreDec_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rm);
  let AsmString = "mov.w\t${rm}, r0";
  let Predicates = [HasSH2A];
}

def MOV_L_MemPreDec_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rm);
  let AsmString = "mov.l\t${rm}, r0";
  let Predicates = [HasSH2A];
}

def MOV_B_R0Fixed_MemPostInc : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "mov.b\tr0, @${rn}+";
  let Predicates = [HasSH2A];
}

def MOV_W_R0Fixed_MemPostInc : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "mov.w\tr0, @${rn}+";
  let Predicates = [HasSH2A];
}

def MOV_L_R0Fixed_MemPostInc : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "mov.l\tr0, @${rn}+";
  let Predicates = [HasSH2A];
}

def MOV_B_MemDisp_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> disp;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 1;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7-4} = rm;
  let Inst{3-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, memdisp_b4:$disp);
  let AsmString = "mov.b\t@(${disp}, ${rm}), r0";
  let Predicates = [HasSH1];
}

def MOV_B_MemDisp_GPR : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<12> disp;
  bits<4> rn;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{23-20} = rm;
  let Inst{11-0} = disp;
  let Inst{27-24} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, memdisp_b12:$disp, GPR:$rn);
  let AsmString = "mov.b\t@(${disp}, ${rm}), ${rn}";
  let Predicates = [HasSH2A];
}

def MOVU_B_MemDisp_GPR : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<12> disp;
  bits<4> rn;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{23-20} = rm;
  let Inst{11-0} = disp;
  let Inst{27-24} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, memdisp_b12:$disp, GPR:$rn);
  let AsmString = "movu.b\t@(${disp}, ${rm}), ${rn}";
  let Predicates = [HasSH2A];
}

def MOV_W_MemDisp_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> disp;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 1;
  let Inst{9} = 0;
  let Inst{8} = 1;
  let Inst{7-4} = rm;
  let Inst{3-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, memdisp_w4:$disp);
  let AsmString = "mov.w\t@(${disp}, ${rm}), r0";
  let Predicates = [HasSH1];
}

def MOV_W_MemDisp_GPR : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<12> disp;
  bits<4> rn;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 1;
  let Inst{23-20} = rm;
  let Inst{11-0} = disp;
  let Inst{27-24} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, memdisp_w12:$disp, GPR:$rn);
  let AsmString = "mov.w\t@(${disp}, ${rm}), ${rn}";
  let Predicates = [HasSH2A];
}

def MOVU_W_MemDisp_GPR : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<12> disp;
  bits<4> rn;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 1;
  let Inst{23-20} = rm;
  let Inst{11-0} = disp;
  let Inst{27-24} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, memdisp_w12:$disp, GPR:$rn);
  let AsmString = "movu.w\t@(${disp}, ${rm}), ${rn}";
  let Predicates = [HasSH2A];
}

def MOV_L_MemDisp_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> disp;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 1;
  let Inst{7-4} = rm;
  let Inst{3-0} = disp;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, memdisp_l4:$disp, GPR:$rn);
  let AsmString = "mov.l\t@(${disp}, ${rm}), ${rn}";
  let Predicates = [HasSH1];
}

def MOV_L_MemDisp_GPR_2 : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<12> disp;
  bits<4> rn;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{23-20} = rm;
  let Inst{11-0} = disp;
  let Inst{27-24} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, memdisp_l12:$disp, GPR:$rn);
  let AsmString = "mov.l\t@(${disp}, ${rm}), ${rn}";
  let Predicates = [HasSH2A];
}

def MOV_B_R0Fixed_MemDisp : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  bits<4> disp;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7-4} = rn;
  let Inst{3-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn, memdisp_b4:$disp);
  let AsmString = "mov.b\tr0, @(${disp}, ${rn})";
  let Predicates = [HasSH1];
}

def MOV_B_GPR_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{23-20} = rm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn, memdisp_b12:$disp);
  let AsmString = "mov.b\t${rm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def MOV_W_R0Fixed_MemDisp : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  bits<4> disp;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 1;
  let Inst{7-4} = rn;
  let Inst{3-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn, memdisp_w4:$disp);
  let AsmString = "mov.w\tr0, @(${disp}, ${rn})";
  let Predicates = [HasSH1];
}

def MOV_W_GPR_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 1;
  let Inst{23-20} = rm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn, memdisp_w12:$disp);
  let AsmString = "mov.w\t${rm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def MOV_L_GPR_MemDisp : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  bits<4> disp;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  let Inst{3-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn, memdisp_l4:$disp);
  let AsmString = "mov.l\t${rm}, @(${disp}, ${rn})";
  let Predicates = [HasSH1];
}

def MOV_L_GPR_MemDisp_2 : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{23-20} = rm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn, memdisp_l12:$disp);
  let AsmString = "mov.l\t${rm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def MOV_B_MemR0_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemR0Idx:$rm, GPR:$rn);
  let AsmString = "mov.b\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_W_MemR0_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemR0Idx:$rm, GPR:$rn);
  let AsmString = "mov.w\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_L_MemR0_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemR0Idx:$rm, GPR:$rn);
  let AsmString = "mov.l\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_B_GPR_MemR0 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, MemR0Idx:$rn);
  let AsmString = "mov.b\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_W_GPR_MemR0 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, MemR0Idx:$rn);
  let AsmString = "mov.w\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_L_GPR_MemR0 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, MemR0Idx:$rn);
  let AsmString = "mov.l\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MOV_B_MemGBR_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 1;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins gbrdisp_b8:$disp);
  let AsmString = "mov.b\t@(${disp}, gbr), r0";
  let Predicates = [HasSH1];
}

def MOV_W_MemGBR_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 1;
  let Inst{9} = 0;
  let Inst{8} = 1;
  let Inst{7-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins gbrdisp_w8:$disp);
  let AsmString = "mov.w\t@(${disp}, gbr), r0";
  let Predicates = [HasSH1];
}

def MOV_L_MemGBR_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 1;
  let Inst{9} = 1;
  let Inst{8} = 0;
  let Inst{7-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins gbrdisp_l8:$disp);
  let AsmString = "mov.l\t@(${disp}, gbr), r0";
  let Predicates = [HasSH1];
}

def MOV_B_R0Fixed_MemGBR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins gbrdisp_b8:$disp);
  let AsmString = "mov.b\tr0, @(${disp}, gbr)";
  let Predicates = [HasSH1];
}

def MOV_W_R0Fixed_MemGBR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 1;
  let Inst{7-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins gbrdisp_w8:$disp);
  let AsmString = "mov.w\tr0, @(${disp}, gbr)";
  let Predicates = [HasSH1];
}

def MOV_L_R0Fixed_MemGBR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 1;
  let Inst{8} = 0;
  let Inst{7-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins gbrdisp_l8:$disp);
  let AsmString = "mov.l\tr0, @(${disp}, gbr)";
  let Predicates = [HasSH1];
}

def MOVCO_L_R0Fixed_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "movco.l\tr0, @${rn}";
  let Predicates = [HasSH4A];
}

def MOVLI_L_MemReg_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "movli.l\t@${rm}, r0";
  let Predicates = [HasSH4A];
}

def MOVUA_L_MemReg_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "movua.l\t@${rm}, r0";
  let Predicates = [HasSH4A];
}

def MOVUA_L_MemPostInc_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "movua.l\t@${rm}+, r0";
  let Predicates = [HasSH4A];
}

def MOVML_L_GPR_MemPreDec : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let DecoderMethod = "decodeMovMemDecR15";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, MemDecR15:$fm);
  let AsmString = "movml.l\t${rm}, ${fm}";
  let Predicates = [HasSH2A];
}

def MOVML_L_MemPostInc_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let DecoderMethod = "decodeMovMemIncR15";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemIncR15:$fm, GPR:$rn);
  let AsmString = "movml.l\t${fm}, ${rn}";
  let Predicates = [HasSH2A];
}

def MOVMU_L_GPR_MemPreDec : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let DecoderMethod = "decodeMovMemDecR15";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, MemDecR15:$fm);
  let AsmString = "movmu.l\t${rm}, ${fm}";
  let Predicates = [HasSH2A];
}

def MOVMU_L_MemPostInc_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let DecoderMethod = "decodeMovMemIncR15";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemIncR15:$fm, GPR:$rn);
  let AsmString = "movmu.l\t${fm}, ${rn}";
  let Predicates = [HasSH2A];
}

def CAS_L_GPR_GPR_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let DecoderMethod = "decodeCasFixed";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn, MemR0Fixed:$fm);
  let AsmString = "cas.l\t${rm}, ${rn}, ${fm}";
  let Predicates = [HasJ2];
}

def MOVRT_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "movrt\t${rn}";
  let Predicates = [HasSH2A];
}

def MOVT_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "movt\t${rn}";
  let Predicates = [HasSH1];
}

def NOTT : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "nott";
  let Predicates = [HasSH2A];
}

def SWAP_B_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "swap.b\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def SWAP_W_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "swap.w\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def XTRACT_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "xtract\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def BAND_B_Imm_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{23} = 0;
  let Inst{19} = 1;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{22-20} = imm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn, memdisp_b12:$disp);
  let AsmString = "band.b\t${imm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def BANDNOT_B_Imm_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{23} = 0;
  let Inst{19} = 1;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{22-20} = imm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn, memdisp_b12:$disp);
  let AsmString = "bandnot.b\t${imm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def BCLR_B_Imm_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{23} = 0;
  let Inst{19} = 1;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{22-20} = imm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn, memdisp_b12:$disp);
  let AsmString = "bclr.b\t${imm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def BCLR_Imm_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 1;
  let Inst{9} = 1;
  let Inst{8} = 0;
  let Inst{3} = 0;
  let Inst{2-0} = imm;
  let Inst{7-4} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn);
  let AsmString = "bclr\t${imm}, ${rn}";
  let Predicates = [HasSH2A];
}

def BLD_B_Imm_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{23} = 0;
  let Inst{19} = 1;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{22-20} = imm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn, memdisp_b12:$disp);
  let AsmString = "bld.b\t${imm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def BLD_Imm_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 1;
  let Inst{9} = 1;
  let Inst{8} = 1;
  let Inst{3} = 1;
  let Inst{2-0} = imm;
  let Inst{7-4} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn);
  let AsmString = "bld\t${imm}, ${rn}";
  let Predicates = [HasSH2A];
}

def BLDNOT_B_Imm_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{23} = 0;
  let Inst{19} = 1;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{22-20} = imm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn, memdisp_b12:$disp);
  let AsmString = "bldnot.b\t${imm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def BOR_B_Imm_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{23} = 0;
  let Inst{19} = 1;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 1;
  let Inst{22-20} = imm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn, memdisp_b12:$disp);
  let AsmString = "bor.b\t${imm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def BORNOT_B_Imm_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{23} = 0;
  let Inst{19} = 1;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 1;
  let Inst{22-20} = imm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn, memdisp_b12:$disp);
  let AsmString = "bornot.b\t${imm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def BSET_B_Imm_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{23} = 0;
  let Inst{19} = 1;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 1;
  let Inst{22-20} = imm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn, memdisp_b12:$disp);
  let AsmString = "bset.b\t${imm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def BSET_Imm_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 1;
  let Inst{9} = 1;
  let Inst{8} = 0;
  let Inst{3} = 1;
  let Inst{2-0} = imm;
  let Inst{7-4} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn);
  let AsmString = "bset\t${imm}, ${rn}";
  let Predicates = [HasSH2A];
}

def BST_B_Imm_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{23} = 0;
  let Inst{19} = 1;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{22-20} = imm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn, memdisp_b12:$disp);
  let AsmString = "bst.b\t${imm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def BST_Imm_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 1;
  let Inst{9} = 1;
  let Inst{8} = 1;
  let Inst{3} = 0;
  let Inst{2-0} = imm;
  let Inst{7-4} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn);
  let AsmString = "bst\t${imm}, ${rn}";
  let Predicates = [HasSH2A];
}

def BXOR_B_Imm_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<3> imm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{23} = 0;
  let Inst{19} = 1;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{22-20} = imm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn, memdisp_b12:$disp);
  let AsmString = "bxor.b\t${imm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def ADD_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "add\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def ADD_Imm_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7-0} = imm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm, GPR:$rn);
  let AsmString = "add\t${imm}, ${rn}";
  let Predicates = [HasSH1];
}

def ADDC_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "addc\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def ADDV_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "addv\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def CMP_EQ_Imm_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7-0} = imm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm);
  let AsmString = "cmp/eq\t${imm}, r0";
  let Predicates = [HasSH1];
}

def CMP_EQ_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "cmp/eq\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def CMP_HS_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "cmp/hs\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def CMP_GE_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "cmp/ge\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def CMP_HI_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "cmp/hi\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def CMP_GT_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "cmp/gt\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def CMP_PL_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "cmp/pl\t${rn}";
  let Predicates = [HasSH1];
}

def CMP_PZ_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "cmp/pz\t${rn}";
  let Predicates = [HasSH1];
}

def CMP_STR_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "cmp/str\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def CLIPS_B_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "clips.b\t${rn}";
  let Predicates = [HasSH2A];
}

def CLIPS_W_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "clips.w\t${rn}";
  let Predicates = [HasSH2A];
}

def CLIPU_B_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "clipu.b\t${rn}";
  let Predicates = [HasSH2A];
}

def CLIPU_W_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "clipu.w\t${rn}";
  let Predicates = [HasSH2A];
}

def DIV0S_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "div0s\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def DIV0U : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "div0u";
  let Predicates = [HasSH1];
}

def DIV1_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "div1\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def DIVS_R0Fixed_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "divs\tr0, ${rn}";
  let Predicates = [HasSH2A];
}

def DIVU_R0Fixed_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "divu\tr0, ${rn}";
  let Predicates = [HasSH2A];
}

def DMULS_L_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "dmuls.l\t${rm}, ${rn}";
  let Predicates = [HasSH2];
}

def DMULU_L_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "dmulu.l\t${rm}, ${rn}";
  let Predicates = [HasSH2];
}

def DT_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "dt\t${rn}";
  let Predicates = [HasSH2];
}

def EXTS_B_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "exts.b\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def EXTS_W_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "exts.w\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def EXTU_B_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "extu.b\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def EXTU_W_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "extu.w\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MAC_L_MemPostInc_MemPostInc : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mac.l\t@${rm}+, @${rn}+";
  let Predicates = [HasSH2];
}

def MAC_W_MemPostInc_MemPostInc : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mac.w\t@${rm}+, @${rn}+";
  let Predicates = [HasSH1];
}

def MUL_L_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mul.l\t${rm}, ${rn}";
  let Predicates = [HasSH2];
}

def MULR_R0Fixed_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "mulr\tr0, ${rn}";
  let Predicates = [HasSH2A];
}

def MULS_W_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "muls.w\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def MULU_W_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "mulu.w\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def NEG_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "neg\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def NEGC_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "negc\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def SUB_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "sub\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def SUBC_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "subc\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def SUBV_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "subv\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def AND_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "and\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def AND_Imm_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 1;
  let Inst{7-0} = imm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm);
  let AsmString = "and\t${imm}, r0";
  let Predicates = [HasSH1];
}

def AND_B_Imm_MemR0GBR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 1;
  let Inst{9} = 0;
  let Inst{8} = 1;
  let Inst{7-0} = imm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm);
  let AsmString = "and.b\t${imm}, @(r0,gbr)";
  let Predicates = [HasSH1];
}

def NOT_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "not\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def OR_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "or\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def OR_Imm_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 0;
  let Inst{9} = 1;
  let Inst{8} = 1;
  let Inst{7-0} = imm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm);
  let AsmString = "or\t${imm}, r0";
  let Predicates = [HasSH1];
}

def OR_B_Imm_MemR0GBR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 1;
  let Inst{9} = 1;
  let Inst{8} = 1;
  let Inst{7-0} = imm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm);
  let AsmString = "or.b\t${imm}, @(r0,gbr)";
  let Predicates = [HasSH1];
}

def TAS_B_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "tas.b\t@${rn}";
  let Predicates = [HasSH1];
}

def TST_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "tst\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def TST_Imm_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7-0} = imm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm);
  let AsmString = "tst\t${imm}, r0";
  let Predicates = [HasSH1];
}

def TST_B_Imm_MemR0GBR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 1;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7-0} = imm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm);
  let AsmString = "tst.b\t${imm}, @(r0,gbr)";
  let Predicates = [HasSH1];
}

def XOR_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "xor\t${rm}, ${rn}";
  let Predicates = [HasSH1];
}

def XOR_Imm_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 0;
  let Inst{9} = 1;
  let Inst{8} = 0;
  let Inst{7-0} = imm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm);
  let AsmString = "xor\t${imm}, r0";
  let Predicates = [HasSH1];
}

def XOR_B_Imm_MemR0GBR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 1;
  let Inst{9} = 1;
  let Inst{8} = 0;
  let Inst{7-0} = imm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm);
  let AsmString = "xor.b\t${imm}, @(r0,gbr)";
  let Predicates = [HasSH1];
}

def ROTCL_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "rotcl\t${rn}";
  let Predicates = [HasSH1];
}

def ROTCR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "rotcr\t${rn}";
  let Predicates = [HasSH1];
}

def ROTL_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "rotl\t${rn}";
  let Predicates = [HasSH1];
}

def ROTR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "rotr\t${rn}";
  let Predicates = [HasSH1];
}

def SHAD_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "shad\t${rm}, ${rn}";
  let Predicates = [HasSH3];
}

def SHAL_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "shal\t${rn}";
  let Predicates = [HasSH1];
}

def SHAR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "shar\t${rn}";
  let Predicates = [HasSH1];
}

def SHLD_GPR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, GPR:$rn);
  let AsmString = "shld\t${rm}, ${rn}";
  let Predicates = [HasSH3];
}

def SHLL_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "shll\t${rn}";
  let Predicates = [HasSH1];
}

def SHLL2_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "shll2\t${rn}";
  let Predicates = [HasSH1];
}

def SHLL8_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "shll8\t${rn}";
  let Predicates = [HasSH1];
}

def SHLL16_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "shll16\t${rn}";
  let Predicates = [HasSH1];
}

def SHLR_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "shlr\t${rn}";
  let Predicates = [HasSH1];
}

def SHLR2_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "shlr2\t${rn}";
  let Predicates = [HasSH1];
}

def SHLR8_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "shlr8\t${rn}";
  let Predicates = [HasSH1];
}

def SHLR16_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "shlr16\t${rn}";
  let Predicates = [HasSH1];
}

def BF_BranchDisp : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 0;
  let Inst{9} = 1;
  let Inst{8} = 1;
  let Inst{7-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins bdisp8:$disp);
  let AsmString = "bf\t${disp}";
  let Predicates = [HasSH1];
}

def BF_S_BranchDisp : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 1;
  let Inst{9} = 1;
  let Inst{8} = 1;
  let Inst{7-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins bdisp8:$disp);
  let AsmString = "bf/s\t${disp}";
  let Predicates = [HasSH2];
}

def BT_BranchDisp : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 1;
  let Inst{7-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins bdisp8:$disp);
  let AsmString = "bt\t${disp}";
  let Predicates = [HasSH1];
}

def BT_S_BranchDisp : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> disp;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 1;
  let Inst{10} = 1;
  let Inst{9} = 0;
  let Inst{8} = 1;
  let Inst{7-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins bdisp8:$disp);
  let AsmString = "bt/s\t${disp}";
  let Predicates = [HasSH2];
}

def BRA_BranchDisp : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<12> disp;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 0;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins bdisp12:$disp);
  let AsmString = "bra\t${disp}";
  let Predicates = [HasSH1];
}

def BRAF_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "braf\t${rm}";
  let Predicates = [HasSH2];
}

def BSR_BranchDisp : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<12> disp;
  let Inst{15} = 1;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins bdisp12:$disp);
  let AsmString = "bsr\t${disp}";
  let Predicates = [HasSH1];
}

def BSRF_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "bsrf\t${rm}";
  let Predicates = [HasSH2];
}

def JMP_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "jmp\t@${rm}";
  let Predicates = [HasSH1];
}

def JSR_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "jsr\t@${rm}";
  let Predicates = [HasSH1];
}

def JSR_N_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "jsr/n\t@${rm}";
  let Predicates = [HasSH2A];
}

def RTS : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "rts";
  let Predicates = [HasSH1];
}

def RTS_N : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "rts/n";
  let Predicates = [HasSH2A];
}

def RTV_N_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "rtv/n\t${rm}";
  let Predicates = [HasSH2A];
}

def CLRMAC : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "clrmac";
  let Predicates = [HasSH1];
}

def CLRS : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "clrs";
  let Predicates = [HasSH3];
}

def CLRT : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "clrt";
  let Predicates = [HasSH1];
}

def ICBI_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "icbi\t@${rn}";
  let Predicates = [HasSH4A];
}

def LDBANK_MemReg_R0Fixed : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldbank\t@${rm}, r0";
  let Predicates = [HasSH2A];
}

def LDC_GPR_FixedReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldc\t${rm}, sr";
  let Predicates = [HasSH1];
}

def LDC_L_MemPostInc_FixedReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldc.l\t@${rm}+, sr";
  let Predicates = [HasSH1];
}

def LDC_GPR_FixedReg_2 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldc\t${rm}, tbr";
  let Predicates = [HasSH2A];
}

def LDC_GPR_FixedReg_3 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldc\t${rm}, gbr";
  let Predicates = [HasSH1];
}

def LDC_L_MemPostInc_FixedReg_2 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldc.l\t@${rm}+, gbr";
  let Predicates = [HasSH1];
}

def LDC_GPR_FixedReg_4 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldc\t${rm}, vbr";
  let Predicates = [HasSH1];
}

def LDC_L_MemPostInc_FixedReg_3 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldc.l\t@${rm}+, vbr";
  let Predicates = [HasSH1];
}

def LDC_GPR_FixedReg_5 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldc\t${rm}, ssr";
  let Predicates = [HasSH3];
}

def LDC_L_MemPostInc_FixedReg_4 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldc.l\t@${rm}+, ssr";
  let Predicates = [HasSH3];
}

def LDC_GPR_FixedReg_6 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldc\t${rm}, spc";
  let Predicates = [HasSH3];
}

def LDC_L_MemPostInc_FixedReg_5 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "ldc.l\t@${rm}+, spc";
  let Predicates = [HasSH3];
}

def LDC_GPR_BankReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<3> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  let Inst{6-4} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, BankReg:$rn);
  let AsmString = "ldc\t${rm}, ${rn}";
  let Predicates = [HasSH3];
}

def LDC_L_MemPostInc_BankReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<3> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  let Inst{6-4} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, BankReg:$rn);
  let AsmString = "ldc.l\t@${rm}+, ${rn}";
  let Predicates = [HasSH3];
}

def LDS_GPR_FixedReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "lds\t${rm}, mach";
  let Predicates = [HasSH1];
}

def LDS_L_MemPostInc_FixedReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "lds.l\t@${rm}+, mach";
  let Predicates = [HasSH1];
}

def LDS_GPR_FixedReg_2 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "lds\t${rm}, macl";
  let Predicates = [HasSH1];
}

def LDS_L_MemPostInc_FixedReg_2 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "lds.l\t@${rm}+, macl";
  let Predicates = [HasSH1];
}

def LDS_GPR_FixedReg_3 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "lds\t${rm}, pr";
  let Predicates = [HasSH1];
}

def LDS_L_MemPostInc_FixedReg_3 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "lds.l\t@${rm}+, pr";
  let Predicates = [HasSH1];
}

def MOVCA_L_R0Fixed_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "movca.l\tr0, @${rn}";
  let Predicates = [HasSH4];
}

def NOP : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "nop";
  let Predicates = [HasSH1];
}

def OCBI_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "ocbi\t@${rn}";
  let Predicates = [HasSH4];
}

def OCBP_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "ocbp\t@${rn}";
  let Predicates = [HasSH4];
}

def OCBWB_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "ocbwb\t@${rn}";
  let Predicates = [HasSH4];
}

def PREF_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "pref\t@${rn}";
  let Predicates = [HasSH3];
}

def PREFI_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "prefi\t@${rn}";
  let Predicates = [HasSH4A];
}

def RESBANK : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "resbank";
  let Predicates = [HasSH2A];
}

def RTE : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "rte";
  let Predicates = [HasSH1];
}

def SETS : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "sets";
  let Predicates = [HasSH3];
}

def SETT : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "sett";
  let Predicates = [HasSH1];
}

def SLEEP : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "sleep";
  let Predicates = [HasSH1];
}

def STBANK_R0Fixed_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "stbank\tr0, @${rn}";
  let Predicates = [HasSH2A];
}

def STC_FixedReg_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "stc\tsr, ${rn}";
  let Predicates = [HasSH1];
}

def STC_L_FixedReg_MemPreDec : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rn);
  let AsmString = "stc.l\tsr, ${rn}";
  let Predicates = [HasSH1];
}

def STC_FixedReg_GPR_2 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "stc\ttbr, ${rn}";
  let Predicates = [HasSH2A];
}

def STC_FixedReg_GPR_3 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "stc\tgbr, ${rn}";
  let Predicates = [HasSH1];
}

def STC_L_FixedReg_MemPreDec_2 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rn);
  let AsmString = "stc.l\tgbr, ${rn}";
  let Predicates = [HasSH1];
}

def STC_FixedReg_GPR_4 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "stc\tvbr, ${rn}";
  let Predicates = [HasSH1];
}

def STC_L_FixedReg_MemPreDec_3 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rn);
  let AsmString = "stc.l\tvbr, ${rn}";
  let Predicates = [HasSH1];
}

def STC_FixedReg_GPR_5 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "stc\tssr, ${rn}";
  let Predicates = [HasSH3];
}

def STC_L_FixedReg_MemPreDec_4 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rn);
  let AsmString = "stc.l\tssr, ${rn}";
  let Predicates = [HasSH3];
}

def STC_FixedReg_GPR_6 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "stc\tspc, ${rn}";
  let Predicates = [HasSH3];
}

def STC_L_FixedReg_MemPreDec_5 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rn);
  let AsmString = "stc.l\tspc, ${rn}";
  let Predicates = [HasSH3];
}

def STC_BankReg_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{6-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins BankReg:$rm, GPR:$rn);
  let AsmString = "stc\t${rm}, ${rn}";
  let Predicates = [HasSH3];
}

def STC_L_BankReg_MemPreDec : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{6-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins BankReg:$rm, MemDec:$rn);
  let AsmString = "stc.l\t${rm}, ${rn}";
  let Predicates = [HasSH3];
}

def STS_FixedReg_GPR : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "sts\tmach, ${rn}";
  let Predicates = [HasSH1];
}

def STS_L_FixedReg_MemPreDec : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rn);
  let AsmString = "sts.l\tmach, ${rn}";
  let Predicates = [HasSH1];
}

def STS_FixedReg_GPR_2 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "sts\tmacl, ${rn}";
  let Predicates = [HasSH1];
}

def STS_L_FixedReg_MemPreDec_2 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rn);
  let AsmString = "sts.l\tmacl, ${rn}";
  let Predicates = [HasSH1];
}

def STS_FixedReg_GPR_3 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "sts\tpr, ${rn}";
  let Predicates = [HasSH1];
}

def STS_L_FixedReg_MemPreDec_3 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rn);
  let AsmString = "sts.l\tpr, ${rn}";
  let Predicates = [HasSH1];
}

def SYNCO : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "synco";
  let Predicates = [HasSH4A];
}

def TRAPA_Imm : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<8> imm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 1;
  let Inst{8} = 1;
  let Inst{7-0} = imm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins SHImm:$imm);
  let AsmString = "trapa\t${imm}";
  let Predicates = [HasSH1];
}

def BGND : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 0;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "bgnd";
  let Predicates = [HasJ2];
}

def FMOV_FReg_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm, FReg:$rn);
  let AsmString = "fmov\t${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FMOV_S_MemReg_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, FReg:$rn);
  let AsmString = "fmov.s\t@${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FMOV_S_FReg_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm, GPR:$rn);
  let AsmString = "fmov.s\t${rm}, @${rn}";
  let Predicates = [HasSH2E];
}

def FMOV_S_MemPostInc_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, FReg:$rn);
  let AsmString = "fmov.s\t@${rm}+, ${rn}";
  let Predicates = [HasSH2E];
}

def FMOV_S_FReg_MemPreDec : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm, MemDec:$rn);
  let AsmString = "fmov.s\t${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FMOV_S_MemR0_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemR0Idx:$rm, FReg:$rn);
  let AsmString = "fmov.s\t${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FMOV_S_FReg_MemR0 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm, MemR0Idx:$rn);
  let AsmString = "fmov.s\t${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FMOV_S_MemDisp_FReg : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<12> disp;
  bits<4> rn;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{23-20} = rm;
  let Inst{11-0} = disp;
  let Inst{27-24} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, memdisp_l12:$disp, FReg:$rn);
  let AsmString = "fmov.s\t@(${disp}, ${rm}), ${rn}";
  let Predicates = [HasSH2A];
}

def FMOV_S_FReg_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{23-20} = rm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm, GPR:$rn, memdisp_l12:$disp);
  let AsmString = "fmov.s\t${rm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def FMOV_DReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-5} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, DReg:$rn);
  let AsmString = "fmov\t${rm}, ${rn}";
  let Predicates = [HasSH2A];
}

def FMOV_DReg_XReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-5} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, XReg:$rn);
  let AsmString = "fmov\t${rm}, ${rn}";
  let Predicates = [HasSH4];
}

def FMOV_XReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-5} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins XReg:$rm, DReg:$rn);
  let AsmString = "fmov\t${rm}, ${rn}";
  let Predicates = [HasSH4];
}

def FMOV_XReg_XReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-5} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins XReg:$rm, XReg:$rn);
  let AsmString = "fmov\t${rm}, ${rn}";
  let Predicates = [HasSH4];
}

def FMOV_D_MemReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, DReg:$rn);
  let AsmString = "fmov.d\t@${rm}, ${rn}";
  let Predicates = [HasSH2A];
}

def FMOV_D_MemReg_XReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, XReg:$rn);
  let AsmString = "fmov.d\t@${rm}, ${rn}";
  let Predicates = [HasSH4];
}

def FMOV_D_DReg_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-5} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, GPR:$rn);
  let AsmString = "fmov.d\t${rm}, @${rn}";
  let Predicates = [HasSH2A];
}

def FMOV_D_XReg_MemReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-5} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins XReg:$rm, GPR:$rn);
  let AsmString = "fmov.d\t${rm}, @${rn}";
  let Predicates = [HasSH4];
}

def FMOV_D_MemPostInc_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, DReg:$rn);
  let AsmString = "fmov.d\t@${rm}+, ${rn}";
  let Predicates = [HasSH2A];
}

def FMOV_D_MemPostInc_XReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, XReg:$rn);
  let AsmString = "fmov.d\t@${rm}+, ${rn}";
  let Predicates = [HasSH4];
}

def FMOV_D_DReg_MemPreDec : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-5} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, MemDec:$rn);
  let AsmString = "fmov.d\t${rm}, ${rn}";
  let Predicates = [HasSH2A];
}

def FMOV_D_XReg_MemPreDec : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-5} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins XReg:$rm, MemDec:$rn);
  let AsmString = "fmov.d\t${rm}, ${rn}";
  let Predicates = [HasSH4];
}

def FMOV_D_MemR0_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemR0Idx:$rm, DReg:$rn);
  let AsmString = "fmov.d\t${rm}, ${rn}";
  let Predicates = [HasSH2A];
}

def FMOV_D_MemR0_XReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemR0Idx:$rm, XReg:$rn);
  let AsmString = "fmov.d\t${rm}, ${rn}";
  let Predicates = [HasSH4];
}

def FMOV_D_DReg_MemR0 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-5} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, MemR0Idx:$rn);
  let AsmString = "fmov.d\t${rm}, ${rn}";
  let Predicates = [HasSH2A];
}

def FMOV_D_XReg_MemR0 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-5} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins XReg:$rm, MemR0Idx:$rn);
  let AsmString = "fmov.d\t${rm}, ${rn}";
  let Predicates = [HasSH4];
}

def FMOV_D_MemDisp_DReg : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<12> disp;
  bits<3> rn;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{24} = 0;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{23-20} = rm;
  let Inst{11-0} = disp;
  let Inst{27-25} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm, memdisp_d12:$disp, DReg:$rn);
  let AsmString = "fmov.d\t@(${disp}, ${rm}), ${rn}";
  let Predicates = [HasSH2A];
}

def FMOV_D_DReg_MemDisp : Instruction {
  let Namespace = "SH";
  bits<32> Inst;
  let Size = 4;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<4> rn;
  bits<12> disp;
  let Inst{31} = 0;
  let Inst{30} = 0;
  let Inst{29} = 1;
  let Inst{28} = 1;
  let Inst{20} = 0;
  let Inst{19} = 0;
  let Inst{18} = 0;
  let Inst{17} = 0;
  let Inst{16} = 1;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{23-21} = rm;
  let Inst{27-24} = rn;
  let Inst{11-0} = disp;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, GPR:$rn, memdisp_d12:$disp);
  let AsmString = "fmov.d\t${rm}, @(${disp}, ${rn})";
  let Predicates = [HasSH2A];
}

def FLDI0_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rn);
  let AsmString = "fldi0\t${rn}";
  let Predicates = [HasSH2E];
}

def FLDI1_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rn);
  let AsmString = "fldi1\t${rn}";
  let Predicates = [HasSH2E];
}

def FLDS_FReg_FixedReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm);
  let AsmString = "flds\t${rm}, fpul";
  let Predicates = [HasSH2E];
}

def FSTS_FixedReg_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rn);
  let AsmString = "fsts\tfpul, ${rn}";
  let Predicates = [HasSH2E];
}

def FABS_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rn);
  let AsmString = "fabs\t${rn}";
  let Predicates = [HasSH2E];
}

def FNEG_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rn);
  let AsmString = "fneg\t${rn}";
  let Predicates = [HasSH2E];
}

def FADD_FReg_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm, FReg:$rn);
  let AsmString = "fadd\t${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FSUB_FReg_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm, FReg:$rn);
  let AsmString = "fsub\t${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FMUL_FReg_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm, FReg:$rn);
  let AsmString = "fmul\t${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FMAC_FR0Fixed_FReg_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let DecoderMethod = "decodeFmacFR0";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FR0Fixed:$fr0, FReg:$rm, FReg:$rn);
  let AsmString = "fmac\t${fr0}, ${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FDIV_FReg_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm, FReg:$rn);
  let AsmString = "fdiv\t${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FSQRT_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rn);
  let AsmString = "fsqrt\t${rn}";
  let Predicates = [HasSH3E];
}

def FCMP_EQ_FReg_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm, FReg:$rn);
  let AsmString = "fcmp/eq\t${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FCMP_GT_FReg_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-4} = rm;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm, FReg:$rn);
  let AsmString = "fcmp/gt\t${rm}, ${rn}";
  let Predicates = [HasSH2E];
}

def FLOAT_FixedReg_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rn);
  let AsmString = "float\tfpul, ${rn}";
  let Predicates = [HasSH2E];
}

def FTRC_FReg_FixedReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rm);
  let AsmString = "ftrc\t${rm}, fpul";
  let Predicates = [HasSH2E];
}

def FIPR_FVReg_FVReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<2> rm;
  bits<2> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{9-8} = rm;
  let Inst{11-10} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FVReg:$rm, FVReg:$rn);
  let AsmString = "fipr\t${rm}, ${rn}";
  let Predicates = [HasSH4];
}

def FTRV_FixedReg_FVReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<2> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{9} = 0;
  let Inst{8} = 1;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-10} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FVReg:$rn);
  let AsmString = "ftrv\txmtrx, ${rn}";
  let Predicates = [HasSH4];
}

def FSRRA_FReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins FReg:$rn);
  let AsmString = "fsrra\t${rn}";
  let Predicates = [HasSH4A];
}

def FSCA_FixedReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rn);
  let AsmString = "fsca\tfpul, ${rn}";
  let Predicates = [HasSH4A];
}

def FABS_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rn);
  let AsmString = "fabs\t${rn}";
  let Predicates = [HasSH2A];
}

def FNEG_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rn);
  let AsmString = "fneg\t${rn}";
  let Predicates = [HasSH2A];
}

def FADD_DReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-5} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, DReg:$rn);
  let AsmString = "fadd\t${rm}, ${rn}";
  let Predicates = [HasSH2A];
}

def FSUB_DReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-5} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, DReg:$rn);
  let AsmString = "fsub\t${rm}, ${rn}";
  let Predicates = [HasSH2A];
}

def FMUL_DReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{7-5} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, DReg:$rn);
  let AsmString = "fmul\t${rm}, ${rn}";
  let Predicates = [HasSH2A];
}

def FDIV_DReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 1;
  let Inst{7-5} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, DReg:$rn);
  let AsmString = "fdiv\t${rm}, ${rn}";
  let Predicates = [HasSH2A];
}

def FSQRT_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rn);
  let AsmString = "fsqrt\t${rn}";
  let Predicates = [HasSH2A];
}

def FCMP_EQ_DReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 0;
  let Inst{7-5} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, DReg:$rn);
  let AsmString = "fcmp/eq\t${rm}, ${rn}";
  let Predicates = [HasSH2A];
}

def FCMP_GT_DReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{7-5} = rm;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm, DReg:$rn);
  let AsmString = "fcmp/gt\t${rm}, ${rn}";
  let Predicates = [HasSH2A];
}

def FLOAT_FixedReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rn);
  let AsmString = "float\tfpul, ${rn}";
  let Predicates = [HasSH2A];
}

def FTRC_DReg_FixedReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{7} = 0;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-9} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm);
  let AsmString = "ftrc\t${rm}, fpul";
  let Predicates = [HasSH2A];
}

def FCNVDS_DReg_FixedReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rm;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-9} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rm);
  let AsmString = "fcnvds\t${rm}, fpul";
  let Predicates = [HasSH2A];
}

def FCNVSD_FixedReg_DReg : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<3> rn;
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{8} = 0;
  let Inst{7} = 1;
  let Inst{6} = 0;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  let Inst{11-9} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins DReg:$rn);
  let AsmString = "fcnvsd\tfpul, ${rn}";
  let Predicates = [HasSH2A];
}

def LDS_GPR_FixedReg_4 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "lds\t${rm}, fpscr";
  let Predicates = [HasSH2E];
}

def STS_FixedReg_GPR_4 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "sts\tfpscr, ${rn}";
  let Predicates = [HasSH2E];
}

def LDS_L_MemPostInc_FixedReg_4 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "lds.l\t@${rm}+, fpscr";
  let Predicates = [HasSH2E];
}

def STS_L_FixedReg_MemPreDec_4 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 0;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rn);
  let AsmString = "sts.l\tfpscr, ${rn}";
  let Predicates = [HasSH2E];
}

def LDS_GPR_FixedReg_5 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "lds\t${rm}, fpul";
  let Predicates = [HasSH2E];
}

def STS_FixedReg_GPR_5 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 0;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rn);
  let AsmString = "sts\tfpul, ${rn}";
  let Predicates = [HasSH2E];
}

def LDS_L_MemPostInc_FixedReg_5 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rm;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 1;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rm;
  dag OutOperandList = (outs);
  dag InOperandList = (ins GPR:$rm);
  let AsmString = "lds.l\t@${rm}+, fpul";
  let Predicates = [HasSH2E];
}

def STS_L_FixedReg_MemPreDec_5 : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  bits<4> rn;
  let Inst{15} = 0;
  let Inst{14} = 1;
  let Inst{13} = 0;
  let Inst{12} = 0;
  let Inst{7} = 0;
  let Inst{6} = 1;
  let Inst{5} = 0;
  let Inst{4} = 1;
  let Inst{3} = 0;
  let Inst{2} = 0;
  let Inst{1} = 1;
  let Inst{0} = 0;
  let Inst{11-8} = rn;
  dag OutOperandList = (outs);
  dag InOperandList = (ins MemDec:$rn);
  let AsmString = "sts.l\tfpul, ${rn}";
  let Predicates = [HasSH2E];
}

def FRCHG : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{11} = 1;
  let Inst{10} = 0;
  let Inst{9} = 1;
  let Inst{8} = 1;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "frchg";
  let Predicates = [HasSH4];
}

def FSCHG : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{11} = 0;
  let Inst{10} = 0;
  let Inst{9} = 1;
  let Inst{8} = 1;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "fschg";
  let Predicates = [HasSH2A];
}

def FPCHG : Instruction {
  let Namespace = "SH";
  bits<16> Inst;
  let Size = 2;
  let DecoderNamespace = "SH";
  let Inst{15} = 1;
  let Inst{14} = 1;
  let Inst{13} = 1;
  let Inst{12} = 1;
  let Inst{11} = 0;
  let Inst{10} = 1;
  let Inst{9} = 1;
  let Inst{8} = 1;
  let Inst{7} = 1;
  let Inst{6} = 1;
  let Inst{5} = 1;
  let Inst{4} = 1;
  let Inst{3} = 1;
  let Inst{2} = 1;
  let Inst{1} = 0;
  let Inst{0} = 1;
  dag OutOperandList = (outs);
  dag InOperandList = (ins );
  let AsmString = "fpchg";
  let Predicates = [HasSH4A];
}

