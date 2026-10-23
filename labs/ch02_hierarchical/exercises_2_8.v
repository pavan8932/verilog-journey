// =============================================================================
// File: exercises_2_8.v
// Solutions to Chapter 2 Exercises (Section 2.8)
// Reference: Samir Palnitkar - Verilog HDL, Page 26
// =============================================================================

// -----------------------------------------------------------------------------
// Exercise 1: Interconnect Switch (IS) Hierarchy
// -----------------------------------------------------------------------------

// 1.a Define modules MEM, SC, and Xbar (no internals, no terminal lists)
module MEM;
    // Shared Memory - internals not defined
endmodule

module SC;
    // System Controller - internals not defined
endmodule

module Xbar;
    // Data Crossbar - internals not defined
endmodule

// 1.b Define module IS and instantiate MEM, SC, Xbar as mem1, sc1, xbar1
module IS;
    // Instantiating subcomponents
    MEM  mem1();
    SC   sc1();
    Xbar xbar1();
endmodule

// 1.c Define stimulus block (Top) and instantiate IS as is1
module Top;
    // Stimulus block wrapping the entire design
    IS is1();
endmodule


// -----------------------------------------------------------------------------
// Exercise 2: 4-bit Ripple Carry Adder (Ripple_Add) Hierarchy
// -----------------------------------------------------------------------------

// 2.a Define module FA (1-bit Full Adder)
module FA;
    // 1-bit Full Adder - internals not defined
endmodule

// 2.b Define module Ripple_Add and instantiate four FA instances: fa0, fa1, fa2, fa3
module Ripple_Add;
    // 4 instances of Full Adder to form a 4-bit adder
    FA fa0();
    FA fa1();
    FA fa2();
    FA fa3();
endmodule
