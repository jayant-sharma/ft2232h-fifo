`include "../../include/incparams.vh"

module dp_sync_fifo #(
   parameter WIDTH  = 64,
   parameter DEPTH  = 1024,
   parameter AWIDTH = `CLOG2(DEPTH)
)(
   input 			rst,
   input 			clk,

   input 			wra,
   input 			rda,
   input 	[WIDTH-1:0]	dina,
   output 	[WIDTH-1:0] 	douta,

   input 			wrb,
   input 			rdb,
   input 	[WIDTH-1:0]	dinb,
   output 	[WIDTH-1:0] 	doutb,

   output 			empty,
   output 			full,
   output			conflict
);

reg [AWIDTH:0] rd_ptr, wr_ptr;
wire [WIDTH-1:0] ram_douta, ram_doutb;
wire [AWIDTH-1:0] ram_addra, ram_addrb;

initial begin
   wr_ptr <= 0;
   rd_ptr <= 0;
end

//*************** FIFO STATUS *****************************************
assign empty    = (wr_ptr == rd_ptr);
assign full     = (wr_ptr[AWIDTH] != rd_ptr[AWIDTH])      &&
                  (wr_ptr[AWIDTH-1:0] == rd_ptr[AWIDTH-1:0]);
assign conflict = (wra && wrb) || (rda && rdb) ||
                  (wra && rda) || (wrb && rdb);

//*************** FIFO POINTERS ***************************************
always@(posedge clk or posedge rst) begin
   if(rst) begin
      wr_ptr <= 0;
      rd_ptr <= 0;
   end
   else begin
      if (!full && (wra || wrb))
	 wr_ptr <= wr_ptr + 1;
      if (!empty && (rda || rdb))
	 rd_ptr <= rd_ptr + 1;
   end
end

//*************** RAM  INTERFACE***************************************
assign douta     = rst ? 0 : ((!empty && rda && !rdb) ? ram_douta : douta);
assign doutb     = rst ? 0 : ((!empty && !rda && rdb) ? ram_doutb : doutb);
assign ram_addra = (wra && !wrb) ? wr_ptr : ((rda && !rdb) ? rd_ptr : 0);
assign ram_addrb = (!wra && wrb) ? wr_ptr : ((!rda && rdb) ? rd_ptr : 0);

dpram fifomem (
   .clka  (clka),
   .wea   (wra),
   .addra (ram_addra),
   .dina  (dina),
   .douta (ram_douta),
   .clkb  (clkb),
   .web   (wrb),
   .addrb (ram_addrb),
   .dinb  (dinb),
   .doutb (ram_doutb)
);
defparam fifomem.DATA = WIDTH;
defparam fifomem.ADDR = AWIDTH;

endmodule
