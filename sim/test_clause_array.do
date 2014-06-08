quit -sim
vlib work
vmap work work

vlog -quiet ../lit_cell.v -sv
vlog -quiet ../lit2.v
vlog -quiet ../lit4.v
vlog -quiet ../lit8.v
vlog -quiet ../terminal_cell.v
vlog -quiet ../clause1.v
vlog -quiet ../clause2.v
vlog -quiet ../clause4.v
vlog -quiet ../clause8.v
vlog -quiet ../clause_array.v
vlog -quiet ../max_in_datas.v
vlog -quiet ../test/ClauseData.sv
vlog -quiet ../test/ClauseArray.sv
vlog -quiet ../test/test_clause_array.sv

vsim -quiet test_clause_array_top

add wave -noupdate -divider {TEST}
add wave -noupdate sim:/test_clause_array_top/test_clause_array/*
add wave -noupdate -divider {DUT}
add wave -noupdate sim:/test_clause_array_top/test_clause_array/clause_array/*

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