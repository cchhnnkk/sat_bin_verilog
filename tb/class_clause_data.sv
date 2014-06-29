class class_clause_data #(int size = 8);

	parameter MAX = 9;

	bit [2:0] data[size];

	function void reset();
		for (int i = 0; i < size; ++i)
		begin
			data[i] = 0;
		end
	endfunction

	function void get(output [3*size-1:0]  _data);
		int index;
		for (int i = 0; i < size; ++i)
		begin
			for (int j = 0; j < 3; ++j)
			begin
				index = size - 1 - i;
				index = index*3+j;
				_data[index] = data[i][j];
			end
		end
	endfunction

	function void set(input [3*size-1:0] value);
		int index;
		for (int i = 0; i < size; ++i)
		begin
			for (int j = 0; j < 3; ++j)
			begin
				index = size - 1 - i;
				index = index*3+j;
				data[i][j] = value[index];
			end
		end
	endfunction

	function void set_clause(input [2*size-1:0] value);
		int index;
		for (int i = 0; i < size; ++i)
		begin
			for (int j = 0; j < 2; ++j)
			begin
				index = size - 1 - i;
				index = index*2+j;
				data[i][j+1] = value[index];
			end
		end
	endfunction

	function void get_clause(output [2*size-1:0] value);
		int index;
		for (int i = 0; i < size; ++i)
		begin
			for (int j = 0; j < 2; ++j)
			begin
				index = size - 1 - i;
				index = index*2+j;
				value[index] = data[i][j+1];
			end
		end
	endfunction

	function int get_len();
		int len = 0;
		for (int i = 0; i < size; ++i)
		begin
			if(data[i][2:1]!=0) begin
				len += 1;
			end
		end
		if(len == 0) begin
			len = MAX;
		end
		get_len = len;
	endfunction

	function void set_lits(int cl[size]);
		foreach (cl[i]) begin
			data[i][2:1] = cl[i];
		end
	endfunction

	function void set_lit(input int index, input [1:0] value);
		data[index][1:0] = value;
	endfunction

	function void set_value(input int index, input [2:0] value);
		data[index] = value;
	endfunction

	function void set_imps(int d[size]);
		foreach (d[i]) begin
			data[i][0] = d[i];
		end
	endfunction

	function void get_lit(input int index, output [1:0] value);
		value = data[index][1:0];
	endfunction

	function void assert_lit(int index, bit [2:0] value);
		assert(value == data[index]);
	endfunction

	function void display();
		display_lits();
		display_implied();
	endfunction

	function void display_lits();
        string str_all = "";
        string str;
        bit [1:0] d;
		for (int i = 0; i < size; ++i)
		begin
			d = data[i][2:1];
			$sformat(str, "%d", d);
            str_all = {str_all, str, " "};
		end
        $display("\tvalue = %s", str_all);
	endfunction

	function void display_implied();
        string str_all = "\t";
        string str;
        bit [1:0] d;
		for (int i = 0; i < size; ++i)
		begin
			d = data[i][0];
			$sformat(str, "%d", d);
			// str.itoa(data[i*3]);
            str_all = {str_all, str, " "};
		end
        $display("\timplied = %s", str_all);
	endfunction

endclass
