`include "../include/incparams.vh"

module tb_FIFOLOGIC;

reg clk, clk60, clk120;
wire tpulse;
reg EFB, TXE, FFA, RXF;
wire D1, WR, RB, D2, RD, WA;

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
   $dumpfile("../simulation/versim/waveGated.vcd");
   $dumpvars(0,tb_FIFOLOGIC);
end
 
initial begin
   clk = 0; clk60 = 0; clk120 = 0;
   EFB = 0; TXE = 0; FFA = 0; RXF = 0;
   #10
   $display("\nSimulation Started...");
   #100
   
   simulate("U");

   #5000
   $display("\nSimulation Finished\n");
   $finish;
end

task simulate;
   input [7:0]cmd;
   begin
      {FFA,EFB,RXF,TXE} = 4'b0011;
      #1000 
      
      if (cmd == "U") begin
	 {FFA,EFB,RXF,TXE} = 4'b1110;
	 writeUSB_UM(20, 630, 0);
	 
	 {FFA,EFB,RXF,TXE} = 4'b1101;
	 readUSB_UM(40, 630, 0);
      end
      
      if (cmd == "F") begin
	 {FFA,EFB,RXF,TXE} = 4'b1110;
	 writeUSB_FM(20, 630, 0);
	 
	 {FFA,EFB,RXF,TXE} = 4'b1101;
	 readUSB_FM(40, 630, 0);
      end
      
      {FFA,EFB,RXF,TXE} = 4'b0011;
   end
endtask

task writeUSB_FM;
   input [7:0] bytes;
   input [32:0] t;  
   input [32:0] x;
   reg [7:0] i;
   begin
      for (i=0; i<(bytes/2)+1; i=i+1) begin
	 @ (negedge WR);
	 {FFA,EFB,RXF,TXE} = 4'b0111;
	 #(t+x)  
	 {FFA,EFB,RXF,TXE} = 4'b0110;
      end
   end
endtask

task readUSB_FM;
   input [7:0] bytes; 
   input [32:0] t;  
   input [32:0] x;
   reg [7:0] i;
   begin
      for (i=0; i<(bytes/2)+1; i=i+1) begin 
	 @ (posedge RD);
	 {FFA,EFB,RXF,TXE} = 4'b1001;
	 #(t+x)
	 {FFA,EFB,RXF,TXE} = 4'b1011; 
      end
   end
endtask

task writeUSB_UM;
   input [7:0] bytes;   
   input [32:0] t;  
   input [32:0] x;
   reg [7:0] i;
   begin
      for (i=0; i<(bytes); i=i+1) begin
	 @ (negedge WR);
	 {FFA,EFB,RXF,TXE} = 4'b1111;
	 #(t+x)
	 {FFA,EFB,RXF,TXE} = 4'b1110;
      end
   end
endtask

task readUSB_UM;
   input [7:0] bytes;  
   input [32:0] t;  
   input [32:0] x;
   reg [7:0] i;
   begin
      for (i=0; i<(bytes); i=i+1) begin
	 @ (posedge RD);
	 {FFA,EFB,RXF,TXE} = 4'b1111;
	 #(t+x)
	 {FFA,EFB,RXF,TXE} = 4'b1101;
      end
   end
endtask

always #`timeperiodby2 clk = ~clk;
always #300 clk60 = ~clk60;
always #600 clk120 = ~clk120;
assign tpulse = clk60 | clk120;

endmodule
