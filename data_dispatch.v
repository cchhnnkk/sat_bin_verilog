module load_update_bin#(
								
	parameter NUM_CLAUSES_A_BIN = 24,
	parameter NUM_VARS_A_BIN = 24,
	parameter WIDTH_BIN_CLAUSES = 24*2,
	parameter WIDTH_BIN_VARS = 12,
	parameter WIDTH_BIN_I = 10,
	parameter WIDTH_BIN_ADDR = 10,
	parameter WIDTH_VAR_STATES = 30,
	parameter ADDR_WIDTH_CLAUSES = 9,
	parameter ADDR_WIDTH_VARS = 9,
	parameter ADDR_WIDTH_VARS_STATES = 9
)
(
	input  clk, 
	input  rst, 

	//load
	input start_load,
	input [WIDTH_BIN_I-1, 0] request_bin_i,

	//from bram
	input [WIDTH_BIN_CLAUSES, 0] bram_clauses_i,
	input [WIDTH_BIN_VARS-1, 0] bram_vars_i,
	input [WIDTH_VAR_STATES-1, 0] bram_vars_states_i,

	//to bram
	output [ADDR_WIDTH_CLAUSES-1:0] bram_addr_clauses_o,
	output [ADDR_WIDTH_VARS-1:0] bram_addr_vars_o,
	output [ADDR_WIDTH_VARS_STATES-1:0] bram_addr_vars_states_o,

	//to sat engine
	output [NUM_CLAUSES_A_BIN-1, 0] wr_clause_cells,
	output [WIDTH_BIN_CLAUSES, 0] clauses_o,
	output clauses_valid_o,
	output [WIDTH_VAR_STATES-1, 0] vars_states_o,
	output vars_states_valid_o,
	output load_done,

	//update
	input start_update,
	output [NUM_CLAUSES_A_BIN-1, 0] rd_clause_cells,

	//update data from sat engine
	input [WIDTH_BIN_CLAUSES, 0] clauses_i,
	input clauses_valid_i,
	input [WIDTH_VAR_STATES-1, 0] vars_states_i,
	input vars_states_valid_i,
	
	//update bram
	output [NUM_CLAUSES_A_BIN*2-1, 0] learnt_clauses_o,
	output [ADDR_WIDTH_CLAUSES-1:0] addr_learnt_clauses_o,
	output learnt_clauses_valid_o,
	output [WIDTH_VAR_STATES-1, 0] update_vars_states_o,
	output [ADDR_WIDTH_VARS_STATES-1:0] addr_update_vars_states_o,
	output update_vars_state_valid_o,
	output update_done
)

	/*
	*==========================================================================
	*									load bin
	*==========================================================================
	*/
	reg [WIDTH_BIN_ADDR-1, 0] clause_bin_i_base_addr;
	wire [WIDTH_BIN_ADDR-1, 0] var_bin_i_base_addr;

	always @(posedge clk)
	begin
		if(~rst)
			clause_bin_i_base_addr <= 0;
		else if(start_load)
			clause_bin_i_base_addr <= request_bin_i*NUM_CLAUSES_A_BIN; //i*24
		else
			clause_bin_i_base_addr <= clause_bin_i_base_addr;
	end
	assign var_bin_i_base_addr = clause_bin_i_base_addr; //i*24

	parameter	LOAD_IDLE = 0,
				LOAD_BIN = 1,
				LOAD_DONE = 2;

	reg [1:0] c_rd_state, n_rd_state;
	reg [5:0] rd_vars_cnt, rd_clauses_cnt;
	
	always @(posedge clk)
	begin
		if(rst)
			c_rd_state <= 0;
		else
			c_rd_state <= n_rd_state;
	end

	always @(*)
	begin
		if(rst)
			n_rd_state = 0;
		else
			case(c_rd_state)
				LOAD_IDLE:
					if(start_load)
						n_rd_state = LOAD_BIN;
					else
						n_rd_state = LOAD_IDLE;
				LOAD_BIN:
					if(rd_vars_cnt==NUM_VARS_A_BIN && rd_clauses_cnt==NUM_CLAUSES_A_BIN)
						n_rd_state = LOAD_DONE;
					else
						n_rd_state = LOAD_BIN;
				LOAD_DONE:
					n_rd_state = LOAD_IDLE;
				default:
					n_rd_state = LOAD_IDLE;
			endcase
	end
	
	always @(posedge clk)
		if (~rst)
			rd_vars_cnt <= 0;
		else if (c_rd_state==LOAD_BIN && rd_vars_cnt<NUM_VARS_A_BIN)
			rd_vars_cnt <= rd_vars_cnt+1;
		else if (c_rd_state==LOAD_BIN)
			rd_vars_cnt <= rd_vars_cnt;
		else
			rd_vars_cnt <= 0;
	end

	always @(posedge clk)
		if (~rst)
			rd_clauses_cnt <= 0;
		else if (c_rd_state==LOAD_BIN && rd_clauses_cnt<NUM_CLAUSES_A_BIN)
			rd_clauses_cnt <= rd_clauses_cnt+1;
		else if (c_rd_state==LOAD_BIN)
			rd_clauses_cnt <= rd_clauses_cnt;
		else
			rd_clauses_cnt <= 0;
	end

	reg [ADDR_WIDTH_VARS-1:0] bram_addr_vars_r;
	reg [ADDR_WIDTH_CLAUSES-1:0] bram_addr_clauses_r;
	reg [ADDR_WIDTH_VARS_STATES-1:0] bram_addr_vars_states_r;
	assign bram_addr_vars_o = bram_addr_vars_r;
	assign bram_addr_clauses_o = bram_addr_clauses_r;
	assign bram_addr_vars_states_o = bram_addr_vars_states_r;

	always @(posedge clk)
		if (~rst)
			bram_addr_vars_r <= 0;
		else if (c_rd_state==LOAD_BIN)
			bram_addr_vars_r <= var_bin_i_base_addr + rd_vars_cnt;
		else
			bram_addr_vars_r <= 0;
	end

	always @(posedge clk)
		if (~rst)
			bram_addr_clauses_r <= 0;
		else if (c_rd_state==LOAD_BIN)
			bram_addr_clauses_r <= clause_bin_i_base_addr + rd_vars_cnt;
		else
			bram_addr_clauses_r <= 0;
	end

	always @(posedge clk)
		if (~rst)
			bram_addr_vars_states_r <= 0;
		else if (c_rd_state==LOAD_BIN)
			bram_addr_vars_states_r <= bram_vars_i;
		else
			bram_addr_vars_states_r <= 0;
	end

	reg [NUM_CLAUSES_A_BIN-1, 0] wr_clause_cells_r;
	reg [WIDTH_BIN_CLAUSES, 0] clauses_r;
	reg clauses_valid_r;
	assign wr_clause_cells_o = wr_clause_cells_r;
	assign clauses_o = clauses_r;
	assign clauses_valid_o = clauses_valid_r;

	reg c_valid_delay;
	always @(posedge clk)
	begin
		if(rst)
			c_valid_delay <= 0;
		else if(c_rd_state==LOAD_BIN)
			c_valid_delay <= 1;
		else
			c_valid_delay <= 0;
	end

	always @(posedge clk)
	begin
		if(rst) begin
			clauses_r <= 0;
			clauses_valid_r <= 0;
		end else if(c_rd_state==LOAD_BIN) begin
			clauses_r <= bram_clauses_i;
			clauses_valid_r <= c_valid_delay;
		end else begin
			clauses_r <= 0;
			clauses_valid_r <= 0;
		end
	end

	reg wr_c_delay;
	always @(posedge clk)
	begin
		if(rst)
			wr_c_delay <= 0;
		else if(start_load)
			wr_c_delay <= 1;
		else
			wr_c_delay <= 0;
	end
	always @(posedge clk)
	begin
		if(rst)
			wr_clause_cells_r <= 0;
		else if(wr_c_delay)
			wr_clause_cells_r <= {23'b0, 1'b1};
		else
			wr_clause_cells_r <= wr_clause_cells_r<<1;
	end

	reg [WIDTH_VAR_STATES-1, 0] vars_states_r;
	reg vars_states_valid_r;
	assign vars_states_o = vars_states_r;
	assign vars_states_valid_o = vars_states_valid_r;

	reg vstate_valid_delay[1:0];
	always @(posedge clk)
	begin
		if(rst)
			vstate_valid_delay <= 0;
		else if(c_rd_state==LOAD_BIN)
			vstate_valid_delay <= {1'b1,vstate_valid_delay[1]};
		else
			vstate_valid_delay <= {1'b0,vstate_valid_delay[1]};
	end

	always @(posedge clk)
	begin
		if(rst) begin
			vars_states_r <= 0;
			vars_states_valid_r <= 0;
		end else if(c_rd_state==LOAD_BIN) begin
			vars_states_r <= bram_vars_states_i;
			vars_states_valid_r <= vstate_valid_delay[0];
		end else begin
			vars_states_r <= 0
			vars_states_valid_r <= 0;
		end
	end

	reg [1:0] load_done_r;
	assign load_done = load_done_r[0];
	always @(posedge clk)
	begin
		if(rst)
			load_done_r <= 0;
		else if(c_rd_state==LOAD_DONE)
			load_done_r <= {1'b1,load_done_r[1]};
		else
			load_done_r <= {1'b0,load_done_r[1]};
	end

	/*
	*==========================================================================
	*									update bin
	*==========================================================================
	*/

	parameter	UPDATE_IDLE = 0,
				START_UPDATE = 1,
				UPDATE_DONE = 2;

	reg [1:0] c_wr_state, n_wr_state;
	reg [5:0] wr_vars_cnt, wr_clauses_cnt;
	
	always @(posedge clk)
	begin
		if(rst)
			c_wr_state <= 0;
		else
			c_wr_state <= n_wr_state;
	end

	always @(*)
	begin
		if(rst)
			n_wr_state = 0;
		else
			case(c_wr_state)
				UPDATE_IDLE:
					if(start_update)
						n_wr_state = UPDATE_BIN;
					else
						n_wr_state = UPDATE_IDLE;
				UPDATE_BIN:
					if(wr_vars_cnt==NUM_VARS_A_BIN && wr_clauses_cnt==NUM_CLAUSES_A_BIN/2)
						n_wr_state = UPDATE_DONE;
					else
						n_wr_state = UPDATE_BIN;
				UPDATE_DONE:
					n_wr_state = UPDATE_IDLE;
				default:
					n_wr_state = UPDATE_IDLE;
			endcase
	end

	//vars id in the bin
	generate for(i=0;i<NUM_VARS_A_BIN;i=i+1)
		begin: reg_loop
			reg [WIDTH_BIN_VARS-1:0] var_ID_r;
			if(i==0)
				always @(posedge clk)
					if(~rst)
						var_ID_r <= 0;
					else if(c_valid_delay)
						var_ID_r <= bram_vars_i;
					else if(vars_states_valid_i)
						var_ID_r <= 0;
					else
						var_ID_r <= var_ID_r;
			else
				always @(posedge clk)
				begin
					if(~rst)
						var_ID_r <= 0;
					else if(c_valid_delay && vars_states_valid_i)
						var_ID_r <= reg_loop[i-1].var_ID_r;
					else
						var_ID_r <= var_ID_r;
				end
		end
	endgenerate

	assign addr_update_vars_states_o = reg_loop[NUM_VARS_A_BIN-1].var_ID_r;
	
endmodule
