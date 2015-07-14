`include "../../include/incparams.vh"

module spram #(
   parameter DATA = 16,
   parameter ADDR = 5
)(
   input 			clk,  
   input 			we, 
   input 	[ADDR-1:0]	addr,
   input 	[DATA-1:0] 	din,  
   output reg	[DATA-1:0] 	dout
);


reg [DATA-1:0] mem [0:2**ADDR-1];

initial
   dout <= 0;

always@(posedge clk) begin
   dout <= mem[addr];
   if (we) begin
      mem[addr] <= din;
      //dout <= din;
   end
end

endmodule
