/**
 子句阵列的实现
 主要功能：实例化clause8，以及find_learntc_inserti
*/
module clause_array #(
	parameter NUM_CLAUSES_A_BIN = 4,
	parameter NUM_VARS_A_BIN = 8,
	parameter WIDTH_VAR_STATES = 30,
	parameter WIDTH_C_LEN = 5
)
(
	input clk,
	input rst,

	input [NUM_CLAUSES_A_BIN-1:0] wr_i,
	input [WIDTH_C_LEN-1 : 0] clause_len_i,
	input [NUM_VARS_A_BIN*3-1:0] var_value_frombase_i,
	output [NUM_VARS_A_BIN*3-1:0] var_value_tobase_o,

	output [NUM_CLAUSES_A_BIN-1:0] learntc_insert_index_o
);

	wire [WIDTH_C_LEN*NUM_CLAUSES_A_BIN-1 : 0] clause_len_o;
	wire [WIDTH_C_LEN*NUM_CLAUSES_A_BIN/2-1 : 0] originc_lens, learntc_lens;
	assign {originc_lens, learntc_lens} = clause_len_o;
	
	wire apply_backtrack_i;
				
	clause8 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	clause8
	(
		.clk(clk),
		.rst(rst),
		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_i),
		.var_value_tobase_o(var_value_tobase_o),

		.clause_len_i(clause_len_i),
		.clause_len_o(clause_len_o),
		.apply_backtrack_i(apply_backtrack_i)
	);

	wire [WIDTH_C_LEN-1 : 0] max_len;
	max_in_8_datas  #(
		.NUM(NUM_VARS_A_BIN/2),
		.WIDTH(WIDTH_C_LEN)
	)
	max_in_8_datas_inst0 (
		.data_i(learntc_lens),
		.data_o(max_len),
        .index_o(learntc_insert_index_o)
	);

endmodule
