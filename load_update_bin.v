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

	//load update control
	input start_load_update,
	input first_load_update,
	input [WIDTH_BIN_I-1 : 0] request_bin_num_i,
	output reg [NUM_CLAUSES_A_BIN/2-1 : 0] get_clause_cells_o,
	output reg load_update_done,

	//load data to sat engine
	output reg [NUM_CLAUSES_A_BIN-1 : 0] set_clause_cells_o,
	output reg [WIDTH_BIN_CLAUSES-1 : 0] clauses_o,
	output reg clauses_valid_o,
	output [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1 : 0] var_state_o,
	output [NUM_VARS_A_BIN-1 : 0] var_state_valid_o,

	//get update data from sat engine
	input [WIDTH_BIN_CLAUSES-1 : 0] learnt_clauses_i,
	input learnt_clauses_valid_i,
	input [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1 : 0] var_state_i,

	//backtrack
	input start_backtrck_i,
	input [9:0] bkt_lvl_i
	
)
	//data from bram read port
	wire [WIDTH_BIN_CLAUSES-1 : 0] bram_dout_clauses;
	wire [WIDTH_BIN_VARS-1 : 0] bram_dout_var_id;
	wire [WIDTH_VAR_STATES-1 : 0] bram_dout_var_state;

	//addr to bram read port
	reg [ADDR_WIDTH_CLAUSES-1:0] bram_addr_clauses_r;
	reg [ADDR_WIDTH_VARS-1:0] bram_addr_vars_r;
	wire [ADDR_WIDTH_VARS_STATES-1:0] bram_addr_var_state;

	//update bram
	reg [NUM_CLAUSES_A_BIN*2-1 : 0] data_learnt_clauses_r;
	reg [ADDR_WIDTH_CLAUSES-1:0] addr_learnt_clauses_r;
	reg wr_learnt_clauses_r;
	reg [WIDTH_VAR_STATES-1 : 0] data_update_var_state_r;
	reg [ADDR_WIDTH_VARS_STATES-1:0] addr_update_var_state_r;
	reg wr_update_vars_state_r;

	reg apply_backtrack;
	reg done_backtrack;
	//rd bram global var state
	reg [ADDR_WIDTH_VARS_STATES-1:0] bram_raddr_var_state_bport;
	wire [WIDTH_VAR_STATES-1:0] bram_dout_var_state_bport;
	//wr bram global var state
	reg [ADDR_WIDTH_VARS_STATES-1:0] bram_waddr_var_state_bport;
	reg [WIDTH_VAR_STATES-1:0] bram_din_var_state_bport;
	reg bram_wr_var_state_bport;

	assign bram_dout_var_state_bport = bram_dout_var_state;

	reg [WIDTH_BIN_ADDR-1 : 0] clause_bin_i_base_addr;
	wire [WIDTH_BIN_ADDR-1 : 0] var_bin_i_base_addr;

	wire [WIDTH_BIN_ADDR-1 : 0] clauses_bin_baseaddr = request_bin_num_i*NUM_CLAUSES_A_BIN;//i*24

	always @(posedge clk)
	begin
		if(~rst)
			clause_bin_i_base_addr <= 0;
		else if(start_load_update)
			clause_bin_i_base_addr <= clauses_bin_baseaddr; 
		else
			clause_bin_i_base_addr <= clause_bin_i_base_addr;
	end
	assign var_bin_i_base_addr = clause_bin_i_base_addr; //i*24

	parameter	IDLE = 0,
				UPDATE_FIRST = 1,
				UPDATE_AND_LOAD = 2,
				DONE = 3;

	reg [1:0] c_state, n_state;
	reg [5:0] vars_cnt, clauses_cnt;

	always @(posedge clk)
	begin
		if(rst)
			c_state <= 0;
		else
			c_state <= n_state;
	end

	always @(*)
	begin
		if(rst)
			n_state = 0;
		else
			case(c_state)
				IDLE:
					if(start_load_update)
						n_state = UPDATE_FIRST;
					else if(start_load_update && first_load_update)
						n_state = UPDATE_AND_LOAD;
					else
						n_state = IDLE;
				UPDATE_FIRST:
					if(vars_cnt==NUM_VARS_A_BIN && clauses_cnt==NUM_CLAUSES_A_BIN)
						n_state = UPDATE_AND_LOAD;
					else
						n_state = UPDATE_AND_LOAD;
				UPDATE_AND_LOAD:
					if(vars_cnt==NUM_VARS_A_BIN && clauses_cnt==NUM_CLAUSES_A_BIN)
						n_state = DONE;
					else
						n_state = UPDATE_AND_LOAD;
				DONE:
					n_state = IDLE;
				default:
					n_state = IDLE;
			endcase
	end
	wire apply_update_first = c_state==UPDATE_FIRST;
	wire apply_update_load = c_state==UPDATE_AND_LOAD;
	wire done_update_load = c_state==DONE;

	always @(posedge clk)
	begin
		if (~rst)
			vars_cnt <= 0;
		else if (c_state==UPDATE_AND_LOAD && vars_cnt<NUM_VARS_A_BIN)
			vars_cnt <= vars_cnt+1;
		else if (c_state==UPDATE_AND_LOAD)
			vars_cnt <= vars_cnt;
		else
			vars_cnt <= 0;
	end

	always @(posedge clk)
	begin
		if (~rst)
			clauses_cnt <= 0;
		else if (c_state==UPDATE_AND_LOAD && clauses_cnt<NUM_CLAUSES_A_BIN)
			clauses_cnt <= clauses_cnt+1;
		else if (c_state==UPDATE_AND_LOAD)
			clauses_cnt <= clauses_cnt;
		else
			clauses_cnt <= 0;
	end

	/*
	*==========================================================================
	*							update load clauses
	*==========================================================================
	*/
	always @(posedge clk)
	begin
		if (~rst)
			bram_addr_vars_r <= 0;
		else if (c_state==UPDATE_AND_LOAD)
			bram_addr_vars_r <= var_bin_i_base_addr + vars_cnt;
		else
			bram_addr_vars_r <= 0;
	end

	always @(posedge clk)
	begin
		if (~rst)
			bram_addr_clauses_r <= 0;
		else if (c_state==UPDATE_AND_LOAD)
			bram_addr_clauses_r <= clause_bin_i_base_addr + vars_cnt;
		else
			bram_addr_clauses_r <= 0;
	end

	assign bram_addr_var_state <= apply_backtrack? bram_raddr_var_state_bport : bram_dout_var_id;

	reg c_valid_delay;
	always @(posedge clk)
	begin
		if(rst)
			c_valid_delay <= 0;
		else if(c_state==UPDATE_AND_LOAD)
			c_valid_delay <= 1;
		else
			c_valid_delay <= 0;
	end

	always @(posedge clk)
	begin
		if(rst) begin
			clauses_o <= 0;
			clauses_valid_o <= 0;
		end else if(c_state==UPDATE_AND_LOAD) begin
			clauses_o <= bram_dout_clauses;
			clauses_valid_o <= c_valid_delay;
		end else begin
			clauses_o <= 0;
			clauses_valid_o <= 0;
		end
	end

	reg wr_c_delay;
	always @(posedge clk)
	begin
		if(rst)
			wr_c_delay <= 0;
		else if(c_state==UPDATE_AND_LOAD)
			wr_c_delay <= 1;
		else
			wr_c_delay <= 0;
	end
	
	always @(posedge clk)
	begin
		if(rst)
			set_clause_cells_o <= 0;
		else if(wr_c_delay)
			set_clause_cells_o <= {23'b0, 1'b1};
		else
			set_clause_cells_o <= set_clause_cells_o<<1;
	end

	reg [1:0] load_update_done_r;
	assign load_update_done = load_update_done_r[0];

	always @(posedge clk)
	begin
		if(rst)
			load_update_done_r <= 0;
		else if(c_state==DONE)
			load_update_done_r <= {1'b1, load_update_done_r[1]};
		else
			load_update_done_r <= {1'b0, load_update_done_r[1]};
	end


	//update learnt clauses
	always @(posedge clk)
	begin
		if(rst)
			get_clause_cells_o <= 0;
		else if(c_state == UPDATE_FIRST)
			get_clause_cells_o <= {11'b0, 1'b1};
		else
			get_clause_cells_o <= get_clause_cells_o<<1;
	end

	always @(posedge clk)
	begin
		if(rst) begin
			data_learnt_clauses_r <= 0;
			addr_learnt_clauses_r <= 0;
			wr_learnt_clauses_r <= 0;
		end else if(start_load_update) begin //get the base address
			data_learnt_clauses_r <= 0;
			addr_learnt_clauses_r <= clauses_bin_baseaddr+NUM_CLAUSES_A_BIN/2;
			wr_learnt_clauses_r <= 0;
		end else if(learnt_clauses_valid_i) begin
			data_learnt_clauses_r <= learnt_clauses_i;
			addr_learnt_clauses_r <= addr_learnt_clauses_r+1;
			wr_learnt_clauses_r <= 1;
		end else begin
			data_learnt_clauses_r <= 0;
			addr_learnt_clauses_r <= 0;
			wr_learnt_clauses_r <= 0;
		end
	end

	/*
	*==========================================================================
	*						update load var id and state
	*==========================================================================
	*/

	wire [WIDTH_VAR_STATES-1 : 0] var_state_tosat_w;
	wire valid_var_state_tosat_w;

	regs_vid_state regs_vid_state(
		.clk(clk),
		.rst(rst),

		.apply_update_first(apply_update_first),
		.apply_update_load(apply_update_load),
		.done_update_load(done_update_load),

		.var_state_fromsat_i(var_state_i),
		.var_state_tosat_o(var_state_tosat_w),
		.valid_var_state_tosat_o(valid_var_state_tosat_w),

		//load
		.var_id_frombram_i(bram_dout_var_id),
		.valid_var_id_frombram_i(c_valid_delay),

		.var_state_frombram_i(bram_dout_var_state),

		//update
		.var_id_update_minlevel_o(var_id_update_minlevel_o),
		.var_state_update_minlevel_o(var_state_update_minlevel_o),
		.valid_var_state_update_minlevel_o(valid_var_state_update_minlevel_o)
	);

	reg [WIDTH_VAR_STATES-1 : 0] var_state_tosat_r;

	always @(posedge clk)
	begin
		if(rst)
			var_state_tosat_r <= 0;
		else
			var_state_tosat_r <= var_state_tosat_w;
	end

	assign var_state_o = {var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r, var_state_tosat_r};

	reg [NUM_VARS_A_BIN-1 : 0] shift_valid;
	reg [NUM_VARS_A_BIN-1 : 0] var_state_valid_r;
	assign var_state_valid_o = var_state_valid_r;

	always @(posedge clk)
	begin
		if(rst)
			shift_valid <= 1;
		else if(valid_var_state_tosat_w)
			shift_valid <= shift_valid<<1;
		else if(apply_update_first & apply_update_load)
			shift_valid <= shift_valid;
		else
			shift_valid <= 1;
	end

	always @(posedge clk)
	begin
		if(rst)
			var_state_valid_r <= 0;
		else if(valid_var_state_tosat_w)
			var_state_valid_r <= shift_valid;
		else
			var_state_valid_r <= 0;
	end

	//update
	assign addr_update_var_state_r = apply_backtrack? bram_waddr_var_state_bport:var_state_update_minlevel_o;
	assign data_update_var_state_r = apply_backtrack? bram_din_var_state_bport:var_id_update_minlevel_o;
	assign wr_update_vars_state_r = apply_backtrack? bram_wr_var_state_bport:valid_var_state_update_minlevel_o;

	/*
	*==========================================================================
	*							backtrack
	*==========================================================================
	*/

	always @(posedge clk)
	begin
		if(rst)
			apply_backtrack <= 0;
		else if(start_backtrck_i)
			apply_backtrack <= 1;
		else if(done_backtrack)
			apply_backtrack <= 0;
		else
			apply_backtrack <= apply_backtrack;
	end

	always @(posedge clk)
	begin
		if(rst)
			done_backtrack <= 0;
		else if(start_backtrck_i)
			done_backtrack <= 1;
		else
			done_backtrack <= 0;
	end

	always @(posedge clk)
	begin
		if(rst)
			bram_raddr_var_state_bport <= 0;
		else if(apply_backtrack && bram_raddr_var_state_bport<100)
			bram_raddr_var_state_bport <= bram_raddr_var_state_bport+1;
		else if(done_backtrack)
			bram_raddr_var_state_bport <= 0;
		else
			bram_raddr_var_state_bport <= ptr_top_assign_stack;
	end

	wire [2:0] var_value_b;
	wire [15:0] var_level_b;
	wire [9:0] var_reason_bin_b;
	wire is_highest_bktlvl_b;
	assign {var_value_b, var_level_b, var_reason_bin_b, is_highest_bktlvl_b} = bram_dout_var_state_bport;

	wire need_bkt = apply_backtrck && var_value_b!=0 && var_level_b>bkt_lvl_i;
	wire is_highest_bktlvl = apply_backtrck && var_value_b!=0 && bkt_lvl_i==var_level_sel;

	always @(posedge clk)
	begin
		if(~rst) begin
			bram_waddr_var_state_bport <= 0;
			bram_din_var_state_bport <= 0;
			bram_wr_var_state_bport <= 0;
		end
		else if(need_bkt) begin
			bram_waddr_var_state_bport <= bram_raddr_var_state_bport;
			bram_din_var_state_bport <= 0;
			bram_wr_var_state_bport <= 1;
		end
		else if(is_highest_bktlvl) begin
			bram_waddr_var_state_bport <= bram_raddr_var_state_bport;
			bram_din_var_state_bport <= {bram_dout_var_state_bport[29:1],1'b1};
			bram_wr_var_state_bport <= 1;
		end
		else begin
			bram_waddr_var_state_bport <= 0;
			bram_din_var_state_bport <= 0;
			bram_wr_var_state_bport <= 0;
		end
	end

	bram_w30_d1024 bram_global_var_state_inst(
	  .clka(clk),
	  .wea(),
	  .addra(bram_addr_var_state),
	  .dina(),
	  .douta(bram_dout_var_state),
	  .clkb(clk),
	  .web(wr_update_vars_state_r),
	  .addrb(addr_update_var_state_r),
	  .dinb(data_update_var_state_r),
	  .dout()
	);

	bram_w12_d1024 bram_vars_bins_inst(
	  .clka(clk),
	  .wea(),
	  .addra(bram_addr_vars_r),
	  .dina(),
	  .douta(bram_dout_var_state),
	  .clkb(clk),
	  .web(),
	  .addrb(),
	  .dinb(),
	  .dout()
	);

	bram_w48_d1024 bram_clauses_bins_inst(
	  .clka(clk),
	  .wea(),
	  .addra(bram_addr_clauses_r),
	  .dina(),
	  .douta(bram_dout_clauses),
	  .clkb(clk),
	  .web(wr_learnt_clauses_r),
	  .addrb(addr_learnt_clauses_r),
	  .dinb(data_learnt_clauses_r),
	  .dout()
	);

endmodule
