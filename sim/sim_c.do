quit -sim

vlog -quiet ../lit_cell.v -sv
vlog -quiet test_lit_cell.sv

vsim -quiet test_lit_cell

run 1000 ns