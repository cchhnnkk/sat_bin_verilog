quit -sim

vlog -quiet ../lit_cell.v
vlog -quiet ../test_lit_cell.v

vsim -quiet test_lit_cell

run 1000 ns