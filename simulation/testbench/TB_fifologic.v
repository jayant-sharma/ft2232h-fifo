`timescale 100ps/ 1ps
`define timeperiodby2 50

module tb_FIFOLOGIC;

reg clk, clk60, clk120;
reg FFA, EFB, RXF, TXE;
wire tpulse;
wire D1, D2, RD, WA, RB, WR;

FifoLogic_Gated uut
(
   .clk	(tpulse),
   .FFA	(FFA),
   .RXF	(RXF),
   .TXE	(TXE),
   .EFB	(EFB),
   .RD	(RD),
   .WA	(WA),
   .RB	(RB),
   .WR	(WR),
   .D1	(D1),
   .D2	(D2)
);

initial begin
   $dumpfile("waveGated.vcd");
   $dumpvars(0,tb_FIFOLOGIC);
end
 
initial begin
   clk = 0; clk60 = 0; clk120 = 0;
   {FFA,EFB,RXF,TXE} = 4'b0000;
   #10
   $display("\nSimulation Started...");
   #100
   
   writeUSB_FM(60);
   #1000
   readUSB_FM(60);
   //testALL();

   #5000
   $display("\nSimulation Finished");
   $finish;
end

task writeUSB_FM;
   input [7:0] bytes;
   reg [7:0] i;
   begin
      {FFA,EFB,RXF,TXE} = 4'b0011;
      #2000 
      for (i=0; i<(bytes/2)+1; i=i+1) begin
	 if ( (i>(bytes/4-4)) && (i<(bytes/4+4)) ) begin
	    {FFA,EFB,RXF,TXE} = 4'b0011;
	    #1690; 
	    {FFA,EFB,RXF,TXE} = 4'b0011;
	    #330; 
	 end
	 else begin
	    {FFA,EFB,RXF,TXE} = 4'b0110;
	    #1690;  
	    {FFA,EFB,RXF,TXE} = 4'b0111;
	    #330; 
	 end 
      end
   end
endtask

task readUSB_FM;
   input [7:0] bytes;
   reg [7:0] i;
   begin
      {FFA,EFB,RXF,TXE} = 4'b0011;
      #2000 
      for (i=0; i<(bytes/2)+1; i=i+1) begin 
	 if ( (i>(bytes/4-4)) && (i<(bytes/4+4)) ) begin
	    {FFA,EFB,RXF,TXE} = 4'b0001;
	    #1690; 
	    {FFA,EFB,RXF,TXE} = 4'b0001;
	    #330; 
	 end
	 else begin
	    {FFA,EFB,RXF,TXE} = 4'b1001;
	    #1690; 
	    {FFA,EFB,RXF,TXE} = 4'b1011;
	    #330;  
	 end  
      end
   end
endtask

task readUSB_UM;
   input [7:0] bytes;
   reg [7:0] i;
   begin
      {FFA,EFB,RXF,TXE} = 4'b0011;
      #2000 
      for (i=0; i<(bytes/2)+1; i=i+1) begin
	 {FFA,EFB,RXF,TXE} = 4'b1101;
	 #1690
	 {FFA,EFB,RXF,TXE} = 4'b1111;
	 #330;  
      end
   end
endtask

task writeUSB_UM;
   input [7:0] bytes;
   reg [7:0] i;
   begin
      {FFA,EFB,RXF,TXE} = 4'b1010;
      #2000 
      for (i=0; i<(bytes/2)+1; i=i+1) begin 
	 {FFA,EFB,RXF,TXE} = 4'b1110;
	 #1690  
	 {FFA,EFB,RXF,TXE} = 4'b1111;
	 #330;  
      end
   end
endtask

task testALL;
   reg [5:0] i;
   begin
      @ (posedge clk);
      for (i=0; i<16; i=i+1) begin
	 {FFA,EFB,RXF,TXE} = i[3:0];
	 @ (posedge clk);
      end
   end   
endtask

always #`timeperiodby2 clk = ~clk;
always #300 clk60 = ~clk60;
always #600 clk120 = ~clk120;
assign tpulse = clk60 | clk120;

endmodule
