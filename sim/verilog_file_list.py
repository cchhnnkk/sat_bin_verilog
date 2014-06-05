import os
def print_tree(dir_path, file):
	for name in os.listdir(dir_path):
		full_path = os.path.join(dir_path, name)
		if(name.endswith('.v')):
			str = full_path.replace('\\','/')
			file.write(str+'\n')

		if os.path.isdir(full_path):
			print_tree(full_path, file)

outfile = open('verilog_file_list.f', 'w')
outfile.close()
outfile = open('verilog_file_list.f', 'a')
print_tree('..', outfile)
outfile.close()