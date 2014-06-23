/**
    维护Sat Engine中变量及层级的状态，包括:
      var_state[]
      lvl_state[]

    协助find_bkt_lvl, 计算bkt_lvl计算:
      ：根据lvl_state[]得到的findindex和以及该bin的base_lvl，
      得出需要返回的层级;
  */

module state_list #(
        parameter NUM_VARS = 8,
        parameter NUM_LVLS = 8,
        parameter WIDTH_VAR_STATES = 17,
        parameter WIDTH_LVL_STATES = 11,
        parameter WIDTH_C_LEN = 4,
        parameter WIDTH_LVL = 16,
        parameter WIDTH_BIN = 10
    )
    (
        input                                      clk, 
        input                                      rst, 

        // var value I/O   
        input [NUM_VARS*3-1:0]                     var_value_i,
        output [NUM_VARS*3-1:0]                    var_value_o,
        output [WIDTH_C_LEN-1 : 0]                 clause_len_o,

        //decide   
        input                                      load_lvl_en,
        input [WIDTH_LVL-1:0]                      load_lvl_i,
        input                                      start_decision_i,
        input [WIDTH_BIN-1:0]                      cur_bin_num_i,
        output [WIDTH_LVL-1:0]                     cur_lvl_o,
        output                                     done_decision_o,

        //imply    
        input                                      apply_imply_i,
        output reg                                 done_imply_o,

        //conflict
        input                                      apply_analyze_i,
        output reg                                 add_learntc_en_o,
        output reg                                 done_analyze_o,
        //find bkt lvl
        output [WIDTH_BIN-1:0]                     bkt_bin_o,
        output [WIDTH_LVL-1:0]                     bkt_lvl_o, 

        //backtrack cur bin    
        input                                      apply_bkt_cur_bin_i,
        output reg                                 done_bkt_cur_bin_o,

        //load update var states   
        input [NUM_VARS-1:0]                       wr_var_states,
        input [WIDTH_VAR_STATES*NUM_VARS-1 : 0]    vars_states_i,
        output [WIDTH_VAR_STATES*NUM_VARS-1 : 0]   vars_states_o

        //load update lvl states   
        input [NUM_LVLS-1:0]                       wr_lvl_states,
        input [WIDTH_LVL_STATES*NUM_LVLS -1 : 0]   lvl_states_i,
        output [WIDTH_LVL_STATES*NUM_LVLS -1 : 0]  lvl_states_o,
        input                                      base_lvl_en,
        input [WIDTH_LVL-1:0]                      base_lvl_i
    );

    /**
    * 变量状态
    */
    reg  [WIDTH_LVL-1:0]      base_lvl_r;
    wire [WIDTH_LVL-1:0]      max_lvl;
    wire [NUM_VARS-1:0]       findindex;
    wire [WIDTH_LVL-1:0]      local_bkt_lvl;
    wire [NUM_VARS-1:0]       find_imply_cur, find_conflict_cur;

    var_state8 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_VAR_STATES(WIDTH_VAR_STATES)
    )
    var_state8(
        .clk(clk),
        .rst(rst),
        .var_value_i(var_value_i),
        .var_value_o(var_value_o),
        .index_decided_i(index_decided),
        .cur_lvl_i(cur_lvl_o),
        .apply_imply_i(apply_imply_i),
        .find_imply_o(find_imply_cur),
        .find_conflict_o(find_conflict_cur),
        .apply_analyze_i(apply_analyze_i),
        .max_lvl_o(max_lvl),
        .clause_len_o(clause_len_o),
        .apply_bkt_i(apply_bkt_o),
        .bkt_lvl_i(bkt_lvl_i),
        .wr_states(wr_var_states),
        .vars_states_i(vars_states_i),
        .vars_states_o(vars_states_o)
    );

    /**
    * 层级状态
    */
    wire [1:0] findflag_i;
    assign findlag_i = 0;

    lvl_state8 #(
        .NUM_LVLS(NUM_LVLS),
        .WIDTH_LVL_STATES(WIDTH_LVL_STATES)
    )
    lvl_state8(
        .clk(clk),
        .rst(rst),
        .valid_from_decision_i(valid_from_decision_i),
        .cur_bin_num_i(cur_bin_num_i),
        .cur_lvl_i(cur_lvl_o),
        .findflag_i(findflag_i),
        .findflag_o(),
        .findindex_o(findindex),
        .max_lvl_i(max_lvl),
        .bkt_bin_o(bkt_bin_o),
        .apply_bkt_i(apply_bkt_cur_bin_i),
        .wr_states(wr_states),
        .lvl_states_i(lvl_states_i),
        .lvl_states_o(lvl_states_o)
        );
    
    /**
    * 决策
    */
    wire [NUM_VARS*3-1:0] vars_value_i;
    wire [NUM_VARS-1:0]   index_decided;
    wire [WIDTH_LVL-1:0]      cur_local_lvl;

    decision #(
            .NUM_VARS(NUM_VARS)
    )
    decision(
            .clk(clk),
            .rst(rst),
            .load_lvl_en(load_lvl_en),
            .load_lvl_i(load_lvl_i),
            .decision_pulse(start_decision_i),
            .vars_value_i(var_value_o),
            .index_decided_o(index_decided),
            .decision_done(decision_done),
            .apply_bkt_i(apply_bkt_i),
            .local_bkt_lvl_i(local_bkt_lvl),
            .cur_local_lvl_o(cur_local_lvl)
    );

    assign cur_lvl_o = base_lvl_r + cur_local_lvl;

    /**
    * 计算bkt_lvl
    */
    encode_8to3(.data_i(findindex), .data_o(local_bkt_lvl));

    always @(posedge clk)
    begin
        if(rst)
            base_lvl_r <= 0;
        else if(base_lvl_en)
            base_lvl_r <= base_lvl_i;
        else
            base_lvl_r <= base_lvl_r;
    end                              
    
    reg [WIDTH_LVL-1:0] bkt_lvl_r; 

    always @(posedge clk) begin: set_bkt_lvl_r
        if(rst)
            bkt_lvl_r <= 0;
        else if(findindex==0) // 需要bin间回退
            bkt_lvl_r <= max_lvl;
        else
            bkt_lvl_r <= base_lvl_r + local_bkt_lvl;
    end

    assign bkt_lvl_o = bkt_lvl_r;

    /**
    * 推理的控制
    */
    reg [NUM_VARS-1:0] find_imply_pre, find_conflict_pre;

    always @(posedge clk)
    begin
        if(rst)
            find_imply_pre <= 0;
        else
            find_imply_pre <= find_imply_cur;
    end

    always @(posedge clk) begin: set_done_imply_o 
        if(rst)
            done_imply_o <= 0;
        else if(apply_implication_i && find_imply_cur!=find_imply_pre)
            done_imply_o <= 1;
        else
            done_imply_o <= 0;
    end

    /**
    * 冲突分析的控制，冲突学习子句的查找与添加
    */
    parameter   ANALYZE_IDLE          =  0,
                FIND_LEARNTC          =  1,
                ADD_LEARNTC           =  2,
                ANALYZE_DONE          =  4;

    reg [1:0] c_analyze_state, n_analyze_state;

    always @(posedge clk)
    begin
        if(rst)
            c_analyze_state <= 0;
        else
            c_analyze_state <= n_analyze_state;
    end

    always @(*) begin: set_n_analyze_state
        if(rst)
            n_analyze_state = 0;
        else
            case(c_analyze_state)
                ANALYZE_IDLE:
                    if(apply_analyze_i)
                        n_analyze_state = FIND_LEARNTC;
                    else
                        n_analyze_state = ANALYZE_IDLE;
                FIND_LEARNTC:
                    if(find_conflict_cur!=find_conflict_pre)
                        n_analyze_state = ADD_LEARNTC;    
                    else
                        n_analyze_state = FIND_LEARNTC;
                ADD_LEARNTC:      
                    n_analyze_state = ANALYZE_DONE;
                ANALYZE_DONE:
                    n_analyze_state = ANALYZE_IDLE;
                default:
                    n_analyze_state = ANALYZE_IDLE;
            endcase
    end

    always @(posedge clk) begin: set_done_analyze_o 
        if(rst)
            add_learntc_en_o <= 0;
        else if(c_analyze_state==ADD_LEARNTC)
            add_learntc_en_o <= 1;
        else
            add_learntc_en_o <= 0;
    end

    always @(posedge clk) begin: set_done_analyze_o 
        if(rst)
            done_analyze_o <= 0;
        else if(c_analyze_state==ANALYZE_DONE)
            done_analyze_o <= 1;
        else
            done_analyze_o <= 0;
    end

    /**
    * 回退的控制
    */

    always @(posedge clk) begin: set_done_analyze_o 
        if(rst)
            done_bkt_cur_bin_o    <= 0;
        else if(apply_bkt_cur_bin_i)
            done_bkt_cur_bin_o    <= 1;
        else
            done_bkt_cur_bin_o    <= 0;
    end

endmodule
