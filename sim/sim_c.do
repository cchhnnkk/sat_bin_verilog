quit -sim

vlog -quiet ../lit_cell.v -sv
vlog -quiet ../lit2.v -sv
vlog -quiet ../lit4.v -sv
vlog -quiet ../lit8.v -sv
vlog -quiet ../terminal_cell.v -sv
vlog -quiet ../clause1.v -sv
vlog -quiet ClauseData.sv -sv
vlog -quiet test_clause1.sv

vsim -quiet test_clause1_top

run 1000 ns