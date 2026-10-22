`timescale 1ns / 1ps

module dff (
    output reg q,
    output     q_bar,
    input      d,
    input      clk,
    input      reset
);

    // Inverted output
    assign q_bar = ~q;

    // Asynchronous reset, negative-edge triggered clock
    always @(posedge reset or negedge clk) begin
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule