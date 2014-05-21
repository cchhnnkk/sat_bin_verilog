module lit4(
	parameter NUM_LITS = 4
(
	input  clk, 
	input  rst, 

	input wr_i,
	input [NUM_LITS*3-1 : 0] var_value_frombase_i,
	output [NUM_LITS*3-1 : 0] var_value_tobase_o,

	input [1 : 0] freelitcnt_pre,
	output [1 : 0] freelitcnt_next,

	input imp_drv_i,
	
	output [NUM_LITS-1 : 0] cclause_o,
	input cclause_drv_i,

	output clausesat_o
)

	//vars id in the bin
	wire [NUM_LITS/2*3-1:0] var_value_frombase_0, var_value_frombase_1;
	wire [NUM_LITS/2*3-1:0] var_value_tobase_0, var_value_tobase_1;
	wire [1:0] freelitcnt_0, freelitcnt_1, freelitcnt_2;
	wire imp_drv_0, imp_drv_1;
	wire cclause_0, cclause_1;
	wire cclause_drv_0, cclause_drv_1;
	wire clausesat_0, clausesat_1;

	assign {var_value_frombase_0,var_value_frombase_1} = var_value_frombase_i;

	assign var_value_tobase_o = {var_value_tobase_0, var_value_tobase_1};

	assign clausesat_o = clausesat_0 | clausesat_1;

	assign imp_drv_0 = imp_drv_i;
	assign imp_drv_1 = imp_drv_i;

	lit2 lit2_0(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_0),
		.var_value_tobase_o(var_value_tobase_0),

		.freelitcnt_pre(0),
		.freelitcnt_next(freelitcnt_0),

		.imp_drv_i(imp_drv_0),
		
		.cclause_o(cclause_0),
		.cclause_drv_i(cclause_drv_0),

		.clausesat_o(clausesat_0)
	)

	lit2 lit2_1(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_1),
		.var_value_tobase_o(var_value_tobase_1),

		.freelitcnt_pre(freelitcnt_0),
		.freelitcnt_next(freelitcnt_1),

		.imp_drv_i(imp_drv_1),
		
		.cclause_o(cclause_1),
		.cclause_drv_i(cclause_drv_1),

		.clausesat_o(clausesat_1)
	)

endmodule
