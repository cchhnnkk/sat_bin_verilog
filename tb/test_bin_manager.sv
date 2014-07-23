`timescale 1ns/1ps

module test_bin_manager(input clk, input rst);

    /* --- 测试free_lit_count --- */
    task run();
        begin
            @(posedge clk);
                test_bin_manager_task();
        end
    endtask

    parameter NUM_CLAUSES      = 8;
    parameter NUM_VARS         = 8;
    parameter NUM_LVLS         = 8;
    parameter WIDTH_BIN_ID     = 15;
    parameter WIDTH_C_LEN      = 4;
    parameter WIDTH_LVL        = 16;
    parameter WIDTH_LVL_STATES = 16;
    parameter WIDTH_VAR_STATES = 19;

    reg                                        start_bm_i;
    wire                                       done_bm_o;
    wire                                       global_sat_o;
    wire                                       global_unsat_o;
    reg                                        bin_info_en;
    reg [WIDTH_VARS-1:0]                       nv_all_i;
    reg [WIDTH_CLAUSES-1:0]                    nc_all_i;
    wire                                       start_core_o;
    reg                                        done_core_i;
    wire [WIDTH_BIN_ID-1:0]                    cur_bin_num_o;
    wire [WIDTH_LVL-1:0]                       cur_lvl_o;
    reg                                        local_sat_i;
    reg                                        local_unsat_i;
    reg [WIDTH_LVL-1:0]                        cur_lvl_from_core_i;
    reg [WIDTH_BIN_ID-1:0]                     bkt_bin_from_core_i;
    reg [WIDTH_LVL-1:0]                        bkt_lvl_from_core_i;
    wire [NUM_CLAUSES_A_BIN-1:0]               wr_carray_o;
    wire [NUM_CLAUSES_A_BIN-1:0]               rd_carray_o;
    wire [NUM_VARS_A_BIN*2-1 : 0]              clause_o;
    reg [NUM_VARS_A_BIN*2-1 : 0]               clause_i;
    wire [NUM_VARS_A_BIN-1:0]                  wr_var_states_o;
    wire [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0] vars_states_o;
    reg [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0]  vars_states_i;
    wire [NUM_LVLS-1:0]                        wr_lvl_states_o;
    wire [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0] lvl_states_o;
    reg [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0]  lvl_states_i;
    wire                                       base_lvl_en;
    wire [WIDTH_LVL-1:0]                       base_lvl_o;
    reg                                        apply_ex_i;
    reg                                        ram_we_v_ex_i;
    reg [WIDTH_VARS-1 : 0]                     ram_din_v_ex_i;
    reg [ADDR_WIDTH_VARS-1:0]                  ram_addr_v_ex_i;
    reg                                        ram_we_c_ex_i;
    reg [WIDTH_CLAUSES-1 : 0]                  ram_din_c_ex_i;
    reg [ADDR_WIDTH_CLAUSES-1:0]               ram_addr_c_ex_i;
    reg                                        ram_we_vs_ex_i;
    reg [WIDTH_VAR_STATES-1 : 0]               ram_din_vs_ex_i;
    reg [ADDR_WIDTH_VARS_STATES-1:0]           ram_addr_vs_ex_i;
    reg                                        ram_we_ls_ex_i;
    reg [WIDTH_LVL_STATES-1 : 0]               ram_din_ls_ex_i;
    reg [ADDR_WIDTH_LVLS_STATES-1:0]           ram_addr_ls_ex_i;

    bin_manager #(
        .NUM_CLAUSES_A_BIN     (NUM_CLAUSES_A_BIN),
        .NUM_VARS_A_BIN        (NUM_VARS_A_BIN),
        .NUM_LVLS_A_BIN        (NUM_LVLS_A_BIN),
        .WIDTH_BIN_ID          (WIDTH_BIN_ID),
        .WIDTH_CLAUSES         (WIDTH_CLAUSES),
        .WIDTH_VARS            (WIDTH_VARS),
        .WIDTH_LVL             (WIDTH_LVL),
        .WIDTH_VAR_STATES      (WIDTH_VAR_STATES),
        .WIDTH_LVL_STATES      (WIDTH_LVL_STATES),
        .ADDR_WIDTH_CLAUSES    (ADDR_WIDTH_CLAUSES),
        .ADDR_WIDTH_VARS       (ADDR_WIDTH_VARS),
        .ADDR_WIDTH_VARS_STATES(ADDR_WIDTH_VARS_STATES),
        .ADDR_WIDTH_LVLS_STATES(ADDR_WIDTH_LVLS_STATES)
    )
    bin_manager(
        .clk                (clk),
        .rst                (rst),
        .start_bm_i         (start_bm_i),
        .done_bm_o          (done_bm_o)
        //结果,
        .global_sat_o       (global_sat_o),
        .global_unsat_o     (global_unsat_o)
        //rd bin info,
        .bin_info_en        (bin_info_en),
        .nv_all_i           (nv_all_i),
        .nc_all_i           (nc_all_i)
        //sat engine core,
        .start_core_o       (start_core_o),
        .done_core_i        (done_core_i),
        .cur_bin_num_o      (cur_bin_num_o),
        .cur_lvl_o          (cur_lvl_o),
        .local_sat_i        (local_sat_i),
        .local_unsat_i      (local_unsat_i),
        .cur_lvl_from_core_i(cur_lvl_from_core_i),
        .bkt_bin_from_core_i(bkt_bin_from_core_i),
        .bkt_lvl_from_core_i(bkt_lvl_from_core_i)
        //load update clause to sat engine,
        .wr_carray_o        (wr_carray_o),
        .rd_carray_o        (rd_carray_o),
        .clause_o           (clause_o),
        .clause_i           (clause_i)
        //load update var states  to sat engine,
        .wr_var_states_o    (wr_var_states_o),
        .vars_states_o      (vars_states_o),
        .vars_states_i      (vars_states_i)
        //load update lvl states to sat engine,
        .wr_lvl_states_o    (wr_lvl_states_o),
        .lvl_states_o       (lvl_states_o),
        .lvl_states_i       (lvl_states_i),
        .base_lvl_en        (base_lvl_en),
        .base_lvl_o         (base_lvl_o)
        //外部输入端口,
        .apply_ex_i         (apply_ex_i)
        //vars bins,
        .ram_we_v_ex_i      (ram_we_v_ex_i),
        .ram_din_v_ex_i     (ram_din_v_ex_i),
        .ram_addr_v_ex_o    (ram_addr_v_ex_o)
        //clauses bins,
        .ram_we_c_ex_i      (ram_we_c_ex_i),
        .ram_din_c_ex_i     (ram_din_c_ex_i),
        .ram_addr_c_ex_i    (ram_addr_c_ex_i)
        //vars states,
        .ram_we_vs_ex_i     (ram_we_vs_ex_i),
        .ram_din_vs_ex_i    (ram_din_vs_ex_i),
        .ram_addr_vs_ex_i   (ram_addr_vs_ex_i)
        //lvls states,
        .ram_we_ls_ex_i     (ram_we_ls_ex_i),
        .ram_din_ls_ex_i    (ram_din_ls_ex_i),
        .ram_addr_ls_ex_i   (ram_addr_ls_ex_i)
    );

    /*** 读写与加载 ***/

    `include "../tb/class_clause_data.sv";
    class_clause_data #(8) cdata = new();

    task wr_clauses(input int cbin[][], nb, cmax);
        begin
            for (int i = 0; i < nb*cmax; ++i)
            begin
                @ (posedge clk);
                    cdata.set_lits(cbin[i]);
                    cdata.display_lits();
                    ram_we_c_ex_i = 1;
                    cdata.get_clause(ram_din_c_ex_i);
                    ram_addr_c_ex_i = i;
            end
            @ (posedge clk);
                ram_we_c_ex_i = 0;
            @ (posedge clk);
        end
    endtask

    task wr_vars(input int vbin[], nb, cmax);
        begin
            for (int i = 0; i < nb*cmax; ++i)
            begin
                @ (posedge clk);
                    ram_we_v_ex_i = 1;
                    ram_din_v_ex_i = vbin[i];
                    ram_addr_v_ex_i = i;
            end
            @ (posedge clk);
                ram_we_v_ex_i = 0;
            @ (posedge clk);
        end
    endtask

    task reset_all_signal();
        begin
            apply_ex_i          = 0;
            bin_info_en         = 0;
            done_core_i         = 0;
            local_sat_i         = 0;
            local_unsat_i       = 0;
            ram_we_c_ex_i       = 0;
            ram_we_ls_ex_i      = 0;
            ram_we_v_ex_i       = 0;
            ram_we_vs_ex_i      = 0;
            start_bm_i          = 0;
            ram_addr_c_ex_i     = 0;
            ram_addr_ls_ex_i    = 0;
            ram_addr_v_ex_i     = 0;
            ram_addr_vs_ex_i    = 0;
            clause_i            = 0;
            bkt_bin_from_core_i = 0;
            ram_din_c_ex_i      = 0;
            nc_all_i            = 0;
            bkt_lvl_from_core_i = 0;
            cur_lvl_from_core_i = 0;
            lvl_states_i        = 0;
            ram_din_ls_ex_i     = 0;
            ram_din_v_ex_i      = 0;
            nv_all_i            = 0;
            vars_states_i       = 0;
            ram_din_vs_ex_i     = 0;
        end
    endtask

    /*** 测试用例集 ***/

    `include "../tb/test_bm_case1.sv"

    task test_sat_engine_task();
        begin
            $display("test_sat_engine_task");
            reset_all_signal();
            test_se_case1();
            test_se_case2();
            test_se_case3();
            test_se_case4();
            test_se_case5();
        end
    endtask

    sat_engine #(
        .NUM_CLAUSES     (NUM_CLAUSES),
        .NUM_VARS        (NUM_VARS),
        .WIDTH_BIN_ID    (WIDTH_BIN_ID),
        .WIDTH_C_LEN     (WIDTH_C_LEN),
        .WIDTH_LVL       (WIDTH_LVL),
        .WIDTH_LVL_STATES(WIDTH_LVL_STATES),
        .WIDTH_VAR_STATES(WIDTH_VAR_STATES)
    )
    sat_engine(
        .clk          (clk),
        .rst          (rst),
        .start_core_i (start_core_i),
        .done_core_o  (done_core_o),
        .cur_bin_num_i(cur_bin_num_i),
        .sat_o        (sat_o),
        .cur_lvl_o    (cur_lvl_o),
        .unsat_o      (unsat_o),
        .bkt_lvl_o    (bkt_lvl_o),
        .load_lvl_i   (load_lvl_i),
        .rd_carray_i  (rd_carray_i),
        .clause_o     (clause_o),
        .wr_carray_i  (wr_carray_i),
        .clause_i     (clause_i),
        .wr_var_states(wr_var_states),
        .vars_states_i(vars_states_i),
        .vars_states_o(vars_states_o),
        .wr_lvl_states(wr_lvl_states),
        .lvl_states_i (lvl_states_i),
        .lvl_states_o (lvl_states_o),
        .base_lvl_en  (base_lvl_en),
        .base_lvl_i   (base_lvl_i)
    );
endmodule


module test_sat_engine_top;
    reg  clk;
    reg  rst;

    always #5 clk<=~clk;

    initial begin: init
        clk = 0;
        rst=0;
    end

    // initial begin
    //  $fsdbDumpfile("wave_test_sat_engine.fsdb");
    //  $fsdbDumpvars;
    // end

    task reset();
        begin
            @(posedge clk);
                rst=0;
                clk=0;

            @(posedge clk);
                rst=1;
        end
    endtask

    test_sat_engine test_sat_engine(
        .clk(clk),
        .rst(rst)
    );

    initial begin
        reset();
        $display("start sim");
        test_sat_engine.run();
        $display("done sim");
        $finish();
    end
endmodule
