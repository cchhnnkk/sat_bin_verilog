module control #(

	parameter ADDR_WIDTH = 31,
	parameter NUM_VARS_A_BIN = 18

)
(
	input  clk, 
	input  rst, 

	input start,
	output reg done,

	output reg apply_implication_o,
	input done_implication_i,
	input conflict_i,
	
	output reg start_decision_o,
	input done_decision_i,
	input [15:0] cur_level_i,

	output reg apply_analyze_o,
	input done_analyze_i,
	input [15:0] bkt_bin_num_i,
	input is_independent_bin_i,
	input exist_var_not_vbkt_i,

	output reg apply_backtrack_o,
	input done_backtrack_i,

	output reg global_sat_o,
	output reg global_unsat_o,

	input [15:0] total_bin_num_i,
	output reg start_load_o,
	output reg apply_load_o,
	output reg [WIDTH_BIN_I-1, 0] request_bin_num_o,
	input done_load_i,

	output reg start_update_o,
	output reg apply_update_o,
	input done_update_i
);

	reg [15:0] cur_bin_num;

	parameter	IDLE = 0,
				LOAD_BIN = 1,
				BCP = 2,
				DECISION = 3,
				ANALYSIS = 4,
				BACKTRACK = 5,
				PARTIAL_SAT = 6,
				PARTIAL_UNSAT = 7,
				GLOBAL_SAT = 8,
				GLOBAL_UNSAT = 9;

	reg [3:0] c_state, n_state;
	reg [31:0] wait_cnt, w_cnt, r_cnt;
	reg [31:0] w_clk_cnt, r_clk_cnt;
	
	always @(posedge clk)
	begin
		if(~rst)
			c_state <= 0;
		else
			c_state <= n_state;
	end

	always @(*) begin: set_next_state
		if(~rst)
			n_state = 0;
		else
			case(c_state)
				IDLE:
					if(start)
						n_state = LOAD_BIN;
					else
						n_state = IDLE;
				LOAD_BIN:
					if(done_load_i)
						n_state = BCP;
					else
						n_state = LOAD_BIN;
				BCP:
					if(done_bcp_i && conflict)
						n_state = ANALYSIS;
					else if(done_bcp_i && ~conflict)
						n_state = DECISION;
					else
						n_state = BCP;
				DECISION:
					if(done_decision_i && issat_i)
						n_state = SAT;
					else if(done_decision_i && ~issat_i)
						n_state = BCP;
					else
						n_state = DECISION;
				ANALYSIS:
					if(is_independent_bin_i || exist_var_not_vbkt_i)
						n_state = GLOBAL_UNSAT;
					else if(done_analysis_i && bkt_bin_num_i!=cur_bin_num)
						n_state = PARTIAL_UNSAT
					else if(done_analysis_i && bkt_bin_num_i==cur_bin_num)
						n_state = BACKTRACK;
					else
						n_state = ANALYSIS;
				BACKTRACK:
					if(done_backtrack_i)
						n_state = DECISION;
					else
						n_state = BACKTRACK;
				PARTIAL_SAT:
					if(done_update_i)
						n_state = LOAD_BIN;
					else
						n_state = PARTIAL_SAT;
				PARTIAL_UNSAT:
					if(done_update_i)
						n_state = LOAD_BIN;
					else
						n_state = PARTIAL_UNSAT;
				GLOBAL_SAT:
					n_state = GLOBAL_SAT;
				GLOBAL_UNSAT:
					n_state = GLOBAL_UNSAT;

				default:
					n_state = IDLE;
			endcase
	end

	always @(posedge clk)
	begin
		if(~rst)
			global_sat_o <= 0;
		else if(done_update_i && c_state==GLOBAL_SAT)
			global_sat_o <= 1;
		else
			global_sat_o <= global_sat_o;
	end
	
	always @(posedge clk)
	begin
		if(~rst)
			global_unsat_o <= 0;
		else if(done_update_i && c_state==GLOBAL_UNSAT)
			global_unsat_o <= 1;
		else
			global_unsat_o <= global_unsat_o;
	end
	
	always @(posedge clk)
	begin
		if(~rst)
			done <= 0;
		else if(done_update_i && (c_state==GLOBAL_SAT || c_state==GLOBAL_UNSAT))
			done <= 1;
		else
			done <= done;
	end

	always @(posedge clk)
	begin
		if(~rst)
			apply_implication_o <= 0;
		else if(c_state==BCP)
			apply_implication_o <= 1;
		else
			apply_implication_o <= 0;
	end

	reg impulse_cnt[1:0];
	always @(posedge clk)
	begin
		if(~rst)
			impulse_cnt <= 0;
		else if(c_state==DECISION || c_state==LOAD_BIN || c_state==PARTIAL_UNSAT || c_state==PARTIAL_SAT)
		begin
			if (impulse_cnt == 0) 
				impulse_cnt <= 1;
			else
				impulse_cnt <= 2;
			
		end
		else
			impulse_cnt <= 0;
	end

	always @(posedge clk)
	begin
		if(~rst)
			start_decision_o <= 0;
		else if(c_state==DECISION && impulse_cnt==0)
			start_decision_o <= 1;
		else
			start_decision_o <= 0;
	end

	always @(posedge clk)
	begin
		if(~rst)
			apply_analyze_o <= 0;
		else if(c_state==ANALYSIS)
			apply_analyze_o <= 1;
		else
			apply_analyze_o <= 0;
	end

	always @(posedge clk)
	begin
		if(~rst)
			apply_backtrack_o <= 0;
		else if(c_state==BACKTRACK)
			apply_backtrack_o <= 1;
		else
			apply_backtrack_o <= 0;
	end

	always @(posedge clk)
	begin
		if(~rst) begin
			start_load_o <= 0;
			request_bin_num_o <= 0;
		end
		else if(c_state==LOAD_BIN && impulse_cnt==0) begin
			start_load_o <= 1;
			request_bin_num_o <= request_bin_num_o+1;
		end
		else begin
			start_load_o <= 0;
			request_bin_num_o <= 0;
		end
	end

	always @(posedge clk)
	begin
		if(~rst)
			apply_load_o <= 0;
		else if(c_state==LOAD_BIN)
			apply_load_o <= 1;
		else
			apply_load_o <= 0;
	end

	always @(posedge clk)
	begin
		if(~rst)
			start_update_o <= 0;
		else if((c_state==PARTIAL_UNSAT || c_state==PARTIAL_SAT)&& impulse_cnt==0)
			start_update_o <= 1;
		else
			start_update_o <= 0;
	end

	always @(posedge clk)
	begin
		if(~rst)
			apply_update_o <= 0;
		else if(c_state==LOAD_BIN)
			apply_update_o <= 1;
		else
			apply_update_o <= 0;
	end


endmodule
