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
  let AsmString = "mov\t$rm, $rn";
  let Predicates = [HasSH1];
}
