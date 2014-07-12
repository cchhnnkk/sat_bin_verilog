/*** 测试数据5，bin内回退 ***/

int bin5[8][8] = '{
    '{1, 0, 0, 1, 0, 2, 0, 0},
    '{0, 1, 2, 0, 2, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0}
};
//var state list:
int value5[]   = '{1, 2, 1, 2, 1, 2};
int implied5[] = '{0, 0, 0, 1, 1, 1};
int level5[]   = '{11, 12, 3, 10, 10, 10};
//lvl state list:
int dcd_bin5[] = '{3, 5, 5, 5, 16, 5};
int has_bkt5[] = '{1, 0, 1, 0, 0, 0};
//ctrl
int cur_bin_num5 = 27;
int load_lvl5 = 13;
int base_lvl5 = 10;

//运算过程数据
int process_len5 = 3;
struct_process process_data5[] = '{
    '{"conflict", 0, 0, 0},
    '{"bkt_curb", 0, 0, 0},
    '{"bcp",      4, 3, 1},
    '{"psat",     0, 0, 0}
};

task test_se_case5();
    begin
        $display("===============================================");
        $display("test case 5");
        load_core(bin5, value5, implied5, level5, dcd_bin5, has_bkt5, cur_bin_num5, load_lvl5, base_lvl5);
        test_core(process_data5, process_len5);
        update_core();
    end
endtask

/*
c1  -1 -4 6
c2  -2 3 5
global vars [4, 5, 7, 10, 12, 19]
local vars  [1, 2, 3, 4, 5, 6]
value       [1, 2, 1, 2, 1, 2]
implied     [0, 0, 0, 1, 1, 1]
level       [11, 12, 3, 10, 10, 10]

sat engine run_core: cur_bin == 5
--  preprocess
        conflict c2
        lits    [-2, 3, 5]
        value   [2, 1, 1]
        implied [0, 0, 1]
        level   [12, 3, 10]
        bin     [5, 1, 5]
        bkted   [0, 1, 0]
        reason  [0, 0, 0]

        bkt_bin 5 bkt_lvl 11
--  backtrack_cur_bin: bkt_lvl == 11
--  bcp
        c2 var 2 gvar 5 value 1 level 10
--  decision
----        partial sat
update_bin 5
    c1  -1 -4 6
    c2  -2 3 5
    global vars [4, 5, 7, 10, 12, 19]
    local vars  [1, 2, 3, 4, 5, 6]
    value       [2, 1, 1, 2, 1, 2]
    implied     [0, 1, 0, 1, 1, 1]
    level       [11, 10, 3, 10, 10, 10]
*/
