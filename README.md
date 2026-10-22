# ⚡ Verilog HDL Mastery & Hardware Design Portfolio
> Following ***Verilog HDL: A Guide to Digital Design and Synthesis*** by Samir Palnitkar.

This repository tracks my journey from digital design fundamentals to advanced synthesizable RTL architecture, self-checking testbench design, and full-scale hardware projects.

📖 **[Read the Master Project Memory & Daily Progress Log](./project_memory.md)**

---

## 📂 Repository Structure

- [`labs/`](./labs/) — Systematic implementations and end-of-chapter exercises from Palnitkar:
  - [`ch02_hierarchical/`](./labs/ch02_hierarchical/): Hierarchical 4-bit Ripple Carry Counter with D-FF & T-FF modules.
- [`projects/`](./projects/) — Industry-grade milestone and capstone hardware projects:
  - **Milestone 1**: Parameterized Synchronous FIFO & 32-bit ALU.
  - **Milestone 2**: Full-Duplex Configurable UART with 16x Oversampling & FIFOs.
  - **Capstone**: 5-Stage Pipelined RISC-V (RV32I) Processor / AXI4-Lite SPI-I2C Subsystem.
- [`project_memory.md`](./project_memory.md) — Comprehensive execution plan, roadmap tracker, and daily journal.

---

## 🛠️ Toolchain & Verification Standard
- **HDL**: Verilog (IEEE 1364-2001)
- **Simulator**: [Icarus Verilog (`iverilog`)](https://steveicarus.github.io/iverilog/)
- **Waveform Viewer**: [GTKWave](http://gtkwave.sourceforge.net/)
- **Editor**: Visual Studio Code with *Verilog-HDL/SystemVerilog* extension

### 📐 Mandatory Golden Rules for Every Lab:
1. **Self-Checking Testbench**: Every design file `design.v` must be paired with `tb_design.v`.
2. **GTKWave Waveform Dump**: Every testbench must include `$dumpfile` and `$dumpvars` to generate `.vcd` trace files.
3. **Visual Verification**: Every lab includes waveform analysis in GTKWave to inspect clock edges, signal transitions, and timing.
