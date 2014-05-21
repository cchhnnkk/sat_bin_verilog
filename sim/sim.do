quit -sim
vlog -quiet ../lit_cell.v
vlog -quiet ../test_lit_cell.v
vsim -quiet test_lit_cell

add wave -position insertpoint sim:/test_lit_cell/*
add wave -position insertpoint sim:/test_lit_cell/lit1/*

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 79
configure wave -justifyvalue left
configure wave -signalnamewidth 2
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
WaveRestoreZoom {0 ns} {1000 ns}

run 1000 ns