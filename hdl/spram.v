

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

always @(posedge clk) begin
   if (we) begin
      mem[addr] <= din;
   end
   dout <= mem[addr];
end

endmodule
