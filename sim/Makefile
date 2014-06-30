VLOG_LIST_NAME  = vlog.list

myvlog = vlog -quiet 


# sim_sat_engine.sh:
# 	start vsim

vlog_sat_engine: vlog_include_ref.db
	vlog_test_sat_engine.sh

vlog_include_ref.db:
	init_vlog.sh

wave_sat_engine: hielist
	cd ../tools && ../tools/gen_wave.sh test_sat_engine_top 3

hielist:
	cd ../tools && gen_all_hielist.sh

clean:
	rm -rf work
	rm vlog_db.txt
	#\rm -rf $(CLEAN_THESE)  



# test_clause_array.sv: class_clause_array.sv class_clause_data.sv
# 	$(myvlog) ../tb/class_clause_data.sv

# class_clause_array.sv: 
# 	$(myvlog) ../tb/class_clause_array.sv

# class_clause_data.sv:
# 	$(myvlog) ../tb/class_clause_data.sv

# wave_test_clause_array_top.do: class_clause_array.sv
# 	cd ../tools
# 	gen_wave.sh test_clause_array_top
# 	cd ../sim
