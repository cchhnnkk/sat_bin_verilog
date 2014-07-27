/**
*  Bin_Manager的顶层模块
*/

module sat_bin #(
        parameter NUM_CLAUSES_A_BIN      = 8,
        parameter NUM_VARS_A_BIN         = 8,
        parameter NUM_LVLS_A_BIN         = 8,
        parameter WIDTH_BIN_ID           = 10,
        parameter WIDTH_CLAUSES          = NUM_VARS_A_BIN*2,
        parameter WIDTH_VARS             = 12,
        parameter WIDTH_LVL              = 16
        parameter WIDTH_VAR_STATES       = 11,
        parameter WIDTH_LVL_STATES       = 19,
        parameter ADDR_WIDTH_CLAUSES     = 9,
        parameter ADDR_WIDTH_VARS        = 9,
        parameter ADDR_WIDTH_VAR_STATES = 9,
        parameter ADDR_WIDTH_LVL_STATES = 9
    )
    (
        input                                     clk,
        input                                     rst,

        input                                     start_i,
        output reg                                done_o,

        //结果
        output reg                                global_sat_o,
        output reg                                global_unsat_o
    );

	wire                                     start_bm_i;
	wire                                done_bm_o;
	wire                                global_sat_o;
	wire                                global_unsat_o;
	wire                                     bin_info_en;
	wire [WIDTH_VARS-1:0]                    nv_all_i;
	wire [WIDTH_CLAUSES-1:0]                 nc_all_i;
	wire                                    start_core_o;
	wire                                     done_core_i;
	wire [WIDTH_BIN_ID-1:0]                 cur_bin_num_o;
	wire [WIDTH_LVL-1:0]                    cur_lvl_o;
	wire                                     local_sat_i;
	wire                                     local_unsat_i;
	wire [WIDTH_LVL-1:0]                     cur_lvl_from_core_i;
	wire [WIDTH_BIN_ID-1:0]                  bkt_bin_from_core_i;
	wire [WIDTH_LVL-1:0]                     bkt_lvl_from_core_i;
	wire [NUM_CLAUSES_A_BIN-1:0]                  wr_carray_o;
	wire [NUM_CLAUSES_A_BIN-1:0]                  rd_carray_o;
	wire [NUM_VARS_A_BIN*2-1 : 0]                 clause_o;
	wire [NUM_VARS_A_BIN*2-1 : 0]                  clause_i;
	wire [NUM_VARS_A_BIN-1:0]                     wr_var_states_o;
	wire [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0]    vars_states_o;
	wire [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0]     vars_states_i;
	wire [NUM_LVLS-1:0]                           wr_lvl_states_o;
	wire [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0]    lvl_states_o;
	wire [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0]     lvl_states_i;
	wire                                          base_lvl_en;
	wire [WIDTH_LVL-1:0]                          base_lvl_o;

	assign start_bm_i = start_i;
	assign done_o = done_bm_o;

	bin_manager #(
			.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
			.NUM_VARS_A_BIN(NUM_VARS_A_BIN),
			.NUM_LVLS_A_BIN(NUM_LVLS_A_BIN),
			.WIDTH_BIN_ID(WIDTH_BIN_ID),
			.WIDTH_CLAUSES(WIDTH_CLAUSES),
			.WIDTH_VARS(WIDTH_VARS),
			.WIDTH_LVL(WIDTH_LVL),
			.WIDTH_VAR_STATES(WIDTH_VAR_STATES),
			.WIDTH_LVL_STATES(WIDTH_LVL_STATES),
			.ADDR_WIDTH_CLAUSES(ADDR_WIDTH_CLAUSES),
			.ADDR_WIDTH_VARS(ADDR_WIDTH_VARS),
			.ADDR_WIDTH_VAR_STATES(ADDR_WIDTH_VAR_STATES),
			.ADDR_WIDTH_LVL_STATES(ADDR_WIDTH_LVL_STATES)
	)
	bin_manager(
			.clk(clk),
			.rst(rst),
			.start_bm_i(start_bm_i),
			.done_bm_o(done_bm_o),
			.global_sat_o(global_sat_o),
			.global_unsat_o(global_unsat_o),
			.bin_info_en(bin_info_en),
			.nv_all_i(nv_all_i),
			.nc_all_i(nc_all_i),
			.start_core_o(start_core_o),
			.done_core_i(done_core_i),
			.cur_bin_num_o(cur_bin_num_o),
			.cur_lvl_o(cur_lvl_o),
			.local_sat_i(local_sat_i),
			.local_unsat_i(local_unsat_i),
			.cur_lvl_from_core_i(cur_lvl_from_core_i),
			.bkt_bin_from_core_i(bkt_bin_from_core_i),
			.bkt_lvl_from_core_i(bkt_lvl_from_core_i),
			.wr_carray_o(wr_carray_o),
			.rd_carray_o(rd_carray_o),
			.clause_o(clause_o),
			.clause_i(clause_i),
			.wr_var_states_o(wr_var_states_o),
			.vars_states_o(vars_states_o),
			.vars_states_i(vars_states_i),
			.wr_lvl_states_o(wr_lvl_states_o),
			.lvl_states_o(lvl_states_o),
			.lvl_states_i(lvl_states_i),
			.base_lvl_en(base_lvl_en),
			.base_lvl_o(base_lvl_o)
	);

	wire                                     start_core_i;
	wire                                    done_core_o;
	wire [WIDTH_LVL-1:0]                     cur_bin_num_i;
	wire                                    sat_o;
	wire [WIDTH_LVL-1:0]                    cur_lvl_o;
	wire                                    unsat_o;
	wire [WIDTH_LVL-1:0]                    bkt_lvl_o;
	wire [WIDTH_BIN_ID-1:0]                 bkt_bin_o;
	wire [WIDTH_LVL-1:0]                     load_lvl_i;
	wire [NUM_CLAUSES-1:0]                   rd_carray_i;
	wire [NUM_VARS*2-1 : 0]                 clause_o;
	wire [NUM_CLAUSES-1:0]                   wr_carray_i;
	wire [NUM_VARS*2-1 : 0]                  clause_i;
	wire [NUM_VARS-1:0]                      wr_var_states;
	wire [WIDTH_VAR_STATES*NUM_VARS-1 : 0]   vars_states_i;
	wire [WIDTH_VAR_STATES*NUM_VARS-1 : 0]  vars_states_o;
	wire [NUM_LVLS-1:0]                      wr_lvl_states;
	wire [WIDTH_LVL_STATES*NUM_LVLS -1 : 0]  lvl_states_i;
	wire [WIDTH_LVL_STATES*NUM_LVLS -1 : 0] lvl_states_o;
	wire                                     base_lvl_en;
	wire [WIDTH_LVL-1:0]                     base_lvl_i;

	sat_engine #(
			.NUM_CLAUSES(NUM_CLAUSES),
			.NUM_VARS(NUM_VARS),
			.NUM_LVLS(NUM_LVLS),
			.WIDTH_BIN_ID(WIDTH_BIN_ID),
			.WIDTH_C_LEN(WIDTH_C_LEN),
			.WIDTH_LVL(WIDTH_LVL),
			.WIDTH_LVL_STATES(WIDTH_LVL_STATES),
			.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	sat_engine(
			.clk(clk),
			.rst(rst),
			.start_core_i(start_core_i),
			.done_core_o(done_core_o),
			.cur_bin_num_i(cur_bin_num_i),
			.sat_o(sat_o),
			.cur_lvl_o(cur_lvl_o),
			.unsat_o(unsat_o),
			.bkt_lvl_o(bkt_lvl_o),
			.bkt_bin_o(bkt_bin_o),
			.load_lvl_i(load_lvl_i),
			.rd_carray_i(rd_carray_i),
			.clause_o(clause_o),
			.wr_carray_i(wr_carray_i),
			.clause_i(clause_i),
			.wr_var_states(wr_var_states),
			.vars_states_i(vars_states_i),
			.vars_states_o(vars_states_o),
			.wr_lvl_states(wr_lvl_states),
			.lvl_states_i(lvl_states_i),
			.lvl_states_o(lvl_states_o),
			.base_lvl_en(base_lvl_en),
			.base_lvl_i(base_lvl_i)
	);


endmodule
