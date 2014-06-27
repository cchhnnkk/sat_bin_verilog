/**
*	层级状态列表类
*	提供一些lvl state相关的数据转换的功能
*/
class class_ls_list #(int nv = 8, int width_bini = 16, int width_ls = width_bini+1);

	int dcd_bin[nv];
	int has_bkt[nv];

	function new(int dcd_bin1[nv], int has_bkt1[nv]);
		for (int i = 0; i < nv; ++i)
		begin
			dcd_bin[i] = dcd_bin1[i];
			has_bkt[i] = has_bkt1[i];
		end
	endfunction

	function void reset();
		for (int i = 0; i < nv; ++i)
		begin
			dcd_bin[i] = 0;
			has_bkt[i] = 0;
		end
	endfunction

	function void get(output [nv*width_ls-1:0]  data);
		bit [width_bini-1:0] bin;
		bit bkt;
		for (int i = 0; i < nv; ++i)
		begin
			bin = dcd_bin[i];
			bkt = has_bkt[i];
			data[width_ls*(i+1)-1 : width_ls*i] = {bin, bkt};
		end
	endfunction

	function void set(input [nv*width_ls-1:0] data);
		bit [2:0] v;
		bit [width_bini-1:0] l;
		for (int i = 0; i < nv; ++i)
		begin
			{bin, bkt} = data[width_ls*(i+1)-1 : width_ls*i];
			dcd_bin[i] = bin;
			has_bkt[i] = bkt;
		end
	endfunction

	function void display();
        string str_all;
        string str;
		for (int i = 0; i < nv; ++i)
		begin
			sprintf(str, "%d", dcd_bin[i]);
			// str.itoa(dcd_bin[i]);
            str_all = {str_all, str, " "};
		end
        $display("dcd_bin = %s", str_all);

		for (int i = 0; i < nv; ++i)
		begin
			sprintf(str, "%d", has_bkt[i]);
			// str.itoa(has_bkt[i]);
            str_all = {str_all, str, " "};
		end
        $display("has_bkt = %s", str_all);
	endfunction

endclass
