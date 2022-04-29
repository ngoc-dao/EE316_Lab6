`timescale 1ns / 1ps

module timer_main(
    input clk,
    input start_stop,
    input reset,
    input [15:0] sw,
    output [3:0] an,
    output [6:0] sseg0,
    output [6:0] sseg1, 
    output [6:0] sseg2,
    output [6:0] sseg3,
    );
    
    wire [6:0] in0, in1, in2, in3;
    wire slow_clk;
    
    // Module instantiation of hexto7segment decoder
    hexto7segment c1 (.x(sw[3:0]), .r(in0));
    hexto7segment c2 (.x(sw[7:4]), .r(in1));
    hexto7segment c3 (.x(sw[11:8]), .r(in2));
    hexto7segment c4 (.x(sw[15:12]), .r(in3));
    
    clk_div_disp c5 (clk, reset, slow_clk);
    
    time_mux_state_machine c6(
        .clk(slow_clk),
        .reset(reset),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .an(an),
        .sseg(sseg)
    );
    
endmodule
