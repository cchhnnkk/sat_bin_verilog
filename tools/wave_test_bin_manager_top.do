test_bin_manager_top
test_bin_manager_top
[[u'test_bin_manager', u'test_bin_manager', [[u'bin_manager', u'bin_manager', [[u'ctrl_bm', u'ctrl_bm', []], [u'rd_bin_info', u'rd_bin_info', []], [u'load_bin', u'load_bin', []], [u'find_global_bkt_lvl', u'find_global_bkt_lvl', []], [u'bkt_across_bin', u'bkt_across_bin', []], [u'update_bin', u'update_bin', [[u'reduce_in_8_datas', u'reduce_in_8_datas_vs_inst', [[u'reduce_in_4_datas', u'reduce_in_4_datas_inst0', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]], [u'reduce_in_4_datas', u'reduce_in_4_datas_inst1', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]]]], [u'reduce_in_8_datas', u'reduce_in_8_datas_vs_inst', [[u'reduce_in_4_datas', u'reduce_in_4_datas_inst0', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]], [u'reduce_in_4_datas', u'reduce_in_4_datas_inst1', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]]]]]], [u'bram_w30_d1024', u'bram_vars_bins_inst', []], [u'bram_w30_d1024', u'bram_clauses_bins_inst', []], [u'bram_w30_d1024', u'bram_global_var_state_inst', []], [u'bram_w30_d1024', u'bram_global_lvl_state_inst', []]]]]]]
add wave -noupdate -expand -group {test_bin_manager_top} /test_bin_manager_top/*
test_bin_manager
test_bin_manager
[[u'bin_manager', u'bin_manager', [[u'ctrl_bm', u'ctrl_bm', []], [u'rd_bin_info', u'rd_bin_info', []], [u'load_bin', u'load_bin', []], [u'find_global_bkt_lvl', u'find_global_bkt_lvl', []], [u'bkt_across_bin', u'bkt_across_bin', []], [u'update_bin', u'update_bin', [[u'reduce_in_8_datas', u'reduce_in_8_datas_vs_inst', [[u'reduce_in_4_datas', u'reduce_in_4_datas_inst0', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]], [u'reduce_in_4_datas', u'reduce_in_4_datas_inst1', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]]]], [u'reduce_in_8_datas', u'reduce_in_8_datas_vs_inst', [[u'reduce_in_4_datas', u'reduce_in_4_datas_inst0', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]], [u'reduce_in_4_datas', u'reduce_in_4_datas_inst1', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]]]]]], [u'bram_w30_d1024', u'bram_vars_bins_inst', []], [u'bram_w30_d1024', u'bram_clauses_bins_inst', []], [u'bram_w30_d1024', u'bram_global_var_state_inst', []], [u'bram_w30_d1024', u'bram_global_lvl_state_inst', []]]]]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} /test_bin_manager_top/test_bin_manager/*
bin_manager
bin_manager
[[u'ctrl_bm', u'ctrl_bm', []], [u'rd_bin_info', u'rd_bin_info', []], [u'load_bin', u'load_bin', []], [u'find_global_bkt_lvl', u'find_global_bkt_lvl', []], [u'bkt_across_bin', u'bkt_across_bin', []], [u'update_bin', u'update_bin', [[u'reduce_in_8_datas', u'reduce_in_8_datas_vs_inst', [[u'reduce_in_4_datas', u'reduce_in_4_datas_inst0', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]], [u'reduce_in_4_datas', u'reduce_in_4_datas_inst1', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]]]], [u'reduce_in_8_datas', u'reduce_in_8_datas_vs_inst', [[u'reduce_in_4_datas', u'reduce_in_4_datas_inst0', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]], [u'reduce_in_4_datas', u'reduce_in_4_datas_inst1', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]]]]]], [u'bram_w30_d1024', u'bram_vars_bins_inst', []], [u'bram_w30_d1024', u'bram_clauses_bins_inst', []], [u'bram_w30_d1024', u'bram_global_var_state_inst', []], [u'bram_w30_d1024', u'bram_global_lvl_state_inst', []]]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} /test_bin_manager_top/test_bin_manager/bin_manager/*
ctrl_bm
ctrl_bm
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {ctrl_bm} /test_bin_manager_top/test_bin_manager/bin_manager/ctrl_bm/*
rd_bin_info
rd_bin_info
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {rd_bin_info} /test_bin_manager_top/test_bin_manager/bin_manager/rd_bin_info/*
load_bin
load_bin
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {load_bin} /test_bin_manager_top/test_bin_manager/bin_manager/load_bin/*
find_global_bkt_lvl
find_global_bkt_lvl
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {find_global_bkt_lvl} /test_bin_manager_top/test_bin_manager/bin_manager/find_global_bkt_lvl/*
bkt_across_bin
bkt_across_bin
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {bkt_across_bin} /test_bin_manager_top/test_bin_manager/bin_manager/bkt_across_bin/*
update_bin
update_bin
[[u'reduce_in_8_datas', u'reduce_in_8_datas_vs_inst', [[u'reduce_in_4_datas', u'reduce_in_4_datas_inst0', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]], [u'reduce_in_4_datas', u'reduce_in_4_datas_inst1', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]]]], [u'reduce_in_8_datas', u'reduce_in_8_datas_vs_inst', [[u'reduce_in_4_datas', u'reduce_in_4_datas_inst0', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]], [u'reduce_in_4_datas', u'reduce_in_4_datas_inst1', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]]]]]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/*
reduce_in_8_datas
reduce_in_8_datas_vs_inst
[[u'reduce_in_4_datas', u'reduce_in_4_datas_inst0', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]], [u'reduce_in_4_datas', u'reduce_in_4_datas_inst1', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]]]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/*
reduce_in_4_datas
reduce_in_4_datas_inst0
[[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst0} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst0/*
reduce_in_2_datas
reduce_in_2_datas_inst0
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst0} -group {reduce_in_2_datas_inst0} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst0/reduce_in_2_datas_inst0/*
reduce_in_2_datas
reduce_in_2_datas_inst1
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst0} -group {reduce_in_2_datas_inst1} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst0/reduce_in_2_datas_inst1/*
reduce_in_4_datas
reduce_in_4_datas_inst1
[[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst1} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst1/*
reduce_in_2_datas
reduce_in_2_datas_inst0
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst1} -group {reduce_in_2_datas_inst0} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst1/reduce_in_2_datas_inst0/*
reduce_in_2_datas
reduce_in_2_datas_inst1
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst1} -group {reduce_in_2_datas_inst1} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst1/reduce_in_2_datas_inst1/*
reduce_in_8_datas
reduce_in_8_datas_vs_inst
[[u'reduce_in_4_datas', u'reduce_in_4_datas_inst0', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]], [u'reduce_in_4_datas', u'reduce_in_4_datas_inst1', [[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]]]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/*
reduce_in_4_datas
reduce_in_4_datas_inst0
[[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst0} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst0/*
reduce_in_2_datas
reduce_in_2_datas_inst0
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst0} -group {reduce_in_2_datas_inst0} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst0/reduce_in_2_datas_inst0/*
reduce_in_2_datas
reduce_in_2_datas_inst1
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst0} -group {reduce_in_2_datas_inst1} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst0/reduce_in_2_datas_inst1/*
reduce_in_4_datas
reduce_in_4_datas_inst1
[[u'reduce_in_2_datas', u'reduce_in_2_datas_inst0', []], [u'reduce_in_2_datas', u'reduce_in_2_datas_inst1', []]]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst1} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst1/*
reduce_in_2_datas
reduce_in_2_datas_inst0
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst1} -group {reduce_in_2_datas_inst0} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst1/reduce_in_2_datas_inst0/*
reduce_in_2_datas
reduce_in_2_datas_inst1
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {update_bin} -group {reduce_in_8_datas_vs_inst} -group {reduce_in_4_datas_inst1} -group {reduce_in_2_datas_inst1} /test_bin_manager_top/test_bin_manager/bin_manager/update_bin/reduce_in_8_datas_vs_inst/reduce_in_4_datas_inst1/reduce_in_2_datas_inst1/*
bram_w30_d1024
bram_vars_bins_inst
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {bram_vars_bins_inst} /test_bin_manager_top/test_bin_manager/bin_manager/bram_vars_bins_inst/*
bram_w30_d1024
bram_clauses_bins_inst
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {bram_clauses_bins_inst} /test_bin_manager_top/test_bin_manager/bin_manager/bram_clauses_bins_inst/*
bram_w30_d1024
bram_global_var_state_inst
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {bram_global_var_state_inst} /test_bin_manager_top/test_bin_manager/bin_manager/bram_global_var_state_inst/*
bram_w30_d1024
bram_global_lvl_state_inst
[]
add wave -noupdate -expand -group {test_bin_manager_top} -expand -group {test_bin_manager} -expand -group {bin_manager} -group {bram_global_lvl_state_inst} /test_bin_manager_top/test_bin_manager/bin_manager/bram_global_lvl_state_inst/*
