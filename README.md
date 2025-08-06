# Low Level Hardware Digital Systems I

## Project Title: RISC-V Soft Processor & ALU-based Calculator

This project implements a 5-stage RISC-V processor datapath in Verilog, along with supporting modules such as an ALU, calculator, register file, and top-level controller. It follows a bottom-up design approach through five exercises, each building on the previous, with full testbenches provided.

---

## 📁 File Structure

| File | Description |
|------|-------------|
| `alu.sv` | Implements a 32-bit ALU capable of arithmetic, logical, and shift operations based on a 4-bit `alu_op`. |
| `calc.sv` | Calculator using the ALU and a 16-bit accumulator with buttons and switches as input and output through LEDs. |
| `calc_enc.sv` | Encodes control logic from button inputs into `alu_op` signals used in `calc.sv`. |
| `calc_tb.sv` | Testbench for the calculator module, simulating ALU operations and verifying accumulator behavior. |
| `regfile.sv` | Implements a 32×32-bit register file with synchronous write and asynchronous read capabilities. |
| `datapath.sv` | Implements the datapath of a simplified RISC-V processor including the PC, ALU, register file, and control multiplexers. |
| `ram.v` | Data memory module supporting read and write operations. |
| `rom.v` | Instruction memory (ROM) module initialized with a RISC-V program. |
| `top_proc.sv` | Top-level processor module with 5-stage FSM control (IF, ID, EX, MEM, WB), coordinating all subsystems. |

---

## 🧪 Testbenches

- `calc_tb.sv`: Validates ALU and calculator logic based on predefined sequences.
- `top_proc_tb.v`: To validate full processor execution across all instruction types.

---

## 📄 Report

The submitted report includes:
- Block diagrams for FSM and datapath
- Waveform screenshots for calculator and full processor simulations
- Explanation of each module's design
- Instruction decoding from the ROM
- AEM and author identification

---

## 🧠 Topics Covered

- Structural & Behavioral Verilog
- ALU design & logic operations
- FSM-based processor control
- RISC-V instruction decoding
- Datapath design
- Register file architecture
- Testbench development & verification

---
