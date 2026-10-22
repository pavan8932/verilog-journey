`timescale 1ns / 1ps

module tb_ripple_carry_counter;

    reg clk;
    reg reset;
    wire [3:0] q;

    // Instantiate DUT (Device Under Test)
    ripple_carry_counter dut (
        .q     (q),
        .clk   (clk),
        .reset (reset)
    );

    // Generate 10ns clock (50% duty cycle: 5ns low, 5ns high)
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // MANDATORY GTKWave dump
    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, tb_ripple_carry_counter);
    end

    // Stimulus and monitoring
    initial begin
        $display("--------------------------------------------------");
        $display("Time\t\tReset\tClock\tCounter Value (q)");
        $display("--------------------------------------------------");
        $monitor("%0dns\t\t%b\t%b\t%b (%0d in decimal)", $time, reset, clk, q, q);

        // Assert reset initially
        reset = 1'b1;
        #15 reset = 1'b0; // De-assert reset

        // Run for 200ns to see the full count from 0 to 15 and wrap around
        #200;

        $display("--------------------------------------------------");
        $display("Simulation Finished Successfully!");
        $display("--------------------------------------------------");
        $finish;
    end

endmodule