
/**
 *  该文件是使用gen_num_verilog.py生成的
 *  gen_num_verilog ../src/sat_engine/state_list/lvl_states.gen 8
 */
/**
 维护Sat Engine中4个层级的状态，每个层级中包括:
     reg [WIDTH_BIN_ID-1:0] dcd_bin_r;
     reg has_bkt_r;

 协助find_bkt_lvl:
     根据max_lvl -> 遍历has_bkt[]
     沿着isbkt[]从后向前查找bkted为False的层级
               <--    <--    <--
     findflag_left: 2 ... 2 1 0 ... 0
 */

module lvl_state8 #(
        parameter NUM_LVLS         = 8,
        parameter WIDTH_LVL_STATES = 11,
        parameter WIDTH_LVL        = 16,
        parameter WIDTH_BIN_ID     = 10
    )
    (
        input                                     clk, 
        input                                     rst, 

        //decide
        input                                     valid_from_decision_i,
        input [WIDTH_BIN_ID-1:0]                  cur_bin_num_i,
     	input [WIDTH_LVL-1:0]                     cur_lvl_i,
        input [WIDTH_LVL-1:0]                     lvl_next_i,
        output [WIDTH_LVL-1:0]                    lvl_next_o,

        //find bkt lvl
        input [1:0]                               findflag_left_i,
        output [1:0]                              findflag_left_o,
        input [WIDTH_LVL-1:0]                     max_lvl_i,
        output [WIDTH_BIN_ID-1:0]                 bkt_bin_o,
        output [WIDTH_LVL-1:0]                    bkt_lvl_o,

        //backtrack
        input                                     apply_bkt_i,

        //load update
        input [NUM_LVLS-1:0]                      wr_states,
        input [WIDTH_LVL_STATES*NUM_LVLS -1 : 0]  lvl_states_i,
        output [WIDTH_LVL_STATES*NUM_LVLS -1 : 0] lvl_states_o
    );

    wire [NUM_LVLS/2-1:0]                      valid_from_decision_0, valid_from_decision_1;
    wire [WIDTH_BIN_ID-1:0]                    bkt_bin_o_0, bkt_bin_o_1;
    wire [WIDTH_LVL-1:0]                       bkt_lvl_o_0, bkt_lvl_o_1;
    wire [1:0]                                 findflag_left_temp;

    assign bkt_bin_o = bkt_bin_o_1 | bkt_bin_o_0;
    assign bkt_lvl_o = bkt_lvl_o_1 | bkt_lvl_o_0;

    wire [NUM_LVLS/2-1:0]                      wr_states_1, wr_states_0;
    wire [WIDTH_LVL_STATES*NUM_LVLS/2-1:0]     lvl_states_i_1, lvl_states_i_0;
    wire [WIDTH_LVL_STATES*NUM_LVLS/2-1:0]     lvl_states_o_1, lvl_states_o_0;
    assign {wr_states_1, wr_states_0} = wr_states;
    assign {lvl_states_i_1, lvl_states_i_0} = lvl_states_i;
    assign lvl_states_o = {lvl_states_o_1, lvl_states_o_0};

    wire [WIDTH_LVL-1:0]                   lvl_temp;
    wire [31 : 0]                          debug_lid_temp;

    lvl_state4 #(
        .WIDTH_LVL_STATES(WIDTH_LVL_STATES),
        .WIDTH_LVL       (WIDTH_LVL),
        .WIDTH_BIN_ID    (WIDTH_BIN_ID)
    )
    lvl_state4_0(
        .clk                  (clk),
        .rst                  (rst),
        .valid_from_decision_i(valid_from_decision_i),
        .cur_bin_num_i        (cur_bin_num_i),
        .cur_lvl_i            (cur_lvl_i),
        .lvl_next_i           (lvl_next_i),
        .lvl_next_o           (lvl_temp),
        .findflag_left_i      (findflag_left_temp),
        .findflag_left_o      (findflag_left_o),
        .max_lvl_i            (max_lvl_i),
        .bkt_bin_o            (bkt_bin_o_0),
        .bkt_lvl_o            (bkt_lvl_o_0),
        .apply_bkt_i          (apply_bkt_i),
        .wr_states            (wr_states_0),
        .lvl_states_i         (lvl_states_i_0),
        .lvl_states_o         (lvl_states_o_0)
    );

    lvl_state4 #(
        .WIDTH_LVL_STATES(WIDTH_LVL_STATES),
        .WIDTH_LVL       (WIDTH_LVL),
        .WIDTH_BIN_ID    (WIDTH_BIN_ID)
    )
    lvl_state4_1(
        .clk                  (clk),
        .rst                  (rst),
        .valid_from_decision_i(valid_from_decision_i),
        .cur_bin_num_i        (cur_bin_num_i),
        .cur_lvl_i            (cur_lvl_i),
        .lvl_next_i           (lvl_temp),
        .lvl_next_o           (lvl_next_o),
        .findflag_left_i      (findflag_left_i),
        .findflag_left_o      (findflag_left_temp),
        .max_lvl_i            (max_lvl_i),
        .bkt_bin_o            (bkt_bin_o_1),
        .bkt_lvl_o            (bkt_lvl_o_1),
        .apply_bkt_i          (apply_bkt_i),
        .wr_states            (wr_states_1),
        .lvl_states_i         (lvl_states_i_1),
        .lvl_states_o         (lvl_states_o_1)
    );

endmodule

/**
 维护Sat Engine中4个层级的状态，每个层级中包括:
     reg [WIDTH_BIN_ID-1:0] dcd_bin_r;
     reg has_bkt_r;

 协助find_bkt_lvl:
     根据max_lvl -> 遍历has_bkt[]
     沿着isbkt[]从后向前查找bkted为False的层级
               <--    <--    <--
     findflag_left: 2 ... 2 1 0 ... 0
 */

module lvl_state4 #(
        parameter NUM_LVLS         = 4,
        parameter WIDTH_LVL_STATES = 11,
        parameter WIDTH_LVL        = 16,
        parameter WIDTH_BIN_ID     = 10
    )
    (
        input                                     clk, 
        input                                     rst, 

        //decide
        input                                     valid_from_decision_i,
        input [WIDTH_BIN_ID-1:0]                  cur_bin_num_i,
     	input [WIDTH_LVL-1:0]                     cur_lvl_i,
        input [WIDTH_LVL-1:0]                     lvl_next_i,
        output [WIDTH_LVL-1:0]                    lvl_next_o,

        //find bkt lvl
        input [1:0]                               findflag_left_i,
        output [1:0]                              findflag_left_o,
        input [WIDTH_LVL-1:0]                     max_lvl_i,
        output [WIDTH_BIN_ID-1:0]                 bkt_bin_o,
        output [WIDTH_LVL-1:0]                    bkt_lvl_o,

        //backtrack
        input                                     apply_bkt_i,

        //load update
        input [NUM_LVLS-1:0]                      wr_states,
        input [WIDTH_LVL_STATES*NUM_LVLS -1 : 0]  lvl_states_i,
        output [WIDTH_LVL_STATES*NUM_LVLS -1 : 0] lvl_states_o
    );

    wire [NUM_LVLS/2-1:0]                      valid_from_decision_0, valid_from_decision_1;
    wire [WIDTH_BIN_ID-1:0]                    bkt_bin_o_0, bkt_bin_o_1;
    wire [WIDTH_LVL-1:0]                       bkt_lvl_o_0, bkt_lvl_o_1;
    wire [1:0]                                 findflag_left_temp;

    assign bkt_bin_o = bkt_bin_o_1 | bkt_bin_o_0;
    assign bkt_lvl_o = bkt_lvl_o_1 | bkt_lvl_o_0;

    wire [NUM_LVLS/2-1:0]                      wr_states_1, wr_states_0;
    wire [WIDTH_LVL_STATES*NUM_LVLS/2-1:0]     lvl_states_i_1, lvl_states_i_0;
    wire [WIDTH_LVL_STATES*NUM_LVLS/2-1:0]     lvl_states_o_1, lvl_states_o_0;
    assign {wr_states_1, wr_states_0} = wr_states;
    assign {lvl_states_i_1, lvl_states_i_0} = lvl_states_i;
    assign lvl_states_o = {lvl_states_o_1, lvl_states_o_0};

    wire [WIDTH_LVL-1:0]                   lvl_temp;
    wire [31 : 0]                          debug_lid_temp;

    lvl_state2 #(
        .WIDTH_LVL_STATES(WIDTH_LVL_STATES),
        .WIDTH_LVL       (WIDTH_LVL),
        .WIDTH_BIN_ID    (WIDTH_BIN_ID)
    )
    lvl_state2_0(
        .clk                  (clk),
        .rst                  (rst),
        .valid_from_decision_i(valid_from_decision_i),
        .cur_bin_num_i        (cur_bin_num_i),
        .cur_lvl_i            (cur_lvl_i),
        .lvl_next_i           (lvl_next_i),
        .lvl_next_o           (lvl_temp),
        .findflag_left_i      (findflag_left_temp),
        .findflag_left_o      (findflag_left_o),
        .max_lvl_i            (max_lvl_i),
        .bkt_bin_o            (bkt_bin_o_0),
        .bkt_lvl_o            (bkt_lvl_o_0),
        .apply_bkt_i          (apply_bkt_i),
        .wr_states            (wr_states_0),
        .lvl_states_i         (lvl_states_i_0),
        .lvl_states_o         (lvl_states_o_0)
    );

    lvl_state2 #(
        .WIDTH_LVL_STATES(WIDTH_LVL_STATES),
        .WIDTH_LVL       (WIDTH_LVL),
        .WIDTH_BIN_ID    (WIDTH_BIN_ID)
    )
    lvl_state2_1(
        .clk                  (clk),
        .rst                  (rst),
        .valid_from_decision_i(valid_from_decision_i),
        .cur_bin_num_i        (cur_bin_num_i),
        .cur_lvl_i            (cur_lvl_i),
        .lvl_next_i           (lvl_temp),
        .lvl_next_o           (lvl_next_o),
        .findflag_left_i      (findflag_left_i),
        .findflag_left_o      (findflag_left_temp),
        .max_lvl_i            (max_lvl_i),
        .bkt_bin_o            (bkt_bin_o_1),
        .bkt_lvl_o            (bkt_lvl_o_1),
        .apply_bkt_i          (apply_bkt_i),
        .wr_states            (wr_states_1),
        .lvl_states_i         (lvl_states_i_1),
        .lvl_states_o         (lvl_states_o_1)
    );

endmodule

/**
 维护Sat Engine中4个层级的状态，每个层级中包括:
     reg [WIDTH_BIN_ID-1:0] dcd_bin_r;
     reg has_bkt_r;

 协助find_bkt_lvl:
     根据max_lvl -> 遍历has_bkt[]
     沿着isbkt[]从后向前查找bkted为False的层级
               <--    <--    <--
     findflag_left: 2 ... 2 1 0 ... 0
 */

module lvl_state2 #(
        parameter NUM_LVLS         = 2,
        parameter WIDTH_LVL_STATES = 11,
        parameter WIDTH_LVL        = 16,
        parameter WIDTH_BIN_ID     = 10
    )
    (
        input                                     clk, 
        input                                     rst, 

        //decide
        input                                     valid_from_decision_i,
        input [WIDTH_BIN_ID-1:0]                  cur_bin_num_i,
     	input [WIDTH_LVL-1:0]                     cur_lvl_i,
        input [WIDTH_LVL-1:0]                     lvl_next_i,
        output [WIDTH_LVL-1:0]                    lvl_next_o,

        //find bkt lvl
        input [1:0]                               findflag_left_i,
        output [1:0]                              findflag_left_o,
        input [WIDTH_LVL-1:0]                     max_lvl_i,
        output [WIDTH_BIN_ID-1:0]                 bkt_bin_o,
        output [WIDTH_LVL-1:0]                    bkt_lvl_o,

        //backtrack
        input                                     apply_bkt_i,

        //load update
        input [NUM_LVLS-1:0]                      wr_states,
        input [WIDTH_LVL_STATES*NUM_LVLS -1 : 0]  lvl_states_i,
        output [WIDTH_LVL_STATES*NUM_LVLS -1 : 0] lvl_states_o
    );

    wire [NUM_LVLS/2-1:0]                      valid_from_decision_0, valid_from_decision_1;
    wire [WIDTH_BIN_ID-1:0]                    bkt_bin_o_0, bkt_bin_o_1;
    wire [WIDTH_LVL-1:0]                       bkt_lvl_o_0, bkt_lvl_o_1;
    wire [1:0]                                 findflag_left_temp;

    assign bkt_bin_o = bkt_bin_o_1 | bkt_bin_o_0;
    assign bkt_lvl_o = bkt_lvl_o_1 | bkt_lvl_o_0;

    wire [NUM_LVLS/2-1:0]                      wr_states_1, wr_states_0;
    wire [WIDTH_LVL_STATES*NUM_LVLS/2-1:0]     lvl_states_i_1, lvl_states_i_0;
    wire [WIDTH_LVL_STATES*NUM_LVLS/2-1:0]     lvl_states_o_1, lvl_states_o_0;
    assign {wr_states_1, wr_states_0} = wr_states;
    assign {lvl_states_i_1, lvl_states_i_0} = lvl_states_i;
    assign lvl_states_o = {lvl_states_o_1, lvl_states_o_0};

    wire [WIDTH_LVL-1:0]                   lvl_temp;
    wire [31 : 0]                          debug_lid_temp;

    lvl_state1 #(
        .WIDTH_LVL_STATES(WIDTH_LVL_STATES),
        .WIDTH_LVL       (WIDTH_LVL),
        .WIDTH_BIN_ID    (WIDTH_BIN_ID)
    )
    lvl_state1_0(
        .clk                  (clk),
        .rst                  (rst),
        .valid_from_decision_i(valid_from_decision_i),
        .cur_bin_num_i        (cur_bin_num_i),
        .cur_lvl_i            (cur_lvl_i),
        .lvl_next_i           (lvl_next_i),
        .lvl_next_o           (lvl_temp),
        .findflag_left_i      (findflag_left_temp),
        .findflag_left_o      (findflag_left_o),
        .max_lvl_i            (max_lvl_i),
        .bkt_bin_o            (bkt_bin_o_0),
        .bkt_lvl_o            (bkt_lvl_o_0),
        .apply_bkt_i          (apply_bkt_i),
        .wr_states            (wr_states_0),
        .lvl_states_i         (lvl_states_i_0),
        .lvl_states_o         (lvl_states_o_0)
    );

    lvl_state1 #(
        .WIDTH_LVL_STATES(WIDTH_LVL_STATES),
        .WIDTH_LVL       (WIDTH_LVL),
        .WIDTH_BIN_ID    (WIDTH_BIN_ID)
    )
    lvl_state1_1(
        .clk                  (clk),
        .rst                  (rst),
        .valid_from_decision_i(valid_from_decision_i),
        .cur_bin_num_i        (cur_bin_num_i),
        .cur_lvl_i            (cur_lvl_i),
        .lvl_next_i           (lvl_temp),
        .lvl_next_o           (lvl_next_o),
        .findflag_left_i      (findflag_left_i),
        .findflag_left_o      (findflag_left_temp),
        .max_lvl_i            (max_lvl_i),
        .bkt_bin_o            (bkt_bin_o_1),
        .bkt_lvl_o            (bkt_lvl_o_1),
        .apply_bkt_i          (apply_bkt_i),
        .wr_states            (wr_states_1),
        .lvl_states_i         (lvl_states_i_1),
        .lvl_states_o         (lvl_states_o_1)
    );

endmodule

