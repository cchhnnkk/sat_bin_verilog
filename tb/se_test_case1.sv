
/*** ��������1 ***/

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
int load_lvl1 = 2;
int base_lvl1 = 2;

//�����������
int process_len1 = 6;
struct_process process_data1[] = '{
    '{"decision", 0, 1, 2},
    '{"bcp",      2, 1, 2},
    '{"bcp",      4, 2, 2},
    '{"decision", 1, 1, 3},
    '{"bcp",      3, 1, 3},
    '{"psat",     0, 0, 0}
};

task se_test_case1();
    begin
        $display("===============================================");
        $display("test case 1");
        bin          = bin1;
        value        = value1;
        implied      = implied1;
        level        = level1;
        dcd_bin      = dcd_bin1;
        has_bkt      = has_bkt1;
        cur_bin_num  = cur_bin_num1;
        load_lvl     = load_lvl1;
        base_lvl     = base_lvl1;
        process_len  = process_len1;
        process_data = process_data1;
        run_test_case();
    end
endtask
