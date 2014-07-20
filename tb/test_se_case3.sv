
/*** ²âÊÔÊý¾Ý3£¬Ö±½Ópartial sat ***/

int bin3[8][8] = '{
    '{1, 0, 2, 0, 2, 0, 0, 0},
    '{0, 2, 0, 1, 1, 0, 0, 0},
    '{0, 2, 0, 0, 2, 0, 0, 0},
    '{0, 2, 0, 1, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0, 0, 0, 0}
};
//var state list:
int value3[]   = '{1, 2, 1, 2, 0, 0, 0, 0};
int implied3[] = '{1, 0, 1, 1, 0, 0, 0, 0};
int level3[]   = '{0, 1, 2, 3, 0, 0, 0, 0};
//lvl state list:
int dcd_bin3[] = '{2, 0, 0, 0, 0, 0, 0, 0};
int has_bkt3[] = '{0, 0, 0, 0, 0, 0, 0, 0};
//ctrl
int cur_bin_num3 = 2;
int load_lvl3 = 4;
int base_lvl3 = 3;

//ÔËËã¹ý³ÌÊý¾Ý
int process_len3 = 1;
struct_process process_data3[] = '{
    '{"psat",   0, 0, 0}
};

task test_se_case3();
    begin
        $display("===============================================");
        $display("test case 3");
        load_core(bin3, value3, implied3, level3, dcd_bin3, has_bkt3, cur_bin_num3, load_lvl3, base_lvl3);
        test_core(process_data3, process_len3);
        update_core();
    end
endtask

// todooo
/*
c1  -1 3 5
c2  2 -4 -5
c3  2 5
c4  2 -4
global vars [1, 2, 5, 6, 7]
local vars  [1, 2, 3, 4, 5]
value       [1, 2, 1, 2, 0]
implied     [1, 0, 1, 1, 0]
level       [0, 1, 2, 3, 0]

sat engine run_core: cur_bin == 3
--  bcp
--  decision
----        partial sat
*/
