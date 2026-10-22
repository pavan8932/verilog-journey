// =============================================================================
// File: ripple_carry_counter.v
// Module: ripple_carry_counter (4-bit Asynchronous Ripple Carry Counter)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 2 (Section 2.2)
// Description: Cascades 4 T-Flip-Flops. The output of each stage acts as
//              the clock for the next stage (asynchronous ripple clocking).
// =============================================================================
`timescale 1ns / 1ps

module ripple_carry_counter (
    output [3:0] q,
    input        clk,
    input        reset
);

    // 4 instances of the T-flip-flop
    // Each stage's output q[n] clocks the next stage q[n+1]
    tff tff0 (.q(q[0]), .clk(clk),  .reset(reset));
    tff tff1 (.q(q[1]), .clk(q[0]), .reset(reset));
    tff tff2 (.q(q[2]), .clk(q[1]), .reset(reset));
    tff tff3 (.q(q[3]), .clk(q[2]), .reset(reset));

endmodule
