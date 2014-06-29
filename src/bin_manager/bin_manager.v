/**
*  Bin_Manager的顶层模块
*/

module bin_manager #(
        parameter NUM_CLAUSES_A_BIN      = 8,
        parameter NUM_VARS_A_BIN         = 8,
        parameter NUM_LVLS_A_BIN         = 8,
        parameter WIDTH_BIN_ID           = 10,
        parameter WIDTH_CLAUSES          = NUM_VARS_A_BIN*2,
        parameter WIDTH_VARS             = 12,
        parameter WIDTH_LVL              = 16
        parameter WIDTH_VAR_STATES       = 30,
        parameter WIDTH_LVL_STATES       = 30,
        parameter ADDR_WIDTH_CLAUSES     = 9,
        parameter ADDR_WIDTH_VARS        = 9,
        parameter ADDR_WIDTH_VARS_STATES = 9,
        parameter ADDR_WIDTH_LVLS_STATES = 9
    )
    (
        input                                     clk,
        input                                     rst,

        input                                     start_bm_i,
        output reg                                done_bm_o,

        //结果
        output reg                                global_sat_o,
        output reg                                global_unsat_o,

        //rd bin info
        input                                     bin_info_en,
        input [WIDTH_VARS-1:0]                    nv_all_i,
        input [WIDTH_CLAUSES-1:0]                 nc_all_i,

        //sat engine core
        output                                    start_core_o,
        input                                     done_core_i,

        output [WIDTH_BIN_ID-1:0]                 cur_bin_num_o,
        output [WIDTH_LVL-1:0]                    cur_lvl_o,
        input                                     local_sat_i,
        input                                     local_unsat_i,
        input [WIDTH_LVL-1:0]                     cur_lvl_from_core_i,
        input [WIDTH_BIN_ID-1:0]                  bkt_bin_from_core_i,
        input [WIDTH_LVL-1:0]                     bkt_lvl_from_core_i,

        //load update clause to sat engine
        output [NUM_CLAUSES_A_BIN-1:0]                  wr_carray_o,
        output [NUM_CLAUSES_A_BIN-1:0]                  rd_carray_o,
        output [NUM_VARS_A_BIN*2-1 : 0]                 clause_o,
        input [NUM_VARS_A_BIN*2-1 : 0]                  clause_i,

        //load update var states  to sat engine
        output [NUM_VARS_A_BIN-1:0]                     wr_var_states_o,
        output [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0]    vars_states_o,
        input [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0]     vars_states_i

        //load update lvl states to sat engine
        output [NUM_LVLS-1:0]                           wr_lvl_states_o,
        output [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0]    lvl_states_o,
        input [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0]     lvl_states_i,
        output                                          base_lvl_en,
        output [WIDTH_LVL-1:0]                          base_lvl_o
    );

    //实例化
    //ctrl_bm
    wire                       start_rdinfo;
    wire                       done_rdinfo;
    wire                       done_load;
    wire                       start_load;
    wire [WIDTH_BIN_ID-1:0]    request_bin_num;
    wire                       start_find;
    wire                       done_find;
    wire [WIDTH_BIN_ID-1:0]    bkt_bin_find;
    wire                       start_bkt_across_bin;
    wire                       done_bkt_across_bin;
    wire                       start_update;
    wire                       done_update;

    ctrl_bm #(
        .WIDTH_BIN_ID(WIDTH_BIN_ID),
        .WIDTH_CLAUSES(WIDTH_CLAUSES),
        .WIDTH_LVL(WIDTH_LVL)
        )
    ctrl_bm(
        .clk                   (clk),
        .rst                   (rst),
        .start_bm_i            (start_bm_i),
        .done_bm_o             (done_bm_o),
        .cur_bin_num_o         (cur_bin_num_o),
        .cur_lvl_o             (cur_lvl_o),
        .global_sat_o          (global_sat_o),
        .global_unsat_o        (global_unsat_o),
        .done_rdinfo_i         (done_rdinfo),
        .nc_all_i              (nc_all),
        .start_rdinfo_o        (start_rdinfo),
        .done_load_i           (done_load),
        .start_load_o          (start_load),
        .request_bin_num_o     (request_bin_num),
        .start_core_o          (start_core_o),
        .done_core_i           (done_core_i),
        .local_sat_i           (local_sat_i),
        .cur_lvl_from_core_i   (cur_lvl_from_core_i),
        .bkt_bin_from_core_i   (bkt_bin_from_core_i),
        .start_find_o          (start_find),
        .done_find_i           (done_find),
        .bkt_bin_from_find_i   (bkt_bin_find),
        .start_bkt_across_bin_o(start_bkt_across_bin),
        .done_bkt_across_bin_i (done_bkt_across_bin),
        .start_update_o        (start_update),
        .done_update_i         (done_update)
        );

    //rd_bin_info
    wire [WIDTH_VARS-1:0]           nv_all;
    wire [WIDTH_CLAUSES-1:0]        nc_all;

    rd_bin_info #(
        .WIDTH_CLAUSES(WIDTH_CLAUSES),
        .WIDTH_VARS(WIDTH_VARS)
        )
    rd_bin_info(
        .clk           (clk),
        .rst           (rst),
        .start_rdinfo_i(start_rdinfo),
        .done_rdinfo_o (done_rdinfo),
        .data_en       (bin_info_en),
        .nv_all_i      (nv_all_i),
        .nc_all_i      (nc_all_i),
        .nv_all_o      (nv_all),
        .nc_all_o      (nc_all)
        );
 

    //load_bin
    wire                       apply_load;
    wire [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0] var_state_o;
    wire [NUM_LVLS_A_BIN-1:0]                  wr_lvl_states_o;
    wire [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0] lvl_states_o;
    wire [WIDTH_CLAUSES-1 : 0]               ram_data_c_i;
    wire [ADDR_WIDTH_CLAUSES-1:0]            ram_addr_c_o;
    wire [WIDTH_VARS-1 : 0]                  ram_data_v_i;
    wire [ADDR_WIDTH_VARS-1:0]               ram_addr_v_o;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_data_v_state_i;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_addr_v_state_o;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_data_l_state_i;
    wire [ADDR_WIDTH_LVLS_STATES-1:0]        ram_addr_l_state_o;

    load_bin #(
        .NUM_CLAUSES_A_BIN     (NUM_CLAUSES_A_BIN),
        .NUM_VARS_A_BIN        (NUM_VARS_A_BIN),
        .NUM_LVLS_A_BIN        (NUM_LVLS_A_BIN),
        .WIDTH_CLAUSES         (WIDTH_CLAUSES),
        .WIDTH_VARS            (WIDTH_VARS),
        .WIDTH_LVL             (WIDTH_LVL),
        .WIDTH_BIN_ID          (WIDTH_BIN_ID),
        .WIDTH_VAR_STATES      (WIDTH_VAR_STATES),
        .ADDR_WIDTH_CLAUSES    (ADDR_WIDTH_CLAUSES),
        .ADDR_WIDTH_VARS       (ADDR_WIDTH_VARS),
        .ADDR_WIDTH_VARS_STATES(ADDR_WIDTH_VARS_STATES),
        .ADDR_WIDTH_LVLS_STATES(ADDR_WIDTH_LVLS_STATES)
        )
    load_bin(
        .clk               (clk),
        .rst               (rst),
        .start_load        (start_load),
        .request_bin_num_i (request_bin_num),
        .apply_load_o      (apply_load),
        .done_load         (done_load),
        .wr_carray_o       (wr_carray_o),
        .clause_o          (clause_o),
        .wr_var_states_o   (wr_var_states_o),
        .var_state_o       (var_state_o),
        .wr_lvl_states_o   (wr_lvl_states_o),
        .lvl_states_o      (lvl_states_o),
        .cur_lvl_i         (cur_lvl_o),
        .base_lvl_o        (base_lvl_o),
        .base_lvl_en       (base_lvl_en),
        .ram_data_c_i      (ram_data_c_i),
        .ram_addr_c_o      (ram_addr_c_o),
        .ram_data_v_i      (ram_data_v_i),
        .ram_addr_v_o      (ram_addr_v_o),
        .ram_data_v_state_i(ram_data_v_state_i),
        .ram_addr_v_state_o(ram_addr_v_state_o),
        .ram_data_l_state_i(ram_data_l_state_i),
        .ram_addr_l_state_o(ram_addr_l_state_o)
        );



    // find_global_bkt_lvl
    wire                                     apply_find_o;
    wire [WIDTH_LVL-1:0]                     bkt_lvl_find;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_data_l_state_i;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_addr_l_state_o;

    find_global_bkt_lvl #(
        .WIDTH_LVL             (WIDTH_LVL),
        .WIDTH_BIN_ID          (WIDTH_BIN_ID),
        .WIDTH_LVL_STATES      (WIDTH_LVL_STATES),
        .ADDR_WIDTH_LVLS_STATES(ADDR_WIDTH_LVLS_STATES)
        )
    find_global_bkt_lvl(
        .clk               (clk),
        .rst               (rst),
        .start_find        (start_find),
        .apply_find_o      (apply_find_o),
        .done_find         (done_find),
        .bkt_lvl_i         (bkt_lvl_from_core_i),
        .bkt_lvl_o         (bkt_lvl_find),
        .bkt_bin_o         (bkt_bin_find),
        .ram_data_l_state_i(ram_data_l_state_i),
        .ram_addr_l_state_o(ram_addr_l_state_o)
        );


    // bkt_across_bin
    wire                                     start_bkt_across_bin;
    wire                                     apply_bkt_o;
    wire                                     done_bkt_across_bin;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_raddr_v_state_o;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_rdata_v_state_i;
    wire                                     ram_we_v_state_o;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_wdata_v_state_o;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_waddr_v_state_o;

    bkt_across_bin #(
        .WIDTH_VARS            (WIDTH_VARS),
        .WIDTH_LVL             (WIDTH_LVL),
        .WIDTH_VAR_STATES      (WIDTH_VAR_STATES),
        .WIDTH_LVL_STATES      (WIDTH_LVL_STATES),
        .ADDR_WIDTH_VARS_STATES(ADDR_WIDTH_VARS_STATES)
        .ADDR_WIDTH_LVLS_STATES(ADDR_WIDTH_LVLS_STATES)
        )
    bkt_across_bin(
        .clk                (clk),
        .rst                (rst),
        .start_bkt          (start_bkt_across_bin),
        .apply_bkt_o        (apply_bkt_o),
        .done_bkt           (done_bkt_across_bin),
        .nv_all             (nv_all),
        .bkt_lvl_i          (bkt_lvl_find),
        .ram_raddr_v_state_o(ram_raddr_v_state_o),
        .ram_rdata_v_state_i(ram_rdata_v_state_i),
        .ram_we_v_state_o   (ram_we_v_state_o),
        .ram_wdata_v_state_o(ram_wdata_v_state_o),
        .ram_waddr_v_state_o(ram_waddr_v_state_o)
        );


    // update_bin
    wire                                     apply_update_o;
    wire                                     done_update;
    wire [NUM_CLAUSES_A_BIN-1:0]               rd_carray_o;;
    wire [NUM_VARS_A_BIN*2-1 : 0]              clause_i;
    wire [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0] var_state_i;
    wire [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0] lvl_states_i;
    wire                                     ram_we_c_o;
    wire [WIDTH_CLAUSES-1:0]                 ram_data_c_o;
    wire [ADDR_WIDTH_CLAUSES-1:0]            ram_addr_c_o;
    wire [WIDTH_VARS-1 : 0]                  ram_data_v_i;
    wire [ADDR_WIDTH_VARS-1:0]               ram_addr_v_o;
    wire                                     ram_we_v_state_o;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_data_v_state_o;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_addr_v_state_o;
    wire                                     ram_we_l_state_o;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_data_l_state_o;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_addr_l_state_o;

    update_bin #(
        .NUM_CLAUSES_A_BIN     (NUM_CLAUSES_A_BIN),
        .NUM_VARS_A_BIN        (NUM_VARS_A_BIN),
        .NUM_LVLS_A_BIN        (NUM_LVLS_A_BIN),
        .WIDTH_CLAUSES         (WIDTH_CLAUSES),
        .WIDTH_VARS            (WIDTH_VARS),
        .WIDTH_LVL             (WIDTH_LVL),
        .WIDTH_BIN_ID          (WIDTH_BIN_ID),
        .WIDTH_VAR_STATES      (WIDTH_VAR_STATES),
        .ADDR_WIDTH_CLAUSES    (ADDR_WIDTH_CLAUSES),
        .ADDR_WIDTH_VARS       (ADDR_WIDTH_VARS),
        .ADDR_WIDTH_VARS_STATES(ADDR_WIDTH_VARS_STATES)
        )
    update_bin(
        .clk               (clk),
        .rst               (rst),
        .start_update      (start_update),
        .cur_bin_num_i     (cur_bin_num_o),
        .apply_update_o    (apply_update_o),
        .done_update       (done_update),
        .rd_carray_o       (rd_carray_o),
        .clause_i          (clause_i),
        .var_state_i       (var_state_i),
        .lvl_states_i      (lvl_states_i),
        .base_lvl_i        (base_lvl_o),
        .ram_we_c_o        (ram_we_c_o),
        .ram_data_c_o      (ram_data_c_o),
        .ram_addr_c_o      (ram_addr_c_o),
        .ram_data_v_i      (ram_data_v_i),
        .ram_addr_v_o      (ram_addr_v_o),
        .ram_we_v_state_o  (ram_we_v_state_o),
        .ram_data_v_state_o(ram_data_v_state_o),
        .ram_addr_v_state_o(ram_addr_v_state_o),
        .ram_we_l_state_o  (ram_we_l_state_o),
        .ram_data_l_state_o(ram_data_l_state_o),
        .ram_addr_l_state_o(ram_addr_l_state_o)
        );

    //bram
    bram_w12_d1024 bram_vars_bins_inst(
        .clka(clk),
        .wea(),
        .addra(bram_addr_vars_r),
        .dina(),
        .douta(bram_dout_var_state),
        .clkb(clk),
        .web(),
        .addrb(),
        .dinb(),
        .dout()
    );

    bram_w48_d1024 bram_clauses_bins_inst(
        .clka(clk),
        .wea(),
        .addra(bram_addr_clauses_r),
        .dina(),
        .douta(bram_dout_clauses),
        .clkb(clk),
        .web(wr_learnt_clauses_r),
        .addrb(addr_learnt_clauses_r),
        .dinb(data_learnt_clauses_r),
        .dout()
    );

    bram_w30_d1024 bram_global_var_state_inst(
        .clka(clk),
        .wea(),
        .addra(bram_addr_var_state),
        .dina(),
        .douta(bram_dout_var_state),
        .clkb(clk),
        .web(wr_update_vars_state_r),
        .addrb(addr_update_var_state_r),
        .dinb(data_update_var_state_r),
        .dout()
    );

    bram_w30_d1024 bram_global_lvl_state_inst(
      .clka(clk),
      .wea(),
      .addra(bram_addr_lvl_state),
      .dina(),
      .douta(bram_dout_lvl_state),
      .clkb(clk),
      .web(wr_update_lvls_state_r),
      .addrb(addr_update_lvl_state_r),
      .dinb(data_update_lvl_state_r),
      .dout()
    );

endmodule
