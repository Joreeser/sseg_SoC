module sseg_wrapper
   #(parameter W = 8)  // width of output port
   (
    input  logic clk,
    input  logic reset,
    // slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr,
    input  logic [31:0] wr_data,
    output logic [31:0] rd_data,
    // external port    
    output logic [W-1:0] sseg, an
   );

   // declaration
   logic [31:0] buf_reg0, buf_reg1;
   logic wr_en;

   // body
   // output buffer register
   always_ff @(posedge clk, posedge reset)
      if (reset)
	  begin
         buf_reg0 <= 0;
		 buf_reg1 <= 0;
	  end
      else   
         if (wr_en && (addr == 0))
            buf_reg0 <= wr_data[31:0];
		 else if (wr_en && (addr == 1))
			buf_reg1[9:0] <= wr_data[9:0];
   // decoding logic 
   assign wr_en = cs && write;
   // slot read interface
   assign rd_data =  0;
   // external output  
   sseg_disp display(.data_in(buf_reg0), .refresh_val(buf_reg1[9:0]), .clk(clk), .reset(reset), .sseg(sseg), .an(an));
endmodule
       



