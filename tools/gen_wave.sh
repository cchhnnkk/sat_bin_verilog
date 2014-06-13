#!/bin/bash 

# gen_wave.sh test_clause_array_top 3

if [[ $# == 0 ]]; then
	echo 'please input the module_name'
elif [[ $# == 1 ]]; then
	cat hielist.json | gen_hietree.py $1 | gen_wave_do.py > "wave_$1.do"
elif [[ $# == 2 ]]; then
	cat hielist.json | gen_hietree.py $1 | gen_wave_do.py $2 > "wave_$1.do"
fi
