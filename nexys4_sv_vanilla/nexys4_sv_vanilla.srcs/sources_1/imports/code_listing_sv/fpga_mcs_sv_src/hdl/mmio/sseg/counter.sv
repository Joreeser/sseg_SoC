module counter#(parameter N = 27)(
    input logic [9:0] refresh_val,
    input logic clk, reset,
    output logic tick);
    
    logic [N-1:0] count, count_next, thresh;
    
    assign thresh = {{refresh_val, 1'b0}+refresh_val, 15'b0};
    assign count_next = count + 1;
    assign tick = (count == 1) ? 1 : 0;
    
    always_ff @(posedge clk, posedge reset)
        if (reset || count == thresh)
            count <= 0;
        else
            count <= count_next;
            
    
    
endmodule