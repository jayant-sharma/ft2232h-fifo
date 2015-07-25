`include "../../include/incparams.vh"

module FT2232_sim #(
   parameter DATA  = `DATA_BUS,
   parameter DEPTH = `FIFO_DEPTH,
   parameter ADDR  = `CLOG2(DEPTH)
)(
   // Host PC Interface
   input			H_wr,
   input			H_rd,
   input	[7:0]	H_din,
   output	[7:0]	H_dout,
   // FT2232 Interface
   inout  	[7:0]	DBUS,
   input  			RD,
   input  			WR,
   input  			SIWU,
   output 			RXF,
   output 			TXE
);




endmodule
