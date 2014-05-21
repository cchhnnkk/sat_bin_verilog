module clause4  #(
	parameter NUM_CLAUSES_A_BIN = 4,
	parameter NUM_VARS_A_BIN = 8,
	parameter WIDTH_VAR_STATES = 30
)
(
	input clk,
	input rst,

	input [NUM_CLAUSES_A_BIN-1:0] wr_i,
	input [NUM_VARS_A_BIN*3-1:0] var_value_frombase_i,
	output [NUM_VARS_A_BIN*3-1:0] var_value_tobase_o

)

	wire wr_0, wr_1;

	wire [3*NUM_VARS_A_BIN-1:0] var_value_tobase_0, var_value_tobase_1;

	assign var_value_tobase_o = var_value_tobase_0 | var_value_tobase_1;

	clause2 clause2_0 #(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk),
		.rst(rst), 
		.wr_i(wr_0),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_0)
	)

	clause2 clause2_1 #(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_1),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_1)
	)

endmodule
