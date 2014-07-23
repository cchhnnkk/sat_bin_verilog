
/*** 测试数据2，冲突分析 ***/

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
    '{"conflict", 0, 0, 0},
    '{"punsat",   0, 0, 0}
};


task se_test_case2();
    begin
        $display("===============================================");
        $display("test case 2");
        bin          = bin2;
        value        = value2;
        implied      = implied2;
        level        = level2;
        dcd_bin      = dcd_bin2;
        has_bkt      = has_bkt2;
        cur_bin_num  = cur_bin_num2;
        load_lvl     = load_lvl2;
        base_lvl     = base_lvl2;
        process_len  = process_len2;
        process_data = process_data2;
        run_test_case();
    end
endtask

/*
load_bin 3
    c1  -1 3 5
    c2  2 -4 -5
    c3  2 5
    local vars  [1, 2, 3, 4, 5]
    value       [1, 1, 1, 2, 0]
    implied     [1, 0, 1, 1, 0]
    level       [0, 1, 2, 1, 0]

    int base_lvl2 = 2;

sat engine run_core: cur_bin == 3
--  preprocess
--  bcp
        c2 var 5 gvar 7 value 3 level 1
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

