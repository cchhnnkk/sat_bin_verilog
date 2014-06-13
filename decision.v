/**
    寻找下一个决策变量:
        使用静态的赋值顺序
        lock[]，初始为00，遇到free变量变为01，后面的都为11
*/
module decision #(
        parameter NUM_BIN_VARS = 8,
    )
    (
        input                             clk, 
        input                             rst, 
        input                             decision_pulse,
        input      [NUM_BIN_VARS*3-1:0]   vars_value_i,
        output reg [NUM_BIN_VARS-1:0]     index_decided_o,
        output reg                        decision_done,

        input      [15:0]                 bkt_level_i,
        input                             bkt_level_valid_i,
        output     [15:0]                 cur_level_o
    );

    reg [15:0]                     cur_level_r;

    always @(posedge clk) begin: set_cur_level_r
        if(rst)
            cur_level_r <= 0;
        else if(decision_pulse)     //决策
            cur_level_r <= cur_level_r+1;
        else if(bkt_level_valid_i)  //回退
            cur_level_r <= bkt_level_i;
        else
            cur_level_r <= 0;
    end

    assign cur_level_o = cur_level_r;

    wire [NUM_BIN_VARS-1:0] index_o;

    dcd_in_8_vars dcd_in_8_vars(
        .value_i(vars_value_i),
        .lock_cnt_i(0),
        .lock_cnt_o(),
        .index_o(index_o)
    );

    always @(posedge clk)
    begin
        if(rst)
            index_decided_o <= 0;
        else if(decision_pulse)
            index_decided_o <= index_o;
        else
            index_decided_o <= index_decided_o;
    end

    always @(posedge clk)
    begin
        if(rst)
            decision_done <= 0;
        else if(decision_pulse)
            decision_done <= 1;
        else
            decision_done <= 0;
    end

endmodule

module dcd_in_8_vars #(
        parameter NUM = 8,
        parameter WIDTH = 3
    )
    (
        input [NUM*WIDTH-1 : 0] value_i,
        input [1:0]             lock_cnt_i,
        output [1:0]            lock_cnt_o,
        output [NUM-1 : 0]      index_o
    );

    parameter NUM_SUB = NUM;

    wire [NUM_SUB*WIDTH/2-1 : 0] value_i_0, value_i_1;
    wire [NUM/2-1 : 0]           index_o_0, index_o_1;
    assign {value_i_1, value_i_0} = value_i;
    assign index_o = {index_1, index_0};

    dcd_in_4_vars #(
        .WIDTH(WIDTH)
    )
    dcd_in_4_vars_0(
        .value_i(value_i_0),
        .lock_cnt_i(lock_cnt_i_0),
        .lock_cnt_o(lock_cnt_o_0),
        .index_o(index_o_0)
    );

    dcd_in_4_vars #(
        .WIDTH(WIDTH)
    )
    dcd_in_4_vars_1(
        .value_i(value_i_1),
        .lock_cnt_i(lock_cnt_i_1),
        .lock_cnt_o(lock_cnt_o_1),
        .index_o(index_o_1)
    );

endmodule

module dcd_in_4_vars #(
        parameter NUM = 4,
        parameter WIDTH = 3
    )
    (
        input [NUM*WIDTH-1 : 0] value_i,
        input [1:0]             lock_cnt_i,
        output [1:0]            lock_cnt_o,
        output [NUM-1 : 0]      index_o
    );

    parameter NUM_SUB = NUM;

    wire [NUM_SUB*WIDTH/2-1 : 0] value_i_0, value_i_1;
    wire [NUM/2-1 : 0]           index_o_0, index_o_1;
    assign {value_i_1, value_i_0} = value_i;
    assign index_o = {index_1, index_0};

    dcd_in_2_vars #(
        .WIDTH(WIDTH)
    )
    dcd_in_2_vars_0(
        .value_i(value_i_0),
        .lock_cnt_i(lock_cnt_i_0),
        .lock_cnt_o(lock_cnt_o_0),
        .index_o(index_o_0)
    );

    dcd_in_2_vars #(
        .WIDTH(WIDTH)
    )
    dcd_in_2_vars_1(
        .value_i(value_i_1),
        .lock_cnt_i(lock_cnt_i_1),
        .lock_cnt_o(lock_cnt_o_1),
        .index_o(index_o_1)
    );

endmodule

module dcd_in_2_vars #(
        parameter NUM = 2,
        parameter WIDTH = 3
    )
    (
        input [NUM*WIDTH-1 : 0] value_i,
        input [1:0]             lock_cnt_i,
        output [1:0]            lock_cnt_o,
        output [NUM-1 : 0]      index_o
    );

    parameter NUM_SUB = NUM;

    wire [NUM_SUB*WIDTH/2-1 : 0] value_i_0, value_i_1;
    wire [NUM/2-1 : 0]           index_o_0, index_o_1;
    assign {value_i_1, value_i_0} = value_i;
    assign index_o = {index_1, index_0};

    dcd_in_1_vars #(
        .WIDTH(WIDTH)
    )
    dcd_in_1_vars_0(
        .value_i(value_i_0),
        .lock_cnt_i(lock_cnt_i_0),
        .lock_cnt_o(lock_cnt_o_0),
        .index_o(index_o_0)
    );

    dcd_in_1_vars #(
        .WIDTH(WIDTH)
    )
    dcd_in_1_vars_1(
        .value_i(value_i_1),
        .lock_cnt_i(lock_cnt_i_1),
        .lock_cnt_o(lock_cnt_o_1),
        .index_o(index_o_1)
    );

endmodule

module dcd_in_1_vars #(
        parameter NUM = 1,
        parameter WIDTH = 3
    )
    (
        input [NUM*WIDTH-1 : 0] value_i,
        input [1:0]             lock_cnt_i,
        output [1:0]            lock_cnt_o,
        output [NUM-1 : 0]      index_o
    );

    assign lock_cnt_o = lock_cnt_i!=2'b00?2'b11:(value_i[3*1+2:3*1+1]==00? 2'b01:2'b00);
    assign index_o = lock_cnt_o == 1? 1 : 0;

endmodule

