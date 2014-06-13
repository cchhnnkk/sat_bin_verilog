/**
    维护Sat Engine中变量及层级的状态，包括:
      var_state[]
      lvl_state[]

    协助find_bkt_lvl:
      根据lvl_state[]得到的bkt_bin和以及该bin的base_lvl，
      得出需要返回的层级;
  */

module state_list #(
        parameter NUM_CLAUSES_A_BIN = 8,
        parameter NUM_VARS_A_BIN = 8,
        parameter WIDTH_VAR_STATES = 30,
        parameter WIDTH_C_LEN = 4
    )
    (
        input                                      clk, 
        input                                      rst, 

        // var value I/O   
        input [NUM_VARS*3-1:0]                     var_value_i,
        output [NUM_VARS*3-1:0]                    var_value_o,

        //decide   
        input                                      valid_from_decision_i,
        input [9:0]                                cur_level_i,
        input [9:0]                                cur_bin_num_i,

        //imply    
        input                                      apply_imply_i,
        output                                     find_imply_o,
        output                                     find_conflict_o,

        //conflict 
        input                                      apply_analyze_i,
        output [9:0]                               max_level_o,

        //find bkt lvl
        input [1:0]                                findflag_i,
        output [1:0]                               findflag_o,
        output [9:0]                               bkt_bin_o,
        output [9:0]                               bkt_lvl_o, 

        //backtrack    
        input                                      apply_bkt_i,

        //load update var states   
        input                                      wr_var_states,
        input [WIDTH_VAR_STATES*NUM_VARS-1 : 0]    vars_states_i,
        output [WIDTH_VAR_STATES*NUM_VARS-1 : 0]   vars_states_o

        //load update lvl states   
        input                                      wr_lvl_states,
        input [WIDTH_LVL_STATES*NUM_LVLS -1 : 0]   lvl_states_i,
        output [WIDTH_LVL_STATES*NUM_LVLS -1 : 0]  lvl_states_o
    );

    wire [9:0]                                  max_level;

    var_state8 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_VAR_STATES(WIDTH_VAR_STATES)
    )
    var_state8(
        .clk(clk)
        .rst(rst)
        .var_value_i(var_value_i)
        .var_value_o(var_value_o)
        .valid_from_decision_i(valid_from_decision_i)
        .cur_level_i(cur_level_i)
        .apply_imply_i(apply_imply_i)
        .find_imply_o(find_imply_o)
        .find_conflict_o(find_conflict_o)
        .apply_analyze_i(apply_analyze_i)
        .max_level_o(max_level)
        .apply_bkt_i(apply_bkt_o)
        .bkt_lvl_i(bkt_lvl_i)
        .wr_states(wr_var_states)
        .vars_states_i(vars_states_i)
        .vars_states_o(vars_states_o)
    );

    wire [1:0] findflag_i;
    assign findlag_i = 0;

    lvl_state8 #(
        .NUM_LVLS(NUM_LVLS),
        .WIDTH_LVL_STATES(WIDTH_LVL_STATES)
    )
    lvl_state8(
        .clk(clk)
        .rst(rst)
        .valid_from_decision_i(valid_from_decision_i)
        .cur_bin_num_i(cur_bin_num_i)
        .findflag_i(findflag_i)
        .findflag_o()
        .max_level_i(max_level),
        .bkt_bin_o(bkt_bin_o)
        .apply_bkt_i(apply_bkt_i)
        .wr_states(wr_states)
        .lvl_states_i(lvl_states_i)
        .lvl_states_o(lvl_states_o)
    );

endmodule
