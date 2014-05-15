module clause_array#(
	parameter NUM_CLAUSES_A_BIN = 24,
	parameter NUM_VARS_A_BIN = 24,
	parameter WIDTH_VAR_STATES = 30
)
(
	input clk,
	input rst,

	input [NUM_CLAUSES_A_BIN-1:0] wr_i,
	input [NUM_VARS_A_BIN*3-1:0] var_value_frombase_i,
	output [NUM_VARS_A_BIN*3-1:0] var_value_tobase_o

)

	wire wr_0, wr_1, wr_2, wr_3, wr_4, wr_5, wr_6, wr_7, wr_8, wr_9, wr_10, wr_11, wr_12, wr_13, wr_14, wr_15, wr_16, wr_17, wr_18, wr_19, wr_20, wr_21, wr_22, wr_23;

	wire [3*NUM_VARS_A_BIN-1:0] var_value_tobase_0, var_value_tobase_1, var_value_tobase_2, var_value_tobase_3, var_value_tobase_4, var_value_tobase_5, var_value_tobase_6, var_value_tobase_7, var_value_tobase_8, var_value_tobase_9, var_value_tobase_10, var_value_tobase_11, var_value_tobase_12, var_value_tobase_13, var_value_tobase_14, var_value_tobase_15, var_value_tobase_16, var_value_tobase_17, var_value_tobase_18, var_value_tobase_19, var_value_tobase_20, var_value_tobase_21, var_value_tobase_22, var_value_tobase_23;

	assign var_value_tobase_o = var_value_tobase_0 | var_value_tobase_1 | var_value_tobase_2 | var_value_tobase_3 | var_value_tobase_4 | var_value_tobase_5 | var_value_tobase_6 | var_value_tobase_7 | var_value_tobase_8 | var_value_tobase_9 | var_value_tobase_10 | var_value_tobase_11 | var_value_tobase_12 | var_value_tobase_13 | var_value_tobase_14 | var_value_tobase_15 | var_value_tobase_16 | var_value_tobase_17 | var_value_tobase_18 | var_value_tobase_19 | var_value_tobase_20 | var_value_tobase_21 | var_value_tobase_22 | var_value_tobase_23;

	clause clause0#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk),
		.rst(rst), 
		.wr_i(wr_0),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_0)
	)

	clause clause1#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_1),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_1)
	)

	clause clause2#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_2),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_2)
	)

	clause clause3#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_3),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_3)
	)

	clause clause4#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_4),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_4)
	)

	clause clause5#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_5),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_5)
	)

	clause clause6#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_6),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_6)
	)

	clause clause7#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_7),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_7)
	)

	clause clause8#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_8),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_8)
	)

	clause clause9#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_9),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_9)
	)

	clause clause10#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_10),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_10)
	)

	clause clause11#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_11),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_11)
	)

	clause clause12#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_12),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_12)
	)

	clause clause13#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_13),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_13)
	)

	clause clause14#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_14),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_14)
	)

	clause clause15#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_15),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_15)
	)

	clause clause16#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_16),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_16)
	)

	clause clause17#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_17),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_17)
	)

	clause clause18#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_18),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_18)
	)

	clause clause19#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_19),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_19)
	)

	clause clause20#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_20),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_20)
	)

	clause clause21#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_21),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_21)
	)

	clause clause22#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_22),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_22)
	)

	clause clause23#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	(
		.clk(clk), 
		.rst(rst), 
		.wr_i(wr_23),
		.var_value_frombase_i(var_value_frombase),
		.var_value_tobase_o(var_value_tobase_23)
	)


endmodule
