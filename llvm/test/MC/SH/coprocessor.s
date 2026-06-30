# RUN: llvm-mc -triple=sh -show-encoding %s | FileCheck %s

# CP0 load/store (J-core coprocessor 0)
clds cp0_r0, CP0_COM
# CHECK: clds cp0_r0, cp0_com {{.*}}encoding: [0x40,0x89]
clds cp0_r7, CP0_COM
# CHECK: clds cp0_r7, cp0_com {{.*}}encoding: [0x47,0x89]
clds cp0_r15, CP0_COM
# CHECK: clds cp0_r15, cp0_com {{.*}}encoding: [0x4f,0x89]
csts CP0_COM, cp0_r0
# CHECK: csts cp0_com, cp0_r0 {{.*}}encoding: [0x40,0xc9]
csts CP0_COM, cp0_r7
# CHECK: csts cp0_com, cp0_r7 {{.*}}encoding: [0x47,0xc9]
csts CP0_COM, cp0_r15
# CHECK: csts cp0_com, cp0_r15 {{.*}}encoding: [0x4f,0xc9]

# GP register <-> CP0 transfer
lds r0, CP0_COM
# CHECK: lds r0, cp0_com {{.*}}encoding: [0x40,0x88]
lds r7, CP0_COM
# CHECK: lds r7, cp0_com {{.*}}encoding: [0x47,0x88]
lds r15, CP0_COM
# CHECK: lds r15, cp0_com {{.*}}encoding: [0x4f,0x88]
sts CP0_COM, r0
# CHECK: sts cp0_com, r0 {{.*}}encoding: [0x40,0xc8]
sts CP0_COM, r7
# CHECK: sts cp0_com, r7 {{.*}}encoding: [0x47,0xc8]
sts CP0_COM, r15
# CHECK: sts cp0_com, r15 {{.*}}encoding: [0x4f,0xc8]

# CPI (coprocessor interface) transfer — isAsmParserOnly aliases for FPUL
lds r0, CPI_COM
# CHECK: lds r0, cpi_com {{.*}}encoding: [0x40,0x5a]
lds r5, CPI_COM
# CHECK: lds r5, cpi_com {{.*}}encoding: [0x45,0x5a]
lds r15, CPI_COM
# CHECK: lds r15, cpi_com {{.*}}encoding: [0x4f,0x5a]
sts CPI_COM, r0
# CHECK: sts cpi_com, r0 {{.*}}encoding: [0x00,0x5a]
sts CPI_COM, r3
# CHECK: sts cpi_com, r3 {{.*}}encoding: [0x03,0x5a]
sts CPI_COM, r15
# CHECK: sts cpi_com, r15 {{.*}}encoding: [0x0f,0x5a]
