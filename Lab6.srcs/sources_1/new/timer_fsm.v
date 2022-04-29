`timescale 1ns / 1ps

module timer_fsm(
    input clk,
    input reset,
    input [1:0] mode,
    input [7:0] sw,
    input [6:0] in0,
    input [6:0] in1,
    input [6:0] in2,
    input [6:0] in3,
    output reg [3:0] an,
    output reg [6:0] sseg
    );
    
    reg [6:0] state;
    reg [6:0] next_state;
    
    always @(*) begin
        case (state)            // State transition
            7'b000000: next_state = 7'b0000000;
            default: next_state = 7'b0000000;
        endcase
    end
    
    always @(*) begin
        case (state)            // Multiplexer
            2'b00: sseg = in0;
            2'b01: sseg = in1;
            2'b10: sseg = in2;
            2'b11: sseg = in3;
        endcase
        
        case (state)            // Decoder
            2'b00: an = 4'b1110;
            2'b01: an = 4'b1101;
            2'b10: an = 4'b1011;
            2'b11: an = 4'b0111;
        endcase
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;
        else
            state <= next_state;
    end
endmodule
