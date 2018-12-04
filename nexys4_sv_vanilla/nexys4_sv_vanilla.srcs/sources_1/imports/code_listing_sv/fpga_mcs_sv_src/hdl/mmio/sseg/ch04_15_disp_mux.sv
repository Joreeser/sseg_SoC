// Listing 4.15
module disp_mux
   (
    input  logic clk, reset, tick,
    input  logic [7:0] in7, in6, in5, in4, in3, in2, in1, in0,
    output logic [7:0] an,   // enable
    output logic [7:0] sseg  // led segments
   );

   // signal declaration
   logic [2:0] an_control, an_control_next;

   // 3-bit counter
   // register
   always_ff @(posedge clk,  posedge reset)
      if (reset)
         an_control <= 0;
      else
         an_control <= an_control_next;

   // next-state logic
   assign an_control_next = (tick) ? an_control + 1 : an_control;

   // Counter to control 4-to-1 multiplexing
   // and to generate active-low enable signal
   always_comb
      case (an_control)
         3'b000:
            begin
               an = 8'b11111110;
               sseg = in0;
            end
         3'b001:
            begin
               an =  8'b11111101;
               sseg = in1;
            end
         3'b010:
            begin
               an =  8'b11111011;
               sseg = in2;
            end
         3'b011:
            begin
                an = 8'b11110111;
                sseg = in3;
            end
         3'b100:
            begin
                an = 8'b11101111;
                sseg = in4;
            end
         3'b101:
            begin
                an = 8'b11011111;
                sseg = in5;
            end
         3'b110:
            begin
                an = 8'b10111111;
                sseg = in6;
            end
         default:
            begin
               an =  8'b01111111;
               sseg = in7;
            end
       endcase
endmodule