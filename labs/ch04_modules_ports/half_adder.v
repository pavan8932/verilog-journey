// =============================================================================
// File: half_adder.v
// Module: half_adder (1-bit Half Adder Leaf Cell)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 4 (Modules and Ports)
// =============================================================================
`timescale 1ns / 1ps

module half_adder (
    input  wire a,
    input  wire b,
    output wire sum,
    output wire cout
);

    assign sum  = a ^ b;
    assign cout = a & b;

endmodule
