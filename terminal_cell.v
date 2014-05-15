module terminal_cell#(
	NUM_VARS_A_BIN = 24
)
(
	input  clk, 
	input  rst, 

	input [NUM_VARS_A_BIN-1 : 0] clausesat_i,
	
	input [1:0] freelitcnt_i,

	output imp_drv_o,
	
	input [NUM_VARS_A_BIN-1 : 0] cclause_i,
	output cclause_drv_o
)
	
	wire clausesat;
	assign clausesat = |clausesat_i;

	assign imp_drv_o = freelitcnt_i==2'b01;

	assign cclause_drv_o = |cclause_i;

endmodule
