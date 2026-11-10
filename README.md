# 32-Bit Single-Cycle RISC-V CPU Core

A custom synthesizable 32-bit RISC-V processor core written in Verilog HDL and verified using Icarus Verilog (`iverilog`) and GTKWave.

## **Architecture Overview**

* **Instruction Set Architecture (ISA):** RISC-V (RV32I subset - R-Type, I-Type)
* **Execution Pipeline:** Single-cycle datapath with autonomous Program Counter
* **Core Components:**
* **ALU (32-bit):** Supports ADD, SUB, AND, OR, XOR, SLT operations with Zero Flag generation
* **Register File:** 32x32-bit dual-read / single-write port register array with hardwired `x0` zero protection
* **Control Unit & Decoder:** Instruction decoder mapping `opcode`, `funct3`, and `funct7` bitfields to control buses
* **Program Counter & ROM:** Autonomous fetch-decode-execute instruction memory pipeline

## **Repository Structure**

```text
├── alu32.v              # 32-Bit Arithmetic Logic Unit
├── regfile32.v          # 32-Bit x 32 Dual-Read Register File
├── control_unit.v       # RISC-V Control Unit & Decoder
├── instruction_mem.v    # Pre-loaded Instruction ROM Memory
├── datapath.v           # Integrated Top-Level CPU Core
└── tb_top_core.v        # System Verification Testbench

```

## **Simulation & Verification**

1. **Compile the RTL and Testbench:**
```bash
iverilog -o top_core_tb.out datapath.v instruction_mem.v alu32.v regfile32.v control_unit.v tb_top_core.v

```

2. **Run Simulation:**
```bash
vvp top_core_tb.out

```

3. **Inspect Waveforms:**
```bash
gtkwave top_core.vcd

```

---

![alt text](<Screenshot1.png>)
![alt text](<Screenshot2.png>)

Author: Nathan Papa