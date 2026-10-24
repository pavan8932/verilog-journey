// =============================================================================
// File: adder4.v
// Module: adder4 (4-bit Ripple Carry Adder Top Module)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 4 (Modules and Ports)
// Topic: Cascading sub-modules with internal carry chain
// =============================================================================
`timescale 1ns / 1ps

module adder4 (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       cin,
    output wire [3:0] sum,
    output wire       cout
);

    // Internal carry wires connecting the 4 full adder stages
    wire c1, c2, c3;

    // 4 stages of full adders connected by name
    full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c1));
    full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c1),  .sum(sum[1]), .cout(c2));
    full_adder fa2 (.a(a[2]), .b(b[2]), .cin(c2),  .sum(sum[2]), .cout(c3));
    full_adder fa3 (.a(a[3]), .b(b[3]), .cin(c3),  .sum(sum[3]), .cout(cout));

endmodule
