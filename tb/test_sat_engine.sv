`timescale 1ns/1ps

module test_sat_engine(input clk, input rst);

	/* --- 测试free_lit_count --- */
	task run();
		begin
			@(posedge clk);
				test_sat_engine_task();
			@(posedge clk);
				$stop();
		end
	endtask

    parameter NUM_CLAUSES      = 8;
    parameter NUM_VARS         = 8;
    parameter WIDTH_BIN_ID     = 10;
    parameter WIDTH_C_LEN      = 4;
    parameter WIDTH_LVL        = 16;
    parameter WIDTH_LVL_STATES = 11;
    parameter WIDTH_VAR_STATES = 19;

	reg                                     start_core_i;
	wire                                    done_core_o;
	reg [WIDTH_LVL-1:0]                     cur_bin_num_i;
	wire                                    sat_o;
	wire [WIDTH_LVL-1:0]                    cur_lvl_o;
	wire                                    unsat_o;
	wire [WIDTH_LVL-1:0]                    bkt_lvl_o;
	reg [WIDTH_LVL-1:0]                     load_lvl_i;
	reg [NUM_CLAUSES-1:0]                   rd_carray_i;
	wire [NUM_VARS*3-1 : 0]                 clause_o;
	reg [NUM_CLAUSES-1:0]                   wr_carray_i;
	reg [NUM_VARS*3-1 : 0]                  clause_i;
	reg [NUM_VARS-1:0]                      wr_var_states;
	reg [WIDTH_VAR_STATES*NUM_VARS-1 : 0]   vars_states_i;
	wire [WIDTH_VAR_STATES*NUM_VARS-1 : 0]  vars_states_o;
	reg [NUM_LVLS-1:0]                      wr_lvl_states;
	reg [WIDTH_LVL_STATES*NUM_LVLS -1 : 0]  lvl_states_i;
	wire [WIDTH_LVL_STATES*NUM_LVLS -1 : 0] lvl_states_o;
	reg                                     base_lvl_en;
	reg [WIDTH_LVL-1:0]                     base_lvl_i;


	`include "../tb/class_sat_engine.sv";
	class_sat_engine #(8, 8) carray_data = new();

	task wr_clause_array(input int bin_data[8][8]);
		begin
			carray_data.reset();
			carray_data.set_array(bin_data);

			for (int i = 0; i < 8; ++i)
			begin
				@ (posedge clk);
					wr_i = 0;
					wr_i[i] = 1;
					clause_len_i = carray_data.get_len(i);
					carray_data.get(i, var_value_i);
			end
			@ (posedge clk);
				wr_i = 0;
			@ (posedge clk);
		end
	endtask

	`include "../tb/class_vs_list.sv";
	class_vs_list #(8, WIDTH_LVL) vs_list = new();

	task wr_vs_list(input int value[8], implied[8], level[8]);
		begin
			vs_list.reset();
			vs_list.set_separate(value, implied, level);
			wr_var_states = 8'hff;
			carray_data.get(vars_states_i);
			@ (posedge clk);
				wr_var_states = 8'h0;
			@ (posedge clk);
		end
	endtask

	`include "../tb/class_ls_list.sv";
	class_ls_list #(8, WIDTH_LVL) ls_list = new();

	task wr_ls_list(input int dcd_bin[8], has_bkt[8]);
		begin
			ls_list.reset();
			ls_list.set_separate(dcd_bin, has_bkt);
			wr_lvl_states = 8'hff;
			carray_data.get(lvl_states_i);
			@ (posedge clk);
				wr_lvl_states = 8'h0;
			@ (posedge clk);
		end
	endtask

	task test_core(input int bin_data[8][8], value[8], implied[8], level[8], dcd_bin[8], has_bkt[8]);
		begin
			//load bin
			wr_clause_array(bin_data);
			wr_vs_list(value, implied, level);
			wr_ls_list(dcd_bin, has_bkt);

			start_core_i = 0;
			base_lvl_en = 1

			//start
			@ (posedge clk);
				start_core_i = 1;
				cur_bin_num_i = 1;
				load_lvl_i = 1;
				base_lvl_en = 1;
				base_lvl_i = 1;
			@ (posedge clk);
				start_core_i = 0;

		end
	endtask

	bit [NUM_CLAUSES-1:0] inserti;
	task test_inserti(input int bin_data[8][8]);
		begin
			@ (posedge clk);
				$display("test_inserti");
				apply_bkt_i = 0;
				apply_impl_i = 0;
			@ (posedge clk);
				wr_sat_engine(bin_data);
				inserti = 0;
				carray_data.get_learntc_inserti(inserti);
				$display("inserti=%b\tlearntc_insert_index_o=%b", inserti, sat_engine.learntc_insert_index_o);
				assert(inserti == sat_engine.learntc_insert_index_o);
		end
	endtask

	/* --- 测试free_lit_count --- */

	int bin1[8][8] = '{
		'{2, 0, 1, 0, 0, 0, 0, 0},
		'{0, 2, 0, 1, 0, 0, 0, 0},
		'{0, 0, 2, 0, 2, 0, 0, 0},
		'{0, 0, 0, 0, 0, 0, 0, 0},
		'{0, 0, 0, 0, 0, 0, 0, 0},
		'{0, 0, 0, 0, 0, 0, 0, 0},
		'{0, 0, 0, 0, 0, 0, 0, 0},
		'{0, 0, 0, 0, 0, 0, 0, 0}
	};

	//var state list:
	int value[]   = '{0, 0, 0, 0, 0, 0, 0, 0};
	int implied[] = '{0, 0, 0, 0, 0, 0, 0, 0};
	int level[]   = '{0, 0, 0, 0, 0, 0, 0, 0};

	//lvl state list:
	int dcd_bin[] = '{0, 0, 0, 0, 0, 0, 0, 0};
	int has_bkt[] = '{0, 0, 0, 0, 0, 0, 0, 0};

	int bin2[8][8] = '{
		'{2, 0, 1, 0, 0, 0, 0, 0},
		'{0, 2, 0, 1, 0, 2, 0, 0},
		'{2, 0, 0, 1, 2, 0, 0, 0},
		'{1, 1, 0, 0, 1, 0, 0, 0},

		'{0, 1, 2, 0, 2, 0, 0, 0},
		'{0, 0, 0, 1, 0, 0, 2, 0},
		'{2, 0, 0, 1, 0, 1, 0, 1},
		'{1, 0, 1, 0, 0, 1, 2, 0}
	};

	task test_sat_engine_task();
		begin
			$display("test_sat_engine_task");
			test_inserti(bin1);
			test_inserti(bin2);
		end
	endtask

	sat_engine #(
		.NUM_CLAUSES     (NUM_CLAUSES),
		.NUM_VARS        (NUM_VARS),
		.WIDTH_BIN_ID    (WIDTH_BIN_ID),
		.WIDTH_C_LEN     (WIDTH_C_LEN),
		.WIDTH_LVL       (WIDTH_LVL),
		.WIDTH_LVL_STATES(WIDTH_LVL_STATES),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES)
	)
	sat_engine(
		.clk          (clk),
		.rst          (rst),
		.start_core_i (start_core_i),
		.done_core_o  (done_core_o),
		.cur_bin_num_i(cur_bin_num_i),
		.sat_o        (sat_o),
		.cur_lvl_o    (cur_lvl_o),
		.unsat_o      (unsat_o),
		.bkt_lvl_o    (bkt_lvl_o),
		.load_lvl_i   (load_lvl_i),
		.rd_carray_i  (rd_carray_i),
		.clause_o     (clause_o),
		.wr_carray_i  (wr_carray_i),
		.clause_i     (clause_i),
		.wr_var_states(wr_var_states),
		.vars_states_i(vars_states_i),
		.vars_states_o(vars_states_o),
		.wr_lvl_states(wr_lvl_states),
		.lvl_states_i (lvl_states_i),
		.lvl_states_o (lvl_states_o),
		.base_lvl_en  (base_lvl_en),
		.base_lvl_i   (base_lvl_i)
	);
endmodule


module test_sat_engine_top;
	reg  clk;
	reg  rst;

	always #5 clk<=~clk;

	initial begin: init
		clk = 0;
		rst=0;
	end

	// initial begin
	// 	$fsdbDumpfile("wave_test_sat_engine.fsdb");
	// 	$fsdbDumpvars;
	// end

	task reset();
		begin
			@(posedge clk);
				rst=0;
				clk=0;

			@(posedge clk);
				rst=1;
		end
	endtask

	test_sat_engine test_sat_engine(
		.clk(clk),
		.rst(rst)
	);

	initial begin
		reset();
		test_sat_engine.run();
		$display("done");
	end
endmodule
