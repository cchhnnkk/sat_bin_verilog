/**
 子句阵列的实现
 主要功能：实例化clause8，以及find_learntc_inserti
 */

module clause_array #(
        parameter NUM_CLAUSES = 8,
        parameter NUM_VARS = 8,
        parameter WIDTH_C_LEN = 4
    )
    (
        input                          clk,
        input                          rst,

        //data I/O
        input [NUM_VARS*3-1:0]         var_value_i,
        output [NUM_VARS*3-1:0]        var_value_o,

        //load update
        input [NUM_CLAUSES-1:0]        wr_i,
        input [NUM_CLAUSES-1:0]        rd_i,
        input [NUM_VARS*2-1 : 0]       clause_i,
        output [NUM_VARS*2-1 : 0]      clause_o,
        input [WIDTH_C_LEN-1 : 0]      clause_len_i,

        //ctrl
        input                          add_learntc_en_i,
        output                         all_c_sat_o,
        input                          apply_impl_i,
        input                          apply_bkt_i
    );

    wire [WIDTH_C_LEN*NUM_CLAUSES-1 : 0]    clause_len_o;
    wire [WIDTH_C_LEN*NUM_CLAUSES/2-1 : 0]  originc_lens, clause_lens;
    wire [NUM_CLAUSES-1:0]                  wr_clause;

    assign {clause_lens, originc_lens} = clause_len_o;
    
    clause8 #(
            .WIDTH_C_LEN(WIDTH_C_LEN)
        )
        clause8(
            .clk(clk),
            .rst(rst),

            .var_value_i(var_value_i),
            .var_value_o(var_value_o),

            .wr_i(wr_i),
            .rd_i(rd_i),
            .clause_i(clause_i),
            .clause_o(clause_o),
            .clause_len_i(clause_len_i),
            .clause_len_o(clause_len_o),

            .all_c_sat_o(all_c_sat_o),
            .apply_impl_i(apply_impl_i),
            .apply_bkt_i(apply_bkt_i)
        );

    wire [WIDTH_C_LEN-1 : 0]          max_len;
    wire [NUM_CLAUSES/2-1:0]    insert_index;
    wire [NUM_CLAUSES-1:0]      learntc_insert_index;

    max_in_4_datas #(
            .WIDTH(WIDTH_C_LEN)
        )
        max_in_4_datas_inst0 (
            .data_i(clause_lens),
            .data_o(max_len),
            .index_o(insert_index)
        );
    assign learntc_insert_index = {insert_index, 4'd0};
    assign wr_clause = add_learntc_en_i? learntc_insert_index : wr_i;
endmodule
