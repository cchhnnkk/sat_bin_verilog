module lit_cell
(
	input  clk, 
	input  rst, 

	input wr_i,
	input [2:0] var_value_frombase_i,
	output reg [2:0] var_value_tobase_o,

	input [1:0] freelitcnt_pre,
	output reg [1:0] freelitcnt_next,

	input imp_drv_i,
	
	output cclause_o,
	input cclause_drv_i,

	output clausesat_o
);

	reg [1:0] lit_of_clause_r;
	reg var_implied_r;

	wire participate;
	assign participate = lit_of_clause_r[0] | lit_of_clause_r[1];

	wire isfree;
	assign isfree = var_value_frombase_i[2:1]==2'b00;

	assign clausesat_o = participate && lit_of_clause_r==var_value_frombase_i[2:0];

	//free lit cnt
	always @(*) begin
		if (participate && isfree) begin
			if(freelitcnt_pre==2'b00)
				freelitcnt_next = 2'b01;
			else
				freelitcnt_next = 2'b11;
		end
		else begin
			freelitcnt_next = freelitcnt_pre;
		end
	end

	//find conflict
	assign cclause_o = participate && var_implied_r && var_value_frombase_i[2:1]==2'b11;

	//var, var_bar to base cell
	always @(*) begin
		if (participate && isfree && imp_drv_i)
			var_value_tobase_o[2:1] = lit_of_clause_r[1:0];
		else if(participate && cclause_drv_i)
			var_value_tobase_o[2:1] = 2'b11;
		else
			var_value_tobase_o[2:1] = 2'b00;
	end

	always @(*) begin
		var_value_tobase_o[0] = imp_drv_i;
	end

	always @(posedge clk) begin
		if (~rst)
			var_implied_r <= 0;
		else if (participate && isfree && imp_drv_i)
			var_implied_r <= 1;
		else
			var_implied_r <= var_implied_r;
	end

	always @(posedge clk) begin
		if (~rst)
			lit_of_clause_r <= 0;
		else if (wr_i)
			lit_of_clause_r <= var_value_frombase_i[2:1];
		else
			lit_of_clause_r <= lit_of_clause_r;
	end
endmodule
