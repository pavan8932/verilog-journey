// =============================================================================
// File: tb_mux4_to_1.v
// Module: tb_mux4_to_1 (Testbench for 4-to-1 Multiplexer)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 5 (Gate-Level Modeling)
// =============================================================================
`timescale 1ns / 1ps

module tb_mux4_to_1;

    reg in0, in1, in2, in3;
    reg s1, s0;
    wire out;

    // Instantiate 4-to-1 MUX
    mux4_to_1 dut (
        .in0 (in0),
        .in1 (in1),
        .in2 (in2),
        .in3 (in3),
        .s1  (s1),
        .s0  (s0),
        .out (out)
    );

    // MANDATORY GTKWave dump
    initial begin
        $dumpfile("mux4_to_1.vcd");
        $dumpvars(0, tb_mux4_to_1);
    end

    // Stimulus block testing all 4 channels
    initial begin
        $display("-----------------------------------------------------------------");
        $display("Time\ts1 s0\t|\tin0 in1 in2 in3\t|\tout\tSelected Channel");
        $display("-----------------------------------------------------------------");
        $monitor("%0dns\t%b  %b\t|\t %b   %b   %b   %b\t|\t %b",
                 $time, s1, s0, in0, in1, in2, in3, out);

        // Set distinctive values for inputs: in0=1, in1=0, in2=1, in3=0
        in0 = 1'b1; in1 = 1'b0; in2 = 1'b1; in3 = 1'b0;

        // Select Channel 0 (s1=0, s0=0) -> out should be in0 = 1
        s1 = 1'b0; s0 = 1'b0;
        #15;

        // Select Channel 1 (s1=0, s0=1) -> out should be in1 = 0
        s1 = 1'b0; s0 = 1'b1;
        #15;

        // Select Channel 2 (s1=1, s0=0) -> out should be in2 = 1
        s1 = 1'b1; s0 = 1'b0;
        #15;

        // Select Channel 3 (s1=1, s0=1) -> out should be in3 = 0
        s1 = 1'b1; s0 = 1'b1;
        #15;

        // Dynamic change on selected channel 3: change in3 from 0 to 1
        in3 = 1'b1;
        #15;

        $display("-----------------------------------------------------------------");
        $display("Simulation Finished! Check mux4_to_1.vcd in GTKWave.");
        $display("Observe the propagation delay between input switch and output switch!");
        $display("-----------------------------------------------------------------");
        $finish;
    end

endmodule
