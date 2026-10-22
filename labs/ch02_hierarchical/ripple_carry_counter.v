`timescale 1ns / 1ps

module ripple_carry_counter (
    output [3:0] q,
    input        clk,
    input        reset
);

    // 4 stages of T-FF:
    // q[0] clocks stage 1, q[1] clocks stage 2, q[2] clocks stage 3
    tff tff0 (.q(q[0]), .clk(clk),  .reset(reset));
    tff tff1 (.q(q[1]), .clk(q[0]), .reset(reset));
    tff tff2 (.q(q[2]), .clk(q[1]), .reset(reset));
    tff tff3 (.q(q[3]), .clk(q[2]), .reset(reset));

endmodule