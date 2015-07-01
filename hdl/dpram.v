

module dpram #(
   parameter DATA = 16,
   parameter ADDR = 5
)(
   input 			clka,  
   input 			wea , 
   input 	[ADDR-1:0]	addra,
   input 	[DATA-1:0] 	dina,  
   output reg	[DATA-1:0] 	douta,  	

   input 			clkb,    
   input 			web,      
   input 	[ADDR-1:0] 	addrb,  
   input 	[DATA-1:0] 	dinb,
   output reg 	[DATA-1:0] 	doutb
);


reg [DATA-1:0] mem [0:2**ADDR-1];

always @(posedge clka) begin
   if (wea) begin
      mem[addra] <= dina;
   end
   douta <= mem[addra];
end

always @(posedge clkb) begin
   if (web) begin
      mem[addrb] <= dinb;
   end
   doutb <= mem[addrb];
end

endmodule
