/**
 vid和states的寄存器组，用于load和update时的缓存
 */
module buffer_state(
        input             clk,
        input             rst,

        input             apply_update_first,
        input             apply_update_load,
        input             done_update_load,

        input [30*24-1:0] var_state_fromsat_i,
        output reg [29:0] var_state_tosat_o,
        output reg        valid_var_state_tosat_o,

        //load
        input [11:0]      var_id_frombram_i,
        input             valid_var_id_frombram_i,

        input [29:0]      var_state_frombram_i,

        //update
        output reg [11:0] var_id_update_minlvl_o,
        output reg [29:0] var_state_update_minlvl_o,
        output reg        valid_var_state_update_minlvl_o,

        //backtrack
        input             apply_backtrck,
        input [9:0]       bkt_lvl_i

    );
    reg [12*24-1:0]                     var_id_load_r;
    reg [12*24-1:0]                     var_id_update_r;
    reg [30*24-1:0]                     var_state_update_r;

    wire [11:0]                         var_id_load_0, var_id_load_1, var_id_load_2, var_id_load_3, var_id_load_4, var_id_load_5, var_id_load_6, var_id_load_7, var_id_load_8, var_id_load_9, var_id_load_10, var_id_load_11, var_id_load_12, var_id_load_13, var_id_load_14, var_id_load_15, var_id_load_16, var_id_load_17, var_id_load_18, var_id_load_19, var_id_load_20, var_id_load_21, var_id_load_22, var_id_load_23;

    assign {var_id_load_0, var_id_load_1, var_id_load_2, var_id_load_3, var_id_load_4, var_id_load_5, var_id_load_6, var_id_load_7, var_id_load_8, var_id_load_9, var_id_load_10, var_id_load_11, var_id_load_12, var_id_load_13, var_id_load_14, var_id_load_15, var_id_load_16, var_id_load_17, var_id_load_18, var_id_load_19, var_id_load_20, var_id_load_21, var_id_load_22, var_id_load_23} = var_id_load_r;

    wire [11:0]                         var_id_load_w_0, var_id_load_w_1, var_id_load_w_2, var_id_load_w_3, var_id_load_w_4, var_id_load_w_5, var_id_load_w_6, var_id_load_w_7, var_id_load_w_8, var_id_load_w_9, var_id_load_w_10, var_id_load_w_11, var_id_load_w_12, var_id_load_w_13, var_id_load_w_14, var_id_load_w_15, var_id_load_w_16, var_id_load_w_17, var_id_load_w_18, var_id_load_w_19, var_id_load_w_20, var_id_load_w_21, var_id_load_w_22, var_id_load_w_23;

    assign var_id_load_w_all = {var_id_load_w_0, var_id_load_w_1, var_id_load_w_2, var_id_load_w_3, var_id_load_w_4, var_id_load_w_5, var_id_load_w_6, var_id_load_w_7, var_id_load_w_8, var_id_load_w_9, var_id_load_w_10, var_id_load_w_11, var_id_load_w_12, var_id_load_w_13, var_id_load_w_14, var_id_load_w_15, var_id_load_w_16, var_id_load_w_17, var_id_load_w_18, var_id_load_w_19, var_id_load_w_20, var_id_load_w_21, var_id_load_w_22, var_id_load_w_23};

    wire [29:0]                         var_id_update_0, var_id_update_1, var_id_update_2, var_id_update_3, var_id_update_4, var_id_update_5, var_id_update_6, var_id_update_7, var_id_update_8, var_id_update_9, var_id_update_10, var_id_update_11, var_id_update_12, var_id_update_13, var_id_update_14, var_id_update_15, var_id_update_16, var_id_update_17, var_id_update_18, var_id_update_19, var_id_update_20, var_id_update_21, var_id_update_22, var_id_update_23;

    assign {var_id_update_0, var_id_update_1, var_id_update_2, var_id_update_3, var_id_update_4, var_id_update_5, var_id_update_6, var_id_update_7, var_id_update_8, var_id_update_9, var_id_update_10, var_id_update_11, var_id_update_12, var_id_update_13, var_id_update_14, var_id_update_15, var_id_update_16, var_id_update_17, var_id_update_18, var_id_update_19, var_id_update_20, var_id_update_21, var_id_update_22, var_id_update_23} = var_id_update_r;


    wire [29:0]                         var_state_update_0, var_state_update_1, var_state_update_2, var_state_update_3, var_state_update_4, var_state_update_5, var_state_update_6, var_state_update_7, var_state_update_8, var_state_update_9, var_state_update_10, var_state_update_11, var_state_update_12, var_state_update_13, var_state_update_14, var_state_update_15, var_state_update_16, var_state_update_17, var_state_update_18, var_state_update_19, var_state_update_20, var_state_update_21, var_state_update_22, var_state_update_23;

    assign {var_state_update_0, var_state_update_1, var_state_update_2, var_state_update_3, var_state_update_4, var_state_update_5, var_state_update_6, var_state_update_7, var_state_update_8, var_state_update_9, var_state_update_10, var_state_update_11, var_state_update_12, var_state_update_13, var_state_update_14, var_state_update_15, var_state_update_16, var_state_update_17, var_state_update_18, var_state_update_19, var_state_update_20, var_state_update_21, var_state_update_22, var_state_update_23} = var_state_update_r;

    /*
     *================================================================
     *                            load
     *================================================================
     */

    wire [11:0]                         var_state_rdhere_0 = valid_var_id_frombram_i==var_id_update_0? var_state_update_0:0;
    wire [11:0]                         var_state_rdhere_1 = valid_var_id_frombram_i==var_id_update_1? var_state_update_1:0;
    wire [11:0]                         var_state_rdhere_2 = valid_var_id_frombram_i==var_id_update_2? var_state_update_2:0;
    wire [11:0]                         var_state_rdhere_3 = valid_var_id_frombram_i==var_id_update_3? var_state_update_3:0;
    wire [11:0]                         var_state_rdhere_4 = valid_var_id_frombram_i==var_id_update_4? var_state_update_4:0;
    wire [11:0]                         var_state_rdhere_5 = valid_var_id_frombram_i==var_id_update_5? var_state_update_5:0;
    wire [11:0]                         var_state_rdhere_6 = valid_var_id_frombram_i==var_id_update_6? var_state_update_6:0;
    wire [11:0]                         var_state_rdhere_7 = valid_var_id_frombram_i==var_id_update_7? var_state_update_7:0;
    wire [11:0]                         var_state_rdhere_8 = valid_var_id_frombram_i==var_id_update_8? var_state_update_8:0;
    wire [11:0]                         var_state_rdhere_9 = valid_var_id_frombram_i==var_id_update_9? var_state_update_9:0;
    wire [11:0]                         var_state_rdhere_10 = valid_var_id_frombram_i==var_id_update_10? var_state_update_10:0;
    wire [11:0]                         var_state_rdhere_11 = valid_var_id_frombram_i==var_id_update_11? var_state_update_11:0;
    wire [11:0]                         var_state_rdhere_12 = valid_var_id_frombram_i==var_id_update_12? var_state_update_12:0;
    wire [11:0]                         var_state_rdhere_13 = valid_var_id_frombram_i==var_id_update_13? var_state_update_13:0;
    wire [11:0]                         var_state_rdhere_14 = valid_var_id_frombram_i==var_id_update_14? var_state_update_14:0;
    wire [11:0]                         var_state_rdhere_15 = valid_var_id_frombram_i==var_id_update_15? var_state_update_15:0;
    wire [11:0]                         var_state_rdhere_16 = valid_var_id_frombram_i==var_id_update_16? var_state_update_16:0;
    wire [11:0]                         var_state_rdhere_17 = valid_var_id_frombram_i==var_id_update_17? var_state_update_17:0;
    wire [11:0]                         var_state_rdhere_18 = valid_var_id_frombram_i==var_id_update_18? var_state_update_18:0;
    wire [11:0]                         var_state_rdhere_19 = valid_var_id_frombram_i==var_id_update_19? var_state_update_19:0;
    wire [11:0]                         var_state_rdhere_20 = valid_var_id_frombram_i==var_id_update_20? var_state_update_20:0;
    wire [11:0]                         var_state_rdhere_21 = valid_var_id_frombram_i==var_id_update_21? var_state_update_21:0;
    wire [11:0]                         var_state_rdhere_22 = valid_var_id_frombram_i==var_id_update_22? var_state_update_22:0;
    wire [11:0]                         var_state_rdhere_23 = valid_var_id_frombram_i==var_id_update_23? var_state_update_23:0;
    wire [11:0]                         var_state_rdhere_or = var_state_update_0 | var_state_update_1 | var_state_update_2 | var_state_update_3 | var_state_update_4 | var_state_update_5 | var_state_update_6 | var_state_update_7 | var_state_update_8 | var_state_update_9 | var_state_update_10 | var_state_update_11 | var_state_update_12 | var_state_update_13 | var_state_update_14 | var_state_update_15 | var_state_update_16 | var_state_update_17 | var_state_update_18 | var_state_update_19 | var_state_update_20 | var_state_update_21 | var_state_update_22 | var_state_update_23;
    reg                                 var_state_rdhere_or_r;
    always @(posedge clk)
    begin
        if(~rst)
            var_state_rdhere_or_r <= 0;
        else
            var_state_rdhere_or_r <= var_state_rdhere_or;
    end
    wire rdhere_valid = valid_var_id_frombram_i== var_id_update_0 | valid_var_id_frombram_i==var_id_update_1 | valid_var_id_frombram_i==var_id_update_2 | valid_var_id_frombram_i==var_id_update_3 | valid_var_id_frombram_i==var_id_update_4 | valid_var_id_frombram_i==var_id_update_5 | valid_var_id_frombram_i==var_id_update_6 | valid_var_id_frombram_i==var_id_update_7 | valid_var_id_frombram_i==var_id_update_8 | valid_var_id_frombram_i==var_id_update_9 | valid_var_id_frombram_i==var_id_update_10 | valid_var_id_frombram_i==var_id_update_11 | valid_var_id_frombram_i==var_id_update_12 | valid_var_id_frombram_i==var_id_update_13 | valid_var_id_frombram_i==var_id_update_14 | valid_var_id_frombram_i==var_id_update_15 | valid_var_id_frombram_i==var_id_update_16 | valid_var_id_frombram_i==var_id_update_17 | valid_var_id_frombram_i==var_id_update_18 | valid_var_id_frombram_i==var_id_update_19 | valid_var_id_frombram_i==var_id_update_20 | valid_var_id_frombram_i==var_id_update_21 | valid_var_id_frombram_i==var_id_update_22 | valid_var_id_frombram_i==var_id_update_23;
    reg  rdhere_valid_r;
    always @(posedge clk)
    begin
        if(~rst)
            rdhere_valid_r <= 0;
        else
            rdhere_valid_r <= rdhere_valid;
    end


    always @(posedge clk)
    begin
        if(~rst)
            var_id_load_r <= 0;
        else if(valid_var_id_frombram_i)
            var_id_load_r <= {var_id_load_w_all[30*23-1:0], var_id_frombram_i};
        else
            var_id_load_r <= var_id_load_r;
    end

    reg valid_var_state_load_r;

    always @(posedge clk)
    begin
        if(~rst)
            valid_var_state_load_r <= 0;
        else if(valid_var_id_frombram_i)
            valid_var_state_load_r <= 1;
        else
            valid_var_state_load_r <= 0;
    end

    always @(posedge clk)
    begin
        if(~rst)
            var_id_load_r <= 0;
        else if(valid_var_id_frombram_i)
            var_id_load_r <= {var_id_load_w_all[12*23-1:0], var_id_frombram_i};
        else
            var_id_load_r <= var_id_load_r;
    end

    wire [29:0] select_here_ornot = rdhere_valid_r? var_state_rdhere_or_r: var_state_frombram_i;
    wire [2:0]  var_value_sel;
    wire [15:0] var_lvl_sel;
    wire [9:0]  var_reason_bin_sel;
    wire        is_highest_bktlvl_sel;
    assign {var_value_sel, var_lvl_sel, var_reason_bin_sel, is_highest_bktlvl_sel} = select_here_ornot;
    wire        need_bkt = apply_backtrck && bkt_lvl_i<var_lvl_sel;
    wire        is_highest_bktlvl = apply_backtrck && bkt_lvl_i==var_lvl_sel;

    wire [2:0]  var_value_convert;
    assign var_value_convert[2:1] = var_value_sel[0]==0? ~var_value_sel[2:1]:var_value_sel[2:1];
    assign var_value_convert[0];

    always @(posedge clk)
    begin
        if(~rst) begin
            var_state_tosat_o <= 0;
            valid_var_state_tosat_o <= 0;
        end
        else if(valid_var_state_load_r && need_bkt) begin
            var_state_tosat_o <= 0;
            valid_var_state_tosat_o <= 1;
        end
        else if(valid_var_state_load_r && is_highest_bktlvl) begin
            var_state_tosat_o <= {var_value_convert, var_lvl_sel, var_reason_bin_sel, ,1'b1};
            valid_var_state_tosat_o <= 1;
        end
        else if(valid_var_state_load_r) begin
            var_state_tosat_o <= select_here_ornot;
            valid_var_state_tosat_o <= 1;
        end
        else begin
            var_state_tosat_o <= 0;
            valid_var_state_tosat_o <= 0;
        end
    end

    /*
     *================================================================
     *                           update
     *================================================================
     */
    reg [23:0] need_update;
    wire [11:0] var_id_update_w_or;
    wire [29:0] var_state_update_w_or;


    always @(posedge clk)
    begin
        if(~rst) begin
            var_id_update_minlvl_o <= 0;
            var_state_update_minlvl_o <= 0;
            valid_var_state_update_minlvl_o <= 0;
        end
        else if(need_update!=0) begin
            var_id_update_minlvl_o <= var_id_update_w_or;
            var_state_update_minlvl_o <= var_state_update_w;
            valid_var_state_update_minlvl_o <= 1;
        end
        else begin
            var_id_update_minlvl_o <= 0;
            var_state_update_minlvl_o <= 0;
            valid_var_state_update_minlvl_o <= 0;
        end
    end

    always @(posedge clk)
    begin
        if(~rst)
            var_id_update_r <= 0;
        else if(~apply_update_first && ~apply_update_load)
            var_id_update_r <= var_id_fromsat_i;
        else if(done_update_load)
            var_id_update_r <= var_id_load_r;
        else
            var_id_update_r <= var_id_update_r;
    end

    always @(posedge clk)
    begin
        if(~rst)
            var_state_update_r <= 0;
        else if(~apply_update_first && ~apply_update_load)
            var_state_update_r <= var_state_fromsat_i;
        else
            var_state_update_r <= var_state_update_r;
    end


    always @(posedge clk)
    begin
        if(~rst)
            need_update <= ~24'b0;
        else if(apply_update_first | apply_update_load) begin
            need_update[0] <= ptr_update[0]==2'b01 ? 0 : need_update[0];
            need_update[1] <= ptr_update[1]==2'b01 ? 0 : need_update[1];
            need_update[2] <= ptr_update[2]==2'b01 ? 0 : need_update[2];
            need_update[3] <= ptr_update[3]==2'b01 ? 0 : need_update[3];
            need_update[4] <= ptr_update[4]==2'b01 ? 0 : need_update[4];
            need_update[5] <= ptr_update[5]==2'b01 ? 0 : need_update[5];
            need_update[6] <= ptr_update[6]==2'b01 ? 0 : need_update[6];
            need_update[7] <= ptr_update[7]==2'b01 ? 0 : need_update[7];
            need_update[8] <= ptr_update[8]==2'b01 ? 0 : need_update[8];
            need_update[9] <= ptr_update[9]==2'b01 ? 0 : need_update[9];
            need_update[10] <= ptr_update[10]==2'b01 ? 0 : need_update[10];
            need_update[11] <= ptr_update[11]==2'b01 ? 0 : need_update[11];
            need_update[12] <= ptr_update[12]==2'b01 ? 0 : need_update[12];
            need_update[13] <= ptr_update[13]==2'b01 ? 0 : need_update[13];
            need_update[14] <= ptr_update[14]==2'b01 ? 0 : need_update[14];
            need_update[15] <= ptr_update[15]==2'b01 ? 0 : need_update[15];
            need_update[16] <= ptr_update[16]==2'b01 ? 0 : need_update[16];
            need_update[17] <= ptr_update[17]==2'b01 ? 0 : need_update[17];
            need_update[18] <= ptr_update[18]==2'b01 ? 0 : need_update[18];
            need_update[19] <= ptr_update[19]==2'b01 ? 0 : need_update[19];
            need_update[20] <= ptr_update[20]==2'b01 ? 0 : need_update[20];
            need_update[21] <= ptr_update[21]==2'b01 ? 0 : need_update[21];
            need_update[22] <= ptr_update[22]==2'b01 ? 0 : need_update[22];
            need_update[23] <= ptr_update[23]==2'b01 ? 0 : need_update[23];
        end
        else
            need_update <= need_update;
    end

    wire [2:0] value_0, value_1, value_2, value_3, value_4, value_5, value_6, value_7, value_8, value_9, value_10, value_11, value_12, value_13, value_14, value_15, value_16, value_17, value_18, value_19, value_20, value_21, value_22, value_23;
    wire [15:0] lvl_0, lvl_1, lvl_2, lvl_3, lvl_4, lvl_5, lvl_6, lvl_7, lvl_8, lvl_9, lvl_10, lvl_11, lvl_12, lvl_13, lvl_14, lvl_15, lvl_16, lvl_17, lvl_18, lvl_19, lvl_20, lvl_21, lvl_22, lvl_23;
    wire [9:0]  reason_bin_0, reason_bin_1, reason_bin_2, reason_bin_3, reason_bin_4, reason_bin_5, reason_bin_6, reason_bin_7, reason_bin_8, reason_bin_9, reason_bin_10, reason_bin_11, reason_bin_12, reason_bin_13, reason_bin_14, reason_bin_15, reason_bin_16, reason_bin_17, reason_bin_18, reason_bin_19, reason_bin_20, reason_bin_21, reason_bin_22, reason_bin_23;
    wire        isbktlvl_0, isbktlvl_0, isbktlvl_1, isbktlvl_2, isbktlvl_3, isbktlvl_4, isbktlvl_5, isbktlvl_6, isbktlvl_7, isbktlvl_8, isbktlvl_9, isbktlvl_10, isbktlvl_11, isbktlvl_12, isbktlvl_13, isbktlvl_14, isbktlvl_15, isbktlvl_16, isbktlvl_17, isbktlvl_18, isbktlvl_19, isbktlvl_20, isbktlvl_21, isbktlvl_22, isbktlvl_23;

    assign {value_0, lvl_0, reason_bin_0, isbktlvl_0} = var_state_update_0;
    assign {value_1, lvl_1, reason_bin_1, isbktlvl_1} = var_state_update_1;
    assign {value_2, lvl_2, reason_bin_2, isbktlvl_2} = var_state_update_2;
    assign {value_3, lvl_3, reason_bin_3, isbktlvl_3} = var_state_update_3;
    assign {value_4, lvl_4, reason_bin_4, isbktlvl_4} = var_state_update_4;
    assign {value_5, lvl_5, reason_bin_5, isbktlvl_5} = var_state_update_5;
    assign {value_6, lvl_6, reason_bin_6, isbktlvl_6} = var_state_update_6;
    assign {value_7, lvl_7, reason_bin_7, isbktlvl_7} = var_state_update_7;
    assign {value_8, lvl_8, reason_bin_8, isbktlvl_8} = var_state_update_8;
    assign {value_9, lvl_9, reason_bin_9, isbktlvl_9} = var_state_update_9;
    assign {value_10, lvl_10, reason_bin_10, isbktlvl_10} = var_state_update_10;
    assign {value_11, lvl_11, reason_bin_11, isbktlvl_11} = var_state_update_11;
    assign {value_12, lvl_12, reason_bin_12, isbktlvl_12} = var_state_update_12;
    assign {value_13, lvl_13, reason_bin_13, isbktlvl_13} = var_state_update_13;
    assign {value_14, lvl_14, reason_bin_14, isbktlvl_14} = var_state_update_14;
    assign {value_15, lvl_15, reason_bin_15, isbktlvl_15} = var_state_update_15;
    assign {value_16, lvl_16, reason_bin_16, isbktlvl_16} = var_state_update_16;
    assign {value_17, lvl_17, reason_bin_17, isbktlvl_17} = var_state_update_17;
    assign {value_18, lvl_18, reason_bin_18, isbktlvl_18} = var_state_update_18;
    assign {value_19, lvl_19, reason_bin_19, isbktlvl_19} = var_state_update_19;
    assign {value_20, lvl_20, reason_bin_20, isbktlvl_20} = var_state_update_20;
    assign {value_21, lvl_21, reason_bin_21, isbktlvl_21} = var_state_update_21;
    assign {value_22, lvl_22, reason_bin_22, isbktlvl_22} = var_state_update_22;
    assign {value_23, lvl_23, reason_bin_23, isbktlvl_23} = var_state_update_23;

    wire [15:0] lvl_0_0 = need_update[0]? lvl_0 | ~16'b0;
    wire [15:0] lvl_0_1 = need_update[1]? lvl_1 | ~16'b0;
    wire [15:0] lvl_0_2 = need_update[2]? lvl_2 | ~16'b0;
    wire [15:0] lvl_0_3 = need_update[3]? lvl_3 | ~16'b0;
    wire [15:0] lvl_0_4 = need_update[4]? lvl_4 | ~16'b0;
    wire [15:0] lvl_0_5 = need_update[5]? lvl_5 | ~16'b0;
    wire [15:0] lvl_0_6 = need_update[6]? lvl_6 | ~16'b0;
    wire [15:0] lvl_0_7 = need_update[7]? lvl_7 | ~16'b0;
    wire [15:0] lvl_0_8 = need_update[8]? lvl_8 | ~16'b0;
    wire [15:0] lvl_0_9 = need_update[9]? lvl_9 | ~16'b0;
    wire [15:0] lvl_0_10 = need_update[10]? lvl_10 | ~16'b0;
    wire [15:0] lvl_0_11 = need_update[11]? lvl_11 | ~16'b0;
    wire [15:0] lvl_0_12 = need_update[12]? lvl_12 | ~16'b0;
    wire [15:0] lvl_0_13 = need_update[13]? lvl_13 | ~16'b0;
    wire [15:0] lvl_0_14 = need_update[14]? lvl_14 | ~16'b0;
    wire [15:0] lvl_0_15 = need_update[15]? lvl_15 | ~16'b0;
    wire [15:0] lvl_0_16 = need_update[16]? lvl_16 | ~16'b0;
    wire [15:0] lvl_0_17 = need_update[17]? lvl_17 | ~16'b0;
    wire [15:0] lvl_0_18 = need_update[18]? lvl_18 | ~16'b0;
    wire [15:0] lvl_0_19 = need_update[19]? lvl_19 | ~16'b0;
    wire [15:0] lvl_0_20 = need_update[20]? lvl_20 | ~16'b0;
    wire [15:0] lvl_0_21 = need_update[21]? lvl_21 | ~16'b0;
    wire [15:0] lvl_0_22 = need_update[22]? lvl_22 | ~16'b0;
    wire [15:0] lvl_0_23 = need_update[23]? lvl_23 | ~16'b0;

    wire [15:0] lvl_1_0 = lvl_0_1<lvl_0_0? lvl_0_1:lvl_0_0;
    wire [15:0] lvl_1_1 = lvl_0_3<lvl_0_2? lvl_0_3:lvl_0_2;
    wire [15:0] lvl_1_2 = lvl_0_5<lvl_0_4? lvl_0_5:lvl_0_4;
    wire [15:0] lvl_1_3 = lvl_0_7<lvl_0_6? lvl_0_7:lvl_0_6;
    wire [15:0] lvl_1_4 = lvl_0_9<lvl_0_8? lvl_0_9:lvl_0_8;
    wire [15:0] lvl_1_5 = lvl_0_11<lvl_0_10? lvl_0_11:lvl_0_10;
    wire [15:0] lvl_1_6 = lvl_0_13<lvl_0_12? lvl_0_13:lvl_0_12;
    wire [15:0] lvl_1_7 = lvl_0_15<lvl_0_14? lvl_0_15:lvl_0_14;
    wire [15:0] lvl_1_8 = lvl_0_17<lvl_0_16? lvl_0_17:lvl_0_16;
    wire [15:0] lvl_1_9 = lvl_0_19<lvl_0_18? lvl_0_19:lvl_0_18;
    wire [15:0] lvl_1_10 = lvl_0_21<lvl_0_20? lvl_0_21:lvl_0_20;
    wire [15:0] lvl_1_11 = lvl_0_23<lvl_0_22? lvl_0_23:lvl_0_22;

    wire [15:0] lvl_2_0 = lvl_1_1<lvl_1_0? lvl_1_1:lvl_1_0;
    wire [15:0] lvl_2_1 = lvl_1_3<lvl_1_2? lvl_1_3:lvl_1_2;
    wire [15:0] lvl_2_2 = lvl_1_5<lvl_1_4? lvl_1_5:lvl_1_4;
    wire [15:0] lvl_2_3 = lvl_1_7<lvl_1_6? lvl_1_7:lvl_1_6;
    wire [15:0] lvl_2_4 = lvl_1_9<lvl_1_8? lvl_1_9:lvl_1_8;
    wire [15:0] lvl_2_5 = lvl_1_11<lvl_1_10? lvl_1_11:lvl_1_10;

    wire [15:0] lvl_3_0 = lvl_2_1<lvl_2_0? lvl_2_1:lvl_2_0;
    wire [15:0] lvl_3_1 = lvl_2_3<lvl_2_2? lvl_2_3:lvl_2_2;
    wire [15:0] lvl_3_2 = lvl_2_5<lvl_2_4? lvl_2_5:lvl_2_4;

    wire [15:0] lvl_4_0 = lvl_3_1<lvl_3_0? lvl_3_1:lvl_3_0;
    wire [15:0] min_lvl = lvl_4_0<lvl_3_2? lvl_4_0:lvl_3_2;

    wire [1:0]  ptr_update[24];
    assign ptr_update[0] = need_update && min_lvl==lvl_0;
    assign ptr_update[1] = ptr_update[0]!=2'b00 ? 2'b11 : {1'b0, need_update[0] && min_lvl==lvl_1};
    assign ptr_update[2] = ptr_update[1]!=2'b00 ? 2'b11 : {1'b0, need_update[1] && min_lvl==lvl_2};
    assign ptr_update[3] = ptr_update[2]!=2'b00 ? 2'b11 : {1'b0, need_update[2] && min_lvl==lvl_3};
    assign ptr_update[4] = ptr_update[3]!=2'b00 ? 2'b11 : {1'b0, need_update[3] && min_lvl==lvl_4};
    assign ptr_update[5] = ptr_update[4]!=2'b00 ? 2'b11 : {1'b0, need_update[4] && min_lvl==lvl_5};
    assign ptr_update[6] = ptr_update[5]!=2'b00 ? 2'b11 : {1'b0, need_update[5] && min_lvl==lvl_6};
    assign ptr_update[7] = ptr_update[6]!=2'b00 ? 2'b11 : {1'b0, need_update[6] && min_lvl==lvl_7};
    assign ptr_update[8] = ptr_update[7]!=2'b00 ? 2'b11 : {1'b0, need_update[7] && min_lvl==lvl_8};
    assign ptr_update[9] = ptr_update[8]!=2'b00 ? 2'b11 : {1'b0, need_update[8] && min_lvl==lvl_9};
    assign ptr_update[10] = ptr_update[9]!=2'b00 ? 2'b11 : {1'b0, need_update[9] && min_lvl==lvl_10};
    assign ptr_update[11] = ptr_update[10]!=2'b00 ? 2'b11 : {1'b0, need_update[10] && min_lvl==lvl_11};
    assign ptr_update[12] = ptr_update[11]!=2'b00 ? 2'b11 : {1'b0, need_update[11] && min_lvl==lvl_12};
    assign ptr_update[13] = ptr_update[12]!=2'b00 ? 2'b11 : {1'b0, need_update[12] && min_lvl==lvl_13};
    assign ptr_update[14] = ptr_update[13]!=2'b00 ? 2'b11 : {1'b0, need_update[13] && min_lvl==lvl_14};
    assign ptr_update[15] = ptr_update[14]!=2'b00 ? 2'b11 : {1'b0, need_update[14] && min_lvl==lvl_15};
    assign ptr_update[16] = ptr_update[15]!=2'b00 ? 2'b11 : {1'b0, need_update[15] && min_lvl==lvl_16};
    assign ptr_update[17] = ptr_update[16]!=2'b00 ? 2'b11 : {1'b0, need_update[16] && min_lvl==lvl_17};
    assign ptr_update[18] = ptr_update[17]!=2'b00 ? 2'b11 : {1'b0, need_update[17] && min_lvl==lvl_18};
    assign ptr_update[19] = ptr_update[18]!=2'b00 ? 2'b11 : {1'b0, need_update[18] && min_lvl==lvl_19};
    assign ptr_update[20] = ptr_update[19]!=2'b00 ? 2'b11 : {1'b0, need_update[19] && min_lvl==lvl_20};
    assign ptr_update[21] = ptr_update[20]!=2'b00 ? 2'b11 : {1'b0, need_update[20] && min_lvl==lvl_21};
    assign ptr_update[22] = ptr_update[21]!=2'b00 ? 2'b11 : {1'b0, need_update[21] && min_lvl==lvl_22};
    assign ptr_update[23] = ptr_update[22]!=2'b00 ? 2'b11 : {1'b0, need_update[22] && min_lvl==lvl_23};

    wire [29:0] var_state_update_w_0 = ptr_update[0]==2'b01 ? var_state_update_0 : 0;
    wire [29:0] var_state_update_w_1 = ptr_update[1]==2'b01 ? var_state_update_1 : 0;
    wire [29:0] var_state_update_w_2 = ptr_update[2]==2'b01 ? var_state_update_2 : 0;
    wire [29:0] var_state_update_w_3 = ptr_update[3]==2'b01 ? var_state_update_3 : 0;
    wire [29:0] var_state_update_w_4 = ptr_update[4]==2'b01 ? var_state_update_4 : 0;
    wire [29:0] var_state_update_w_5 = ptr_update[5]==2'b01 ? var_state_update_5 : 0;
    wire [29:0] var_state_update_w_6 = ptr_update[6]==2'b01 ? var_state_update_6 : 0;
    wire [29:0] var_state_update_w_7 = ptr_update[7]==2'b01 ? var_state_update_7 : 0;
    wire [29:0] var_state_update_w_8 = ptr_update[8]==2'b01 ? var_state_update_8 : 0;
    wire [29:0] var_state_update_w_9 = ptr_update[9]==2'b01 ? var_state_update_9 : 0;
    wire [29:0] var_state_update_w_10 = ptr_update[10]==2'b01 ? var_state_update_10 : 0;
    wire [29:0] var_state_update_w_11 = ptr_update[11]==2'b01 ? var_state_update_11 : 0;
    wire [29:0] var_state_update_w_12 = ptr_update[12]==2'b01 ? var_state_update_12 : 0;
    wire [29:0] var_state_update_w_13 = ptr_update[13]==2'b01 ? var_state_update_13 : 0;
    wire [29:0] var_state_update_w_14 = ptr_update[14]==2'b01 ? var_state_update_14 : 0;
    wire [29:0] var_state_update_w_15 = ptr_update[15]==2'b01 ? var_state_update_15 : 0;
    wire [29:0] var_state_update_w_16 = ptr_update[16]==2'b01 ? var_state_update_16 : 0;
    wire [29:0] var_state_update_w_17 = ptr_update[17]==2'b01 ? var_state_update_17 : 0;
    wire [29:0] var_state_update_w_18 = ptr_update[18]==2'b01 ? var_state_update_18 : 0;
    wire [29:0] var_state_update_w_19 = ptr_update[19]==2'b01 ? var_state_update_19 : 0;
    wire [29:0] var_state_update_w_20 = ptr_update[20]==2'b01 ? var_state_update_20 : 0;
    wire [29:0] var_state_update_w_21 = ptr_update[21]==2'b01 ? var_state_update_21 : 0;
    wire [29:0] var_state_update_w_22 = ptr_update[22]==2'b01 ? var_state_update_22 : 0;
    wire [29:0] var_state_update_w_23 = ptr_update[23]==2'b01 ? var_state_update_23 : 0;

    assign var_state_update_w_or = var_state_update_w_0 | var_state_update_w_1 | var_state_update_w_2 | var_state_update_w_3 | var_state_update_w_4 | var_state_update_w_5 | var_state_update_w_6 | var_state_update_w_7 | var_state_update_w_8 | var_state_update_w_9 | var_state_update_w_10 | var_state_update_w_11 | var_state_update_w_12 | var_state_update_w_13 | var_state_update_w_14 | var_state_update_w_15 | var_state_update_w_16 | var_state_update_w_17 | var_state_update_w_18 | var_state_update_w_19 | var_state_update_w_20 | var_state_update_w_21 | var_state_update_w_22 | var_state_update_w_23;

    wire [11:0] var_id_update_w_0 = ptr_update[0]==2'b01 ? var_id_update_0 : 0;
    wire [11:0] var_id_update_w_1 = ptr_update[1]==2'b01 ? var_id_update_1 : 0;
    wire [11:0] var_id_update_w_2 = ptr_update[2]==2'b01 ? var_id_update_2 : 0;
    wire [11:0] var_id_update_w_3 = ptr_update[3]==2'b01 ? var_id_update_3 : 0;
    wire [11:0] var_id_update_w_4 = ptr_update[4]==2'b01 ? var_id_update_4 : 0;
    wire [11:0] var_id_update_w_5 = ptr_update[5]==2'b01 ? var_id_update_5 : 0;
    wire [11:0] var_id_update_w_6 = ptr_update[6]==2'b01 ? var_id_update_6 : 0;
    wire [11:0] var_id_update_w_7 = ptr_update[7]==2'b01 ? var_id_update_7 : 0;
    wire [11:0] var_id_update_w_8 = ptr_update[8]==2'b01 ? var_id_update_8 : 0;
    wire [11:0] var_id_update_w_9 = ptr_update[9]==2'b01 ? var_id_update_9 : 0;
    wire [11:0] var_id_update_w_10 = ptr_update[10]==2'b01 ? var_id_update_10 : 0;
    wire [11:0] var_id_update_w_11 = ptr_update[11]==2'b01 ? var_id_update_11 : 0;
    wire [11:0] var_id_update_w_12 = ptr_update[12]==2'b01 ? var_id_update_12 : 0;
    wire [11:0] var_id_update_w_13 = ptr_update[13]==2'b01 ? var_id_update_13 : 0;
    wire [11:0] var_id_update_w_14 = ptr_update[14]==2'b01 ? var_id_update_14 : 0;
    wire [11:0] var_id_update_w_15 = ptr_update[15]==2'b01 ? var_id_update_15 : 0;
    wire [11:0] var_id_update_w_16 = ptr_update[16]==2'b01 ? var_id_update_16 : 0;
    wire [11:0] var_id_update_w_17 = ptr_update[17]==2'b01 ? var_id_update_17 : 0;
    wire [11:0] var_id_update_w_18 = ptr_update[18]==2'b01 ? var_id_update_18 : 0;
    wire [11:0] var_id_update_w_19 = ptr_update[19]==2'b01 ? var_id_update_19 : 0;
    wire [11:0] var_id_update_w_20 = ptr_update[20]==2'b01 ? var_id_update_20 : 0;
    wire [11:0] var_id_update_w_21 = ptr_update[21]==2'b01 ? var_id_update_21 : 0;
    wire [11:0] var_id_update_w_22 = ptr_update[22]==2'b01 ? var_id_update_22 : 0;
    wire [11:0] var_id_update_w_23 = ptr_update[23]==2'b01 ? var_id_update_23 : 0;

    assign var_id_update_w_or = var_id_update_w_0 | var_id_update_w_1 | var_id_update_w_2 | var_id_update_w_3 | var_id_update_w_4 | var_id_update_w_5 | var_id_update_w_6 | var_id_update_w_7 | var_id_update_w_8 | var_id_update_w_9 | var_id_update_w_10 | var_id_update_w_11 | var_id_update_w_12 | var_id_update_w_13 | var_id_update_w_14 | var_id_update_w_15 | var_id_update_w_16 | var_id_update_w_17 | var_id_update_w_18 | var_id_update_w_19 | var_id_update_w_20 | var_id_update_w_21 | var_id_update_w_22 | var_id_update_w_23;

endmodule
