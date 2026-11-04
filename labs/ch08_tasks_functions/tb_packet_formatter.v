// =============================================================================
// File: tb_packet_formatter.v
// Module: tb_packet_formatter (Testbench for Packet Formatter)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 8 (Tasks and Functions)
// Topic: Reusable Tasks, Handshakes, and Automatic Re-entrancy
// =============================================================================
`timescale 1ns / 1ps

module tb_packet_formatter;

    reg        clk;
    reg        rst_n;
    reg        valid_in;
    reg  [7:0] data_in;

    wire        valid_out;
    wire [15:0] packet_out;

    integer pass_count = 0;
    integer fail_count = 0;

    // Instantiate DUT
    packet_formatter dut (
        .clk        (clk),
        .rst_n      (rst_n),
        .valid_in   (valid_in),
        .data_in    (data_in),
        .valid_out  (valid_out),
        .packet_out (packet_out)
    );

    // 10ns Clock (100 MHz)
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // MANDATORY GTKWave dump
    initial begin
        $dumpfile("packet_formatter.vcd");
        $dumpvars(0, tb_packet_formatter);
    end

    // -------------------------------------------------------------------------
    // Task 1: Re-entrant Automatic Clock Delay
    // Allocates local variable 'i' on the call stack per invocation
    // -------------------------------------------------------------------------
    task automatic delay_cycles(input integer num_cycles);
        integer i;
        begin
            for (i = 0; i < num_cycles; i = i + 1)
                @(posedge clk);
        end
    endtask

    // -------------------------------------------------------------------------
    // Task 2: Synchronous Frame Transaction and Verification Task
    // Drives input data, asserts valid, waits for registered output, and checks
    // -------------------------------------------------------------------------
    task send_and_verify(input [7:0] byte_data, input [15:0] expected_frame);
        begin
            // 1. Drive input on falling edge to guarantee setup time
            @(negedge clk);
            valid_in = 1'b1;
            data_in  = byte_data;

            // 2. Sample on the rising clock edge when DUT registers the frame
            @(posedge clk);
            #1; // Small delta delay after clock edge
            if (valid_out && packet_out === expected_frame) begin
                $display("[%0dns] [PASS] Input=0x%h -> Frame=0x%h", $time, byte_data, packet_out);
                pass_count = pass_count + 1;
            end else begin
                $display("[%0dns] [FAIL] Input=0x%h -> Frame=0x%h (Expected: 0x%h)",
                         $time, byte_data, packet_out, expected_frame);
                fail_count = fail_count + 1;
            end

            // 3. De-assert valid_in on following falling edge
            @(negedge clk);
            valid_in = 1'b0;
            data_in  = 8'h00;
        end
    endtask

    // Stimulus Sequence
    initial begin
        $display("-----------------------------------------------------------------");
        $display("Starting Chapter 8 Simulation: Tasks and Functions");
        $display("-----------------------------------------------------------------");

        // 1. Reset sequence
        valid_in = 1'b0;
        data_in  = 8'h00;
        rst_n    = 1'b0;
        #15;
        rst_n    = 1'b1; // De-assert reset

        delay_cycles(2);

        // 2. Test Case 1: Payload = 0x55 (4 ones -> odd parity bit = 1)
        // Frame: {4'hA, 8'h55, 1'b1, 3'b111} = 0xA55F
        send_and_verify(8'h55, 16'hA55F);

        delay_cycles(1);

        // 3. Test Case 2: Payload = 0x33 (4 ones -> odd parity bit = 1)
        // Frame: {4'hA, 8'h33, 1'b1, 3'b111} = 0xA33F
        send_and_verify(8'h33, 16'hA33F);

        delay_cycles(1);

        // 4. Test Case 3: Payload = 0x01 (1 one -> odd parity bit = 0)
        // Frame: {4'hA, 8'h01, 1'b0, 3'b111} = 0xA017
        send_and_verify(8'h01, 16'hA017);

        delay_cycles(1);

        // 5. Test Case 4: Payload = 0xAA (4 ones -> odd parity bit = 1)
        // Frame: {4'hA, 8'hAA, 1'b1, 3'b111} = 0xAAAF
        send_and_verify(8'hAA, 16'hAAAF);

        delay_cycles(2);

        $display("-----------------------------------------------------------------");
        $display("Simulation Finished! Total Tests: %0d Passed, %0d Failed", pass_count, fail_count);
        $display("-----------------------------------------------------------------");
        $finish;
    end

endmodule
