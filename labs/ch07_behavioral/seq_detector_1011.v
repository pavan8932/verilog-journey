// =============================================================================
// File: seq_detector_1011.v
// Module: seq_detector_1011 (Moore FSM for Overlapping Sequence Detection "1011")
// Reference: Samir Palnitkar - Verilog HDL, Chapter 7 (Behavioral Modeling)
// Architecture: Industry-Standard 3-Process FSM Architecture
// =============================================================================
`timescale 1ns / 1ps

module seq_detector_1011 (
    input  wire clk,
    input  wire rst_n,       // Asynchronous active-low reset
    input  wire din,         // Serial bitstream input
    output reg  detected,    // High for 1 clock cycle when "1011" detected
    output wire [2:0] state_out // Current state output for debug/GTKWave
);

    // State Encoding using localparam (3 bits for 5 states)
    localparam S_IDLE = 3'b000;
    localparam S_1    = 3'b001;
    localparam S_10   = 3'b010;
    localparam S_101  = 3'b011;
    localparam S_1011 = 3'b100;

    reg [2:0] state;
    reg [2:0] next_state;

    assign state_out = state;

    // -------------------------------------------------------------------------
    // Process 1: Sequential State Register
    // Uses non-blocking assignments (<=) triggered on clock edge
    // -------------------------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // -------------------------------------------------------------------------
    // Process 2: Combinational Next-State Logic
    // Uses blocking assignments (=) inside always @(*) with complete case
    // -------------------------------------------------------------------------
    always @(*) begin
        // Default assignment avoids inferred latches
        next_state = state;

        case (state)
            S_IDLE: begin
                if (din)
                    next_state = S_1;
                else
                    next_state = S_IDLE;
            end

            S_1: begin
                if (din)
                    next_state = S_1;    // Continuous '1's stay in S_1
                else
                    next_state = S_10;   // '10' matched
            end

            S_10: begin
                if (din)
                    next_state = S_101;  // '101' matched
                else
                    next_state = S_IDLE; // '100' breaks sequence, restart
            end

            S_101: begin
                if (din)
                    next_state = S_1011; // '1011' completed!
                else
                    next_state = S_10;   // '1010' has suffix '10', go to S_10
            end

            S_1011: begin
                // Overlapping capability: S_1011 has suffix '1'
                if (din)
                    next_state = S_1;    // Suffix '1' matches first bit
                else
                    next_state = S_10;   // Suffix '10' matches first two bits!
            end

            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    // -------------------------------------------------------------------------
    // Process 3: Output Logic (Moore Machine: depends only on current state)
    // -------------------------------------------------------------------------
    always @(*) begin
        if (state == S_1011)
            detected = 1'b1;
        else
            detected = 1'b0;
    end

endmodule
