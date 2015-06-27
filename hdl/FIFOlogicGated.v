`timescale 100ps / 1ps

module FifoLogic_Gated (
   input 	clk,
   input 	FFA,
   input 	RXF,
   input 	TXE,
   input 	EFB,
   output 	RD,
   output 	WA,
   output 	RB,
   output 	WR,
   output reg 	D1,
   output reg 	D2
);

assign #270 clk_27 = clk;
assign #180 clk_45 = clk_27;

assign #28 FFA_N = ~FFA;
assign #28 EFB_N = ~EFB;

assign #28 x1 = RXF | FFA_N;
assign #28 x2 = TXE | EFB_N;

assign #29 x3 = x1 & x2;
assign #28 x1_n = ~x1;

assign #28 d1 = x3 | x1_n;
assign #28 d2 = x1 | x3;

initial begin
   D1 = 1; D2 = 1;
end

always@(posedge clk_45) begin
   D1 <= d1;
   D2 <= d2;
end

assign #20 RB = D1 ? 1'b1 : clk_27;
assign #20 WR = D1 ? 1'b1 : clk;
assign #20 RD = D2 ? 1'b1 : clk;
assign #20 WA = D2 ? 1'b1 : clk;

endmodule
