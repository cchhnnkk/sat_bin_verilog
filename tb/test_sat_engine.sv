`timescale 1ns/1ps

module test_sat_engine(input clk, input rst);

    /* --- 测试free_lit_count --- */
    task run();
        begin
            @(posedge clk);
                test_sat_engine_task();
        end
    endtask

    parameter NUM_CLAUSES      = 8;
    parameter NUM_VARS         = 8;
    parameter NUM_LVLS         = 8;
    parameter WIDTH_BIN_ID     = 10;
    parameter WIDTH_C_LEN      = 4;
    parameter WIDTH_LVL        = 16;
    parameter WIDTH_LVL_STATES = 11;
    parameter WIDTH_VAR_STATES = 19;

    reg                                     start_core_i;
    wire                                    done_core_o;
    reg [WIDTH_LVL-1:0]                     cur_bin_num_i;
    wire                                    sat_o;
    wire [WIDTH_LVL-1:0]                    cur_lvl_o;
    wire                                    unsat_o;
    wire [WIDTH_LVL-1:0]                    bkt_lvl_o;
    reg [WIDTH_LVL-1:0]                     load_lvl_i;
    reg [NUM_CLAUSES-1:0]                   rd_carray_i;
    wire [NUM_VARS*2-1 : 0]                 clause_o;
    reg [NUM_CLAUSES-1:0]                   wr_carray_i;
    reg [NUM_VARS*2-1 : 0]                  clause_i;
    reg [NUM_VARS-1:0]                      wr_var_states;
    reg [WIDTH_VAR_STATES*NUM_VARS-1 : 0]   vars_states_i;
    wire [WIDTH_VAR_STATES*NUM_VARS-1 : 0]  vars_states_o;
    reg [NUM_LVLS-1:0]                      wr_lvl_states;
    reg [WIDTH_LVL_STATES*NUM_LVLS -1 : 0]  lvl_states_i;
    wire [WIDTH_LVL_STATES*NUM_LVLS -1 : 0] lvl_states_o;
    reg                                     base_lvl_en;
    reg [WIDTH_LVL-1:0]                     base_lvl_i;


    `include "../tb/class_clause_array.sv";
    class_clause_array #(8, 8) carray_data = new();

    task wr_clause_array(input int bin_data[8][8]);
        begin
            carray_data.reset();
            carray_data.set_array(bin_data);

            for (int i = 0; i < 8; ++i)
            begin
                @ (posedge clk);
                    wr_carray_i = 0;
                    wr_carray_i[i] = 1;
                    carray_data.get_clause(i, clause_i);
                    //$display("kkkk sim time %4tps", $time);
                    //carray_data.cdatas[i].display();
            end
            @ (posedge clk);
                wr_carray_i = 0;
            @ (posedge clk);
        end
    endtask

    task rd_clause_array();
        begin
            rd_carray_i = 0;
            for (int i = 0; i < 8; ++i)
            begin
                @ (posedge clk);
                    rd_carray_i = 0;
                    rd_carray_i[i] = 1;
            end
            @ (posedge clk);
            rd_carray_i = 0;
            @ (posedge clk);
        end
    endtask

    `include "../tb/class_vs_list.sv";
    class_vs_list #(8, WIDTH_LVL) vs_list = new();

    task wr_vs_list(input int value[8], implied[8], level[8]);
        begin
            vs_list.reset();
            vs_list.set_separate(value, implied, level);
            wr_var_states = 8'hff;
            vs_list.get(vars_states_i);
            @ (posedge clk);
                wr_var_states = 8'h0;
            @ (posedge clk);
        end
    endtask

    `include "../tb/class_ls_list.sv";
    class_ls_list #(8, WIDTH_LVL) ls_list = new();

    task wr_ls_list(input int dcd_bin[8], has_bkt[8]);
        begin
            ls_list.reset();
            ls_list.set_separate(dcd_bin, has_bkt);
            wr_lvl_states = 8'hff;
            ls_list.get(lvl_states_i);
            @ (posedge clk);
                wr_lvl_states = 8'h0;
            @ (posedge clk);
        end
    endtask

    task reset_all_signal();
        begin
            lvl_states_i  = 0;
            start_core_i  = 0;
            cur_bin_num_i = 0;
            load_lvl_i    = 0;
            rd_carray_i   = 0;
            wr_carray_i   = 0;
            clause_i      = 0;
            wr_var_states = 0;
            vars_states_i = 0;
            wr_lvl_states = 0;
            lvl_states_i  = 0;
            base_lvl_en   = 0;
            base_lvl_i    = 0;
        end
    endtask

    typedef struct {
        string name;
        int var_id;
        int value;
        int level;
    } struct_process;


    task load_core(input int bin_data[8][8], value[8], implied[8], level[8], dcd_bin[8], has_bkt[8],
                             cur_bin_num, load_lvl, base_lvl);
        begin
            reset_all_signal();

            //load bin
            wr_clause_array(bin_data);
            wr_vs_list(value, implied, level);
            wr_ls_list(dcd_bin, has_bkt);

            start_core_i = 0;
            base_lvl_en = 1;

            //start
            @ (posedge clk);
                start_core_i = 1;
                cur_bin_num_i = cur_bin_num;
                load_lvl_i = load_lvl;
                base_lvl_en = 1;
                base_lvl_i = base_lvl;
            @ (posedge clk);
                start_core_i = 0;
                base_lvl_en = 0;
            @ (posedge clk);
        end
    endtask

    task update_core();
        rd_clause_array();
    endtask

    task dis_process(struct_process process_data[], int i);
        $display("%1tns process_data: name=%s", $time/1000.0, process_data[i].name);

        if(process_data[i].name=="decision" || process_data[i].name=="bcp")
            $display("\tvar_id=%1d, value=%1d, level=%1d",
                process_data[i].var_id,
                process_data[i].value,
                process_data[i].level);
        // $finish();
    endtask

    //解析处理步骤
    task test_core(input struct_process process_data[], input int process_len);
        begin
            int valid_from_decision_1;
            int valid_from_decision_2;
            int i;
            bit error_tag;
            error_tag = 0;
            i = 0;
            while(i<process_len)
            begin
                if(sat_engine.state_list.done_decision_o && sat_engine.state_list.valid_from_decision)
                begin
                    dis_process(process_data, i);
                    assert(process_data[i].name=="decision")
                    else begin
                        $display("!----- Error: decision");
                        error_tag = 1;
                    end

                    valid_from_decision_1 = sat_engine.state_list.valid_from_decision;
                    valid_from_decision_2 = 1<<process_data[i].var_id;
                    assert(valid_from_decision_1 == valid_from_decision_2)
                    else
                        dis_process(process_data, i);
                    i++;
                end

                if(sat_engine.state_list.debug_imply_valid)
                begin
                    assert(process_data[i].name=="bcp")
                    else begin
                        $display("!----- Error: bcp");
                        dis_process(process_data, i);
                        error_tag = 1;
                    end
                    vs_list.set(sat_engine.state_list.debug_var_state_o);

                    for (int j = 0; j < NUM_VARS; ++j)
                    begin
                        if(sat_engine.state_list.debug_imply_index[j]!=0) begin
                            dis_process(process_data, i);
                            assert(process_data[i].name  == "bcp")
                            else begin
                                $display("!----- Error: bcp");
                                error_tag = 1;
                            end

                            assert(process_data[i].value == vs_list.value[j])
                            else
                                $display("!----- Error: i=%1d, j=%1d, expect value=%1d, value=%1d",
                                    i, j, process_data[i].value, vs_list.value[j]);

                            assert(process_data[i].level == vs_list.level[j])
                            else
                                $display("!----- Error: i=%1d, j=%1d, expect level=%1d, level=%1d",
                                    i, j, process_data[i].level, vs_list.level[j]);

                            i++;
                        end
                    end
                end

                if(sat_engine.state_list.debug_conflict_valid)
                begin
                    dis_process(process_data, i);
                    assert(process_data[i].name=="conflict")
                    else begin
                        $display("!----- Error: conflict");
                        error_tag = 1;
                    end
                    i++;
                end

                if(done_core_o && sat_engine.all_c_is_sat)
                begin
                    dis_process(process_data, i);
                    assert(process_data[i].name=="psat")
                    else begin
                        $display("!----- Error: psat");
                        error_tag = 1;
                    end
                    i++;
                end

                if(done_core_o && ~sat_engine.all_c_is_sat)
                begin
                    dis_process(process_data, i);
                    assert(process_data[i].name=="punsat")
                    else begin
                        $display("!----- Error: punsat");
                        error_tag = 1;
                    end

                    i++;
                end

                @ (posedge clk);

                if(error_tag == 1) begin
                    repeat (10) @ (posedge clk);
                    $finish();
                end
            end

            while(done_core_o!=1)
                @ (posedge clk);

            repeat (10) @(posedge clk);
        end
    endtask


    /*** 测试数据1 ***/

    int bin1[8][8] = '{
        '{2, 0, 1, 0, 0, 0, 0, 0},
        '{0, 2, 0, 1, 0, 0, 0, 0},
        '{0, 0, 2, 0, 2, 0, 0, 0},
        '{0, 0, 0, 0, 0, 0, 0, 0},
        '{0, 0, 0, 0, 0, 0, 0, 0},
        '{0, 0, 0, 0, 0, 0, 0, 0},
        '{0, 0, 0, 0, 0, 0, 0, 0},
        '{0, 0, 0, 0, 0, 0, 0, 0}
    };
    //var state list:
    int value1[]   = '{0, 0, 0, 0, 0, 0, 0, 0};
    int implied1[] = '{0, 0, 0, 0, 0, 0, 0, 0};
    int level1[]   = '{0, 0, 0, 0, 0, 0, 0, 0};
    //lvl state list:
    int dcd_bin1[] = '{0, 0, 0, 0, 0, 0, 0, 0};
    int has_bkt1[] = '{0, 0, 0, 0, 0, 0, 0, 0};
    //ctrl
    int cur_bin_num1 = 1;
    int load_lvl1 = 1;
    int base_lvl1 = 1;

    //运算过程数据
    int process_len1 = 6;
    struct_process process_data1[] = '{
        '{"decision", 0, 1, 2},
        '{"bcp",      2, 1, 2},
        '{"bcp",      4, 2, 2},
        '{"decision", 1, 1, 3},
        '{"bcp",      3, 1, 3},
        '{"psat",     1, 1, 1}
    };

    /*** 测试数据2，冲突 ***/

    int bin2[8][8] = '{
        '{1, 0, 2, 0, 2, 0, 0, 0},
        '{0, 2, 0, 1, 1, 0, 0, 0},
        '{0, 2, 0, 0, 2, 0, 0, 0},
        '{0, 0, 0, 0, 0, 0, 0, 0},
        '{0, 0, 0, 0, 0, 0, 0, 0},
        '{0, 0, 0, 0, 0, 0, 0, 0},
        '{0, 0, 0, 0, 0, 0, 0, 0},
        '{0, 0, 0, 0, 0, 0, 0, 0}
    };
    //var state list:
    int value2[]   = '{1, 1, 1, 2, 0, 0, 0, 0};
    int implied2[] = '{1, 0, 1, 1, 0, 0, 0, 0};
    int level2[]   = '{0, 1, 2, 1, 0, 0, 0, 0};
    //lvl state list:
    int dcd_bin2[] = '{2, 0, 0, 0, 0, 0, 0, 0};
    int has_bkt2[] = '{0, 0, 0, 0, 0, 0, 0, 0};
    //ctrl
    int cur_bin_num2 = 2;
    int load_lvl2 = 3;
    int base_lvl2 = 2;

    //运算过程数据
    int process_len2 = 3;
    struct_process process_data2[] = '{
        '{"bcp",      4, 3, 1},
        '{"conflict", 1, 1, 1},
        '{"punsat",   1, 1, 1}
    };

    /*
    load_bin 3
        c1  -1 3 5
        c2  2 -4 -5
        c3  2 5
        local vars  [1, 2, 3, 4, 5]
        value       [1, 1, 1, 2, 0]
        implied     [1, 0, 1, 1, 0]
        level       [0, 1, 2, 1, 0]

    sat engine run_core: cur_bin == 3
    --  preprocess
    --  bcp
            c2 var 5 gvar 7 value 1 level 1
    --  analysis the conflict
            conflict c3
            lits    [2, 5]
            value   [1, 1]
            implied [0, 1]
            level   [1, 1]
            bin     [2, 2]
            bkted   [0, 0]
            reason  [0, 2]

    --  the learntc [2, -4]
            bkt_bin 0 bkt_lvl 1
    ----        partial unsat
    --  find_global_bkt_lvl
            bkt_bin 2 bkt_lvl 1
    --  backtrack across bin: bkt_lvl == 1
    update_bin 3
        c1  -1 3 5
        c2  2 -4 -5
        c3  2 5
        c4  2 -4
        local vars  [1, 2, 3, 4, 5]
        value       [1, 2, 0, 0, 0]
        implied     [1, 0, 0, 0, 0]
        level       [0, 1, 0, 0, 0]

      level   1
      bkted   1
      d_bin   2
    */


    /*** 测试数据2，冲突 ***/

    // todooo

    task test_sat_engine_task();
        begin
            reset_all_signal();
            $display("test_sat_engine_task");

            $display("===============================================");
            $display("test case 1");
            load_core(bin1, value1, implied1, level1, dcd_bin1, has_bkt1, cur_bin_num1, load_lvl1, base_lvl1);
            test_core(process_data1, process_len1);
            update_core();

            $display("===============================================");
            $display("test case 2");
            load_core(bin2, value2, implied2, level2, dcd_bin2, has_bkt2, cur_bin_num2, load_lvl2, base_lvl2);
            test_core(process_data2, process_len2);
            update_core();
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
