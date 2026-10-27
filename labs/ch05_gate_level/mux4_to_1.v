// =============================================================================
// File: mux4_to_1.v
// Module: mux4_to_1 (4-to-1 Multiplexer using Gate Primitives)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 5 (Gate-Level Modeling)
// Topic: Gate primitives with propagation delays #(rise, fall)
// =============================================================================
`timescale 1ns / 1ps

module mux4_to_1 (
    input  wire in0,
    input  wire in1,
    input  wire in2,
    input  wire in3,
    input  wire s1,
    input  wire s0,
    output wire out
);

    // Internal connection wires
    wire s1_n, s0_n;
    wire y0, y1, y2, y3;

    // Invert select lines with 1ns propagation delay
    not #1 n1 (s1_n, s1);
    not #1 n0 (s0_n, s0);

    // 3-input AND gates with Rise delay = 2ns, Fall delay = 3ns
    and #(2, 3) a0 (y0, in0, s1_n, s0_n);
    and #(2, 3) a1 (y1, in1, s1_n, s0);
    and #(2, 3) a2 (y2, in2, s1,   s0_n);
    and #(2, 3) a3 (y3, in3, s1,   s0);

    // 4-input OR gate with Rise delay = 2ns, Fall delay = 3ns
    or #(2, 3) o1 (out, y0, y1, y2, y3);

endmodule
