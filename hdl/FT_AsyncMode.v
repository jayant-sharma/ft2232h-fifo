`define FREQ_MHz 			200
`define DELAY2CYCLES(d) (`FREQ_MHz*d)/1000     	


module ftAsyncMode _N(
	parameter DATA = 8,
	parameter ADDR = 12
)(
	input clk,
	
	// External(uP) Interface
	input 						ext_wr,
	input  		[DATA-1:0]	ext_wr_data,
	
	input 						ext_rd,
	output reg					ext_rd_data_valid,
	output reg	[DATA-1:0]	ext_rd_data,
	
	// FT22332 Interface
	input 						RXF_N,
	input			[DATA-1:0]	ft_rd_data,
	output reg					RD_N,
	
	input 						TXE_N,
	output 						WR_N,
	output reg 	[DATA-1:0]	ft_wr_data
);

reg [1:0] rd_state;
parameter 
	RD_IDLE   = 0,
	RD_FETCH  = 1,
	RD_ACTIVE = 2;

initial begin
	RD_N <= 1'b1;
	rd_state <= RD_IDLE;
end

// Asynchronous Read

always@(negedge RXF_N or posedge clk) begin
	if(!RXF_N) begin
		RD_N <= 1'b0;
		r15 <= DELAY2CYCLES(15);
		rd_state <= FETCH;
	end
	else begin
		case(rd_state)
			RD_IDLE: begin
				ext_rd_data_valid <= 1'b0;
				ext_rd_data <= 8'h00;
				RD_N <= 1'b1;
			end
			RD_FETCH: begin
				r15 <= r15 - 1;
				if(r15 == 1) begin
					ext_rd_data_valid <= 1'b1;
					ext_rd_data <= ft_rd_data;
					r30 <= DELAY2CYCLES(30);
					rd_state <= RD_ACTIVE;
				end 
			end
			RD_ACTIVE: begin
				r30 <= r30 - 1;
				ext_rd_data_valid <= 1'b0;
				ext_rd_data <= 8'h00;
				if(r30 == 1) begin
					RD_N <= 1'b1;
					rd_state <= RD_IDLE;
				end
			end
		endcase
	end
end






endmodule

