// =============================================================================
// File: packet_formatter.v
// Module: packet_formatter (Packet Formatter & Parity Engine)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 8 (Tasks and Functions)
// Topic: Synthesizable Functions in RTL
// =============================================================================
`timescale 1ns / 1ps

module packet_formatter (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        valid_in,
    input  wire [7:0]  data_in,
    output reg         valid_out,
    output reg  [15:0] packet_out
);

    // Frame Delimiters
    localparam [3:0] HEADER = 4'b1010; // 0xA
    localparam [2:0] FOOTER = 3'b111;  // 0x7

    // -------------------------------------------------------------------------
    // Function 1: Computes Odd Parity bit (0 simulation time, synthesizes to XOR tree)
    // -------------------------------------------------------------------------
    function calc_parity;
        input [7:0] byte_data;
        begin
            // Odd parity: returns 1 if number of 1s in byte_data is even
            calc_parity = ~(^byte_data);
        end
    endfunction

    // -------------------------------------------------------------------------
    // Function 2: Assembles 16-bit frame: {HEADER[3:0], DATA[7:0], PARITY[0], FOOTER[2:0]}
    // -------------------------------------------------------------------------
    function [15:0] assemble_frame;
        input [7:0] payload;
        input       parity_bit;
        begin
            assemble_frame = {HEADER, payload, parity_bit, FOOTER};
        end
    endfunction

    // Sequential Output Register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_out  <= 1'b0;
            packet_out <= 16'h0000;
        end else if (valid_in) begin
            valid_out  <= 1'b1;
            // Invoking functions on RHS
            packet_out <= assemble_frame(data_in, calc_parity(data_in));
        end else begin
            valid_out  <= 1'b0;
        end
    end

endmodule
