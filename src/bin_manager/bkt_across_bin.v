/**
*   bin间回退
*/

`include "../src/debug_define.v"

module bkt_across_bin #(
        parameter WIDTH_VAR              = 12,
        parameter WIDTH_LVL              = 16,
        parameter WIDTH_VAR_STATES       = 30,
        parameter WIDTH_LVL_STATES       = 30,
        parameter WIDTH_BIN_ID           = 10,
        parameter ADDR_WIDTH_VAR_STATES = 9,
        parameter ADDR_WIDTH_LVL_STATES = 9
    )
    (
        input                                  clk,
        input                                  rst,

        //control
        input                                  start_bkt_i,
        output reg                             apply_bkt_o,
        output reg                             done_bkt_o,

        input [WIDTH_VAR-1:0]                  nv_all_i,
        input [WIDTH_LVL-1:0]                  bkt_lvl_i,
        input [WIDTH_BIN_ID-1:0]               bkt_bin_i,

        //vars states
        //rd
        output reg [ADDR_WIDTH_VAR_STATES-1:0] ram_raddr_vs_o,
        input [WIDTH_VAR_STATES-1 : 0]         ram_rdata_vs_i,
        //wr
        output reg                             ram_we_vs_o,
        output reg [WIDTH_VAR_STATES-1 : 0]    ram_wdata_vs_o,
        output reg [ADDR_WIDTH_VAR_STATES-1:0] ram_waddr_vs_o,

        //wr lvls states
        output reg                             ram_we_ls_o,
        output reg [WIDTH_LVL_STATES-1 : 0]    ram_data_ls_o,
        output reg [ADDR_WIDTH_LVL_STATES-1:0] ram_addr_ls_o
    );

    wire [2:0]     var_value;
    wire [15:0]    var_lvl;

    parameter   IDLE = 0,
                BKT = 1,
                DONE = 2;

    reg [1:0]               c_state, n_state;
    reg [WIDTH_VAR-1:0]    var_cnt;

    always @(posedge clk)
    begin
        if(~rst)
            c_state <= 0;
        else
            c_state <= n_state;
    end

    always @(*)
    begin
        if(~rst)
            n_state = 0;
        else
            case(c_state)
                IDLE:
                    if(start_bkt_i)
                        n_state = BKT;
                    else
                        n_state = IDLE;
                BKT:
                    if(var_cnt==nv_all_i)
                        n_state = DONE;
                    else
                        n_state = BKT;
                DONE:
                    n_state = IDLE;
                default:
                    n_state = IDLE;
            endcase
    end

    /**
    *  计数器
    */
    always @(posedge clk)
    begin
        if (~rst)
            var_cnt <= 0;
        else if (c_state==BKT)
            var_cnt <= var_cnt+1;
        else
            var_cnt <= 0;
    end

    always @(posedge clk)
    begin
        if (~rst)
            ram_raddr_vs_o <= 0;
        else if (c_state==BKT)
            ram_raddr_vs_o <= var_cnt;
        else
            ram_raddr_vs_o <= 0;
    end

    assign {var_value, var_lvl} = ram_rdata_vs_i;

    //wr
    always @(posedge clk)
    begin
        if(~rst) begin
            ram_we_vs_o <= 0;
            ram_wdata_vs_o <= 0;
            ram_waddr_vs_o <= 0;
        end else if(var_lvl==bkt_lvl_i && var_value[0]==0) begin //翻转
            ram_we_vs_o <= 1;
            ram_wdata_vs_o <= {~var_value[2:1], var_value[0]};
            ram_waddr_vs_o <= ram_raddr_vs_o;
        end else if(var_lvl>=bkt_lvl_i) begin
            ram_we_vs_o <= 1;
            ram_wdata_vs_o <= 0;
            ram_waddr_vs_o <= ram_raddr_vs_o;
        end else begin
            ram_we_vs_o <= 0;
            ram_wdata_vs_o <= 0;
            ram_waddr_vs_o <= 0;
        end
    end

    //翻转has_bkted=true
    always @(posedge clk)
    begin
        if(~rst) begin
            ram_we_ls_o <= 0;
            ram_data_ls_o <= 0;
            ram_addr_ls_o <= 0;
        end else if(var_lvl==bkt_lvl_i && var_value[0]==0) begin //翻转
            ram_we_ls_o <= 1;
            ram_data_ls_o <= {bkt_bin_i, 1'b1};
            ram_addr_ls_o <= bkt_lvl_i;
        end else begin
            ram_we_ls_o <= 0;
            ram_data_ls_o <= 0;
            ram_addr_ls_o <= bkt_lvl_i;
        end
    end

    //持续信号，用于bram的mux
    always @(posedge clk)
    begin
        if(~rst)
            apply_bkt_o <= 0;
        else if(c_state==BKT)
            apply_bkt_o <= 1;
        else
            apply_bkt_o <= 0;
    end

    always @(posedge clk)
    begin
        if(~rst)
            done_bkt_o <= 0;
        else if(start_bkt_i)
            done_bkt_o <= 1;
        else
            done_bkt_o <= 0;
    end

    /**
    *  输出调试的信息
    */
    `ifdef DEBUG_bkt_across_bin
        always @(posedge clk) begin
            if(var_lvl==bkt_lvl_i && var_value[0]==0) begin //翻转
                $display("%1tns bkt convert var %d", $time/1000, ram_raddr_vs_o);
            end
            else if(var_lvl>=bkt_lvl_i) begin
                $display("%1tns bkt clear var %d", $time/1000, ram_raddr_vs_o);
            end
        end
    `endif

endmodule
