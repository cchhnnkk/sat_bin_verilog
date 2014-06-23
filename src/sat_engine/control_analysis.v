module control_analysis #(
        parameter NUM_CLAUSES = 24,
        parameter WIDTH_VAR_STATES = 30
    )
    (
     input                           clk,
     input                           rst,

     input [NUM_VARS*3-1:0]          var_value_i,
     output [NUM_VARS*3-1:0]         var_value_o,

     input [NUM_VARS-1:0]            vars_decided_tobase_i,
     input [NUM_VARS*15-1:0]         decide_lvl_i,

     input                           apply_implication_i,
     output reg                      done_imply_o,

     input                           apply_analyze_i,
     input [NUM_CLAUSES*5-1:0]       clause_len_i,
     output reg                      done_analyze_o,
     input [9:0]                     cur_bin_num_i,
     output reg [9:0]                bkt_bin_num_o,
     output                          is_independent_bin_o,
     output                          exist_var_not_vbkt_o,
     //load
     input                           apply_load_i,
     input [NUM_VARS*2-1 : 0]        load_clauses_i,

     //update
     input                           apply_update_i,
     output [NUM_VARS*2-1 : 0]       update_clause_o,

     //load update
     input                           set_vars_states_i,
     input                           get_vars_states_i,
     input [WIDTH_VAR_STATES-1 : 0]  vars_states_i,
     output [WIDTH_VAR_STATES-1 : 0] vars_states_o,

     input [NUM_VARS/2-1:0]          bitmap_learntc,
     output reg [NUM_VARS/2-1:0]     wr_learntc_o
    )

    //analyze conflict and learn conflict clause

    parameter   ANALYZE_IDLE          =  0,
                FIND_CONFLICT_CLAUSE  =  1,
                ADD_LEARNT_CLAUSE     =  2,
                BACKTRACK             =  3,
                ANALYZE_DONE          =  4;

    reg [1:0] c_analyze_state, n_analyze_state;

    always @(posedge clk)
    begin
        if(rst)
            c_analyze_state <= 0;
        else
            c_analyze_state <= n_analyze_state;
    end

    always @(*)
    begin
        if(rst)
            n_analyze_state = 0;
        else
            case(c_analyze_state)
                ANALYZE_IDLE:
                    if(apply_analyze_i)
                        n_analyze_state = FIND_CONFLICT_CLAUSE;
                    else
                        n_analyze_state = ANALYZE_IDLE;
                FIND_CONFLICT_CLAUSE:
                    if(find_conflict_cur!=find_conflict_pre)
                        n_analyze_state = ADD_LEARNT_CLAUSE;
                    else
                        n_analyze_state = FIND_CONFLICT_CLAUSE;
                ADD_LEARNT_CLAUSE:
                    if(bkt_bin_num_o!=cur_bin_num_i || exist_var_not_vbkt_o)
                        n_analyze_state = ANALYZE_DONE;
                    else
                        n_analyze_state = BACKTRACK;
                BACKTRACK:
                    n_analyze_state = ANALYZE_DONE;
                ANALYZE_DONE:
                    n_analyze_state = ANALYZE_IDLE;
                default:
                    n_analyze_state = ANALYZE_IDLE;
            endcase
    end

endmodule
