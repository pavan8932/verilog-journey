// =============================================================================
// File: tb_ripple_carry_counter.v
// Module: tb_ripple_carry_counter (Stimulus / Testbench Module)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 2 (Section 2.3)
// =============================================================================
`timescale 1ns / 1ps

module tb_ripple_carry_counter;

    // Registers to drive inputs of the DUT
    reg clk;
    reg reset;

    // Wire to observe outputs of the DUT
    wire [3:0] q;

    // Instantiate Design Under Test (DUT)
    ripple_carry_counter dut (
        .q(q),
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 10ns period (50% duty cycle, toggling every 5ns)
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Stimulus block: reset sequence and run time control
    initial begin
        // Setup GTKWave waveform dump
        $dumpfile("counter.vcd");
        $dumpvars(0, tb_ripple_carry_counter);

        // Display banner
        $display("--------------------------------------------------");
        $display("Starting Simulation: 4-bit Ripple Carry Counter");
        $display("Time\t\tReset\tClock\tCounter Value (q)");
        $display("--------------------------------------------------");
        $monitor("%0dns\t\t%b\t%b\t%b (%0d in decimal)", $time, reset, clk, q, q);

        // Assert reset initially
        reset = 1'b1;
        #15 reset = 1'b0;  // De-assert reset after 15ns

        // Let the counter run for 200ns
        #180;

        // Pulse reset again to verify reset functionality while running
        reset = 1'b1;
        #10 reset = 1'b0;

        #50;
        $display("--------------------------------------------------");
        $display("Simulation Complete! Open counter.vcd in GTKWave.");
        $display("--------------------------------------------------");
        $finish;
    end

endmodule
