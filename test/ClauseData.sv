class ClauseData #(int size = 8);

	parameter MAX = 9;

	reg [2:0] data[size];

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

	function void set_c(input [3*size-1:0] value);
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

	function void set_lit(input int index, input [1:0] value);
		data[index][1:0] = value;
	endfunction

	function void set_value(input int index, input [2:0] value);
		data[index] = value;
	endfunction

	function void set_lits(int cl[size]);
		foreach (cl[i]) begin
			data[i][2:1] = cl[i];
		end
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

endclass
