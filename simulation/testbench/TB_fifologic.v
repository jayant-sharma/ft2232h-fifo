`timescale 100ps/ 1ps
`define timeperiodby2 50

module tb_FIFOLOGIC;

reg clk, clk60, clk120, tpulse;
reg FFA, EFB, RXF, TXE;
wire D1, D2;

FifoLogic_Gated uut
(
   .clk(clk),
   .FFA(FFA),
   .RXF(RXF),
   .TXE(TXE),
   .EFB(EFB),
   .D1(D1),
   .D2(D2)
);

initial begin
   $dumpfile("waveGated.vcd");
   $dumpvars(0,tb_FIFOLOGIC);
end
 
initial begin
   clk = 0; clk60 = 0; clk120 = 0; tpulse = 0;
   FFA = 1'b0; EFB = 1'b0; RXF = 1'b0; TXE = 1'b0;
   #10
   $display("\nSimulation Started...");
   #100
   testALL();
/*
  
	{FFA,EFB,RXF,TXE} = 4'b0000;
   #50  
	{FFA,EFB,RXF,TXE} = 4'b1001;
   #50
	{FFA,EFB,RXF,TXE} = 4'b0000;
   #50  
	{FFA,EFB,RXF,TXE} = 4'b0000;
   #50  
	{FFA,EFB,RXF,TXE} = 4'b0000;
   #50
*/
   #1000
   $display("\nSimulation Finished");
   $finish;
end

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

always begin
   #50 clk = ~clk;
   #300 clk60 = ~clk60;
   #600 clk120 = ~clk120;
   tpulse = clk60 & clk120;
end

endmodule

