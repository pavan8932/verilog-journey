// =============================================================================
// File: cla_4bit.v
// Module: cla_4bit (4-bit Carry Lookahead Adder using Dataflow Modeling)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 6 (Dataflow Modeling)
// Topics: Continuous assignment (assign), Generate & Propagate, Reduction operators
// =============================================================================
`timescale 1ns / 1ps

module cla_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       cin,
    output wire [3:0] sum,
    output wire       cout,
    output wire       zero    // Reduction operator: 1 if all bits of sum are 0
);

    // 1. Bitwise Generate (G) and Propagate (P) terms
    wire [3:0] g; // Gi = Ai & Bi
    wire [3:0] p; // Pi = Ai ^ Bi

    assign g = a & b;
    assign p = a ^ b;

    // 2. Lookahead Carry Logic: Evaluated in parallel (O(1) gate delay!)
    wire [4:0] c;
    assign c[0] = cin;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);
    assign c[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c[0]);

    // 3. Final Sum and Carry-out
    assign sum  = p ^ c[3:0]; // Sum[i] = Pi ^ Ci
    assign cout = c[4];

    // 4. Reduction Operator: ~| (Reduction NOR) returns 1 if all bits of sum are 0
    assign zero = ~|sum;

endmodule
