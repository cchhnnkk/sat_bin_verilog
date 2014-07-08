

vlog: vlog_sat_engine

sim: sim_sat_engine

view:
	start vsim -view vsim.wlf

# sat engine
vlog_sat_engine:
	vlog_test_sat_engine.sh

sim_clause_array:
	sed "s/test_sat_engine_top/test_clause_array_top/g" test_se_console.do > test_ca_console.do
	vsim -c -do test_ca_console.do
	rm test_ca_console.do
	python transcript_info.py
	sed -i "s/--//g" transcript.todo
	sublime_text transcript.todo

sim_sat_engine:
	vsim -c -do test_se_console.do
	python transcript_info.py
	sublime_text transcript.todo

wave_sat_engine: hielist
	cd ../tools && ../tools/gen_wave.sh test_sat_engine_top 3

init_ref_sat_engine:
	../tools/gen_include_ref.py > vlog_include_ref.db ../src/sat_engine ../tb

# clause1
wave_clause1: hielist
	cd ../tools && ../tools/gen_wave.sh test_clause1_top 3

init_ref_all:
	../tools/gen_include_ref.py > vlog_include_ref.db ..

hielist:
	cd ../tools && gen_all_hielist.sh

clean:
	rm -rf work
	rm vlog_db.txt
	#\rm -rf $(CLEAN_THESE)  
