// =============================================================================
// File: tb_adder4.v
// Module: tb_adder4 (Testbench with Hierarchical Signal Probing)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 4 (Modules and Ports)
// =============================================================================
`timescale 1ns / 1ps

module tb_adder4;

    reg  [3:0] a;
    reg  [3:0] b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;

    // Instantiate 4-bit adder
    adder4 dut (
        .a    (a),
        .b    (b),
        .cin  (cin),
        .sum  (sum),
        .cout (cout)
    );

    // MANDATORY GTKWave dump
    initial begin
        $dumpfile("adder4.vcd");
        $dumpvars(0, tb_adder4);
    end

    // Stimulus block
    initial begin
        $display("-----------------------------------------------------------------");
        $display("Time\ta\tb\tcin\t|\tsum\tcout\t|\tInternal Carries");
        $display("-----------------------------------------------------------------");

        // Test 1: Simple addition 2 + 3 = 5
        a = 4'd2; b = 4'd3; cin = 1'b0;
        #10;
        $display("%0dns\t%d\t%d\t%b\t|\t%d\t%b\t|\tc1=%b c2=%b c3=%b (Probed)",
                 $time, a, b, cin, sum, cout, dut.c1, dut.c2, dut.c3);

        // Test 2: Addition with Carry-in 7 + 8 + 1 = 16 (sum=0, cout=1)
        a = 4'd7; b = 4'd8; cin = 1'b1;
        #10;
        $display("%0dns\t%d\t%d\t%b\t|\t%d\t%b\t|\tc1=%b c2=%b c3=%b (Probed)",
                 $time, a, b, cin, sum, cout, dut.c1, dut.c2, dut.c3);

        // Test 3: Overflow condition 15 + 1 = 16 (sum=0, cout=1)
        a = 4'd15; b = 4'd1; cin = 1'b0;
        #10;
        $display("%0dns\t%d\t%d\t%b\t|\t%d\t%b\t|\tc1=%b c2=%b c3=%b (Probed)",
                 $time, a, b, cin, sum, cout, dut.c1, dut.c2, dut.c3);

        // Test 4: Maximum sum 15 + 15 + 1 = 31 (sum=15, cout=1)
        a = 4'd15; b = 4'd15; cin = 1'b1;
        #10;
        $display("%0dns\t%d\t%d\t%b\t|\t%d\t%b\t|\tc1=%b c2=%b c3=%b (Probed)",
                 $time, a, b, cin, sum, cout, dut.c1, dut.c2, dut.c3);

        #10;
        $display("-----------------------------------------------------------------");
        $display("Simulation Finished! Check adder4.vcd in GTKWave.");
        $display("-----------------------------------------------------------------");
        $finish;
    end

endmodule
