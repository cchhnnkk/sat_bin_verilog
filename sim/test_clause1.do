quit -sim
vlib work
vmap work work

vlog -quiet ../lit_cell.v -sv
vlog -quiet ../lit2.v
vlog -quiet ../lit4.v
vlog -quiet ../lit8.v
vlog -quiet ../terminal_cell.v
vlog -quiet ../clause1.v
vlog -quiet ../test/ClauseData.sv -sv
vlog -quiet ../test/test_clause1.sv

vsim -quiet test_clause1_top

add wave -noupdate -divider {TEST}
add wave -noupdate sim:/test_clause1_top/test_clause1/*
add wave -noupdate -divider {DUT}
add wave -noupdate sim:/test_clause1_top/test_clause1/clause1/*
add wave -noupdate -expand -group {lit0} sim:/test_clause1_top/test_clause1/clause1/lit8_0/lit4_0/lit2_0/lit_cell_0/*
add wave -noupdate -expand -group {lit1} sim:/test_clause1_top/test_clause1/clause1/lit8_0/lit4_0/lit2_0/lit_cell_1/*
add wave -noupdate -expand -group {lit2} sim:/test_clause1_top/test_clause1/clause1/lit8_0/lit4_0/lit2_1/lit_cell_0/*
add wave -noupdate -expand -group {lit3} sim:/test_clause1_top/test_clause1/clause1/lit8_0/lit4_0/lit2_1/lit_cell_1/*

add wave -noupdate -expand -group {terminal_cell} sim:/test_clause1_top/test_clause1/clause1/terminal_cell/*


TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 79
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {200 ns}

run 200 ns