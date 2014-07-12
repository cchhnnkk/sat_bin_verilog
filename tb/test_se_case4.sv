
/*** 测试数据4，直接冲突 ***/

int bin4[8][8] = '{
    '{0, 2, 0, 2, 1, 0, 0, 0},
    '{2, 0, 0, 0, 0, 2, 1, 0},
    '{2, 0, 2, 0, 0, 0, 1, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0}
};
//var state list:
int value4[]   = '{1, 1, 1, 1, 2, 2, 1, 0};
int implied4[] = '{0, 0, 0, 0, 0, 1, 1, 0};
int level4[]   = '{3, 4, 8, 10, 9, 9, 8, 0};
//lvl state list:
int dcd_bin4[] = '{5, 5, 5, 8, 11, 0, 0, 0};
int has_bkt4[] = '{0, 0, 0, 0, 0, 0, 0, 0};
//ctrl
int cur_bin_num4 = 15;
int load_lvl4 = 13;
int base_lvl4 = 12;

//运算过程数据
int process_len4 = 1;
struct_process process_data4[] = '{
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
c1  2 4 -5
c2  1 6 -7
c3  1 3 -7
global vars [7, 8, 11, 14, 17, 18, 20]
local vars  [1, 2, 3, 4, 5, 6, 7]
value       [1, 1, 1, 1, 2, 2, 1]
implied     [0, 0, 0, 0, 0, 1, 1]
level       [3, 4, 8, 10, 9, 9, 8]

sat engine run_core: cur_bin == 16
--  preprocess
        conflict c1
        lits    [2, 4, -5]
        value   [1, 1, 2]
        implied [0, 0, 0]
        level   [4, 10, 9]
        bin     [1, 5, 3]
        bkted   [0, 0, 0]
        reason  [0, 0, 0]

        bkt_bin 0 bkt_lvl 10
--  find_global_bkt_lvl
        bkt_bin 3 bkt_lvl 10
--  backtrack across bin: bkt_lvl == 10
update_bin 16
    c1  2 4 -5
    c2  1 6 -7
    c3  1 3 -7
    global vars [7, 8, 11, 14, 17, 18, 20]
    local vars  [1, 2, 3, 4, 5, 6, 7]
    value       [1, 1, 1, 2, 2, 2, 1]
    implied     [0, 0, 0, 0, 0, 1, 1]
    level       [3, 4, 8, 10, 9, 9, 8]
*/
