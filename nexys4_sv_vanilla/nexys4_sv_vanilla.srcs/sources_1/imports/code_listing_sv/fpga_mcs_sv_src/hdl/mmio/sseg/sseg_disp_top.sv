`timescale 1ns / 1ps

module sseg_disp_top(
    input logic clk, reset,
    output logic [7:0] sseg, an);
    
    logic [31:0] data = 32'hFFFFFFFF;
    logic [9:0] refresh_val = 10'd50;
    
    sseg_wrapper display(.clk(clk), .reset(reset), .cs(1), .read(0), .write(1), .addr(.addr), .wr_data(), .rd_data(), .sseg(sseg), .an(an));
    
endmodule
