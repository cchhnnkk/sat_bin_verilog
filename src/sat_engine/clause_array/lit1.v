
`include "../src/debug_define.v"

module lit1 #(
        parameter WIDTH_LVL   = 16
    )
    (
        input                           clk,
        input                           rst,
        
        input  [2:0]                    var_value_i,
        input  [2:0]                    var_value_down_i,
        output [2:0]                    var_value_down_o,
        
        //down在阵列中向下传播
        input  [WIDTH_LVL-1:0]          var_lvl_i,
        input  [WIDTH_LVL-1:0]          var_lvl_down_i,
        output [WIDTH_LVL-1:0]          var_lvl_down_o,
        
        input                           wr_i,
        input  [1:0]                    lit_i,
        output [1:0]                    lit_o,
        
        input  [1:0]                    freelitcnt_pre,
        output [1:0]                    freelitcnt_next,
        
        input                           imp_drv_i,
        
        output                          conflict_c_o,
        output                          all_lit_false_o,
        input                           conflict_c_drv_i,
        
        output                          csat_o,
        input                           csat_drv_i,

        //连接terminal cell
        input  [WIDTH_LVL-1:0]          cmax_lvl_i,
        output [WIDTH_LVL-1:0]          cmax_lvl_o,

        //控制信号
        input                           apply_imply_i,
        input                           apply_analyze_i,
        input                           apply_bkt_i,

        //用于调试的信号
        input  [31 : 0]                 debug_cid_i,
        input  [31 : 0]                 debug_vid_next_i,
        output [31 : 0]                 debug_vid_next_o
    );

    reg [1:0]         lit_of_clause_r;
    reg               var_implied_r;    //用于冲突分析时冲突子句的识别

    wire              participate;
    assign participate = lit_of_clause_r[0] | lit_of_clause_r[1];

    wire              isfree;
    assign isfree = var_value_i[2:1]==2'b00;

    assign csat_o = participate && lit_of_clause_r==var_value_i[2:1];

    //free lit cnt
    reg [1:0] freelitcnt;
    assign freelitcnt_next = freelitcnt;
    always @(*) begin
        if (participate && isfree) begin
            if(freelitcnt_pre==2'b00)
                freelitcnt = 2'b01;
            else
                freelitcnt = 2'b11;
        end
        else begin
            freelitcnt = freelitcnt_pre;
        end
    end

/*
    // synthesis translate_off
    property p9;
        @(posedge clk) disable iff(~rst)
            (participate && isfree && freelitcnt_pre==2'b00)
            |->
                                                     freelitcnt_next == 2'b01;
    endproperty
    assert property(p9);
    // synthesis translate_on
*/

    //find conflict
    assign conflict_c_o = participate && var_implied_r && var_value_i[2:1]==2'b11;
    assign all_lit_false_o = participate && ~isfree && lit_of_clause_r!=var_value_i[2:1] || ~participate;

    //var, var_bar to base cell
    reg [2:0] var_value_w;
    assign var_value_down_o = var_value_w | var_value_down_i;

    wire can_imply;
    assign can_imply = participate && isfree && ~csat_drv_i && imp_drv_i;

    always @(*) begin
        if (can_imply)
            var_value_w[2:1] = lit_of_clause_r[1:0];
        else if(participate && conflict_c_drv_i)
            var_value_w[2:1] = 2'b11;
        else
            var_value_w[2:1] = 2'b00;
    end

    always @(*) begin
        if (can_imply)
            var_value_w[0] = 1;
        else
            var_value_w[0] = 0;
    end

    wire first_imply;
    assign first_imply = apply_imply_i && can_imply && var_value_down_o != var_value_down_i;

    //var_implied_r用于冲突分析时冲突子句的识别
    always @(posedge clk) begin
        if (~rst)
            var_implied_r <= 0;
        else if (first_imply)       //该子句是第一个推理的
            var_implied_r <= 1;
        else if (apply_bkt_i && participate && var_value_i[0]==0) //回退时置为0
            var_implied_r <= 0;
        else if (wr_i)              //load时置为0
            var_implied_r <= 0;
        else
            var_implied_r <= var_implied_r;
    end

    always @(posedge clk) begin
        if (~rst)
            lit_of_clause_r <= 0;
        else if (wr_i)
            lit_of_clause_r <= lit_i;
        else
            lit_of_clause_r <= lit_of_clause_r;
    end

    assign lit_o = lit_of_clause_r;

    //wire [WIDTH_LVL-1:0] var_lvl_this;
    //assign var_lvl_this   = participate && isfree && imp_drv_i ? cmax_lvl_i    : -1;

    //该子句是第一个推理的
    assign var_lvl_down_o = first_imply                        ? cmax_lvl_i    : var_lvl_down_i;

    assign cmax_lvl_o     = participate && ~isfree             ? var_lvl_i    : 0;


    `ifdef DEBUG_clause_array
        assign debug_vid_next_o = debug_vid_next_i + 1;
        //显示所有文字
        int disp_all_lit = 1;
        //显示特定文字
        int len = 3;
        int c[] = '{0, 0, 0};
        int v[] = '{1, 3, 4};
        always @(posedge clk) begin
            if($time/1000 >= `T_START && $time/1000 <= `T_END) begin
                if(disp_all_lit)
                    if(debug_cid_i==1)
                        display_state();
                else begin
                    for(int i=0; i<len; i++) begin
                        if(debug_cid_i==c[i] && debug_vid_next_i==v[i]) begin
                            display_state();
                        end
                    end
                end
            end
        end

        task display_state();
            $display("%1tns c%1d v%1d", $time/1000, debug_cid_i, debug_vid_next_i);
            $display("\tvar_value_i      = %03b", var_value_i);
            $display("\tvar_value_down_i = %03b", var_value_down_i);
            $display("\tvar_value_down_o = %03b", var_value_down_o);
            $display("\tconflict_c_o     = %1d", conflict_c_o);
            $display("\tall_lit_false_o  = %1d", all_lit_false_o);
            $display("\tisfree           = %1d", isfree);
            $display("\tparticipate      = %1d", participate);
            $display("\tlit_of_clause_r  = %1b", lit_of_clause_r);
            $display("\tconflict_c_drv_i = %1b", conflict_c_drv_i);
        endtask
    `endif

endmodule
