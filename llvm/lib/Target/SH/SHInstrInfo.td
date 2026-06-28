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
  let isAsmParserOnly = 1;
  let DecoderNamespace = "SH";
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
  let isAsmParserOnly = 1;
  let DecoderNamespace = "SH";
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
  let isAsmParserOnly = 1;
  let DecoderNamespace = "SH";
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
  let isAsmParserOnly = 1;
  let DecoderNamespace = "SH";
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
  let isAsmParserOnly = 1;
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

