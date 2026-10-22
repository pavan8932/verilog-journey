// =============================================================================
// File: dff.v
// Module: dff (D Flip-Flop with negative edge-triggered clock and active-high reset)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 2 (Hierarchical Modeling)
// =============================================================================
`timescale 1ns / 1ps

module dff (
    output reg q,
    output     q_bar,
    input      d,
    input      clk,
    input      reset
);

    // Complement of q
    assign q_bar = ~q;

    // Sequential block: triggers on the negative edge of clk or positive edge of reset
    always @(posedge reset or negedge clk) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule
