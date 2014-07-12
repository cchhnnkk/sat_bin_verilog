
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
    '{"psat",     0, 0, 0}
};

task test_se_case1();
    begin
        $display("===============================================");
        $display("test case 1");
        load_core(bin1, value1, implied1, level1, dcd_bin1, has_bkt1, cur_bin_num1, load_lvl1, base_lvl1);
        test_core(process_data1, process_len1);
        update_core();
    end
endtask
