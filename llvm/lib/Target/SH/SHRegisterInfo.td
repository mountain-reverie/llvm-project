//===-- SHRegisterInfo.td - SH register file ---------------*- tablegen -*-===//

class SHReg<bits<4> enc, string n> : Register<n> {
  let HWEncoding{3-0} = enc;
  let Namespace = "SH";
}

foreach i = 0-15 in {
  def R#i : SHReg<i, "r"#i>;
}

def GPR : RegisterClass<"SH", [i32], 32, (sequence "R%u", 0, 15)>;

class SHBankReg<bits<3> enc, string n> : Register<n> {
  let HWEncoding{2-0} = enc;
  let Namespace = "SH";
}

foreach i = 0-7 in {
  def R#i#_BANK : SHBankReg<i, "r"#i#"_bank">;
}

def BankReg : RegisterClass<"SH", [i32], 32, (sequence "R%u_BANK", 0, 7)>;

foreach i = 0-15 in {
  def FR#i : SHReg<i, "fr"#i>;
}
def FReg : RegisterClass<"SH", [f32], 32, (sequence "FR%u", 0, 15)>;

def FPUL  : SHReg<0, "fpul">;
def FPSCR : SHReg<0, "fpscr">;
