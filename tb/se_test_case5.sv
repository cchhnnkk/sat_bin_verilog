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
int value5[]   = '{1, 2, 1, 2, 1, 2, 0, 0};
int implied5[] = '{0, 0, 0, 1, 1, 1, 0, 0};
int level5[]   = '{11, 12, 3, 10, 10, 10, 0, 0};
//lvl state list:
int dcd_bin5[] = '{3, 5, 5, 5, 16, 5, 0, 0};
int has_bkt5[] = '{1, 0, 1, 0, 0, 0, 0, 0};
//ctrl
int cur_bin_num5 = 5;
int load_lvl5 = 13;
int base_lvl5 = 10;

//运算过程数据
int process_len5 = 3;
struct_process process_data5[] = '{
    '{"conflict", 0, 0, 0},
    '{"bkt_curb", 0, 0, 0},
    '{"bcp",      1, 1, 10},
    '{"psat",     0, 0, 0}
};

task se_test_case5();
    begin
        $display("===============================================");
        $display("test case 5");
        bin          = bin5;
        value        = value5;
        implied      = implied5;
        level        = level5;
        dcd_bin      = dcd_bin5;
        has_bkt      = has_bkt5;
        cur_bin_num  = cur_bin_num5;
        load_lvl     = load_lvl5;
        base_lvl     = base_lvl5;
        process_len  = process_len5;
        process_data = process_data5;
        run_test_case();
    end
endtask

/*
load_bin 5
	c1  -1 -4 6 
	c2  -2 3 5 
	global vars [4, 5, 7, 10, 12, 19]
	local vars  [1, 2, 3, 4, 5, 6]
	value       [1, 2, 1, 2, 1, 2]
	implied     [0, 0, 0, 1, 1, 1]
	level       [11, 12, 3, 10, 10, 10]
sat engine run_core: cur_bin == 5
--	bcp
		find conflict in c_array.init_state()
--	analysis the conflict
		conflict c2
		lits    [-2, 3, 5]
		value   [2, 1, 1]
		implied [0, 0, 1]
		level   [12, 3, 10]
		bin     [5, 1, 5]
		bkted   [0, 1, 0]
		reason  [0, 0, 0]

--	no learntc
		bkt_bin 5 bkt_lvl 11
--	backtrack_cur_bin: bkt_lvl == 11
--	bcp
		c2 var 2 gvar 5 value 1 level 10
		lits    [-2, 3, 5]
		value   [1, 1, 1]
		implied [1, 0, 1]
		level   [10, 3, 10]
		bin     [5, 1, 5]
		bkted   [1, 1, 1]
		reason  [2, 0, 0]

--	decision
----		partial sat
update_bin 5
	c1  -1 -4 6 
	c2  -2 3 5 
	global vars [4, 5, 7, 10, 12, 19]
	local vars  [1, 2, 3, 4, 5, 6]
	value       [2, 1, 1, 2, 1, 2]
	implied     [0, 1, 0, 1, 1, 1]
	level       [11, 10, 3, 10, 10, 10]

  level   1  2  3  4  5  6  7  8  9 10 11
  bkted   0  0  0  1  1  0  0  0  1  1  1
  d_bin   1  1  1  1  1  1  2  3  3  3  5
*/
