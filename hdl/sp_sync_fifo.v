`include "../../include/incparams.vh"

////////////////////////////////////////////////////////////////////////////
// MODULE: sp_sync_fifo
////////////////////////////////////////////////////////////////////////////

module sp_sync_fifo #(
   parameter WIDTH  = 8,
   parameter DEPTH  = 256,
   parameter AWIDTH = `CLOG2(DEPTH)
)(
   input rst,
   input clk,
   input wr,
   input rd,
   input [WIDTH-1:0] din,

   output [WIDTH-1:0] dout,
   output empty,
   output full
);

reg [AWIDTH:0] rd_ptr, wr_ptr;
wire [WIDTH-1:0] ram_dout;
wire [AWIDTH-1:0] ram_addr;
reg wr1;

initial begin
   wr1 <= 1'b0;
   wr_ptr <= 0;
   rd_ptr <= 0;
end

////////////////////////////////////////////////////////////////////////////
// FIFO STATUS
////////////////////////////////////////////////////////////////////////////
assign empty  = (wr_ptr == rd_ptr);                   
assign full   = ( (wr_ptr[AWIDTH] != rd_ptr[AWIDTH])       &&
                  (wr_ptr[AWIDTH-1:0] == rd_ptr[AWIDTH-1:0]) );

////////////////////////////////////////////////////////////////////////////
// FIFO POINTERS
////////////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst) begin
   if(rst) begin
      wr1 <= 1'b0;
      wr_ptr <= {1'b0,{(AWIDTH-1){1'b0}}};
      rd_ptr <= {1'b0,{(AWIDTH-1){1'b0}}};
   end
   else begin
      wr1 <= 1'b0;
      if(!full && wr) begin
	 wr1 <= 1'b1;
	 wr_ptr <= wr_ptr + 1;
	 if(wr_ptr[AWIDTH-1:0] == DEPTH)
	    wr_ptr <= {1'b1,{(AWIDTH-1){1'b0}}};
      end
      if(!empty && rd) begin
	 rd_ptr <= rd_ptr + 1;
	 if(rd_ptr[AWIDTH-1:0] == DEPTH)
	    rd_ptr <= {1'b1,{(AWIDTH-1){1'b0}}};
      end
   end
end

////////////////////////////////////////////////////////////////////////////
// RAM INTERFACE
////////////////////////////////////////////////////////////////////////////
assign dout  = rst ? 0 : ((!empty && rd) ? ram_dout : dout);
assign ram_addr = wr1 ? wr_ptr : (rd ? rd_ptr[AWIDTH-1:0] : 0);

spram fifomem (
   .clk  (clk),
   .we   (wr),
   .addr (ram_addr),
   .din  (din),
   .dout (ram_dout)
);
defparam fifomem.DATA = WIDTH;
defparam fifomem.ADDR = AWIDTH;

dump dumpsim();

endmodule
