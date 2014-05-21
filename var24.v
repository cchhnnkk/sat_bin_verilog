module base #(
	parameter NUM_CLAUSES_A_BIN = 24,
	parameter WIDTH_VAR_STATES = 30
(
	input  clk, 
	input  rst, 

	input [NUM_VARS_A_BIN*3-1:0] var_value_i,
	output [NUM_VARS_A_BIN*3-1:0] var_value_o,

	input [NUM_VARS_A_BIN-1:0] vars_decided_tobase_i,
	input [NUM_VARS_A_BIN*15-1:0] decide_level_i,
	
	input apply_implication_i,
	output reg done_imply_o,

	input apply_analyze_i,
	input [NUM_CLAUSES_A_BIN*5-1:0] clause_len_i,
	output reg done_analyze_o,
	input [9:0] cur_bin_num_i,
	output reg [9:0] bkt_bin_num_o,
	output is_independent_bin_o,
	output exist_var_not_vbkt_o,
	//load
	input apply_load_i,
	input [NUM_VARS_A_BIN*2-1 : 0] load_clauses_i,
	
	//update
	input apply_update_i,
	output [NUM_VARS_A_BIN*2-1 : 0] update_clause_o,

	//load update
	input set_vars_states_i,
	input get_vars_states_i,
	input [WIDTH_VAR_STATES-1 : 0] vars_states_i,
	output [WIDTH_VAR_STATES-1 : 0] vars_states_o,

	input [NUM_VARS_A_BIN/2-1:0] bitmap_learntc,
	output reg [NUM_VARS_A_BIN/2-1:0] wr_learntc_o
)

	wire [2:0] var_value_i_0, var_value_i_1, var_value_i_2, var_value_i_3, var_value_i_4, var_value_i_5, var_value_i_6, var_value_i_7, var_value_i_8, var_value_i_9, var_value_i_10, var_value_i_11, var_value_i_12, var_value_i_13, var_value_i_14, var_value_i_15, var_value_i_16, var_value_i_17, var_value_i_18, var_value_i_19, var_value_i_20, var_value_i_21, var_value_i_22, var_value_i_23;
	wire [2:0] var_value_o_0, var_value_o_1, var_value_o_2, var_value_o_3, var_value_o_4, var_value_o_5, var_value_o_6, var_value_o_7, var_value_o_8, var_value_o_9, var_value_o_10, var_value_o_11, var_value_o_12, var_value_o_13, var_value_o_14, var_value_o_15, var_value_o_16, var_value_o_17, var_value_o_18, var_value_o_19, var_value_o_20, var_value_o_21, var_value_o_22, var_value_o_23;
	wire vars_decided_tobase_i_0, vars_decided_tobase_i_1, vars_decided_tobase_i_2, vars_decided_tobase_i_3, vars_decided_tobase_i_4, vars_decided_tobase_i_5, vars_decided_tobase_i_6, vars_decided_tobase_i_7, vars_decided_tobase_i_8, vars_decided_tobase_i_9, vars_decided_tobase_i_10, vars_decided_tobase_i_11, vars_decided_tobase_i_12, vars_decided_tobase_i_13, vars_decided_tobase_i_14, vars_decided_tobase_i_15, vars_decided_tobase_i_16, vars_decided_tobase_i_17, vars_decided_tobase_i_18, vars_decided_tobase_i_19, vars_decided_tobase_i_20, vars_decided_tobase_i_21, vars_decided_tobase_i_22, vars_decided_tobase_i_23;
	wire decide_level_i_0, decide_level_i_1, decide_level_i_2, decide_level_i_3, decide_level_i_4, decide_level_i_5, decide_level_i_6, decide_level_i_7, decide_level_i_8, decide_level_i_9, decide_level_i_10, decide_level_i_11, decide_level_i_12, decide_level_i_13, decide_level_i_14, decide_level_i_15, decide_level_i_16, decide_level_i_17, decide_level_i_18, decide_level_i_19, decide_level_i_20, decide_level_i_21, decide_level_i_22, decide_level_i_23;
	wire find_conflict_o_0, find_conflict_o_1, find_conflict_o_2, find_conflict_o_3, find_conflict_o_4, find_conflict_o_5, find_conflict_o_6, find_conflict_o_7, find_conflict_o_8, find_conflict_o_9, find_conflict_o_10, find_conflict_o_11, find_conflict_o_12, find_conflict_o_13, find_conflict_o_14, find_conflict_o_15, find_conflict_o_16, find_conflict_o_17, find_conflict_o_18, find_conflict_o_19, find_conflict_o_20, find_conflict_o_21, find_conflict_o_22, find_conflict_o_23;
	wire find_imply_o_0, find_imply_o_1, find_imply_o_2, find_imply_o_3, find_imply_o_4, find_imply_o_5, find_imply_o_6, find_imply_o_7, find_imply_o_8, find_imply_o_9, find_imply_o_10, find_imply_o_11, find_imply_o_12, find_imply_o_13, find_imply_o_14, find_imply_o_15, find_imply_o_16, find_imply_o_17, find_imply_o_18, find_imply_o_19, find_imply_o_20, find_imply_o_21, find_imply_o_22, find_imply_o_23;
	wire [1:0] load_clauses_0, load_clauses_1, load_clauses_2, load_clauses_3, load_clauses_4, load_clauses_5, load_clauses_6, load_clauses_7, load_clauses_8, load_clauses_9, load_clauses_10, load_clauses_11, load_clauses_12, load_clauses_13, load_clauses_14, load_clauses_15, load_clauses_16, load_clauses_17, load_clauses_18, load_clauses_19, load_clauses_20, load_clauses_21, load_clauses_22, load_clauses_23;
	wire [1:0] update_clause_o_0, update_clause_o_1, update_clause_o_2, update_clause_o_3, update_clause_o_4, update_clause_o_5, update_clause_o_6, update_clause_o_7, update_clause_o_8, update_clause_o_9, update_clause_o_10, update_clause_o_11, update_clause_o_12, update_clause_o_13, update_clause_o_14, update_clause_o_15, update_clause_o_16, update_clause_o_17, update_clause_o_18, update_clause_o_19, update_clause_o_20, update_clause_o_21, update_clause_o_22, update_clause_o_23;
	wire [WIDTH_VAR_STATES-1:0] vars_states_0, vars_states_1, vars_states_2, vars_states_3, vars_states_4, vars_states_5, vars_states_6, vars_states_7, vars_states_8, vars_states_9, vars_states_10, vars_states_11, vars_states_12, vars_states_13, vars_states_14, vars_states_15, vars_states_16, vars_states_17, vars_states_18, vars_states_19, vars_states_20, vars_states_21, vars_states_22, vars_states_23;
	wire [NUM_VARS_A_BIN-1:0] learnt_lit_o_0, learnt_lit_o_1, learnt_lit_o_2, learnt_lit_o_3, learnt_lit_o_4, learnt_lit_o_5, learnt_lit_o_6, learnt_lit_o_7, learnt_lit_o_8, learnt_lit_o_9, learnt_lit_o_10, learnt_lit_o_11, learnt_lit_o_12, learnt_lit_o_13, learnt_lit_o_14, learnt_lit_o_15, learnt_lit_o_16, learnt_lit_o_17, learnt_lit_o_18, learnt_lit_o_19, learnt_lit_o_20, learnt_lit_o_21, learnt_lit_o_22, learnt_lit_o_23;
	wire [NUM_VARS_A_BIN-1:0] var_level_o_0, var_level_o_1, var_level_o_2, var_level_o_3, var_level_o_4, var_level_o_5, var_level_o_6, var_level_o_7, var_level_o_8, var_level_o_9, var_level_o_10, var_level_o_11, var_level_o_12, var_level_o_13, var_level_o_14, var_level_o_15, var_level_o_16, var_level_o_17, var_level_o_18, var_level_o_19, var_level_o_20, var_level_o_21, var_level_o_22, var_level_o_23;

	assign {var_value_i_0, var_value_i_1, var_value_i_2, var_value_i_3, var_value_i_4, var_value_i_5, var_value_i_6, var_value_i_7, var_value_i_8, var_value_i_9, var_value_i_10, var_value_i_11, var_value_i_12, var_value_i_13, var_value_i_14, var_value_i_15, var_value_i_16, var_value_i_17, var_value_i_18, var_value_i_19, var_value_i_20, var_value_i_21, var_value_i_22, var_value_i_23} = var_value_i;
	assign var_value_o = {var_value_o_0, var_value_o_1, var_value_o_2, var_value_o_3, var_value_o_4, var_value_o_5, var_value_o_6, var_value_o_7, var_value_o_8, var_value_o_9, var_value_o_10, var_value_o_11, var_value_o_12, var_value_o_13, var_value_o_14, var_value_o_15, var_value_o_16, var_value_o_17, var_value_o_18, var_value_o_19, var_value_o_20, var_value_o_21, var_value_o_22, var_value_o_23};

	assign {vars_decided_tobase_i_0, vars_decided_tobase_i_1, vars_decided_tobase_i_2, vars_decided_tobase_i_3, vars_decided_tobase_i_4, vars_decided_tobase_i_5, vars_decided_tobase_i_6, vars_decided_tobase_i_7, vars_decided_tobase_i_8, vars_decided_tobase_i_9, vars_decided_tobase_i_10, vars_decided_tobase_i_11, vars_decided_tobase_i_12, vars_decided_tobase_i_13, vars_decided_tobase_i_14, vars_decided_tobase_i_15, vars_decided_tobase_i_16, vars_decided_tobase_i_17, vars_decided_tobase_i_18, vars_decided_tobase_i_19, vars_decided_tobase_i_20, vars_decided_tobase_i_21, vars_decided_tobase_i_22, vars_decided_tobase_i_23} = vars_decided_tobase_i;

	assign {decide_level_i_0, decide_level_i_1, decide_level_i_2, decide_level_i_3, decide_level_i_4, decide_level_i_5, decide_level_i_6, decide_level_i_7, decide_level_i_8, decide_level_i_9, decide_level_i_10, decide_level_i_11, decide_level_i_12, decide_level_i_13, decide_level_i_14, decide_level_i_15, decide_level_i_16, decide_level_i_17, decide_level_i_18, decide_level_i_19, decide_level_i_20, decide_level_i_21, decide_level_i_22, decide_level_i_23} = decide_level_i;

	wire [NUM_VARS_A_BIN-1:0] find_conflict_cur, find_imply_cur;
	reg [NUM_VARS_A_BIN-1:0] find_conflict_pre, find_imply_pre;
	assign find_conflict_cur = {find_conflict_o_0, find_conflict_o_1, find_conflict_o_2, find_conflict_o_3, find_conflict_o_4, find_conflict_o_5, find_conflict_o_6, find_conflict_o_7, find_conflict_o_8, find_conflict_o_9, find_conflict_o_10, find_conflict_o_11, find_conflict_o_12, find_conflict_o_13, find_conflict_o_14, find_conflict_o_15, find_conflict_o_16, find_conflict_o_17, find_conflict_o_18, find_conflict_o_19, find_conflict_o_20, find_conflict_o_21, find_conflict_o_22, find_conflict_o_23};

	assign find_imply_cur = {find_imply_o_0, find_imply_o_1, find_imply_o_2, find_imply_o_3, find_imply_o_4, find_imply_o_5, find_imply_o_6, find_imply_o_7, find_imply_o_8, find_imply_o_9, find_imply_o_10, find_imply_o_11, find_imply_o_12, find_imply_o_13, find_imply_o_14, find_imply_o_15, find_imply_o_16, find_imply_o_17, find_imply_o_18, find_imply_o_19, find_imply_o_20, find_imply_o_21, find_imply_o_22, find_imply_o_23};

	always @(posedge clk)
	begin
		if(rst)
			find_imply_pre <= 0;
		else
			find_imply_pre <= find_imply_cur;
	end

	always @(posedge clk)
	begin
		if(rst)
			done_imply_o <= 0;
		else if(apply_implication_i && find_imply_cur!=find_imply_pre)
			done_imply_o <= 1;
		else
			done_imply_o <= 0;
	end

	//analyze conflict and learn conflict clause

	parameter	ANALYZE_IDLE = 0,
				FIND_CONFLICT_CLAUSE = 1,
				ADD_LEARNT_CLAUSE = 2,
				BACKTRACK = 3,
				ANALYZE_DONE = 4;

	reg [1:0] c_analyze_state, n_analyze_state;
	
	always @(posedge clk)
	begin
		if(rst)
			c_analyze_state <= 0;
		else
			c_analyze_state <= n_analyze_state;
	end

	always @(*)
	begin
		if(rst)
			n_analyze_state = 0;
		else
			case(c_analyze_state)
				ANALYZE_IDLE:
					if(apply_analyze_i)
						n_analyze_state = FIND_CONFLICT_CLAUSE;
					else
						n_analyze_state = ANALYZE_IDLE;
				FIND_CONFLICT_CLAUSE:
					if(find_conflict_cur!=find_conflict_pre)
						n_analyze_state = ADD_LEARNT_CLAUSE;
					else
						n_analyze_state = FIND_CONFLICT_CLAUSE;
				ADD_LEARNT_CLAUSE:
					if(bkt_bin_num_o!=cur_bin_num_i || exist_var_not_vbkt_o)
						n_analyze_state = ANALYZE_DONE;
					else
						n_analyze_state = BACKTRACK;
				BACKTRACK:
					n_analyze_state = ANALYZE_DONE;
				ANALYZE_DONE:
					n_analyze_state = ANALYZE_IDLE;
				default:
					n_analyze_state = ANALYZE_IDLE;
			endcase
	end

	assign exist_var_not_vbkt_o = exist_var_not_vbkt_o_0 | exist_var_not_vbkt_o_1 | exist_var_not_vbkt_o_2 | exist_var_not_vbkt_o_3 | exist_var_not_vbkt_o_4 | exist_var_not_vbkt_o_5 | exist_var_not_vbkt_o_6 | exist_var_not_vbkt_o_7 | exist_var_not_vbkt_o_8 | exist_var_not_vbkt_o_9 | exist_var_not_vbkt_o_10 | exist_var_not_vbkt_o_11 | exist_var_not_vbkt_o_12 | exist_var_not_vbkt_o_13 | exist_var_not_vbkt_o_14 | exist_var_not_vbkt_o_15 | exist_var_not_vbkt_o_16 | exist_var_not_vbkt_o_17 | exist_var_not_vbkt_o_18 | exist_var_not_vbkt_o_19 | exist_var_not_vbkt_o_20 | exist_var_not_vbkt_o_21 | exist_var_not_vbkt_o_22 | exist_var_not_vbkt_o_23;

	reg [NUM_CLAUSES_A_BIN/2-1:0] insert_pointer;
	wire [9:0] clause_len_12, clause_len_13, clause_len_14, clause_len_15, clause_len_16, clause_len_17, clause_len_18, clause_len_19, clause_len_20, clause_len_21, clause_len_22, clause_len_23;
	assign {clause_len_12, clause_len_13, clause_len_14, clause_len_15, clause_len_16, clause_len_17, clause_len_18, clause_len_19, clause_len_20, clause_len_21, clause_len_22, clause_len_23} = clause_len_i;

	wire [9:0] max_len1 = clause_len_12>clause_len_13? clause_len_12:clause_len_13;
	wire [9:0] max_len2 = clause_len_14>clause_len_15? clause_len_14:clause_len_15;
	wire [9:0] max_len3 = clause_len_16>clause_len_17? clause_len_16:clause_len_17;
	wire [9:0] max_len4 = clause_len_18>clause_len_19? clause_len_18:clause_len_19;
	wire [9:0] max_len5 = clause_len_20>clause_len_21? clause_len_20:clause_len_21;
	wire [9:0] max_len6 = clause_len_22>clause_len_23? clause_len_22:clause_len_23;
	wire [9:0] max_len12 = max_len1>max_len2? max_len1:max_len2;
	wire [9:0] max_len34 = max_len3>max_len4? max_len3:max_len4;
	wire [9:0] max_len56 = max_len5>max_len6? max_len5:max_len6;
	wire [9:0] max_len1234 = max_len12>max_len34? max_len12:max_len34;
	wire [9:0] max_len = max_len1234>max_len56? max_len1234:max_len56;

	always @(posedge clk)
	begin
		if(~rst) begin
			insert_pointer[0] <= 0;
			insert_pointer[1] <= 0;
			insert_pointer[2] <= 0;
			insert_pointer[3] <= 0;
			insert_pointer[4] <= 0;
			insert_pointer[5] <= 0;
			insert_pointer[6] <= 0;
			insert_pointer[7] <= 0;
			insert_pointer[8] <= 0;
			insert_pointer[9] <= 0;
			insert_pointer[10] <= 0;
			insert_pointer[11] <= 0;
		end
		else if(c_analyze_state == ADD_LEARNT_CLAUSE) begin
			insert_pointer[0] <= clause_len_12 == max_len;
			insert_pointer[1] <= clause_len_13 == max_len;
			insert_pointer[2] <= clause_len_14 == max_len;
			insert_pointer[3] <= clause_len_15 == max_len;
			insert_pointer[4] <= clause_len_16 == max_len;
			insert_pointer[5] <= clause_len_17 == max_len;
			insert_pointer[6] <= clause_len_18 == max_len;
			insert_pointer[7] <= clause_len_19 == max_len;
			insert_pointer[8] <= clause_len_20 == max_len;
			insert_pointer[9] <= clause_len_21 == max_len;
			insert_pointer[10] <= clause_len_22 == max_len;
			insert_pointer[11] <= clause_len_23 == max_len;
		end
		else begin
			insert_pointer[0] <= 0;
			insert_pointer[1] <= 0;
			insert_pointer[2] <= 0;
			insert_pointer[3] <= 0;
			insert_pointer[4] <= 0;
			insert_pointer[5] <= 0;
			insert_pointer[6] <= 0;
			insert_pointer[7] <= 0;
			insert_pointer[8] <= 0;
			insert_pointer[9] <= 0;
			insert_pointer[10] <= 0;
			insert_pointer[11] <= 0;
		end
	end

	//find backtrack level
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_0 = var_level_o_1>var_level_o_0? var_level_o_1:var_level_o_0;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_1 = var_level_o_3>var_level_o_2? var_level_o_3:var_level_o_2;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_2 = var_level_o_5>var_level_o_4? var_level_o_5:var_level_o_4;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_3 = var_level_o_7>var_level_o_6? var_level_o_7:var_level_o_6;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_4 = var_level_o_9>var_level_o_8? var_level_o_9:var_level_o_8;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_5 = var_level_o_11>var_level_o_10? var_level_o_11:var_level_o_10;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_6 = var_level_o_13>var_level_o_12? var_level_o_13:var_level_o_12;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_7 = var_level_o_15>var_level_o_14? var_level_o_15:var_level_o_14;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_8 = var_level_o_17>var_level_o_16? var_level_o_17:var_level_o_16;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_9 = var_level_o_19>var_level_o_18? var_level_o_19:var_level_o_18;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_10 = var_level_o_21>var_level_o_20? var_level_o_21:var_level_o_20;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_0_11 = var_level_o_23>var_level_o_22? var_level_o_23:var_level_o_22;

	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_1_0 = max_lvl_0_1>max_lvl_0_0? max_lvl_0_1:max_lvl_0_0;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_1_1 = max_lvl_0_3>max_lvl_0_2? max_lvl_0_3:max_lvl_0_2;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_1_2 = max_lvl_0_5>max_lvl_0_4? max_lvl_0_5:max_lvl_0_4;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_1_3 = max_lvl_0_7>max_lvl_0_6? max_lvl_0_7:max_lvl_0_6;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_1_4 = max_lvl_0_9>max_lvl_0_8? max_lvl_0_9:max_lvl_0_8;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_1_5 = max_lvl_11>max_lvl_10? max_lvl_11:max_lvl_10;

	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_2_0 = max_lvl_1_1>max_lvl_1_0? max_lvl_1_1:max_lvl_1_0;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_2_1 = max_lvl_1_3>max_lvl_1_2? max_lvl_1_3:max_lvl_1_2;
	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_2_2 = max_lvl_1_5>max_lvl_1_4? max_lvl_1_5:max_lvl_1_4;

	wire [WIDTH_VAR_STATES-1 : 0] max_lvl_3_0 = max_lvl_2_1>max_lvl_2_0? max_lvl_2_1:max_lvl_2_0;
	wire [WIDTH_VAR_STATES-1 : 0] bkt_lvl = max_lvl_3_0>max_lvl_2_2? max_lvl_3_0:max_lvl_2_2;
	
	wire [9:0] bkt_bin_num_o_0, bkt_bin_num_o_1, bkt_bin_num_o_2, bkt_bin_num_o_3, bkt_bin_num_o_4, bkt_bin_num_o_5, bkt_bin_num_o_6, bkt_bin_num_o_7, bkt_bin_num_o_8, bkt_bin_num_o_9, bkt_bin_num_o_10, bkt_bin_num_o_11, bkt_bin_num_o_12, bkt_bin_num_o_13, bkt_bin_num_o_14, bkt_bin_num_o_15, bkt_bin_num_o_16, bkt_bin_num_o_17, bkt_bin_num_o_18, bkt_bin_num_o_19, bkt_bin_num_o_20, bkt_bin_num_o_21, bkt_bin_num_o_22, bkt_bin_num_o_23;

	always @(posedge clk)
	begin
		if(~rst)
			bkt_bin_num_o <= 0;
		else if(c_analyze_state==ADD_LEARNT_CLAUSE)
			bkt_bin_num_o <= bkt_bin_num_o_0 | bkt_bin_num_o_1 | bkt_bin_num_o_2 | bkt_bin_num_o_3 | bkt_bin_num_o_4 | bkt_bin_num_o_5 | bkt_bin_num_o_6 | bkt_bin_num_o_7 | bkt_bin_num_o_8 | bkt_bin_num_o_9 | bkt_bin_num_o_10 | bkt_bin_num_o_11 | bkt_bin_num_o_12 | bkt_bin_num_o_13 | bkt_bin_num_o_14 | bkt_bin_num_o_15 | bkt_bin_num_o_16 | bkt_bin_num_o_17 | bkt_bin_num_o_18 | bkt_bin_num_o_19 | bkt_bin_num_o_20 | bkt_bin_num_o_21 | bkt_bin_num_o_22 | bkt_bin_num_o_23;
		else
			bkt_bin_num_o <= bkt_bin_num_o;
	end

	//backtrack
	reg apply_backtrack_r;

	always @(posedge clk)
	begin
		if(~rst)
			apply_backtrack_r <= 0;
		else if(c_analyze_state==BACKTRACK)
			apply_backtrack_r <= 1;
		else
			apply_backtrack_r <= 0;
	end

	always @(posedge clk)
	begin
		if(~rst)
			done_analyze_o <= 0;
		else if(c_analyze_state==ANALYZE_DONE)
			done_analyze_o <= 1;
		else
			done_analyze_o <= 0;
	end

	//use to decide whether the bin is independent
	wire is_independent_bin_0, is_independent_bin_1, is_independent_bin_2, is_independent_bin_3, is_independent_bin_4, is_independent_bin_5, is_independent_bin_6, is_independent_bin_7, is_independent_bin_8, is_independent_bin_9, is_independent_bin_10, is_independent_bin_11, is_independent_bin_12, is_independent_bin_13, is_independent_bin_14, is_independent_bin_15, is_independent_bin_16, is_independent_bin_17, is_independent_bin_18, is_independent_bin_19, is_independent_bin_20, is_independent_bin_21, is_independent_bin_22, is_independent_bin_23;

	assign is_independent_bin_o = is_independent_bin_0 & is_independent_bin_1 & is_independent_bin_2 & is_independent_bin_3 & is_independent_bin_4 & is_independent_bin_5 & is_independent_bin_6 & is_independent_bin_7 & is_independent_bin_8 & is_independent_bin_9 & is_independent_bin_10 & is_independent_bin_11 & is_independent_bin_12 & is_independent_bin_13 & is_independent_bin_14 & is_independent_bin_15 & is_independent_bin_16 & is_independent_bin_17 & is_independent_bin_18 & is_independent_bin_19 & is_independent_bin_20 & is_independent_bin_21 & is_independent_bin_22 & is_independent_bin_23;

	// load update
	wire wr_var_states;
	assign wr_var_states = set_vars_states_i | get_vars_states_i;

	assign {load_clauses_0, load_clauses_1, load_clauses_2, load_clauses_3, load_clauses_4, load_clauses_5, load_clauses_6, load_clauses_7, load_clauses_8, load_clauses_9, load_clauses_10, load_clauses_11, load_clauses_12, load_clauses_13, load_clauses_14, load_clauses_15, load_clauses_16, load_clauses_17, load_clauses_18, load_clauses_19, load_clauses_20, load_clauses_21, load_clauses_22, load_clauses_23} = load_clauses_i;

	assign update_clause_o = {update_clause_o_0, update_clause_o_1, update_clause_o_2, update_clause_o_3, update_clause_o_4, update_clause_o_5, update_clause_o_6, update_clause_o_7, update_clause_o_8, update_clause_o_9, update_clause_o_10, update_clause_o_11, update_clause_o_12, update_clause_o_13, update_clause_o_14, update_clause_o_15, update_clause_o_16, update_clause_o_17, update_clause_o_18, update_clause_o_19, update_clause_o_20, update_clause_o_21, update_clause_o_22, update_clause_o_23};

	assign vars_states_o = vars_states_0;
	assign vars_states_23 = vars_states_i;

	base_cell base_cell0 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_0),
		.var_value_o(var_value_o_0),
		.vars_decided_tobase_i(vars_decided_tobase_i_0),
		.decide_level_i(decide_level_i_0),
		.find_conflict_o(find_conflict_o_0),
		.find_imply_o(find_imply_o_0),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_0),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_0),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_1),
		.vars_states_o(vars_states_0),
		.learnt_lit_o(learnt_lit_o_0),
		.var_level_o(var_level_o_0)
	)

	base_cell base_cell1 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_1),
		.var_value_o(var_value_o_1),
		.vars_decided_tobase_i(vars_decided_tobase_i_1),
		.decide_level_i(decide_level_i_1),
		.find_conflict_o(find_conflict_o_1),
		.find_imply_o(find_imply_o_1),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_1),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_1),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_2),
		.vars_states_o(vars_states_1),
		.learnt_lit_o(learnt_lit_o_1),
		.var_level_o(var_level_o_1)
	)

	base_cell base_cell2 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_2),
		.var_value_o(var_value_o_2),
		.vars_decided_tobase_i(vars_decided_tobase_i_2),
		.decide_level_i(decide_level_i_2),
		.find_conflict_o(find_conflict_o_2),
		.find_imply_o(find_imply_o_2),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_2),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_2),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_3),
		.vars_states_o(vars_states_2),
		.learnt_lit_o(learnt_lit_o_2),
		.var_level_o(var_level_o_2)
	)

	base_cell base_cell3 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_3),
		.var_value_o(var_value_o_3),
		.vars_decided_tobase_i(vars_decided_tobase_i_3),
		.decide_level_i(decide_level_i_3),
		.find_conflict_o(find_conflict_o_3),
		.find_imply_o(find_imply_o_3),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_3),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_3),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_4),
		.vars_states_o(vars_states_3),
		.learnt_lit_o(learnt_lit_o_3),
		.var_level_o(var_level_o_3)
	)

	base_cell base_cell4 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_4),
		.var_value_o(var_value_o_4),
		.vars_decided_tobase_i(vars_decided_tobase_i_4),
		.decide_level_i(decide_level_i_4),
		.find_conflict_o(find_conflict_o_4),
		.find_imply_o(find_imply_o_4),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_4),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_4),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_5),
		.vars_states_o(vars_states_4),
		.learnt_lit_o(learnt_lit_o_4),
		.var_level_o(var_level_o_4)
	)

	base_cell base_cell5 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_5),
		.var_value_o(var_value_o_5),
		.vars_decided_tobase_i(vars_decided_tobase_i_5),
		.decide_level_i(decide_level_i_5),
		.find_conflict_o(find_conflict_o_5),
		.find_imply_o(find_imply_o_5),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_5),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_5),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_6),
		.vars_states_o(vars_states_5),
		.learnt_lit_o(learnt_lit_o_5),
		.var_level_o(var_level_o_5)
	)

	base_cell base_cell6 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_6),
		.var_value_o(var_value_o_6),
		.vars_decided_tobase_i(vars_decided_tobase_i_6),
		.decide_level_i(decide_level_i_6),
		.find_conflict_o(find_conflict_o_6),
		.find_imply_o(find_imply_o_6),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_6),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_6),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_7),
		.vars_states_o(vars_states_6),
		.learnt_lit_o(learnt_lit_o_6),
		.var_level_o(var_level_o_6)
	)

	base_cell base_cell7 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_7),
		.var_value_o(var_value_o_7),
		.vars_decided_tobase_i(vars_decided_tobase_i_7),
		.decide_level_i(decide_level_i_7),
		.find_conflict_o(find_conflict_o_7),
		.find_imply_o(find_imply_o_7),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_7),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_7),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_8),
		.vars_states_o(vars_states_7),
		.learnt_lit_o(learnt_lit_o_7),
		.var_level_o(var_level_o_7)
	)

	base_cell base_cell8 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_8),
		.var_value_o(var_value_o_8),
		.vars_decided_tobase_i(vars_decided_tobase_i_8),
		.decide_level_i(decide_level_i_8),
		.find_conflict_o(find_conflict_o_8),
		.find_imply_o(find_imply_o_8),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_8),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_8),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_9),
		.vars_states_o(vars_states_8),
		.learnt_lit_o(learnt_lit_o_8),
		.var_level_o(var_level_o_8)
	)

	base_cell base_cell9 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_9),
		.var_value_o(var_value_o_9),
		.vars_decided_tobase_i(vars_decided_tobase_i_9),
		.decide_level_i(decide_level_i_9),
		.find_conflict_o(find_conflict_o_9),
		.find_imply_o(find_imply_o_9),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_9),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_9),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_10),
		.vars_states_o(vars_states_9),
		.learnt_lit_o(learnt_lit_o_9),
		.var_level_o(var_level_o_9)
	)

	base_cell base_cell10 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_10),
		.var_value_o(var_value_o_10),
		.vars_decided_tobase_i(vars_decided_tobase_i_10),
		.decide_level_i(decide_level_i_10),
		.find_conflict_o(find_conflict_o_10),
		.find_imply_o(find_imply_o_10),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_10),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_10),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_11),
		.vars_states_o(vars_states_10),
		.learnt_lit_o(learnt_lit_o_10),
		.var_level_o(var_level_o_10)
	)

	base_cell base_cell11 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_11),
		.var_value_o(var_value_o_11),
		.vars_decided_tobase_i(vars_decided_tobase_i_11),
		.decide_level_i(decide_level_i_11),
		.find_conflict_o(find_conflict_o_11),
		.find_imply_o(find_imply_o_11),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_11),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_11),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_12),
		.vars_states_o(vars_states_11),
		.learnt_lit_o(learnt_lit_o_11),
		.var_level_o(var_level_o_11)
	)

	base_cell base_cell12 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_12),
		.var_value_o(var_value_o_12),
		.vars_decided_tobase_i(vars_decided_tobase_i_12),
		.decide_level_i(decide_level_i_12),
		.find_conflict_o(find_conflict_o_12),
		.find_imply_o(find_imply_o_12),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_12),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_12),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_13),
		.vars_states_o(vars_states_12),
		.learnt_lit_o(learnt_lit_o_12),
		.var_level_o(var_level_o_12)
	)

	base_cell base_cell13 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_13),
		.var_value_o(var_value_o_13),
		.vars_decided_tobase_i(vars_decided_tobase_i_13),
		.decide_level_i(decide_level_i_13),
		.find_conflict_o(find_conflict_o_13),
		.find_imply_o(find_imply_o_13),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_13),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_13),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_14),
		.vars_states_o(vars_states_13),
		.learnt_lit_o(learnt_lit_o_13),
		.var_level_o(var_level_o_13)
	)

	base_cell base_cell14 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_14),
		.var_value_o(var_value_o_14),
		.vars_decided_tobase_i(vars_decided_tobase_i_14),
		.decide_level_i(decide_level_i_14),
		.find_conflict_o(find_conflict_o_14),
		.find_imply_o(find_imply_o_14),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_14),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_14),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_15),
		.vars_states_o(vars_states_14),
		.learnt_lit_o(learnt_lit_o_14),
		.var_level_o(var_level_o_14)
	)

	base_cell base_cell15 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_15),
		.var_value_o(var_value_o_15),
		.vars_decided_tobase_i(vars_decided_tobase_i_15),
		.decide_level_i(decide_level_i_15),
		.find_conflict_o(find_conflict_o_15),
		.find_imply_o(find_imply_o_15),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_15),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_15),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_16),
		.vars_states_o(vars_states_15),
		.learnt_lit_o(learnt_lit_o_15),
		.var_level_o(var_level_o_15)
	)

	base_cell base_cell16 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_16),
		.var_value_o(var_value_o_16),
		.vars_decided_tobase_i(vars_decided_tobase_i_16),
		.decide_level_i(decide_level_i_16),
		.find_conflict_o(find_conflict_o_16),
		.find_imply_o(find_imply_o_16),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_16),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_16),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_17),
		.vars_states_o(vars_states_16),
		.learnt_lit_o(learnt_lit_o_16),
		.var_level_o(var_level_o_16)
	)

	base_cell base_cell17 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_17),
		.var_value_o(var_value_o_17),
		.vars_decided_tobase_i(vars_decided_tobase_i_17),
		.decide_level_i(decide_level_i_17),
		.find_conflict_o(find_conflict_o_17),
		.find_imply_o(find_imply_o_17),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_17),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_17),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_18),
		.vars_states_o(vars_states_17),
		.learnt_lit_o(learnt_lit_o_17),
		.var_level_o(var_level_o_17)
	)

	base_cell base_cell18 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_18),
		.var_value_o(var_value_o_18),
		.vars_decided_tobase_i(vars_decided_tobase_i_18),
		.decide_level_i(decide_level_i_18),
		.find_conflict_o(find_conflict_o_18),
		.find_imply_o(find_imply_o_18),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_18),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_18),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_19),
		.vars_states_o(vars_states_18),
		.learnt_lit_o(learnt_lit_o_18),
		.var_level_o(var_level_o_18)
	)

	base_cell base_cell19 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_19),
		.var_value_o(var_value_o_19),
		.vars_decided_tobase_i(vars_decided_tobase_i_19),
		.decide_level_i(decide_level_i_19),
		.find_conflict_o(find_conflict_o_19),
		.find_imply_o(find_imply_o_19),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_19),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_19),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_20),
		.vars_states_o(vars_states_19),
		.learnt_lit_o(learnt_lit_o_19),
		.var_level_o(var_level_o_19)
	)

	base_cell base_cell20 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_20),
		.var_value_o(var_value_o_20),
		.vars_decided_tobase_i(vars_decided_tobase_i_20),
		.decide_level_i(decide_level_i_20),
		.find_conflict_o(find_conflict_o_20),
		.find_imply_o(find_imply_o_20),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_20),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_20),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_21),
		.vars_states_o(vars_states_20),
		.learnt_lit_o(learnt_lit_o_20),
		.var_level_o(var_level_o_20)
	)

	base_cell base_cell21 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_21),
		.var_value_o(var_value_o_21),
		.vars_decided_tobase_i(vars_decided_tobase_i_21),
		.decide_level_i(decide_level_i_21),
		.find_conflict_o(find_conflict_o_21),
		.find_imply_o(find_imply_o_21),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_21),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_21),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_22),
		.vars_states_o(vars_states_21),
		.learnt_lit_o(learnt_lit_o_21),
		.var_level_o(var_level_o_21)
	)

	base_cell base_cell22 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_22),
		.var_value_o(var_value_o_22),
		.vars_decided_tobase_i(vars_decided_tobase_i_22),
		.decide_level_i(decide_level_i_22),
		.find_conflict_o(find_conflict_o_22),
		.find_imply_o(find_imply_o_22),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_22),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_22),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_23),
		.vars_states_o(vars_states_22),
		.learnt_lit_o(learnt_lit_o_22),
		.var_level_o(var_level_o_22)
	)

	base_cell base_cell23 #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.var_value_i(var_value_i_23),
		.var_value_o(var_value_o_23),
		.vars_decided_tobase_i(vars_decided_tobase_i_23),
		.decide_level_i(decide_level_i_23),
		.find_conflict_o(find_conflict_o_23),
		.find_imply_o(find_imply_o_23),
		.apply_analyze_i(apply_analyze_i),
		.apply_load_i(apply_load_i),
		.load_clauses_i(load_clauses_23),
		.apply_update_i(apply_update_i),
		.update_clause_o(update_clause_o_23),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_24),
		.vars_states_o(vars_states_23),
		.learnt_lit_o(learnt_lit_o_23),
		.var_level_o(var_level_o_23)
	)


endmodule
