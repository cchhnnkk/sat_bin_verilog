/**
 维护Sat Engine中单个层级的状态，在加载和决策时进行赋值，
 包括:
     reg [WIDTH_BIN-1:0] dcd_bin_r;
     reg has_bkt_r;

 协助find_bkt_lvl:
     根据max_lvl -> 遍历has_bkt[]
     沿着isbkt[]从后向前查找bkted为False的层级
         <--    <--    <--
         findflag: 2 ... 2 1 0 ... 0
 */
module lvl_state_cell #(
        parameter WIDTH_LVL_STATES = 11,
        parameter WIDTH_LVL = 16,
        parameter WIDTH_BIN = 10
    )
    (
        input                           clk, 
        input                           rst, 

        //decide
        input                           valid_from_decision_i,
        input [WIDTH_BIN-1:0]           cur_bin_num_i,
        input [WIDTH_LVL-1:0]           cur_lvl_i,

        //find bkt lvl
        input [1:0]                     findflag_i,
        output [1:0]                    findflag_o,
        input [WIDTH_LVL-1:0]           max_lvl_i,
        output reg [WIDTH_BIN-1:0]      bkt_bin_o,
        output                          findindex_o,

        //backtrack
        input                           apply_bkt_i,

        //load update
        input                           wr_states,
        input [WIDTH_LVL_STATES-1 : 0]  lvl_states_i,
        output [WIDTH_LVL_STATES-1 : 0] lvl_states_o
    )

    //加载和更新数据
    reg [WIDTH_BIN-1:0]   dcd_bin_r;
    reg                   has_bkt_r;
    wire [WIDTH_BIN-1:0] dcd_bin_i;
    wire                 has_bkt_i;
    reg [WIDTH_LVL-1:0]  var_lvl_r,
    assign lvl_states_o = {dcd_bin_r, has_bkt_r};
    assign {dcd_bin_i, has_bkt_i} = lvl_states_i;

    always @(posedge clk) begin: set_var_lvl_r
        if(~rst)
            var_lvl_r <= 0;
        else if(wr_states)              //加载
            var_lvl_r <= cur_lvl_i;
        else if(valid_from_decision_i)  //决策
            var_lvl_r <= cur_lvl_i;
        else
            var_lvl_r <= var_lvl_r;
    end

    always @(posedge clk) begin: set_dcd_bin_r
        if(~rst)
            dcd_bin_r <= 0;
        else if(wr_states)             //加载
            dcd_bin_r <= dcd_bin_i;
        else if(valid_from_decision_i) //决策
            dcd_bin_r <= cur_bin_num_i;
        else
            dcd_bin_r <= dcd_bin_r;
    end

    always @(posedge clk) begin: set_has_bkt_r
        if(~rst)
            has_bkt_r <= 0;
        else if(wr_states)
            has_bkt_r <= has_bkt_i;
        else if(apply_bkt_i && findflag==0)
            has_bkt_r <= 0;
        else if(apply_bkt_i && findflag==1) //翻转
            has_bkt_r <= 1;
        else
            has_bkt_r <= has_bkt_r;
    end

    always @(posedge clk) begin: set_bkt_bin_o
        if(~rst)
            bkt_bin_o <= 0;
        else if(find_conflict_o && findflag==1)
            bkt_bin_o <= var_reason_bin_r;
        else
            bkt_bin_o <= 0;
    end

    assign findflag_o = findflag_i != 0 ? 2 : \
                        (max_lvl_i >= var_lvl_r && has_bkt_r == 0) ? 1:0;

    assign findindex_o = findflag_o == 1;

endmodule
