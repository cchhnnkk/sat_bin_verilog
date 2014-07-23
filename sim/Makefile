
all: vlog sim

vlog: vlog_bm

sim: sim_bm

view:
	start vsim -view vsim.wlf

# bin_manager
vlog_bm:
	vlog_test_bin_manager.sh

# sat engine
vlog_se:
	vlog_test_sat_engine.sh

sim_bm:
	vsim -c -do test_bm_console.do
	python transcript_info.py
	# sublime_text transcript.log

sim_se:
	vsim -c -do test_se_console.do
	python transcript_info.py
	# sublime_text transcript.log

sim_ca:
	sed "s/test_sat_engine_top/test_clause_array_top/g" test_se_console.do > test_ca_console.do
	vsim -c -do test_ca_console.do
	rm test_ca_console.do
	python transcript_info.py
	sed -i "s/--//g" transcript.log
	# sublime_text transcript.log

sim_c1:
	sed "s/test_sat_engine_top/test_clause1_top/g" test_se_console.do > test_c1_console.do
	vsim -c -do test_c1_console.do
	rm test_c1_console.do
	python transcript_info.py
	sed -i "s/--//g" transcript.log
	# sublime_text transcript.log

wave_se: hielist
	cd ../tools && ../tools/gen_wave.sh test_sat_engine_top 3

wave_exlist_se:
	cd ../tools && ../tools/gen_wave.sh test_sat_engine_top 3 wave_exlist_sat_engine.txt

init_ref_se:
	../tools/find_verilog_file.py ../src/sat_engine ../tb > filelist.txt
	echo "../src/debug_define.v" >> filelist.txt
	cat filelist.txt | ../tools/gen_include_ref.py > vlog_include_ref.db
	rm filelist.txt

# clause1
wave_clause1: hielist
	cd ../tools && ../tools/gen_wave.sh test_clause1_top 3

init_ref_all:
	cd ../tools && find_verilog_file .. > filelist.txt
	echo "../debug_define.v" >> filelist.txt
	cat filelist.txt | ../tools/gen_include_ref.py > vlog_include_ref.db
	rm filelist.txt

hielist:
	cd ../tools && gen_all_hielist.sh

clean:
	rm -rf work
	rm vlog_db.txt
	#\rm -rf $(CLEAN_THESE)  
