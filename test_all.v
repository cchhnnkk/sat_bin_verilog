module test_all;

	initial begin
		test_lit_cell_unit();
		test_clause1_unit();
	end

	/* --- test_lit_cell --- */
	test_lit_cell test_lit_cell();
	task test_lit_cell_unit;
		begin
			@ (posedge clk);
				test_lit_cell.start_test = 1;

			while(test_lit_cell.done_test==0) begin
				@ (posedge clk);
			end
		end
	endtask

	/* --- test_clause1 --- */
	test_clause1 test_clause1();
	task test_clause1_unit;
		begin
			@ (posedge clk);
				test_clause1.start_test = 1;

			while(test_clause1.done_test==0) begin
				@ (posedge clk);
			end
		end
	endtask

endmodule
