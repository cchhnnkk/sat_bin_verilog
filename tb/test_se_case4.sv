
/*** 测试数据4，直接冲突 ***/

int bin4[8][8] = '{
    '{0, 2, 0, 2, 2, 0, 0, 0},
    '{1, 0, 1, 0, 2, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0}
};
//var state list:
int value4[]   = '{1, 1, 1, 1, 1, 0, 0, 0};
int implied4[] = '{0, 0, 0, 0, 1, 0, 0, 0};
int level4[]   = '{2, 4, 11, 9, 6, 0, 0, 0};
//lvl state list:
int dcd_bin4[] = '{11, 0, 0, 0, 0, 0, 0, 0};
int has_bkt4[] = '{0, 0, 0, 0, 0, 0, 0, 0};
//ctrl
int cur_bin_num4 = 19;
int load_lvl4 = 17;
int base_lvl4 = 16;

//运算过程数据
int process_len4 = 1;
struct_process process_data4[] = '{
    '{"conflict", 0, 0, 0},
    '{"punsat",   0, 0, 0}
};

task test_se_case4();
    begin
        $display("===============================================");
        $display("test case 4");
        load_core(bin4, value4, implied4, level4, dcd_bin4, has_bkt4, cur_bin_num4, load_lvl4, base_lvl4);
        test_core(process_data4, process_len4);
        update_core();
    end
endtask

/*
load_bin 19
    c1  2 4 5
    c2  -1 -3 5
    global vars [2, 8, 15, 17, 19]
    local vars  [1, 2, 3, 4, 5]
    value       [1, 1, 1, 1, 1]
    implied     [0, 0, 0, 0, 1]
    level       [2, 4, 11, 9, 6]

    int base_lvl4 = 16;

sat engine run_core: cur_bin == 19
--  bcp
        find conflict in c_array.init_state()
--  analysis the conflict
        conflict c1
        lits    [2, 4, 5]
        value   [1, 1, 1]
        implied [0, 0, 1]
        level   [4, 9, 6]
        bin     [1, 3, 2]
        bkted   [0, 0, 0]
        reason  [0, 0, 0]
--  no learntc
        bkt_bin 0 bkt_lvl 9
----        partial unsat
--  find_global_bkt_lvl
        bkt_bin 2 bkt_lvl 9
--  backtrack_across_bin: bkt_lvl == 9
update_bin 19
    c1  2 4 5
    c2  -1 -3 5
    global vars [2, 8, 15, 17, 19]
    local vars  [1, 2, 3, 4, 5]
    value       [1, 1, 0, 2, 1]
    implied     [0, 0, 0, 0, 1]
    level       [2, 4, 0, 9, 6]
*/
