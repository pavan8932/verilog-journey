// =============================================================================
// File: data_types_demo.v
// Module: data_types_demo
// Reference: Samir Palnitkar - Verilog HDL, Chapter 3 (Basic Concepts)
// =============================================================================
`timescale 1ns / 1ps

// Simple macros
`define DATA_WIDTH 8
`define ADDR_WIDTH 2

module data_types_demo (
    input  wire                   clk,
    input  wire                   wr_en,
    input  wire                   bus_en,       // Controls tri-state bus
    input  wire [`ADDR_WIDTH-1:0] addr,         // 2-bit address (0 to 3)
    input  wire [`DATA_WIDTH-1:0] data_in,      // 8-bit input data
    output wire [`DATA_WIDTH-1:0] bus_out,      // Tri-state wire
    output reg  [`DATA_WIDTH-1:0] data_out,     // Register output
    output wire [3:0]             high_nibble,  // Upper 4 bits of data_in
    output wire [3:0]             low_nibble    // Lower 4 bits of data_in
);

    // Vector slicing (part-select)
    assign high_nibble = data_in[7:4];
    assign low_nibble  = data_in[3:0];

    // Tri-state buffer: when bus_en is 0, output is disconnected ('z')
    assign bus_out = (bus_en) ? data_in : 8'bzzzz_zzzz;

    // 4-word memory array (each word is 8 bits wide)
    reg [`DATA_WIDTH-1:0] mem [0:3];

    // Memory write and read on clock edge
    always @(posedge clk) begin
        if (wr_en)
            mem[addr] <= data_in;  // Write
        
        data_out <= mem[addr];     // Read (unwritten slot reads 'x')
    end

endmodule
