// =============================================================================
// File: full_adder.v
// Module: full_adder (1-bit Full Adder built from Half Adders)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 4 (Modules and Ports)
// Topic: Port connection by name (.port(signal))
// =============================================================================
`timescale 1ns / 1ps

module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);

    wire s1, c1, c2;

    // Instantiate two half adders using connection by name: .port(signal)
    half_adder ha1 (
        .a    (a),
        .b    (b),
        .sum  (s1),
        .cout (c1)
    );

    half_adder ha2 (
        .a    (s1),
        .b    (cin),
        .sum  (sum),
        .cout (c2)
    );

    // Final carry output
    assign cout = c1 | c2;

endmodule
