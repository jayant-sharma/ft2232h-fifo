module dump();
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars();
   end    
endmodule
