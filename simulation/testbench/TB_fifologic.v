`timescale 100ps/ 1ps
`define timeperiodby2 50

module tb_FIFOLOGIC;

reg clk;
reg FFA, EFB, RXF, TXE;
wire D1, D2;

FIFOLOGIC uut
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
   $dumpfile("wave.vcd");
   $dumpvars(0,tb_FIFOLOGIC);
end
 
initial begin
   clk = 0;
   FFA = 1'b0; EFB = 1'b0; RXF = 1'b0; TXE = 1'b0;
   #10
   $display("\nSimulation Started...");
  
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

   #1000
   $display("\nSimulation Finished");
   $finish;
end
              
always
   #`timeperiodby2 clk = ~clk;

endmodule

