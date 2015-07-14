`include "../../include/incparams.vh"

module FT2232_sim #(
   parameter DATA  = `DATA_BUS,
   parameter DEPTH = `FIFO_DEPTH,
   parameter ADDR  = `CLOG2(DEPTH)
)(
   // Host PC Interface
   input		H_wr,
   input		H_rd,
   input	[7:0]	H_din,
   output	[7:0]	H_dout,
   // FT2232 Interface
   inout  	[7:0]	DBUS,
   input  		RD,
   input  		WR,
   input  		SIWU,
   output 		RXF,
   output 		TXE
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
