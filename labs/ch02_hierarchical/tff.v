`timescale 1ns / 1ps

module tff (
    output q,
    input  clk,
    input  reset
);

    wire d;

    // Instantiate D-FF: connecting q_bar to d creates toggle action
    dff dff0 (
        .q     (q),
        .q_bar (d),
        .d     (d),
        .clk   (clk),
        .reset (reset)
    );

endmodule