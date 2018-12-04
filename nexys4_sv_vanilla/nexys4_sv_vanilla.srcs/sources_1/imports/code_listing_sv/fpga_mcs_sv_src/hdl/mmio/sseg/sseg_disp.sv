`timescale 1ns / 1ps

module sseg_disp(
    input logic [31:0] data_in,
    input logic [9:0] refresh_val,
    input logic clk, reset,
    output logic [7:0] sseg, an);
    
    logic [31:0] disp_data;
    logic [63:0] disp_sseg;
    
    register data_reg(.clk(clk), .reset(reset), .data_in(data_in), .data_out(disp_data));
    
    counter refresh_counter(.refresh_val(refresh_val), .clk(clk), .reset(reset), .tick(tick));
    
    hex_to_sseg sseg_val0(.hex(disp_data[3:0]), .dp(1), .sseg(disp_sseg[7:0]));
    hex_to_sseg sseg_val1(.hex(disp_data[7:4]), .dp(1), .sseg(disp_sseg[15:8]));
    hex_to_sseg sseg_val2(.hex(disp_data[11:8]), .dp(1), .sseg(disp_sseg[23:16]));
    hex_to_sseg sseg_val3(.hex(disp_data[15:12]), .dp(1), .sseg(disp_sseg[31:24]));
    hex_to_sseg sseg_val4(.hex(disp_data[19:16]), .dp(1), .sseg(disp_sseg[39:32]));
    hex_to_sseg sseg_val5(.hex(disp_data[23:20]), .dp(1), .sseg(disp_sseg[47:40]));
    hex_to_sseg sseg_val6(.hex(disp_data[27:24]), .dp(1), .sseg(disp_sseg[55:48]));
    hex_to_sseg sseg_val7(.hex(disp_data[31:28]), .dp(1), .sseg(disp_sseg[63:56]));
    
    disp_mux display(.clk(clk), .reset(reset), .tick(tick), .in0(disp_sseg[7:0]), .in1(disp_sseg[15:8]), .in2(disp_sseg[23:16]), .in3(disp_sseg[31:24]), 
        .in4(disp_sseg[39:32]), .in5(disp_sseg[47:40]), .in6(disp_sseg[55:48]), .in7(disp_sseg[63:56]), .an(an), .sseg(sseg));
endmodule
