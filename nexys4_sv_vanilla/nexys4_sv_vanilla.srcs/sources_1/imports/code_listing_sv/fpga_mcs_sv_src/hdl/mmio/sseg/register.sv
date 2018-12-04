`timescale 1ns / 1ps

module register(
    input logic clk, reset,
    input logic [31:0] data_in,
    output logic [31:0] data_out);
    
    logic [31:0] r_reg, r_next;
    
    always_ff @(posedge clk, posedge reset)
        if (reset)
            r_reg <= 0;
        else
            r_reg <= r_next;
            
    assign data_in = r_next;
    assign data_out = r_reg;
    
endmodule
