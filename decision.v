module decision #(

	parameter NUM_BIN_VARS = 24,

)
(
	input  clk, 
	input  rst, 

	input start_decision,
	input [NUM_BIN_VARS*3-1:0] vars_value_frombase_i,

	output reg [NUM_BIN_VARS-1:0] vars_decided_tobase_o,
	output reg decision_done,

	input [15:0] bkt_level_i,
	input bkt_level_valid_i,
	output [15:0] cur_level_o
);
	reg [15:0] cur_level_r;
	always @(posedge clk)
	begin
		if(rst)
			cur_level_r <= 0;
		else if(start_decision)
			cur_level_r <= cur_level_r+1;
		else if(bkt_level_valid_i)
			cur_level_r <= bkt_level_i;
		else
			cur_level_r <= 0;
	end

	wire [1:0] lock_cnt0;
	wire [1:0] lock_cnt1;
	wire [1:0] lock_cnt2;
	wire [1:0] lock_cnt3;
	wire [1:0] lock_cnt4;
	wire [1:0] lock_cnt5;
	wire [1:0] lock_cnt6;
	wire [1:0] lock_cnt7;
	wire [1:0] lock_cnt8;
	wire [1:0] lock_cnt9;
	wire [1:0] lock_cnt10;
	wire [1:0] lock_cnt11;
	wire [1:0] lock_cnt12;
	wire [1:0] lock_cnt13;
	wire [1:0] lock_cnt14;
	wire [1:0] lock_cnt15;
	wire [1:0] lock_cnt16;
	wire [1:0] lock_cnt17;
	wire [1:0] lock_cnt18;
	wire [1:0] lock_cnt19;
	wire [1:0] lock_cnt20;
	wire [1:0] lock_cnt21;
	wire [1:0] lock_cnt22;
	wire [1:0] lock_cnt23;

	assign lock_cnt0 = vars_value_frombase_i[3*0+2:3*0+1]==00? 2'b01:2'b00;
	assign lock_cnt1 = lock_cnt0!=2'b00?2'b11:(vars_value_frombase_i[3*1+2:3*1+1]==00? 2'b01:2'b00);
	assign lock_cnt2 = lock_cnt1!=2'b00?2'b11:(vars_value_frombase_i[3*2+2:3*2+1]==00? 2'b01:2'b00);
	assign lock_cnt3 = lock_cnt2!=2'b00?2'b11:(vars_value_frombase_i[3*3+2:3*3+1]==00? 2'b01:2'b00);
	assign lock_cnt4 = lock_cnt3!=2'b00?2'b11:(vars_value_frombase_i[3*4+2:3*4+1]==00? 2'b01:2'b00);
	assign lock_cnt5 = lock_cnt4!=2'b00?2'b11:(vars_value_frombase_i[3*5+2:3*5+1]==00? 2'b01:2'b00);
	assign lock_cnt6 = lock_cnt5!=2'b00?2'b11:(vars_value_frombase_i[3*6+2:3*6+1]==00? 2'b01:2'b00);
	assign lock_cnt7 = lock_cnt6!=2'b00?2'b11:(vars_value_frombase_i[3*7+2:3*7+1]==00? 2'b01:2'b00);
	assign lock_cnt8 = lock_cnt7!=2'b00?2'b11:(vars_value_frombase_i[3*8+2:3*8+1]==00? 2'b01:2'b00);
	assign lock_cnt9 = lock_cnt8!=2'b00?2'b11:(vars_value_frombase_i[3*9+2:3*9+1]==00? 2'b01:2'b00);
	assign lock_cnt10 = lock_cnt9!=2'b00?2'b11:(vars_value_frombase_i[3*10+2:3*10+1]==00? 2'b01:2'b00);
	assign lock_cnt11 = lock_cnt10!=2'b00?2'b11:(vars_value_frombase_i[3*11+2:3*11+1]==00? 2'b01:2'b00);
	assign lock_cnt12 = lock_cnt11!=2'b00?2'b11:(vars_value_frombase_i[3*12+2:3*12+1]==00? 2'b01:2'b00);
	assign lock_cnt13 = lock_cnt12!=2'b00?2'b11:(vars_value_frombase_i[3*13+2:3*13+1]==00? 2'b01:2'b00);
	assign lock_cnt14 = lock_cnt13!=2'b00?2'b11:(vars_value_frombase_i[3*14+2:3*14+1]==00? 2'b01:2'b00);
	assign lock_cnt15 = lock_cnt14!=2'b00?2'b11:(vars_value_frombase_i[3*15+2:3*15+1]==00? 2'b01:2'b00);
	assign lock_cnt16 = lock_cnt15!=2'b00?2'b11:(vars_value_frombase_i[3*16+2:3*16+1]==00? 2'b01:2'b00);
	assign lock_cnt17 = lock_cnt16!=2'b00?2'b11:(vars_value_frombase_i[3*17+2:3*17+1]==00? 2'b01:2'b00);
	assign lock_cnt18 = lock_cnt17!=2'b00?2'b11:(vars_value_frombase_i[3*18+2:3*18+1]==00? 2'b01:2'b00);
	assign lock_cnt19 = lock_cnt18!=2'b00?2'b11:(vars_value_frombase_i[3*19+2:3*19+1]==00? 2'b01:2'b00);
	assign lock_cnt20 = lock_cnt19!=2'b00?2'b11:(vars_value_frombase_i[3*20+2:3*20+1]==00? 2'b01:2'b00);
	assign lock_cnt21 = lock_cnt20!=2'b00?2'b11:(vars_value_frombase_i[3*21+2:3*21+1]==00? 2'b01:2'b00);
	assign lock_cnt22 = lock_cnt21!=2'b00?2'b11:(vars_value_frombase_i[3*22+2:3*22+1]==00? 2'b01:2'b00);
	assign lock_cnt23 = lock_cnt22!=2'b00?2'b11:(vars_value_frombase_i[3*23+2:3*23+1]==00? 2'b01:2'b00);

	always @(posedge clk) begin
		if (~rst) begin
			// reset
			vars_decided_tobase_o <= 0;
		end
		else if (start_decision) begin
			vars_decided_tobase_o[0] <= lock_cnt0!=2'b01;
			vars_decided_tobase_o[1] <= lock_cnt1!=2'b01;
			vars_decided_tobase_o[2] <= lock_cnt2!=2'b01;
			vars_decided_tobase_o[3] <= lock_cnt3!=2'b01;
			vars_decided_tobase_o[4] <= lock_cnt4!=2'b01;
			vars_decided_tobase_o[5] <= lock_cnt5!=2'b01;
			vars_decided_tobase_o[6] <= lock_cnt6!=2'b01;
			vars_decided_tobase_o[7] <= lock_cnt7!=2'b01;
			vars_decided_tobase_o[8] <= lock_cnt8!=2'b01;
			vars_decided_tobase_o[9] <= lock_cnt9!=2'b01;
			vars_decided_tobase_o[10] <= lock_cnt10!=2'b01;
			vars_decided_tobase_o[11] <= lock_cnt11!=2'b01;
			vars_decided_tobase_o[12] <= lock_cnt12!=2'b01;
			vars_decided_tobase_o[13] <= lock_cnt13!=2'b01;
			vars_decided_tobase_o[14] <= lock_cnt14!=2'b01;
			vars_decided_tobase_o[15] <= lock_cnt15!=2'b01;
			vars_decided_tobase_o[16] <= lock_cnt16!=2'b01;
			vars_decided_tobase_o[17] <= lock_cnt17!=2'b01;
			vars_decided_tobase_o[18] <= lock_cnt18!=2'b01;
			vars_decided_tobase_o[19] <= lock_cnt19!=2'b01;
			vars_decided_tobase_o[20] <= lock_cnt20!=2'b01;
			vars_decided_tobase_o[21] <= lock_cnt21!=2'b01;
			vars_decided_tobase_o[22] <= lock_cnt22!=2'b01;
			vars_decided_tobase_o[23] <= lock_cnt23!=2'b01;
		end
		else begin
			vars_decided_tobase_o <= 0;
		end
	end

	always @(posedge clk)
	begin
		if(rst)
			decision_done <= 0;
		else if(start_decision)
			decision_done <= 1;
		else
			decision_done <= 0;
	end

endmodule
