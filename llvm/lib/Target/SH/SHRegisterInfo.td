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

foreach i = [0,2,4,6,8,10,12,14] in {
  def DR#i : SHReg<!srl(i,1), "dr"#i>;
  def XD#i : SHReg<!srl(i,1), "xd"#i>;
}
def DReg : RegisterClass<"SH", [f64], 64, (add DR0,DR2,DR4,DR6,DR8,DR10,DR12,DR14)>;
def XReg : RegisterClass<"SH", [f64], 64, (add XD0,XD2,XD4,XD6,XD8,XD10,XD12,XD14)>;

foreach i = [0,4,8,12] in {
  def FV#i : SHReg<!srl(i,2), "fv"#i>;
}
def FVReg : RegisterClass<"SH", [v4f32], 128, (add FV0,FV4,FV8,FV12)>;

def XMTRX : SHReg<0, "xmtrx">;
