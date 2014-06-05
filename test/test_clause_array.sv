`timescale 1ns/1ps

module test_clause_array();

	reg  clk;
	reg  rst;

	always #5 clk<=~clk;

	initial begin: init
		clk = 0;
		rst=0;
	end

	/* --- 测试free_lit_count --- */
	task run();
		begin
			@(posedge clk);
				reset_state();
			@(posedge clk);
				test_clause_array_task();
		end
	endtask

	task reset_state();
		begin
			@(posedge clk);
				rst=0;
				clk=0;

			@(posedge clk);
				rst=1;
		end
	endtask

	parameter NUM_VARS_A_BIN = 8;
	reg wr_i;
	reg [NUM_VARS_A_BIN*3-1:0] var_value_frombase_i;
	wire [NUM_VARS_A_BIN*3-1:0] var_value_tobase_o;
	reg [4:0] clause_len_i;
	wire [4:0] clause_len_o;
	reg apply_backtrack_i;

	reg [NUM_CLAUSES_A_BIN-1:0] wr_i;
	reg [NUM_VARS_A_BIN*3-1:0] var_value_frombase_i;
	wire [NUM_VARS_A_BIN*3-1:0] var_value_tobase_o;
	wire [NUM_CLAUSES_A_BIN-1:0] learntc_insert_index_o;

	clause_array  #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES),
		.WIDTH_C_LEN(WIDTH_C_LEN)
	)
	clause_array(
		.clk(clk),
		.rst(rst),
		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_i),
		.clause_len_i(clause_len_i),
		.var_value_tobase_o(var_value_tobase_o),
		.learntc_insert_index_o(learntc_insert_index_o)
	);

	`include "../test/ClauseData.sv";
	ClauseArray #(8) carray_data = new;
	ClauseData #(8) cdata_o = new;

	int bin1[8][8] = '{
			'{2, 0, 1, 0, 0, 0, 0, 0},
			'{0, 2, 0, 1, 0, 2, 0, 0},
			'{2, 0, 0, 1, 2, 0, 0, 0},
			'{1, 1, 0, 0, 1, 0, 0, 0},

			'{0, 1, 2, 0, 2, 0, 0, 0},
			'{0, 0, 0, 0, 0, 0, 0, 0},
			'{0, 0, 0, 0, 0, 0, 0, 0},
			'{0, 0, 0, 0, 0, 0, 0, 0}
		};

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

	task wr_clause_array(input int bin_data[8][8]);
		begin
			carray_data.reset();
			carray_data.set_array(bin_data);

			for (int i = 0; i < 8; ++i)
			begin
				@ (posedge clk);
					wr_i = 0;
					wr_i[i] = 1;
					clause_len_i = carray_data[i].get_len();
					carray_data[i].get(var_value_frombase_i);
			end
			@ (posedge clk);
			wr_i = 0;
		end
	endtask

	task test_inserti(input int bin_data[8][8]);
		begin
			wr_clause_array(bin_data);
			bit [nc-1:0] inserti;
			carray_data.get_learntc_inserti(inserti);
			assert(inserti == learntc_insert_index_o);
		end
	endtask

	/* --- 测试free_lit_count --- */
	task test_clause_array_task();
		begin
			$display("test_clause_array_task");
			test_inserti(bin1);
		end
	endtask
endmodule


module test_clause_array_top;
	test_clause_array test_clause_array();
	initial begin
		test_clause_array.run;
		$display("done");
	end
endmodule