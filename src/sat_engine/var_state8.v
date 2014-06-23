/**
 维护Sat Engine中8个变量的状态，每个变量的状态包括：
 reg [2:0] var_value_r;
 reg [15:0] var_lvl_r;
 生成学习子句：
 value为11的变量，而且该变量:
 非当前层 or 当前层决策 or 当前层没有原因子句的
 */
module var_state8 #(
                    parameter NUM_VARS = 8,
                    parameter WIDTH_VAR_STATES = 17
                    )
    (
     input                                    clk, 
     input                                    rst, 

     // data I/O
     input [NUM_VARS*3-1:0]                   var_value_i,
     output [NUM_VARS*3-1:0]                  var_value_o,
     output [WIDTH_C_LEN-1 : 0]               clause_len_o,

     //decide
     input [NUM_VARS-1:0]                     index_decided_i,
     input [9:0]                              cur_lvl_i,

     //imply
     input                                    apply_imply_i,
     output                                   find_imply_o,
     output                                   find_conflict_o,

     //conflict
     input                                    apply_analyze_i,
     output [9:0]                             max_lvl_o,

     //backtrack
     input                                    apply_bkt_i,
     input [9:0]                              bkt_lvl_i,

     //load update var states
     input [NUM_VARS-1:0]                     wr_states,
     input [WIDTH_VAR_STATES*NUM_VARS-1 : 0]  vars_states_i,
     output [WIDTH_VAR_STATES*NUM_VARS-1 : 0] vars_states_o
     )

    wire [NUM_VARS*3/2-1 : 0]   var_value_i_0, var_value_i_1;
    wire [NUM_VARS*3/2-1 : 0]   var_value_o_0, var_value_o_1;
    wire [NUM_VARS/2-1:0]       index_decided_i_0, index_decided_i_1;
    wire                        find_imply_o_0, find_imply_o_1;
    wire                        find_conflict_o_0, find_conflict_o_1;
    wire [WIDTH_VAR_STATES-1:0] max_lvl_o_0, max_lvl_o_1;
    wire [WIDTH_C_LEN-1:0]      clause_len_o_0, clause_len_o_1;

    assign {var_value_i_0, var_value_i_1} = var_value_i;
    assign var_value_o = {var_value_o_0, var_value_o_1};
    assign {index_decided_i_0, index_decided_i_1} = index_decided_i;

    assign find_imply_o = {find_imply_o_0, find_imply_o_1};
    assign find_conflict_o = find_conflict_o_0 | find_conflict_o_1;

    assign max_lvl_o = max_lvl_o_0 > max_lvl_o_1 ? max_lvl_o_0 : max_lvl_o_1;
    assign clause_len_o = clause_len_o_0 + clause_len_o_1;

    wire [NUM_VARS/2-1:0]                    wr_states_0, wr_states_1;
    wire [WIDTH_VAR_STATES*NUM_VARS/2-1 : 0] vars_states_i_0, vars_states_i_1;
    wire [WIDTH_VAR_STATES*NUM_VARS/2-1 : 0] vars_states_o_0, vars_states_o_1;

    assign {wr_states_0, wr_states_1} = wr_states;
    assign {vars_states_i_0, vars_states_i_1} = vars_states_i;
    assign vars_states_o = {vars_states_o_0, vars_states_o_1};

    var_state4 #(
                 .WIDTH_VAR_STATES(WIDTH_VAR_STATES)
                 )
    var_state4_0(
                 .clk(clk),
                 .rst(rst),
                 .var_value_i(var_value_i_0),
                 .var_value_o(var_value_o_0),
                 .index_decided_i(index_decided_i_0),
                 .cur_lvl_i(cur_lvl_i),
                 .apply_imply_i(apply_imply_i),
                 .find_imply_o(find_imply_o_0),
                 .find_conflict_o(find_conflict_o_0),
                 .apply_analyze_i(apply_analyze_i),
                 .clause_len_o(clause_len_o_0),
                 .max_lvl_o(max_lvl_o_0),
                 .apply_bkt_i(apply_bkt_i),
                 .bkt_lvl_i(bkt_lvl_i),
                 .wr_states(wr_states_0),
                 .vars_states_i(vars_states_i_0),
                 .vars_states_o(vars_states_o_0)
                 );

    var_state4 #(
                 .WIDTH_VAR_STATES(WIDTH_VAR_STATES)
                 )
    var_state4_1(
                 .clk(clk),
                 .rst(rst),
                 .var_value_i(var_value_i_1),
                 .var_value_o(var_value_o_1),
                 .index_decided_i(index_decided_i_1),
                 .cur_lvl_i(cur_lvl_i),
                 .apply_imply_i(apply_imply_i),
                 .find_imply_o(find_imply_o_1),
                 .find_conflict_o(find_conflict_o_1),
                 .apply_analyze_i(apply_analyze_i),
                 .clause_len_o(clause_len_o_1),
                 .max_lvl_o(max_lvl_o_1),
                 .apply_bkt_i(apply_bkt_i),
                 .bkt_lvl_i(bkt_lvl_i),
                 .wr_states(wr_states_1),
                 .vars_states_i(vars_states_i_1),
                 .vars_states_o(vars_states_o_1)
                 );

endmodule
