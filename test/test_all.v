`timescale 1ns/1ps

module test_all;

	test_lit_cell test_lit_cell_inst();

	initial begin
		test_lit_cell_inst.run;
	end

endmodule
