// =============================================================================
// File: tb_data_types_demo.v
// Module: tb_data_types_demo (Testbench)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 3 (Basic Concepts)
// =============================================================================
`timescale 1ns / 1ps

module tb_data_types_demo;

    // Inputs to DUT are registers
    reg       clk;
    reg       wr_en;
    reg       bus_en;
    reg [1:0] addr;
    reg [7:0] data_in;

    // Outputs from DUT are wires
    wire [7:0] bus_out;
    wire [7:0] data_out;
    wire [3:0] high_nibble;
    wire [3:0] low_nibble;

    // Instantiate Design Under Test (DUT)
    data_types_demo dut (
        .clk         (clk),
        .wr_en       (wr_en),
        .bus_en      (bus_en),
        .addr        (addr),
        .data_in     (data_in),
        .bus_out     (bus_out),
        .data_out    (data_out),
        .high_nibble (high_nibble),
        .low_nibble  (low_nibble)
    );

    // Generate 10ns clock
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Dump waveforms for GTKWave
    initial begin
        $dumpfile("data_types.vcd");
        $dumpvars(0, tb_data_types_demo);
    end

    // Stimulus block
    initial begin
        $display("---------------------------------------------------------------");
        $display("Time\twr_en\tbus_en\taddr\tdata_in\tbus_out\tdata_out");
        $display("---------------------------------------------------------------");
        $monitor("%0dns\t%b\t%b\t%d\t0x%h\t0x%h\t0x%h",
                 $time, wr_en, bus_en, addr, data_in, bus_out, data_out);

        // 1. Initial values: bus disabled (z) and unwritten memory (x)
        wr_en   = 1'b0;
        bus_en  = 1'b0;
        addr    = 2'd0;
        data_in = 8'hA5;
        #10;

        // 2. Enable tri-state bus (outputs 0xA5, high=A, low=5)
        bus_en  = 1'b1;
        #10;

        // 3. Write 0x55 into memory address 0
        addr    = 2'd0;
        data_in = 8'h55;
        wr_en   = 1'b1;
        #10;

        // 4. Write 0xAA into memory address 1
        addr    = 2'd1;
        data_in = 8'hAA;
        #10;

        // 5. Read back address 0
        wr_en   = 1'b0;
        addr    = 2'd0;
        #10;

        // 6. Read back address 1
        addr    = 2'd1;
        #10;

        // 7. Read unwritten address 2 (should read 'x')
        addr    = 2'd2;
        #10;

        // 8. Turn off bus enable (returns to 'z')
        bus_en  = 1'b0;
        #20;

        $display("---------------------------------------------------------------");
        $display("Simulation complete! Check data_types.vcd in GTKWave.");
        $display("---------------------------------------------------------------");
        $finish;
    end

endmodule
