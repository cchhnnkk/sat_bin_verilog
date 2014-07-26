`timescale 1ns/1ps

module test_bin_manager(input clk, input rst);

    /* --- 测试free_lit_count --- */
    task run();
        begin
            @(posedge clk);
                test_bin_manager_task();
        end
    endtask

    parameter NUM_CLAUSES_A_BIN      = 8;
    parameter NUM_VARS_A_BIN         = 8;
    parameter NUM_LVLS_A_BIN         = 8;
    parameter WIDTH_BIN_ID           = 10;
    parameter WIDTH_CLAUSES          = NUM_VARS_A_BIN*2;
    parameter WIDTH_VAR             = 12;
    parameter WIDTH_LVL              = 16;
    parameter WIDTH_VAR_STATES       = 19;
    parameter WIDTH_LVL_STATES       = 11;
    parameter ADDR_WIDTH_CLAUSES     = 9;
    parameter ADDR_WIDTH_VAR        = 9;
    parameter ADDR_WIDTH_VARS_STATES = 9;
    parameter ADDR_WIDTH_LVLS_STATES = 9;

    reg                                        start_bm_i;
    wire                                       done_bm_o;
    wire                                       global_sat_o;
    wire                                       global_unsat_o;
    reg                                        bin_info_en;
    reg  [WIDTH_VAR-1:0]                      nv_all_i;
    reg  [WIDTH_CLAUSES-1:0]                   nc_all_i;
    //sat engine core
    wire                                       start_core_o;
    reg                                        done_core_i;
    wire [WIDTH_BIN_ID-1:0]                    cur_bin_num_o;
    wire [WIDTH_LVL-1:0]                       cur_lvl_o;
    reg                                        local_sat_i;
    reg                                        local_unsat_i;
    reg  [WIDTH_LVL-1:0]                       cur_lvl_from_core_i;
    reg  [WIDTH_BIN_ID-1:0]                    bkt_bin_from_core_i;
    reg  [WIDTH_LVL-1:0]                       bkt_lvl_from_core_i;
    //load update
    wire [NUM_CLAUSES_A_BIN-1:0]               wr_carray_o;
    wire [NUM_CLAUSES_A_BIN-1:0]               rd_carray_o;
    wire [NUM_VARS_A_BIN*2-1 : 0]              clause_o;
    reg  [NUM_VARS_A_BIN*2-1 : 0]              clause_i;
    wire [NUM_VARS_A_BIN-1:0]                  wr_var_states_o;
    wire [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0] vars_states_o;
    reg  [WIDTH_VAR_STATES*NUM_VARS_A_BIN-1:0] vars_states_i;
    wire [NUM_LVLS_A_BIN-1:0]                  wr_lvl_states_o;
    wire [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0] lvl_states_o;
    reg  [WIDTH_LVL_STATES*NUM_LVLS_A_BIN-1:0] lvl_states_i;
    wire                                       base_lvl_en;
    wire [WIDTH_LVL-1:0]                       base_lvl_o;
    //export
    reg                                        apply_ex_i;
    reg                                        ram_we_v_ex_i;
    reg  [WIDTH_VAR-1 : 0]                     ram_din_v_ex_i;
    reg  [ADDR_WIDTH_VAR-1:0]                  ram_addr_v_ex_i;
    reg                                        ram_we_c_ex_i;
    reg  [WIDTH_CLAUSES-1 : 0]                 ram_din_c_ex_i;
    reg  [ADDR_WIDTH_CLAUSES-1:0]              ram_addr_c_ex_i;
    reg                                        ram_we_vs_ex_i;
    reg  [WIDTH_VAR_STATES-1 : 0]              ram_din_vs_ex_i;
    reg  [ADDR_WIDTH_VARS_STATES-1:0]          ram_addr_vs_ex_i;
    reg                                        ram_we_ls_ex_i;
    reg  [WIDTH_LVL_STATES-1 : 0]              ram_din_ls_ex_i;
    reg  [ADDR_WIDTH_LVLS_STATES-1:0]          ram_addr_ls_ex_i;

    bin_manager #(
            .NUM_CLAUSES_A_BIN     (NUM_CLAUSES_A_BIN),
            .NUM_VARS_A_BIN        (NUM_VARS_A_BIN),
            .NUM_LVLS_A_BIN        (NUM_LVLS_A_BIN),
            .WIDTH_BIN_ID          (WIDTH_BIN_ID),
            .WIDTH_CLAUSES         (WIDTH_CLAUSES),
            .WIDTH_VAR            (WIDTH_VAR),
            .WIDTH_LVL             (WIDTH_LVL),
            .WIDTH_VAR_STATES      (WIDTH_VAR_STATES),
            .WIDTH_LVL_STATES      (WIDTH_LVL_STATES),
            .ADDR_WIDTH_CLAUSES    (ADDR_WIDTH_CLAUSES),
            .ADDR_WIDTH_VAR       (ADDR_WIDTH_VAR),
            .ADDR_WIDTH_VARS_STATES(ADDR_WIDTH_VARS_STATES),
            .ADDR_WIDTH_LVLS_STATES(ADDR_WIDTH_LVLS_STATES)
    )
    bin_manager(
            .clk                (clk),
            .rst                (rst),
            .start_bm_i         (start_bm_i),
            .done_bm_o          (done_bm_o),
            //结果
            .global_sat_o       (global_sat_o),
            .global_unsat_o     (global_unsat_o),
            //rd bin info
            .bin_info_en        (bin_info_en),
            .nv_all_i           (nv_all_i),
            .nc_all_i           (nc_all_i),
            //sat engine core
            .start_core_o       (start_core_o),
            .done_core_i        (done_core_i),
            .cur_bin_num_o      (cur_bin_num_o),
            .cur_lvl_o          (cur_lvl_o),
            .local_sat_i        (local_sat_i),
            .local_unsat_i      (local_unsat_i),
            .cur_lvl_from_core_i(cur_lvl_from_core_i),
            .bkt_bin_from_core_i(bkt_bin_from_core_i),
            .bkt_lvl_from_core_i(bkt_lvl_from_core_i),
            //load update clause with sat engine
            .wr_carray_o        (wr_carray_o),
            .rd_carray_o        (rd_carray_o),
            .clause_o           (clause_o),
            .clause_i           (clause_i),
            //load update var states with sat engine
            .wr_var_states_o    (wr_var_states_o),
            .vars_states_o      (vars_states_o),
            .vars_states_i      (vars_states_i),
            //load update lvl states with sat engine
            .wr_lvl_states_o    (wr_lvl_states_o),
            .lvl_states_o       (lvl_states_o),
            .lvl_states_i       (lvl_states_i),
            .base_lvl_en        (base_lvl_en),
            .base_lvl_o         (base_lvl_o),
            //外部输入端口
            .apply_ex_i         (apply_ex_i),
            //vars bins
            .ram_we_v_ex_i      (ram_we_v_ex_i),
            .ram_din_v_ex_i     (ram_din_v_ex_i),
            .ram_addr_v_ex_i    (ram_addr_v_ex_i),
            //clauses bins
            .ram_we_c_ex_i      (ram_we_c_ex_i),
            .ram_din_c_ex_i     (ram_din_c_ex_i),
            .ram_addr_c_ex_i    (ram_addr_c_ex_i),
            //vars states
            .ram_we_vs_ex_i     (ram_we_vs_ex_i),
            .ram_din_vs_ex_i    (ram_din_vs_ex_i),
            .ram_addr_vs_ex_i   (ram_addr_vs_ex_i),
            //lvls states
            .ram_we_ls_ex_i     (ram_we_ls_ex_i),
            .ram_din_ls_ex_i    (ram_din_ls_ex_i),
            .ram_addr_ls_ex_i   (ram_addr_ls_ex_i)
    );

    //load
    int nb;
    int cmax;
    int vmax;
    int cbin[][];
    int vbin[];

    //update
    int bin_updated[][]; 
    //var state list:
    int value_updated[];
    int implied_updated[];
    int level_updated[];
    //lvl state list:
    int dcd_bin_updated[];
    int has_bkt_updated[];
    //ctrl
    int cur_bin_num_updated;
    int cur_lvl_updated;
    int base_lvl_updated;

    /*** load ***/
    `include "../tb/class_clause_array.sv";
    `include "../tb/class_vs_list.sv";
    `include "../tb/class_ls_list.sv";
    `include "../tb/bm_load_test_case1.sv"
    `include "../tb/bm_update_test_case1.sv"

    class_clause_data #(8) cdata = new();

    task wr_clauses();
        begin
            for (int i = 0; i < nb*cmax; ++i)
            begin
                @ (posedge clk);
                    cdata.set_lits(cbin[i]);
                    //cdata.display_lits();
                    ram_we_c_ex_i = 1;
                    cdata.get_clause(ram_din_c_ex_i);
                    ram_addr_c_ex_i = i;
            end
            @ (posedge clk);
                ram_we_c_ex_i = 0;
            @ (posedge clk);
        end
    endtask

    task wr_vars();
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

    /*** update ***/
    class_clause_data #(8) cdata_update = new();

    reg [NUM_CLAUSES_A_BIN-1:0]               rd_carray;
    initial begin
        automatic int cindex;
        forever @(posedge clk) begin
            if(rd_carray_o!=0) begin
                cindex = 0;
                rd_carray = rd_carray_o;
                while(rd_carray[0]==0) begin
                    rd_carray = rd_carray>>1;
                    cindex++;
                end
                cdata_update.set_lits(bin_updated[cindex]);
                cdata_update.get_clause(clause_i);
            end
        end
    end
    
    class_vs_list #(8, WIDTH_LVL) vs_list = new();
    
    class_ls_list #(8, WIDTH_BIN_ID) ls_list = new();

    task update_bin();
        local_sat_i = 1;
        cur_lvl_from_core_i = cur_lvl_updated;
        bkt_bin_from_core_i = cur_bin_num_updated;
        bkt_lvl_from_core_i = cur_lvl_updated;
        //var state
        vs_list.set_separate(value_updated, implied_updated, level_updated);
        vs_list.get(vars_states_i);
        //lvl state
        ls_list.set_separate(dcd_bin_updated, has_bkt_updated);
        ls_list.get(lvl_states_i);

    endtask

    task reset_all_signal();
        begin
            apply_ex_i          = 0;
            bin_info_en         = 0;
            bkt_bin_from_core_i = 0;
            bkt_lvl_from_core_i = 0;
            clause_i            = 0;
            cur_lvl_from_core_i = 0;
            done_core_i         = 0;
            local_sat_i         = 0;
            local_unsat_i       = 0;
            lvl_states_i        = 0;
            nc_all_i            = 0;
            nv_all_i            = 0;
            ram_addr_c_ex_i     = 0;
            ram_addr_ls_ex_i    = 0;
            ram_addr_v_ex_i     = 0;
            ram_addr_vs_ex_i    = 0;
            ram_din_c_ex_i      = 0;
            ram_din_ls_ex_i     = 0;
            ram_din_v_ex_i      = 0;
            ram_din_vs_ex_i     = 0;
            ram_we_c_ex_i       = 0;
            ram_we_ls_ex_i      = 0;
            ram_we_v_ex_i       = 0;
            ram_we_vs_ex_i      = 0;
            start_bm_i          = 0;
            vars_states_i       = 0;
        end
    endtask

    /*** 测试用例集 ***/

    task test_bin_manager_task();
        $display("test_sat_engine_task");
        reset_all_signal();
        bm_load_test_case1();
    endtask

    task run_bm_load();
        wr_clauses();
        wr_vars();
        start_bm_i = 1;
        @(posedge clk);
        start_bm_i = 0;
    endtask

    task run_bm_update();
        update_bin();
    endtask

endmodule


module test_bin_manager_top;
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

    test_bin_manager test_bin_manager(
        .clk(clk),
        .rst(rst)
    );

    initial begin
        reset();
        $display("start sim");
        test_bin_manager.run();
        $display("done sim");
        $finish();
    end
endmodule
