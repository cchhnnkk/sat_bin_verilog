/**
*   遍历lvl state，查找全局的回退层级
*/
module find_global_bkt_lvl #(
        parameter WIDTH_LVL              = 16,
        parameter WIDTH_BIN_ID           = 10,
        parameter WIDTH_LVL_STATES       = 30,
        parameter ADDR_WIDTH_LVLS_STATES = 9
    )
    (
        input                                         clk,
        input                                         rst,

        //control
        input                                         start_find,
        output reg                                    apply_find_o,
        output reg                                    done_find,

        input [WIDTH_LVL-1:0]                         bkt_lvl_i,
        output [WIDTH_LVL-1:0]                        bkt_lvl_o,
        output [WIDTH_BIN_ID-1 : 0]                   bkt_bin_o,

        //lvls states bram
        output reg                                    ram_we_l_state_o,
        input [WIDTH_LVL_STATES-1 : 0]                ram_data_l_state_i,
        output reg [WIDTH_LVL_STATES-1 : 0]           ram_data_l_state_o,
        output reg [ADDR_WIDTH_LVLS_STATES-1:0]       ram_addr_l_state_o
    )

    wire [WIDTH_BIN_ID-1:0]   dcd_bin;
    wire                   has_bkt;

    parameter   IDLE = 0,
                FIND_BKT_LVL = 1,
                SET_HAS_BKT = 2,
                DONE = 3;

    reg [1:0]               c_state, n_state;
    reg [WIDTH_LVL-1:0]     lvl_cnt;

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
                    if(start_update)
                        n_state = FIND_BKT_LVL;
                    else
                        n_state = IDLE;
                FIND_BKT_LVL:
                    if(lvl_cnt==0 || has_bkt==0)
                        n_state = SET_HAS_BKT;
                    else
                        n_state = FIND_BKT_LVL;
                SET_HAS_BKT:
                    n_state = DONE;
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
            lvl_cnt <= 0;
        else if (start_find)
            lvl_cnt <= bkt_lvl_i;
        else if (c_state==FIND_BKT_LVL && has_bkt!=0)
            lvl_cnt <= lvl_cnt-1;
        else
            lvl_cnt <= 0;
    end

    always @(posedge clk)
    begin
        if (~rst)
            ram_addr_l_state_o <= 0;
        else if (c_state==FIND_BKT_LVL)
            ram_addr_l_state_o <= lvl_cnt;
        else if (c_state==SET_HAS_BKT)
            ram_addr_l_state_o <= bkt_lvl_o;
        else
            ram_addr_l_state_o <= 0;
    end

    assign {dcd_bin, has_bkt} = ram_data_l_state_i;

    //记录结果
    reg [WIDTH_VAR_STATES-1 : 0] ram_data_l_state_r;

    always @(posedge clk)
    begin
        if (~rst)
            ram_addr_v_state_o <= 0;
        else if (has_bkt==0)
            ram_addr_v_state_o <= ram_data_l_state_i;
        else
            ram_addr_v_state_o <= 0;
    end

    assign {bkt_bin_o, bkt_lvl_o} = ram_addr_v_state_o;


    //持续信号，用于bram的mux
    always @(posedge clk)
    begin
        if(~rst)
            apply_find_o <= 0;
        else if(c_state==FIND_BKT_LVL || c_state == SET_HAS_BKT)
            apply_find_o <= 1;
        else
            apply_find_o <= 0;
    end

    /**
    *  将回退层的has_bkt置为1
    */
    always @(posedge clk)
    begin
        if(~rst) begin
            ram_we_l_state_o <= 0;
            ram_data_l_state_o <= 0;
        end else if(c_state == SET_HAS_BKT) begin
            ram_we_l_state_o <= 1;
            ram_data_l_state_o <= {bkt_bin_o, 1'b1};
        end else begin
            ram_we_l_state_o <= 0;
            ram_data_l_state_o <= 0;
        end
    end

    always @(posedge clk)
    begin
        if(~rst)
            done_find <= 0;
        else if(c_state==DONE)
            done_find <= 1;
        else
            done_find <= 0;
    end

endmodule
