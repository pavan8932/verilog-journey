// =============================================================================
// File: tff.v
// Module: tff (Toggle Flip-Flop)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 2 (Hierarchical Modeling)
// Description: T-FF toggles output 'q' on every negative edge of clock.
//              Built hierarchically by instantiating the D-FF module.
// =============================================================================
`timescale 1ns / 1ps

module tff (
    output q,
    input  clk,
    input  reset
);

    wire d;

    // Instantiate D-Flip-Flop:
    // Connecting D input to inverted output (q_bar) causes toggle behavior on every clock edge
    dff dff0 (
        .q(q),
        .q_bar(d),
        .d(d),
        .clk(clk),
        .reset(reset)
    );

endmodule
