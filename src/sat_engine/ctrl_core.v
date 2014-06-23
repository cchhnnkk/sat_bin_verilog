/**
    控制Sat Engine的执行，在load bin以后，开始执行
    返回bin的sat或unsat
  */

module ctrl_core #(
        parameter WIDTH_LVL = 16
    )
    (
     input 				   clk,
     input 				   rst,

     input 				   start_core_i,
     output reg 		   done_core_o,

     //推理
     output reg 		   apply_imply_o,
     input 				   done_imply_i,
     input 				   conflict_i,

     //决策
     output reg 		   start_decision_o,
     input 				   done_decision_i,
     input [WIDTH_LVL-1:0] cur_lvl_i,
     input 				   all_c_is_sat_i,

     //冲突分析
     output reg 		   apply_analyze_o,
     input 				   done_analyze_i,
     input [WIDTH_LVL-1:0] bkt_bin_num_i,

     //回退
     output reg 		   apply_bkt_cur_bin_o,
     input 				   done_bkt_cur_bin_i,

     //其他信号
     wire [WIDTH_LVL-1:0]  cur_bin_num_i,
     output reg			   sat_o,
     output reg			   unsat_o
    );

    parameter       IDLE            =   0,
                    BCP             =   2,
                    DECISION        =   3,
                    ANALYSIS        =   4,
                    BKT_CUR_BIN     =   5,
                    SAT             =   6,
                    UNSAT           =   7;

    reg [3:0] 			   c_state, n_state;
    reg [31:0] 			   wait_cnt, w_cnt, r_cnt;
    reg [31:0] 			   w_clk_cnt, r_clk_cnt;

    always @(posedge clk)
    begin
        if(~rst)
            c_state <= 0;
        else
            c_state <= n_state;
    end

    always @(*) begin: set_next_state
        if(~rst)
            n_state = 0;
        else
            case(c_state)
                IDLE:
                    if(start)
                        n_state = BCP;
                    else
                        n_state = IDLE;
                BCP:
                    if(done_bcp_i && conflict)
                        n_state = ANALYSIS;
                    else if(done_bcp_i && ~conflict)
                        n_state = DECISION;
                    else
                        n_state = BCP;
                DECISION:
                    if(done_decision_i && all_c_is_sat_i)
                        n_state = SAT;
                    else if(done_decision_i)
                        n_state = BCP;
                    else
                        n_state = DECISION;
                ANALYSIS:
                    if(done_analysis_i && bkt_bin_num_i!=cur_bin_num_i)
                        n_state = UNSAT
                    else if(done_analysis_i && bkt_bin_num_i==cur_bin_num_i)
                        n_state = BKT_CUR_BIN;
                    else
                        n_state = ANALYSIS;
                BKT_CUR_BIN:
                    if(done_bkt_cur_bin_i)
                        n_state = DECISION;
                    else
                        n_state = BKT_CUR_BIN;
                PARTIAL_SAT:
                    if(done_update_i)
                        n_state = LOAD_BIN;
                    else
                        n_state = PARTIAL_SAT;
                PARTIAL_UNSAT:
                    if(done_update_i)
                        n_state = LOAD_BIN;
                    else
                        n_state = PARTIAL_UNSAT;

                default:
                    n_state = IDLE;
            endcase
    end

    always @(posedge clk)
    begin
        if(~rst)
            sat_o <= 0;
        else if(c_state==PARTIAL_SAT)
            sat_o <= 1;
        else
            sat_o <= sat_o;
    end

    always @(posedge clk)
    begin
        if(~rst)
            unsat_o <= 0;
        else if(c_state==PARTIAL_UNSAT)
            unsat_o <= 1;
        else
            unsat_o <= unsat_o;
    end

    always @(posedge clk)
    begin
        if(~rst)
            done <= 0;
        else if(done_update_i && (c_state==GLOBAL_SAT || c_state==GLOBAL_UNSAT))
            done <= 1;
        else
            done <= done;
    end

    // 保证start_decision_o信号是一个周期的脉冲信号
    reg impulse_cnt[1:0];
    always @(posedge clk)
    begin
        if(~rst)
            impulse_cnt <= 0;
        else if(c_state==DECISION)
        begin
            if (impulse_cnt == 0)
                impulse_cnt <= 1;
            else
                impulse_cnt <= 2;

        end
        else
            impulse_cnt <= 0;
    end
    
    always @(posedge clk)
    begin
        if(~rst)
            start_decision_o <= 0;
        else if(c_state==DECISION && impulse_cnt==0)
            start_decision_o <= 1;
        else
            start_decision_o <= 0;
    end

    always @(posedge clk)
    begin
        if(~rst)
            apply_imply_o <= 0;
        else if(c_state==BCP)
            apply_imply_o <= 1;
        else
            apply_imply_o <= 0;
    end

    always @(posedge clk)
    begin
        if(~rst)
            start_decision_o <= 0;
        else if(c_state==DECISION && impulse_cnt==0)
            start_decision_o <= 1;
        else
            start_decision_o <= 0;
    end

    always @(posedge clk)
    begin
        if(~rst)
            apply_analyze_o <= 0;
        else if(c_state==ANALYSIS)
            apply_analyze_o <= 1;
        else
            apply_analyze_o <= 0;
    end

    always @(posedge clk)
    begin
        if(~rst)
            apply_bkt_cur_bin_o <= 0;
        else if(c_state==BKT_CUR_BIN)
            apply_bkt_cur_bin_o <= 1;
        else
            apply_bkt_cur_bin_o <= 0;
    end
    
endmodule
