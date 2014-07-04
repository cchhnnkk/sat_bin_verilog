/**
 维护Sat Engine中单个变量的状态，包括：
     reg [2:0] var_value_r;
     reg [15:0] var_lvl_r;
 生成学习子句：
     value为11的变量，而且该变量:
     非当前层 or 当前层决策 or 当前层没有原因子句的
 */
module var_state1 #(
        parameter WIDTH_VAR_STATES = 19,
        parameter WIDTH_LVL        = 16,
        parameter WIDTH_C_LEN      = 4
    )
    (
     input                           clk,
     input                           rst,

     // data I/O
     input [2:0]                     var_value_i,
     output [2:0]                    var_value_o,
     input [WIDTH_LVL-1:0]           var_lvl_i,
     output [WIDTH_LVL-1:0]          var_lvl_o,
     output [1:0]                    learnt_lit_o,
 
     //decide
     input                           valid_from_decision_i,
     input [WIDTH_LVL-1:0]           cur_lvl_i,
 
     //imply
     input                           apply_imply_i,
     output                          find_imply_o,
     output                          find_conflict_o,
 
     //conflict
     input                           apply_analyze_i,
     output [WIDTH_LVL-1:0]          max_lvl_o,
 
     //backtrack
     input                           apply_bkt_i,
     input [WIDTH_LVL-1:0]           bkt_lvl_i,
 
     //load update var states
     input                           wr_states,
     input [WIDTH_VAR_STATES-1  : 0] vars_states_i,
     output [WIDTH_VAR_STATES-1 : 0] vars_states_o
     );

    //var state
    reg [2:0] var_value_r;
    reg [WIDTH_LVL-1:0] var_lvl_r;

    //use to generate learnt clause
    reg [1:0]  learnt_lit_r;
    //由于var_value_r在冲突分析时可能会变为11，所以需要将其值保存下来
    reg [2:0]  saved_var_value_r;

    assign var_value_o = var_value_r;
    assign learnt_lit_o = learnt_lit_r;

    assign update_clause_o = var_value_i[2:1];

    //wr_states
    assign vars_states_o = {var_value_r, var_lvl_r};
    wire [2:0] load_value_i;
    wire [WIDTH_LVL-1:0] load_lvl_i;
    assign {load_value_i, load_lvl_i} = vars_states_i;

    always @(posedge clk) begin: set_vars_value_r
        if(~rst)
            var_value_r <= -1;
        else if(wr_states)              //加载
            var_value_r <= load_value_i;
        else if(valid_from_decision_i)  //决策
            var_value_r <= 3'b010;
        else if(apply_imply_i && var_value_i[0]) //推理
            var_value_r <= var_value_i;
        else if(apply_analyze_i && var_value_i[2:1]==2'b11) //冲突分析
            var_value_r <= var_value_i;
        else if(apply_bkt_i && var_lvl_r>bkt_lvl_i)   //回退
            var_value_r <= 3'b000;
        else if(apply_bkt_i && learnt_lit_r!=2'b00 && var_lvl_r==bkt_lvl_i)
            //翻转
            var_value_r <= {~saved_var_value_r[2:1], saved_var_value_r[0]};
        else
            var_value_r <= var_value_r;
    end

    assign find_imply_o = var_value_r[0];
    assign find_conflict_o = var_value_r[2:1]==2'b11;

    always @(posedge clk) begin: set_var_lvl_r
        if(~rst)
            var_lvl_r <= 0;
        else if(wr_states)              //加载
            var_lvl_r <= load_lvl_i;
        else if(valid_from_decision_i)  //决策
            var_lvl_r <=  cur_lvl_i;
        else if(apply_imply_i && var_value_i[0])     //推理
            var_lvl_r <=  var_lvl_i;
        else
            var_lvl_r <= var_lvl_r;
    end

    assign var_lvl_o = var_lvl_r;

    always @(posedge clk) begin: set_saved_var_value_r
        if(~rst)
            saved_var_value_r <= 0;
        else if(~apply_analyze_i)
            saved_var_value_r <= var_value_r;
        else
            saved_var_value_r <= saved_var_value_r;
    end

    //learnt lit
    //参照sat_bin_python的push_cclause_fifo()函数
    always @(posedge clk) begin: set_learnt_lit_r
        if(~rst)
            learnt_lit_r <= 0;
        else if(var_value_r[2:1]==2'b11) begin
            if(var_lvl_r!=cur_lvl_i)
                //非当前层节点
                learnt_lit_r <= ~saved_var_value_r[2:1];
            else if(var_value_r[0]==0)
                //当前层决策节点
                learnt_lit_r <= ~saved_var_value_r[2:1];
            else if(var_value_i[0]==0)
                //在load以后，一些变量的原因子句在其他bin中，此时无法继续回溯
                //所以将其加入到学习子句中
                learnt_lit_r <= ~saved_var_value_r[2:1];
            else
                learnt_lit_r <= learnt_lit_r;
        end
        else if(apply_analyze_i)
            learnt_lit_r <= learnt_lit_r;
        else
            learnt_lit_r <= 0;
    end

    assign max_lvl_o = (learnt_lit_r!=0) ? var_lvl_r : 0;

endmodule
