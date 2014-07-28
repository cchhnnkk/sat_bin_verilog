/**
*   读取子句信息
*/
module rd_bin_info #(
        parameter WIDTH_CLAUSES = 8*2,
        parameter WIDTH_VARS = 12
    )
    (
        input                             clk,
        input                             rst,

        //control
        input                             start_rdinfo_i,
        output reg                        done_rdinfo_o,

        input                             data_en,
        input [WIDTH_VARS-1:0]            nv_all_i,
        input [WIDTH_CLAUSES-1:0]         nb_all_i,

        output reg [WIDTH_VARS-1:0]       nv_all_o,
        output reg [WIDTH_CLAUSES-1:0]    n_cbin_o
    );

    //保存在寄存器中
    always @(posedge clk)
    begin
        if(~rst)
            nv_all_o <= 0;
        else if(data_en)
            nv_all_o <= nv_all_i;
        else
            nv_all_o <= nv_all_o;
    end

    always @(posedge clk)
    begin
        if(~rst)
            n_cbin_o <= 0;
        else if(data_en)
            n_cbin_o <= nb_all_i;
        else
            n_cbin_o <= n_cbin_o;
    end

    always @(posedge clk)
    begin
        if(~rst)
            done_rdinfo_o <= 0;
        else if(start_rdinfo_i)
            done_rdinfo_o <= 1;
        else
            done_rdinfo_o <= 0;
    end

endmodule
