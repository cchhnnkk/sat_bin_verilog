module clause#(
	parameter NUM_VARS_A_BIN = 24
(
	input  clk, 
	input  rst, 

	input wr_i,
	input [NUM_VARS_A_BIN*3-1:0] var_value_frombase_i,
	output [NUM_VARS_A_BIN*3-1:0] var_value_tobase_o,

	input [4:0] clause_len_i,
	output reg [4:0] clause_len_o,
	input apply_backtrack_i
)

	//vars id in the bin
	wire [2:0] var_value_frombase_0, var_value_frombase_1, var_value_frombase_2, var_value_frombase_3, var_value_frombase_4, var_value_frombase_5, var_value_frombase_6, var_value_frombase_7, var_value_frombase_8, var_value_frombase_9, var_value_frombase_10, var_value_frombase_11, var_value_frombase_12, var_value_frombase_13, var_value_frombase_14, var_value_frombase_15, var_value_frombase_16, var_value_frombase_17, var_value_frombase_18, var_value_frombase_19, var_value_frombase_20, var_value_frombase_21, var_value_frombase_22, var_value_frombase_23;

	wire [2:0] var_value_tobase_0, var_value_tobase_1, var_value_tobase_2, var_value_tobase_3, var_value_tobase_4, var_value_tobase_5, var_value_tobase_6, var_value_tobase_7, var_value_tobase_8, var_value_tobase_9, var_value_tobase_10, var_value_tobase_11, var_value_tobase_12, var_value_tobase_13, var_value_tobase_14, var_value_tobase_15, var_value_tobase_16, var_value_tobase_17, var_value_tobase_18, var_value_tobase_19, var_value_tobase_20, var_value_tobase_21, var_value_tobase_22, var_value_tobase_23;

	wire [1:0] freelitcnt_0,freelitcnt_1,freelitcnt_2,freelitcnt_3,freelitcnt_4,freelitcnt_5,freelitcnt_6,freelitcnt_7,freelitcnt_8,freelitcnt_9,freelitcnt_10,freelitcnt_11,freelitcnt_12,freelitcnt_13,freelitcnt_14,freelitcnt_15,freelitcnt_16,freelitcnt_17,freelitcnt_18,freelitcnt_19,freelitcnt_20,freelitcnt_21,freelitcnt_22,freelitcnt_23;

	wire imp_drv_0, imp_drv_1, imp_drv_2, imp_drv_3, imp_drv_4, imp_drv_5, imp_drv_6, imp_drv_7, imp_drv_8, imp_drv_9, imp_drv_10, imp_drv_11, imp_drv_12, imp_drv_13, imp_drv_14, imp_drv_15, imp_drv_16, imp_drv_17, imp_drv_18, imp_drv_19, imp_drv_20, imp_drv_21, imp_drv_22, imp_drv_23;

	wire cclause_0, cclause_1, cclause_2, cclause_3, cclause_4, cclause_5, cclause_6, cclause_7, cclause_8, cclause_9, cclause_10, cclause_11, cclause_12, cclause_13, cclause_14, cclause_15, cclause_16, cclause_17, cclause_18, cclause_19, cclause_20, cclause_21, cclause_22, cclause_23;

	wire cclause_drv_0, cclause_drv_1, cclause_drv_2, cclause_drv_3, cclause_drv_4, cclause_drv_5, cclause_drv_6, cclause_drv_7, cclause_drv_8, cclause_drv_9, cclause_drv_10, cclause_drv_11, cclause_drv_12, cclause_drv_13, cclause_drv_14, cclause_drv_15, cclause_drv_16, cclause_drv_17, cclause_drv_18, cclause_drv_19, cclause_drv_20, cclause_drv_21, cclause_drv_22, cclause_drv_23;

	wire clausesat_0, clausesat_1, clausesat_2, clausesat_3, clausesat_4, clausesat_5, clausesat_6, clausesat_7, clausesat_8, clausesat_9, clausesat_10, clausesat_11, clausesat_12, clausesat_13, clausesat_14, clausesat_15, clausesat_16, clausesat_17, clausesat_18, clausesat_19, clausesat_20, clausesat_21, clausesat_22, clausesat_23;

	assign {var_value_frombase_0,var_value_frombase_1,var_value_frombase_2,var_value_frombase_3,var_value_frombase_4,var_value_frombase_5,var_value_frombase_6,var_value_frombase_7,var_value_frombase_8,var_value_frombase_9,var_value_frombase_10,var_value_frombase_11,var_value_frombase_12,var_value_frombase_13,var_value_frombase_14,var_value_frombase_15,var_value_frombase_16,var_value_frombase_17,var_value_frombase_18,var_value_frombase_19,var_value_frombase_20,var_value_frombase_21,var_value_frombase_22,var_value_frombase_23} = var_value_frombase_i;

	assign var_value_tobase_o = {var_value_tobase_0, var_value_tobase_1, var_value_tobase_2, var_value_tobase_3, var_value_tobase_4, var_value_tobase_5, var_value_tobase_6, var_value_tobase_7, var_value_tobase_8, var_value_tobase_9, var_value_tobase_10, var_value_tobase_11, var_value_tobase_12, var_value_tobase_13, var_value_tobase_14, var_value_tobase_15, var_value_tobase_16, var_value_tobase_17, var_value_tobase_18, var_value_tobase_19, var_value_tobase_20, var_value_tobase_21, var_value_tobase_22, var_value_tobase_23};

	clause_cell clause_cell_0
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_0),
		.var_value_tobase_o(var_value_tobase_0),

		.freelitcnt_pre(0),
		.freelitcnt_next(freelitcnt_0),

		.imp_drv_i(imp_drv_0),
		
		.cclause_o(cclause_0),
		.cclause_drv_i(cclause_drv_0),

		.clausesat_o(clausesat_0)
	)

	clause_cell clause_cell_1
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_1),
		.var_value_tobase_o(var_value_tobase_1),

		.freelitcnt_pre(freelitcnt_0),
		.freelitcnt_next(freelitcnt_1),

		.imp_drv_i(imp_drv_1),
		
		.cclause_o(cclause_1),
		.cclause_drv_i(cclause_drv_1),

		.clausesat_o(clausesat_1)
	)

	clause_cell clause_cell_2
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_2),
		.var_value_tobase_o(var_value_tobase_2),

		.freelitcnt_pre(freelitcnt_1),
		.freelitcnt_next(freelitcnt_2),

		.imp_drv_i(imp_drv_2),
		
		.cclause_o(cclause_2),
		.cclause_drv_i(cclause_drv_2),

		.clausesat_o(clausesat_2)
	)

	clause_cell clause_cell_3
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_3),
		.var_value_tobase_o(var_value_tobase_3),

		.freelitcnt_pre(freelitcnt_2),
		.freelitcnt_next(freelitcnt_3),

		.imp_drv_i(imp_drv_3),
		
		.cclause_o(cclause_3),
		.cclause_drv_i(cclause_drv_3),

		.clausesat_o(clausesat_3)
	)

	clause_cell clause_cell_4
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_4),
		.var_value_tobase_o(var_value_tobase_4),

		.freelitcnt_pre(freelitcnt_3),
		.freelitcnt_next(freelitcnt_4),

		.imp_drv_i(imp_drv_4),
		
		.cclause_o(cclause_4),
		.cclause_drv_i(cclause_drv_4),

		.clausesat_o(clausesat_4)
	)

	clause_cell clause_cell_5
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_5),
		.var_value_tobase_o(var_value_tobase_5),

		.freelitcnt_pre(freelitcnt_4),
		.freelitcnt_next(freelitcnt_5),

		.imp_drv_i(imp_drv_5),
		
		.cclause_o(cclause_5),
		.cclause_drv_i(cclause_drv_5),

		.clausesat_o(clausesat_5)
	)

	clause_cell clause_cell_6
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_6),
		.var_value_tobase_o(var_value_tobase_6),

		.freelitcnt_pre(freelitcnt_5),
		.freelitcnt_next(freelitcnt_6),

		.imp_drv_i(imp_drv_6),
		
		.cclause_o(cclause_6),
		.cclause_drv_i(cclause_drv_6),

		.clausesat_o(clausesat_6)
	)

	clause_cell clause_cell_7
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_7),
		.var_value_tobase_o(var_value_tobase_7),

		.freelitcnt_pre(freelitcnt_6),
		.freelitcnt_next(freelitcnt_7),

		.imp_drv_i(imp_drv_7),
		
		.cclause_o(cclause_7),
		.cclause_drv_i(cclause_drv_7),

		.clausesat_o(clausesat_7)
	)

	clause_cell clause_cell_8
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_8),
		.var_value_tobase_o(var_value_tobase_8),

		.freelitcnt_pre(freelitcnt_7),
		.freelitcnt_next(freelitcnt_8),

		.imp_drv_i(imp_drv_8),
		
		.cclause_o(cclause_8),
		.cclause_drv_i(cclause_drv_8),

		.clausesat_o(clausesat_8)
	)

	clause_cell clause_cell_9
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_9),
		.var_value_tobase_o(var_value_tobase_9),

		.freelitcnt_pre(freelitcnt_8),
		.freelitcnt_next(freelitcnt_9),

		.imp_drv_i(imp_drv_9),
		
		.cclause_o(cclause_9),
		.cclause_drv_i(cclause_drv_9),

		.clausesat_o(clausesat_9)
	)

	clause_cell clause_cell_10
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_10),
		.var_value_tobase_o(var_value_tobase_10),

		.freelitcnt_pre(freelitcnt_9),
		.freelitcnt_next(freelitcnt_10),

		.imp_drv_i(imp_drv_10),
		
		.cclause_o(cclause_10),
		.cclause_drv_i(cclause_drv_10),

		.clausesat_o(clausesat_10)
	)

	clause_cell clause_cell_11
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_11),
		.var_value_tobase_o(var_value_tobase_11),

		.freelitcnt_pre(freelitcnt_10),
		.freelitcnt_next(freelitcnt_11),

		.imp_drv_i(imp_drv_11),
		
		.cclause_o(cclause_11),
		.cclause_drv_i(cclause_drv_11),

		.clausesat_o(clausesat_11)
	)

	clause_cell clause_cell_12
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_12),
		.var_value_tobase_o(var_value_tobase_12),

		.freelitcnt_pre(freelitcnt_11),
		.freelitcnt_next(freelitcnt_12),

		.imp_drv_i(imp_drv_12),
		
		.cclause_o(cclause_12),
		.cclause_drv_i(cclause_drv_12),

		.clausesat_o(clausesat_12)
	)

	clause_cell clause_cell_13
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_13),
		.var_value_tobase_o(var_value_tobase_13),

		.freelitcnt_pre(freelitcnt_12),
		.freelitcnt_next(freelitcnt_13),

		.imp_drv_i(imp_drv_13),
		
		.cclause_o(cclause_13),
		.cclause_drv_i(cclause_drv_13),

		.clausesat_o(clausesat_13)
	)

	clause_cell clause_cell_14
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_14),
		.var_value_tobase_o(var_value_tobase_14),

		.freelitcnt_pre(freelitcnt_13),
		.freelitcnt_next(freelitcnt_14),

		.imp_drv_i(imp_drv_14),
		
		.cclause_o(cclause_14),
		.cclause_drv_i(cclause_drv_14),

		.clausesat_o(clausesat_14)
	)

	clause_cell clause_cell_15
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_15),
		.var_value_tobase_o(var_value_tobase_15),

		.freelitcnt_pre(freelitcnt_14),
		.freelitcnt_next(freelitcnt_15),

		.imp_drv_i(imp_drv_15),
		
		.cclause_o(cclause_15),
		.cclause_drv_i(cclause_drv_15),

		.clausesat_o(clausesat_15)
	)

	clause_cell clause_cell_16
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_16),
		.var_value_tobase_o(var_value_tobase_16),

		.freelitcnt_pre(freelitcnt_15),
		.freelitcnt_next(freelitcnt_16),

		.imp_drv_i(imp_drv_16),
		
		.cclause_o(cclause_16),
		.cclause_drv_i(cclause_drv_16),

		.clausesat_o(clausesat_16)
	)

	clause_cell clause_cell_17
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_17),
		.var_value_tobase_o(var_value_tobase_17),

		.freelitcnt_pre(freelitcnt_16),
		.freelitcnt_next(freelitcnt_17),

		.imp_drv_i(imp_drv_17),
		
		.cclause_o(cclause_17),
		.cclause_drv_i(cclause_drv_17),

		.clausesat_o(clausesat_17)
	)

	clause_cell clause_cell_18
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_18),
		.var_value_tobase_o(var_value_tobase_18),

		.freelitcnt_pre(freelitcnt_17),
		.freelitcnt_next(freelitcnt_18),

		.imp_drv_i(imp_drv_18),
		
		.cclause_o(cclause_18),
		.cclause_drv_i(cclause_drv_18),

		.clausesat_o(clausesat_18)
	)

	clause_cell clause_cell_19
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_19),
		.var_value_tobase_o(var_value_tobase_19),

		.freelitcnt_pre(freelitcnt_18),
		.freelitcnt_next(freelitcnt_19),

		.imp_drv_i(imp_drv_19),
		
		.cclause_o(cclause_19),
		.cclause_drv_i(cclause_drv_19),

		.clausesat_o(clausesat_19)
	)

	clause_cell clause_cell_20
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_20),
		.var_value_tobase_o(var_value_tobase_20),

		.freelitcnt_pre(freelitcnt_19),
		.freelitcnt_next(freelitcnt_20),

		.imp_drv_i(imp_drv_20),
		
		.cclause_o(cclause_20),
		.cclause_drv_i(cclause_drv_20),

		.clausesat_o(clausesat_20)
	)

	clause_cell clause_cell_21
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_21),
		.var_value_tobase_o(var_value_tobase_21),

		.freelitcnt_pre(freelitcnt_20),
		.freelitcnt_next(freelitcnt_21),

		.imp_drv_i(imp_drv_21),
		
		.cclause_o(cclause_21),
		.cclause_drv_i(cclause_drv_21),

		.clausesat_o(clausesat_21)
	)

	clause_cell clause_cell_22
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_22),
		.var_value_tobase_o(var_value_tobase_22),

		.freelitcnt_pre(freelitcnt_21),
		.freelitcnt_next(freelitcnt_22),

		.imp_drv_i(imp_drv_22),
		
		.cclause_o(cclause_22),
		.cclause_drv_i(cclause_drv_22),

		.clausesat_o(clausesat_22)
	)

	clause_cell clause_cell_23
	(
		.clk(clk), 
		.rst(rst),

		.wr_i(wr_i),
		.var_value_frombase_i(var_value_frombase_23),
		.var_value_tobase_o(var_value_tobase_23),

		.freelitcnt_pre(freelitcnt_22),
		.freelitcnt_next(freelitcnt_23),

		.imp_drv_i(imp_drv_23),
		
		.cclause_o(cclause_23),
		.cclause_drv_i(cclause_drv_23),

		.clausesat_o(clausesat_23)
	)

	wire clausesat_or;
	assign clausesat_or = clausesat_0 | clausesat_1 | clausesat_2 | clausesat_3 | clausesat_4 | clausesat_5 | clausesat_6 | clausesat_7 | clausesat_8 | clausesat_9 | clausesat_10 | clausesat_11 | clausesat_12 | clausesat_13 | clausesat_14 | clausesat_15 | clausesat_16 | clausesat_17 | clausesat_18 | clausesat_19 | clausesat_20 | clausesat_21 | clausesat_22 | clausesat_23;

	wire imp_drv_o;
	assign imp_drv_0 = imp_drv_o
	assign imp_drv_1 = imp_drv_o
	assign imp_drv_2 = imp_drv_o
	assign imp_drv_3 = imp_drv_o
	assign imp_drv_4 = imp_drv_o
	assign imp_drv_5 = imp_drv_o
	assign imp_drv_6 = imp_drv_o
	assign imp_drv_7 = imp_drv_o
	assign imp_drv_8 = imp_drv_o
	assign imp_drv_9 = imp_drv_o
	assign imp_drv_10 = imp_drv_o
	assign imp_drv_11 = imp_drv_o
	assign imp_drv_12 = imp_drv_o
	assign imp_drv_13 = imp_drv_o
	assign imp_drv_14 = imp_drv_o
	assign imp_drv_15 = imp_drv_o
	assign imp_drv_16 = imp_drv_o
	assign imp_drv_17 = imp_drv_o
	assign imp_drv_18 = imp_drv_o
	assign imp_drv_19 = imp_drv_o
	assign imp_drv_20 = imp_drv_o
	assign imp_drv_21 = imp_drv_o
	assign imp_drv_22 = imp_drv_o
	assign imp_drv_23 = imp_drv_o

	wire [NUM_VARS_A_BIN-1 : 0] cclause_i = {cclause_0, cclause_1, cclause_2, cclause_3, cclause_4, cclause_5, cclause_6, cclause_7, cclause_8, cclause_9, cclause_10, cclause_11, cclause_12, cclause_13, cclause_14, cclause_15, cclause_16, cclause_17, cclause_18, cclause_19, cclause_20, cclause_21, cclause_22, cclause_23};

	wire cclause_drv_o;
	assign cclause_drv_0=cclause_drv_o;
	assign cclause_drv_1=cclause_drv_o;
	assign cclause_drv_2=cclause_drv_o;
	assign cclause_drv_3=cclause_drv_o;
	assign cclause_drv_4=cclause_drv_o;
	assign cclause_drv_5=cclause_drv_o;
	assign cclause_drv_6=cclause_drv_o;
	assign cclause_drv_7=cclause_drv_o;
	assign cclause_drv_8=cclause_drv_o;
	assign cclause_drv_9=cclause_drv_o;
	assign cclause_drv_10=cclause_drv_o;
	assign cclause_drv_11=cclause_drv_o;
	assign cclause_drv_12=cclause_drv_o;
	assign cclause_drv_13=cclause_drv_o;
	assign cclause_drv_14=cclause_drv_o;
	assign cclause_drv_15=cclause_drv_o;
	assign cclause_drv_16=cclause_drv_o;
	assign cclause_drv_17=cclause_drv_o;
	assign cclause_drv_18=cclause_drv_o;
	assign cclause_drv_19=cclause_drv_o;
	assign cclause_drv_20=cclause_drv_o;
	assign cclause_drv_21=cclause_drv_o;
	assign cclause_drv_22=cclause_drv_o;
	assign cclause_drv_23=cclause_drv_o;

	terminal_cell terminal_cell#(
		.NUM_VARS_A_BIN(NUM_VARS_A_BIN)
	)
	(
		.clk(clk), 
		.rst(rst), 
		.clausesat_i(clausesat_or),
		.freelitcnt_i(freelitcnt_i),
		.imp_drv_o(imp_drv_o),
		.cclause_i(cclause_i),
		.cclause_drv_o(cclause_drv_o)
	)

	reg need_clear;
	reg is_reason_r;

	always @(posedge clk)
	begin
		if(rst)
			need_clear <= 0;
		else if(is_reason_r && cclause_drv_o)
			need_clear <= 1;
		else if(~is_reason_r)
			need_clear <= 0;
		else
			need_clear <= need_clear;
	end

	always @(posedge clk)
	begin
		if(rst)
			is_reason_r <= 0;
		else if(imp_drv_o)
			is_reason_r <= 1;
		else if(apply_backtrack_i && need_clear)
			is_reason_r <= 0;
		else
			is_reason_r <= is_reason_r;
	end

	reg [4:0] clause_len_r;
	always @(posedge clk)
	begin
		if(rst)
			clause_len_r <= 0;
		else if(wr_i)
			clause_len_r <= clause_len_i;
		else
			clause_len_r <= clause_len_r;
	end
	assign clause_len_o = is_reason_r? 0:clause_len_r;

endmodule
