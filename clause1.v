module clause1 #(
	parameter NUM_VARS_A_BIN = 8,
	parameter WIDTH_C_LEN = 5
)
(
	input  clk,
	input  rst,

	input wr_i,
	input [NUM_VARS_A_BIN*3-1:0] var_value_frombase_i,
	output [NUM_VARS_A_BIN*3-1:0] var_value_tobase_o,

	//用于find_learntc_index
	input [WIDTH_C_LEN-1 : 0] clause_len_i,
	output [WIDTH_C_LEN-1 : 0] clause_len_o,
	input apply_backtrack_i
);

	wire [1:0] freelitcnt_0;
	wire imp_drv_0;
	wire cclause_0;
	wire cclause_drv_0;
	wire clausesat_0;

	lit8 lit8_0(
		.clk(clk),
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_i),
		.var_value_tobase_o(var_value_tobase_o),

		.freelitcnt_pre(0),
		.freelitcnt_next(freelitcnt_0),

		.imp_drv_i(imp_drv_0),

		.cclause_o(cclause_0),
		.cclause_drv_i(cclause_drv_0),

		.clausesat_o(clausesat_0)
	);


	wire cclause_drv_o;
	assign cclause_drv_0=cclause_drv_o;

	terminal_cell terminal_cell(
		.clk(clk),
		.rst(rst),
		.clausesat_i(clausesat_0),
		.freelitcnt_i(freelitcnt_0),
		.imp_drv_o(imp_drv_0),
		.cclause_i(cclause_0),
		.cclause_drv_o(cclause_drv_o)
	);

	reg need_clear;
	reg is_reason_r;

	always @(posedge clk) begin: set_need_clear
		if(rst)
			need_clear <= 0;
		else if(is_reason_r && cclause_drv_o)
			need_clear <= 1;
		else if(~is_reason_r)
			need_clear <= 0;
		else
			need_clear <= need_clear;
	end

	always @(posedge clk) begin: set_is_reason_r
		if(rst)
			is_reason_r <= 0;
		else if(imp_drv_0)
			is_reason_r <= 1;
		else if(apply_backtrack_i && need_clear)
			is_reason_r <= 0;
		else
			is_reason_r <= is_reason_r;
	end

	reg [WIDTH_C_LEN-1 : 0] clause_len_r;
	always @(posedge clk) begin: set_clause_len_r
		if(rst)
			clause_len_r <= 0;
		else if(wr_i)
			clause_len_r <= clause_len_i;
		else
			clause_len_r <= clause_len_r;
	end
	//当该子句不是原因子句时，才将其长度输出
	assign clause_len_o = is_reason_r? 0:clause_len_r;

endmodule
