// =============================================================================
// File: tb_cla_4bit.v
// Module: tb_cla_4bit (Testbench for 4-bit Carry Lookahead Adder)
// Reference: Samir Palnitkar - Verilog HDL, Chapter 6 (Dataflow Modeling)
// =============================================================================
`timescale 1ns / 1ps

module tb_cla_4bit;

    reg  [3:0] a;
    reg  [3:0] b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;
    wire       zero;

    // Instantiate 4-bit Carry Lookahead Adder
    cla_4bit dut (
        .a    (a),
        .b    (b),
        .cin  (cin),
        .sum  (sum),
        .cout (cout),
        .zero (zero)
    );

    // MANDATORY GTKWave dump
    initial begin
        $dumpfile("cla_4bit.vcd");
        $dumpvars(0, tb_cla_4bit);
    end

    // Stimulus block
    initial begin
        $display("-----------------------------------------------------------------");
        $display("Time\ta\tb\tcin\t|\tsum\tcout\tzero\tCalculation");
        $display("-----------------------------------------------------------------");
        $monitor("%0dns\t%d\t%d\t%b\t|\t%d\t%b\t%b\t(0x%h + 0x%h + %b = 0x%h)",
                 $time, a, b, cin, sum, cout, zero, a, b, cin, sum);

        // Test 1: Simple addition 3 + 4 = 7
        a = 4'd3; b = 4'd4; cin = 1'b0;
        #10;

        // Test 2: Addition with Carry-in 5 + 6 + 1 = 12
        a = 4'd5; b = 4'd6; cin = 1'b1;
        #10;

        // Test 3: Overflow condition 15 + 1 = 16 (sum=0, cout=1, zero=1)
        a = 4'd15; b = 4'd1; cin = 1'b0;
        #10;

        // Test 4: Maximum sum 15 + 15 + 1 = 31 (sum=15, cout=1, zero=0)
        a = 4'd15; b = 4'd15; cin = 1'b1;
        #10;

        // Test 5: All zeros 0 + 0 + 0 = 0 (sum=0, cout=0, zero=1)
        a = 4'd0; b = 4'd0; cin = 1'b0;
        #10;

        $display("-----------------------------------------------------------------");
        $display("Simulation Finished! Check cla_4bit.vcd in GTKWave.");
        $display("-----------------------------------------------------------------");
        $finish;
    end

endmodule
