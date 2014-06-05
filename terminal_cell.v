module terminal_cell
(
	input  clk,
	input  rst,

	input clausesat_i,

	input [1:0] freelitcnt_i,

	output imp_drv_o,

	input cclause_i,
	output cclause_drv_o
);

	wire clausesat;
	assign clausesat = clausesat_i;

	assign imp_drv_o = freelitcnt_i==2'b01;

	assign cclause_drv_o = |cclause_i;

endmodule
