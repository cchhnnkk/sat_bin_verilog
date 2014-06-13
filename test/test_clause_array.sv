`timescale 1ns/1ps

module test_clause_array(input clk, input rst);

	/* --- 测试free_lit_count --- */
	task run();
		begin
			@(posedge clk);
				test_clause_array_task();
			@(posedge clk);
				$stop();
		end
	endtask

	parameter NUM_CLAUSES_A_BIN = 8;
	parameter NUM_VARS_A_BIN = 8;
	parameter WIDTH_VAR_STATES = 30;
	parameter WIDTH_C_LEN = 4;

	reg [4:0] clause_len_i;
	wire [4:0] clause_len_o;
	reg apply_impl_i;
	reg apply_bkt_i;

	reg [NUM_CLAUSES_A_BIN-1:0] wr_i;
	reg [NUM_VARS_A_BIN*3-1:0] var_value_frombase_i;
	wire [NUM_VARS_A_BIN*3-1:0] var_value_tobase_o;
	wire [NUM_CLAUSES_A_BIN-1:0] learntc_insert_index_o;

	clause_array #(
		.NUM_CLAUSES_A_BIN(NUM_CLAUSES_A_BIN),
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN),
		.WIDTH_VAR_STATES(WIDTH_VAR_STATES),
		.WIDTH_C_LEN(WIDTH_C_LEN)
	)
	clause_array(
		.clk(clk),
		.rst(rst),
		.wr_i(wr_i),
		.clause_len_i(clause_len_i),
		.var_value_frombase_i(var_value_frombase_i),
		.var_value_tobase_o(var_value_tobase_o),
		.learntc_insert_index_o(learntc_insert_index_o),
		.apply_impl_i(apply_impl_i),
		.apply_bkt_i(apply_bkt_i)
	);

	`include "../test/ClauseArray.sv";
	ClauseArray #(8, 8) carray_data = new();

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
					clause_len_i = carray_data.get_len(i);
					carray_data.get(i, var_value_frombase_i);
			end
			@ (posedge clk);
				wr_i = 0;
			@ (posedge clk);
		end
	endtask

	bit [NUM_CLAUSES_A_BIN-1:0] inserti;
	task test_inserti(input int bin_data[8][8]);
		begin
			@ (posedge clk);
				$display("test_inserti");
				apply_bkt_i = 0;
				apply_impl_i = 0;
			@ (posedge clk);
				wr_clause_array(bin_data);
				inserti = 0;
				carray_data.get_learntc_inserti(inserti);
				$display("inserti=%b\tlearntc_insert_index_o=%b", inserti, learntc_insert_index_o);
				assert(inserti == learntc_insert_index_o);
		end
	endtask

	/* --- 测试free_lit_count --- */
	task test_clause_array_task();
		begin
			$display("test_clause_array_task");
			test_inserti(bin1);
			test_inserti(bin2);
		end
	endtask
endmodule


module test_clause_array_top;
	reg  clk;
	reg  rst;

	always #5 clk<=~clk;

	initial begin: init
		clk = 0;
		rst=0;
	end

	// initial begin
	// 	$fsdbDumpfile("wave_test_clause_array.fsdb");
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

	test_clause_array test_clause_array(
		.clk(clk),
		.rst(rst)
	);

	initial begin
		reset();
		test_clause_array.run();
		$display("done");
	end
endmodule
