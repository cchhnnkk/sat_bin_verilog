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
        parameter WIDTH_LVL              = 16,
        parameter WIDTH_VAR_STATES       = 19,
        parameter WIDTH_LVL_STATES       = 11,
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

        //load update clause with sat engine
        output [NUM_CLAUSES_A_BIN-1:0]               wr_carray_o,
        output [NUM_CLAUSES_A_BIN-1:0]               rd_carray_o,
        output [NUM_VARS_A_BIN*2-1 : 0]              clause_o,
        input [NUM_VARS_A_BIN*2-1 : 0]               clause_i,

        //load update var states with sat engine
        output [NUM_VARS_A_BIN-1:0]                  wr_var_states_o,
        output [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0] vars_states_o,
        input [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0]  vars_states_i,

        //load update lvl states with sat engine
        output [NUM_LVLS_A_BIN-1:0]                  wr_lvl_states_o,
        output [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0] lvl_states_o,
        input [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0]  lvl_states_i,
        output                                       base_lvl_en,
        output [WIDTH_LVL-1:0]                       base_lvl_o,

        //外部输入端口
        input                              apply_ex_i,
        //vars bins
        input                              ram_we_v_ex_i,
        input [WIDTH_VARS-1 : 0]           ram_din_v_ex_i,
        input [ADDR_WIDTH_VARS-1:0]        ram_addr_v_ex_i,
        //clauses bins
        input                              ram_we_c_ex_i,
        input [WIDTH_CLAUSES-1 : 0]        ram_din_c_ex_i,
        input [ADDR_WIDTH_CLAUSES-1:0]     ram_addr_c_ex_i,
        //vars states
        input                              ram_we_vs_ex_i,
        input [WIDTH_VAR_STATES-1 : 0]     ram_din_vs_ex_i,
        input [ADDR_WIDTH_VARS_STATES-1:0] ram_addr_vs_ex_i,
        //lvls states
        input                              ram_we_ls_ex_i,
        input [WIDTH_LVL_STATES-1 : 0]     ram_din_ls_ex_i,
        input [ADDR_WIDTH_LVLS_STATES-1:0] ram_addr_ls_ex_i
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
    wire [WIDTH_LVL-1:0]       bkt_lvl_find;
    wire [WIDTH_VARS-1:0]      nv_all;
    wire [WIDTH_CLAUSES-1:0]   nc_all;

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
         //当前状态
        .cur_bin_num_o         (cur_bin_num_o),
        .cur_lvl_o             (cur_lvl_o),
        .global_sat_o          (global_sat_o),
        .global_unsat_o        (global_unsat_o),
         //读取基本信息
        .done_rdinfo_i         (done_rdinfo),
        .nc_all_i              (nc_all),
        .start_rdinfo_o        (start_rdinfo),
         //load bin
        .done_load_i           (done_load),
        .start_load_o          (start_load),
        .request_bin_num_o     (request_bin_num),
         //sat_engine core
        .start_core_o          (start_core_o),
        .done_core_i           (done_core_i),
        .local_sat_i           (local_sat_i),
        .cur_lvl_from_core_i   (cur_lvl_from_core_i),
        .bkt_bin_from_core_i   (bkt_bin_from_core_i),
         //find_global_bkt_lvl
        .start_find_o          (start_find),
        .done_find_i           (done_find),
        .bkt_bin_from_find_i   (bkt_bin_find),
        .bkt_lvl_from_find_i   (bkt_lvl_find),
         //bkt_across_bin
        .start_bkt_across_bin_o(start_bkt_across_bin),
        .done_bkt_across_bin_i (done_bkt_across_bin),
         //update bin
        .start_update_o        (start_update),
        .done_update_i         (done_update)
    );

    //rd_bin_info

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
    wire [WIDTH_CLAUSES-1 : 0]               ram_douta_c;
    wire [ADDR_WIDTH_CLAUSES-1:0]            ram_addr_c_from_load;
    wire [WIDTH_VARS-1 : 0]                  ram_douta_v;
    wire [ADDR_WIDTH_VARS-1:0]               ram_addr_v_from_load;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_data_vs;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_addr_vs_from_load;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_data_ls;
    wire [ADDR_WIDTH_LVLS_STATES-1:0]        ram_addr_ls_from_load;

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
        .clk              (clk),
        .rst              (rst),
        .start_load       (start_load),
        .request_bin_num_i(request_bin_num),
        .apply_load_o     (apply_load),
        .done_load        (done_load),
        .wr_carray_o      (wr_carray_o),
        .clause_o         (clause_o),
        .wr_var_states_o  (wr_var_states_o),
        .vars_states_o     (vars_states_o),
        .wr_lvl_states_o  (wr_lvl_states_o),
        .lvl_states_o     (lvl_states_o),
        .cur_lvl_i        (cur_lvl_o),
        .base_lvl_o       (base_lvl_o),
        .base_lvl_en      (base_lvl_en),
        .ram_data_c_i     (ram_douta_c),
        .ram_addr_c_o     (ram_addr_c_from_load),
        .ram_data_v_i     (ram_douta_v),
        .ram_addr_v_o     (ram_addr_v_from_load),
        .ram_data_vs_i    (ram_data_vs),
        .ram_addr_vs_o    (ram_addr_vs_from_load),
        .ram_data_ls_i    (ram_data_ls),
        .ram_addr_ls_o    (ram_addr_ls_from_load)
    );


    // find_global_bkt_lvl
    wire                                     apply_find;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_addr_ls_from_find;

    find_global_bkt_lvl #(
        .WIDTH_LVL             (WIDTH_LVL),
        .WIDTH_BIN_ID          (WIDTH_BIN_ID),
        .WIDTH_LVL_STATES      (WIDTH_LVL_STATES),
        .ADDR_WIDTH_LVLS_STATES(ADDR_WIDTH_LVLS_STATES)
    )
    find_global_bkt_lvl(
        .clk          (clk),
        .rst          (rst),
        .start_find   (start_find),
        .apply_find_o (apply_find),
        .done_find    (done_find),
        .bkt_lvl_i    (bkt_lvl_from_core_i),
        .bkt_lvl_o    (bkt_lvl_find),
        .bkt_bin_o    (bkt_bin_find),
        .ram_data_ls_i(ram_data_ls),
        .ram_addr_ls_o(ram_addr_ls_from_find)
    );


    // bkt_across_bin
    wire                                     apply_bkt_across_bin;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_raddr_vs_from_bkt;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_rdata_vs;
    wire                                     ram_we_vs_from_bkt;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_wdata_vs_from_bkt;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_waddr_vs_from_bkt;

    bkt_across_bin #(
        .WIDTH_VARS            (WIDTH_VARS),
        .WIDTH_LVL             (WIDTH_LVL),
        .WIDTH_VAR_STATES      (WIDTH_VAR_STATES),
        .WIDTH_LVL_STATES      (WIDTH_LVL_STATES),
        .ADDR_WIDTH_VARS_STATES(ADDR_WIDTH_VARS_STATES),
        .ADDR_WIDTH_LVLS_STATES(ADDR_WIDTH_LVLS_STATES)
    )
    bkt_across_bin(
        .clk           (clk),
        .rst           (rst),
        .start_bkt     (start_bkt_across_bin),
        .apply_bkt_o   (apply_bkt_across_bin),
        .done_bkt      (done_bkt_across_bin),
        .nv_all        (nv_all),
        .bkt_lvl_i     (bkt_lvl_find),
        .ram_raddr_vs_o(ram_raddr_vs_from_bkt),
        .ram_rdata_vs_i(ram_rdata_vs),
        .ram_we_vs_o   (ram_we_vs_from_bkt),
        .ram_wdata_vs_o(ram_wdata_vs_from_bkt),
        .ram_waddr_vs_o(ram_waddr_vs_from_bkt)
    );


    // update_bin
    wire                                     apply_update;
    wire                                     ram_we_c_from_update;
    wire [WIDTH_CLAUSES-1:0]                 ram_data_c_from_update;
    wire [ADDR_WIDTH_CLAUSES-1:0]            ram_addr_c_from_update;
    wire [ADDR_WIDTH_VARS-1:0]               ram_addr_v_from_update;
    wire                                     ram_we_vs_from_update;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_data_vs_from_update;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_addr_vs_from_update;
    wire                                     ram_we_ls_from_update;
    wire [WIDTH_VAR_STATES-1 : 0]            ram_data_ls_from_update;
    wire [ADDR_WIDTH_VARS_STATES-1:0]        ram_addr_ls_from_update;

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
        .clk           (clk),
        .rst           (rst),
        //update control
        .start_update  (start_update),
        .cur_bin_num_i (cur_bin_num_o),
        .apply_update_o(apply_update),
        .done_update   (done_update),
        //update from sat engine
        .rd_carray_o   (rd_carray_o),
        .clause_i      (clause_i),
        .var_state_i   (vars_states_i),
        .lvl_states_i  (lvl_states_i),
        .base_lvl_i    (base_lvl_o),
        //clauses bins
        .ram_we_c_o    (ram_we_c_from_update),
        .ram_data_c_o  (ram_data_c_from_update),
        .ram_addr_c_o  (ram_addr_c_from_update),
        //vars bins
        .ram_data_v_i  (ram_douta_v),
        .ram_addr_v_o  (ram_addr_v_from_update),
        //vars states
        .ram_we_vs_o   (ram_we_vs_from_update),
        .ram_data_vs_o (ram_data_vs_from_update),
        .ram_addr_vs_o (ram_addr_vs_from_update),
        //lvls states
        .ram_we_ls_o   (ram_we_ls_from_update),
        .ram_data_ls_o (ram_data_ls_from_update),
        .ram_addr_ls_o (ram_addr_ls_from_update)
    );


    /*** bram 变量 **/
    //bram端口复用
    reg [ADDR_WIDTH_VARS-1:0]           ram_addra_v_r;
    reg                                 ram_web_v_r;
    reg [ADDR_WIDTH_CLAUSES-1:0]        ram_addrb_v_r;
    reg [WIDTH_CLAUSES-1:0]             ram_dinb_v_r;
    always @(posedge clk)
    begin
        if(~rst)
            ram_addra_v_r <= 0;
        else if(apply_load)     //加载
            ram_addra_v_r <= ram_addr_v_from_load;
        else
            ram_addra_v_r <= 0;
    end

    always @(posedge clk)
    begin
        if(~rst) begin
            ram_web_v_r <= 0;
            ram_dinb_v_r <= 0;
            ram_addrb_v_r <= 0;
        end
        else if(apply_ex_i) begin   //外部输入
            ram_web_v_r <= ram_we_v_ex_i;
            ram_dinb_v_r <= ram_din_v_ex_i;
            ram_addrb_v_r <= ram_addr_v_ex_i;
        end
        else begin
            ram_web_v_r <= 0;
            ram_dinb_v_r <= 0;
            ram_addrb_v_r <= 0;
        end
    end

    bram_w30_d1024 bram_vars_bins_inst(
        .clka(clk),
        .wea(),
        .addra(ram_addra_v_r),
        .dina(),
        .douta(ram_douta_v),
        .clkb(clk),
        .web(),
        .addrb(),
        .dinb(),
        .dout()
    );

    /*** bram 子句 **/
    //bram端口复用
    reg [ADDR_WIDTH_CLAUSES-1:0]        ram_addra_c_r;
    reg                                 ram_web_c_r;
    reg [ADDR_WIDTH_CLAUSES-1:0]        ram_addrb_c_r;
    reg [WIDTH_CLAUSES-1:0]             ram_dinb_c_r;

    always @(posedge clk)
    begin
        if(~rst)
            ram_addra_c_r <= 0;
        else if(apply_load)     //加载
            ram_addra_c_r <= ram_addr_c_from_load;
        else
            ram_addra_c_r <= 0;
    end

    always @(posedge clk)
    begin
        if(~rst) begin
            ram_web_c_r <= 0;
            ram_dinb_c_r <= 0;
            ram_addrb_c_r <= 0;
        end
        else if(apply_update) begin     //更新
            ram_web_c_r <= 1;
            ram_dinb_c_r <= ram_data_c_from_update;
            ram_addrb_c_r <= ram_addr_c_from_update;
        end
        else if(apply_ex_i) begin   //外部输入
            ram_web_c_r <= ram_we_c_ex_i;
            ram_dinb_c_r <= ram_din_c_ex_i;
            ram_addrb_c_r <= ram_addr_c_ex_i;
        end
        else begin
            ram_web_c_r <= 0;
            ram_dinb_c_r <= 0;
            ram_addrb_c_r <= 0;
        end
    end

    bram_w30_d1024 bram_clauses_bins_inst(
        .clka(clk),
        .wea(),
        .addra(ram_addra_c_r),
        .dina(),
        .douta(ram_douta_c),
        .clkb(clk),
        .web(ram_web_c_r),
        .addrb(ram_addrb_c_r),
        .dinb(ram_dinb_c_r),
        .dout()
    );

    /*** bram 变量状态 **/
    //bram端口复用
    reg [ADDR_WIDTH_VARS_STATES-1:0]    ram_addra_vs_r;
    reg                                 ram_web_vs_r;
    reg [WIDTH_VAR_STATES-1:0]          ram_dinb_vs_r;
    reg [ADDR_WIDTH_VARS_STATES-1:0]    ram_addrb_vs_r;

    always @(posedge clk)
    begin
        if(~rst)
            ram_addra_vs_r <= 0;
        else if(apply_load)     //加载
            ram_addra_vs_r <= ram_addr_vs_from_load;
        else
            ram_addra_vs_r <= 0;
    end

    always @(posedge clk)
    begin
        if(~rst) begin
            ram_web_vs_r <= 0;
            ram_dinb_vs_r <= 0;
            ram_addrb_vs_r <= 0;
        end
        else if(apply_update) begin     //更新
            ram_web_vs_r <= 1;
            ram_dinb_vs_r <= ram_data_vs_from_update;
            ram_addrb_vs_r <= ram_addr_vs_from_update;
        end
        else if(apply_ex_i) begin   //外部输入
            ram_web_vs_r <= ram_we_vs_ex_i;
            ram_dinb_vs_r <= ram_din_vs_ex_i;
            ram_addrb_vs_r <= ram_addr_vs_ex_i;
        end
        else begin
            ram_web_vs_r <= 0;
            ram_dinb_vs_r <= 0;
            ram_addrb_vs_r <= 0;
        end
    end

    bram_w30_d1024 bram_global_var_state_inst(
        .clka(clk),
        .wea(),
        .addra(ram_addra_vs_r),
        .dina(),
        .douta(ram_douta_vs),
        .clkb(clk),
        .web(ram_web_vs_r),
        .addrb(ram_addrb_vs_r),
        .dinb(ram_dinb_vs_r),
        .dout()
    );


    /*** bram 层级状态 **/
    //bram端口复用
    reg [ADDR_WIDTH_LVLS_STATES-1:0]    ram_addra_ls_r;
    reg                                 ram_web_ls_r;
    reg [WIDTH_LVL_STATES-1:0]          ram_dinb_ls_r;
    reg [ADDR_WIDTH_LVLS_STATES-1:0]    ram_addrb_ls_r;

    always @(posedge clk)
    begin
        if(~rst)
            ram_addra_ls_r <= 0;
        else if(apply_load)     //加载
            ram_addra_ls_r <= ram_addr_ls_from_load;
        else
            ram_addra_ls_r <= 0;
    end

    always @(posedge clk)
    begin
        if(~rst) begin
            ram_web_ls_r <= 0;
            ram_dinb_ls_r <= 0;
            ram_addrb_ls_r <= 0;
        end
        else if(apply_update) begin     //更新
            ram_web_ls_r <= 1;
            ram_dinb_ls_r <= ram_data_ls_from_update;
            ram_addrb_ls_r <= ram_addr_ls_from_update;
        end
        else if(apply_ex_i) begin   //外部输入
            ram_web_ls_r <= ram_we_ls_ex_i;
            ram_dinb_ls_r <= ram_din_ls_ex_i;
            ram_addrb_ls_r <= ram_addr_ls_ex_i;
        end
        else begin
            ram_web_ls_r <= 0;
            ram_dinb_ls_r <= 0;
            ram_addrb_ls_r <= 0;
        end
    end

    bram_w30_d1024 bram_global_lvl_state_inst(
        .clka(clk),
        .wea(),
        .addra(ram_addra_ls_r),
        .dina(),
        .douta(ram_douta_vs),
        .clkb(clk),
        .web(ram_web_ls_r),
        .addrb(ram_addrb_ls_r),
        .dinb(ram_dinb_ls_r),
        .dout()
    );

endmodule
