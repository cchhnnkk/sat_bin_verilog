module base_cell#(
	parameter NUM_CLAUSES_A_BIN = 24,
	parameter WIDTH_VAR_STATES = 30
)
(
	input  clk, 
	input  rst, 

	//connect to clause cell
	input [2:0] var_value_i,
	output [2:0] var_value_o,

	//decide
	input vars_decided_tobase_i,
	input decide_level_i,
	input [9:0] cur_bin_num_i,

	//conflict
	output find_conflict_o,
	output find_imply_o,
	output reg is_independent_bin_o,

	input apply_analyze_i,

	input [9:0] bkt_lvl_i,
	output reg [9:0] bkt_bin_num_o,
	input apply_backtrack_i,

	//exist that the learnt lit is not the highest bkt lvl
	output reg exist_var_not_vbkt_o,

	//load
	input apply_load_i,
	input [1 : 0] load_clauses_i,
	
	//update
	input apply_update_i,
	output [1:0] update_clause_o,

	//load update
	input wr_states,
	input [WIDTH_VAR_STATES-1 : 0] vars_states_i,
	output [WIDTH_VAR_STATES-1 : 0] vars_states_o,

	//use to compute the max backtrack level
	output reg [WIDTH_VAR_STATES-1 : 0] var_level_o
)
	//var state
	reg [2:0] var_value_r;
	reg [15:0] var_level_r;
	reg [9:0] var_reason_bin_r;
	reg is_highest_bktlvl_r;

	//use to generate learnt clause
	reg [1:0] learnt_lit_r;
	//use to generate learnt clause
	reg [2:0] assigned_var_value_r;

	assign var_value_o = apply_load_i? load_clauses_i: apply_analyze_i? {learnt_lit_r,var_value_r[0]}:var_value_r;

	assign update_clause_o = var_value_i[2:1];

	always @(posedge clk)
	begin
		if(~rst)
			global_unsat_o <= 0;
		else if(done_update_i && c_state==GLOBAL_UNSAT)
			global_unsat_o <= 1;
		else
			global_unsat_o <= global_unsat_o;
	end

	//wr_states
	assign vars_states_o = {var_value_r, var_level_r, var_reason_bin_r, is_highest_bktlvl_r};
	wire [2:0] var_value_i;
	wire [15:0] var_level_i;
	wire [9:0] var_reason_bin_i;
	wire is_highest_bktlvl_i;
	assign {var_value_i, var_level_i, var_reason_bin_i, is_highest_bktlvl_i} = vars_states_i;

	always @(posedge clk)
	begin
		if(~rst)
			var_value_r <= 0;
		else if(wr_states)
			var_value_r <= var_value_i;
		else if(vars_decided_tobase_i)
			var_value_r <= 3'b010;
		else if(apply_backtrack_i && var_level_r>bkt_lvl_i)
			var_value_r <= 3'b000;
		else if(apply_backtrack_i && learnt_lit_r!=2'b00 && var_level_r==bkt_lvl_i)
			var_value_r <= {~assigned_var_value_r[2:1], assigned_var_value_r[0]};
		else if(var_value_i[0] || var_value_i[2:1]==2'b11)
			var_value_r <= var_value_i;
		else
			var_value_r <= var_value_r;
	end

	assign find_imply_o = var_value_r[0];
	assign find_conflict_o = var_value_r[2:1]==2'b11;

	always @(posedge clk)
	begin
		if(~rst)
			var_level_r <= 0;
		else if(wr_states)
			var_level_r <= var_level_i;
		else if(vars_decided_tobase_i)
			var_level_r <= decide_level_i;
		else if(var_value_i[0])
			var_level_r <= decide_level_i;
		else
			var_level_r <= var_level_r;
	end

	always @(posedge clk)
	begin
		if(~rst)
			var_reason_bin_r <= 0;
		else if(wr_states)
			var_reason_bin_r <= var_reason_bin_i;
		else if(vars_decided_tobase_i || var_value_i[0])
			var_reason_bin_r <= cur_bin_num_i;
		else
			var_reason_bin_r <= var_reason_bin_r;
	end

	always @(posedge clk)
	begin
		if(~rst)
			is_highest_bktlvl_r <= 0;
		else if(wr_states)
			is_highest_bktlvl_r <= is_highest_bktlvl_i;
		else if(apply_backtrack_i && var_level_r>bkt_lvl_i)
			is_highest_bktlvl_r <= 0;
		else if(apply_backtrack_i && learnt_lit_r!=2'b00 && var_level_r==bkt_lvl_i)
			is_highest_bktlvl_r <= 1;
		else
			is_highest_bktlvl_r <= is_highest_bktlvl_r;
	end

	always @(posedge clk)
	begin
		if(~rst)
			assigned_var_value_r <= 0;
		else if(~apply_analyze_i)
			assigned_var_value_r <= var_value_r;
		else
			assigned_var_value_r <= assigned_var_value_r;
	end

	//learnt lit
	always @(posedge clk)
	begin
		if(~rst)
			learnt_lit_r <= 0;
		else if(var_value_r[0]==0 || (var_value_r==2'b11 && var_level_r!=decide_level_i))
			learnt_lit_r <= ~assigned_var_value_r[2:1];
		else if(apply_analyze_i)
			learnt_lit_r <= learnt_lit_r;
		else
			learnt_lit_r <= 0;
	end

	//use to find backtrack level
	always @(posedge clk)
	begin
		if(~rst)
			var_level_o <= 0;
		else if(learnt_lit_r!=0 && is_highest_bktlvl_r==0)
			var_level_o <= decide_level_i;
		else
			var_level_o <= 0;
	end

	//use to decide whether the bin is independent
	always @(posedge clk)
	begin
		if(~rst)
			is_independent_bin_o <= 0;
		else if(var_value_r[0]==1 && var_value_r[2:1]!=0 && var_reason_bin_r==cur_bin_num_i)
			is_independent_bin_o <= 1;
		else
			is_independent_bin_o <= 0;
	end

	always @(posedge clk)
	begin
		if(~rst)
			bkt_bin_num_o <= 0;
		else if(find_conflict_o && var_level_r==bkt_lvl_i)
			bkt_bin_num_o <= var_reason_bin_r;
		else
			bkt_bin_num_o <= 0;
	end

	always @(posedge clk)
	begin
		if(~rst)
			exist_var_not_vbkt_o <= 0;
		else if(learnt_lit_r!=0 && is_highest_bktlvl_r==0)
			exist_var_not_vbkt_o <= var_reason_bin_r;
		else
			exist_var_not_vbkt_o <= 0;
	end

endmodule
