import os


# os.system('vlog -quiet ../lit_cell.v')
# os.system('vlog -quiet ../test_lit_cell.v')

# os.system('vsim test_lit_cell')
# os.system('vsim -c -quiet  -do sim.do test_lit_cell')
# os.system('vsim -quiet -do sim.do')
os.system('vsim -c -quiet -do sim_c.do')
os.system('vsim -c -do sim.do counter_opt -wlf counter_opt.wlf')
os.system('vsim -view counter_opt.wlf')
