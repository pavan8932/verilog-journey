// =============================================================================
// File: tb_seq_detector_1011.v
// Module: tb_seq_detector_1011 (Testbench for Overlapping Sequence Detector)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 7 (Behavioral Modeling)
// =============================================================================
`timescale 1ns / 1ps

module tb_seq_detector_1011;

    reg clk;
    reg rst_n;
    reg din;

    wire detected;
    wire [2:0] state_out;

    // Instantiate Sequence Detector DUT
    seq_detector_1011 dut (
        .clk       (clk),
        .rst_n     (rst_n),
        .din       (din),
        .detected  (detected),
        .state_out (state_out)
    );

    // Generate 10ns Clock (50% duty cycle: 5ns low, 5ns high)
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // MANDATORY GTKWave dump
    initial begin
        $dumpfile("seq_detector_1011.vcd");
        $dumpvars(0, tb_seq_detector_1011);
    end

    // Task to send a single bit cleanly on the negative clock edge
    task send_bit(input b);
        begin
            @(negedge clk);
            din = b;
        end
    endtask

    // Stimulus process
    initial begin
        $display("-----------------------------------------------------------------");
        $display("Starting Chapter 7 Simulation: Sequence Detector 1011 (Moore FSM)");
        $display("-----------------------------------------------------------------");
        $display("Time\t\trst_n\tdin\tstate\tdetected");
        $display("-----------------------------------------------------------------");
        $monitor("%0dns\t\t%b\t%b\t%d\t%b", $time, rst_n, din, state_out, detected);

        // 1. Initial Reset sequence
        din   = 1'b0;
        rst_n = 1'b0;
        #15;
        rst_n = 1'b1; // De-assert reset

        // 2. Feed sequence: 1 -> 0 -> 1 -> 1 (First Detection!)
        $display("\n[Sending sequence: 1 -> 0 -> 1 -> 1]");
        send_bit(1'b1);
        send_bit(1'b0);
        send_bit(1'b1);
        send_bit(1'b1); // Should detect here!

        // 3. Feed overlapping continuation: 0 -> 1 -> 1 (Second Detection!)
        // Full sequence so far: 1-0-1-1-0-1-1
        $display("\n[Sending overlapping continuation: 0 -> 1 -> 1]");
        send_bit(1'b0);
        send_bit(1'b1);
        send_bit(1'b1); // Should detect again due to overlap!

        // 4. Feed non-matching bits then another 1 -> 0 -> 1 -> 1
        $display("\n[Sending reset bits and third match: 0 -> 0 -> 1 -> 0 -> 1 -> 1]");
        send_bit(1'b0);
        send_bit(1'b0);
        send_bit(1'b1);
        send_bit(1'b0);
        send_bit(1'b1);
        send_bit(1'b1); // Third detection!

        // Wait a few cycles to observe return to idle
        send_bit(1'b0);
        #30;

        $display("-----------------------------------------------------------------");
        $display("Simulation Finished! Check seq_detector_1011.vcd in GTKWave.");
        $display("-----------------------------------------------------------------");
        $finish;
    end

endmodule
