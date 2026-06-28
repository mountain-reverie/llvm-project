//===-- SHRegisterInfo.td - SH register file ---------------*- tablegen -*-===//

class SHReg<bits<4> enc, string n> : Register<n> {
  let HWEncoding{3-0} = enc;
  let Namespace = "SH";
}

foreach i = 0-15 in {
  def R#i : SHReg<i, "r"#i>;
}

def GPR : RegisterClass<"SH", [i32], 32, (sequence "R%u", 0, 15)>;
