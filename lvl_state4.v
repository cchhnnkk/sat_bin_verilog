/**
 维护Sat Engine中4个层级的状态，每个层级中包括:
     reg [9:0] dcd_bin_r;
     reg has_bkt_r;

 协助find_bkt_lvl:
     根据max_lvl -> 遍历has_bkt[]
     沿着isbkt[]从后向前查找bkted为False的层级
               <--    <--    <--
     findflag: 2 ... 2 1 0 ... 0
 */
module lvl_state4 #(
                    parameter NUM_LVLS = 4,
                    parameter WIDTH_LVL_STATES = 11
                    )
    (
     input                                     clk, 
     input                                     rst, 

     //decide
     input [NUM_LVLS-1:0]                      valid_from_decision_i,
     input [9:0]                               cur_bin_num_i,

     //find bkt lvl
     input [1:0]                               findflag_i,
     output [1:0]                              findflag_o,
     input [15:0]                              max_lvl_i,
     output [9:0]                              bkt_bin_o,

     //backtrack
     input                                     apply_bkt_i,

     //load update
     input                                     wr_states,
     input [WIDTH_LVL_STATES*NUM_LVLS -1 : 0]  lvl_states_i,
     output [WIDTH_LVL_STATES*NUM_LVLS -1 : 0] lvl_states_o
     );

    wire [NUM_LITS/2-1:0]                      valid_from_decision_0, valid_from_decision_1;
    assign {valid_from_decision_0, valid_from_decision_1} = valid_from_decision_i;

    wire [9:0]                                 bkt_bin_o_0, bkt_bin_o_1;
    assign bkt_bin_o = bkt_bin_o_0 | bkt_bin_o_1;

    wire [WIDTH_LVL_STATES*NUM_LITS/2-1:0]     lvl_states_i_0, lvl_states_i_1;
    assign {lvl_states_i_0, lvl_states_i_1} = lvl_states_i;

    wire [WIDTH_LVL_STATES*NUM_LITS/2-1:0]     lvl_states_o_0, lvl_states_o_1;
    assign lvl_states_o = {lvl_states_o_0, lvl_states_o_1};

    lvl_state2 #(
                 .WIDTH_LVL_STATES(WIDTH_LVL_STATES)
                 )
    lvl_state2_0(
                 .clk(clk),
                 .rst(rst),
                 .valid_from_decision_i(valid_from_decision_i_0),
                 .cur_bin_num_i(cur_bin_num_i),
                 .findflag_i(findflag_i),
                 .findflag_o(findflag_o),
                 .max_level_i(max_level_i),
                 .bkt_bin_o(bkt_bin_o_0),
                 .apply_bkt_i(apply_bkt_i),
                 .bkt_lvl_i(bkt_lvl_i),
                 .wr_states(wr_states),
                 .lvl_states_i(lvl_states_i_0),
                 .lvl_states_o(lvl_states_o_0)
                 );

    lvl_state2 #(
                 .WIDTH_LVL_STATES(WIDTH_LVL_STATES)
                 )
    lvl_state2_1(
                 .clk(clk),
                 .rst(rst),
                 .valid_from_decision_i(valid_from_decision_i_1),
                 .cur_bin_num_i(cur_bin_num_i),
                 .findflag_i(findflag_i),
                 .findflag_o(findflag_o),
                 .max_level_i(max_level_i),
                 .bkt_bin_o(bkt_bin_o_1),
                 .apply_bkt_i(apply_bkt_i),
                 .bkt_lvl_i(bkt_lvl_i),
                 .wr_states(wr_states),
                 .lvl_states_i(lvl_states_i_1),
                 .lvl_states_o(lvl_states_o_1)
                 );

endmodule
