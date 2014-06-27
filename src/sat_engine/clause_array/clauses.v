
/**
 *  该文件是使用gen_num_verilog.py生成的
 *  gen_num_verilog ../src/sat_engine/clause_array/clauses.gen 8
 */
module clause8 #(
        parameter NUM_CLAUSES = 8,
        parameter NUM_VARS    = 8,
        parameter WIDTH_C_LEN = 4
    )
    (
        input                                        clk,
        input                                        rst,

        //data I/O
        input [NUM_VARS*3-1:0]                       var_value_i,
        output [NUM_VARS*3-1:0]                      var_value_o,

        //load update
        input [NUM_CLAUSES-1:0]                      wr_i,
        input [NUM_CLAUSES-1:0]                      rd_i,
        input [NUM_VARS*2-1 : 0]                     clause_i,
        output [NUM_VARS*2-1 : 0]                    clause_o,
        input [WIDTH_C_LEN-1 : 0]                    clause_len_i,
        output [WIDTH_C_LEN*NUM_CLAUSES-1 : 0]       clause_len_o,

        //ctrl
        output                                       all_c_sat_o,
        input                                        apply_impl_i,
        input                                        apply_bkt_i
    );

    wire [NUM_CLAUSES/2-1:0]                wr_0, wr_1;
    wire [3*NUM_VARS-1:0]                   var_value_0, var_value_1;
    wire [NUM_VARS*2-1 : 0]                 clause_o_0, clause_o_1;
    wire [WIDTH_C_LEN*NUM_CLAUSES/2-1 : 0]  clause_len_o_0, clause_len_o_1;
    wire                                    all_c_sat_o_0, all_c_sat_o_1;

    assign {wr_1, wr_0} = wr_i;
    assign {rd_1, rd_0} = rd_i;
    assign var_value_o = var_value_0 | var_value_1;
    assign clause_o = clause_o_0 | clause_o_1;
    assign clause_len_o = {clause_len_o_1, clause_len_o_0};
    assign all_c_sat_o = all_c_sat_o_0 | all_c_sat_o_1;

    clause4 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause4_0 (
        .clk(clk),
        .rst(rst),

        .var_value_i(var_value_i),
        .var_value_o(var_value_0),

        .wr_i(wr_0),
        .rd_i(rd_0),
        .clause_i(clause_i),
        .clause_o(clause_o_0),
        .clause_len_i(clause_len_i),
        .clause_len_o(clause_len_o_0),

        .all_c_sat_o(all_c_sat_o_0),
        .apply_impl_i(apply_impl_i),
        .apply_bkt_i(apply_bkt_i)
        );

    clause4 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause4_1 (
        .clk(clk), 
        .rst(rst), 
        
        .var_value_i(var_value_i),
        .var_value_o(var_value_1),

        .wr_i(wr_1),
        .rd_i(rd_1),
        .clause_i(clause_i),
        .clause_o(clause_o_1),
        .clause_len_i(clause_len_i),
        .clause_len_o(clause_len_o_1),

        .all_c_sat_o(all_c_sat_o_1),
        .apply_impl_i(apply_impl_i),
        .apply_bkt_i(apply_bkt_i)
        );

endmodule

module clause4 #(
        parameter NUM_CLAUSES = 4,
        parameter NUM_VARS    = 8,
        parameter WIDTH_C_LEN = 4
    )
    (
        input                                        clk,
        input                                        rst,

        //data I/O
        input [NUM_VARS*3-1:0]                       var_value_i,
        output [NUM_VARS*3-1:0]                      var_value_o,

        //load update
        input [NUM_CLAUSES-1:0]                      wr_i,
        input [NUM_CLAUSES-1:0]                      rd_i,
        input [NUM_VARS*2-1 : 0]                     clause_i,
        output [NUM_VARS*2-1 : 0]                    clause_o,
        input [WIDTH_C_LEN-1 : 0]                    clause_len_i,
        output [WIDTH_C_LEN*NUM_CLAUSES-1 : 0]       clause_len_o,

        //ctrl
        output                                       all_c_sat_o,
        input                                        apply_impl_i,
        input                                        apply_bkt_i
    );

    wire [NUM_CLAUSES/2-1:0]                wr_0, wr_1;
    wire [3*NUM_VARS-1:0]                   var_value_0, var_value_1;
    wire [NUM_VARS*2-1 : 0]                 clause_o_0, clause_o_1;
    wire [WIDTH_C_LEN*NUM_CLAUSES/2-1 : 0]  clause_len_o_0, clause_len_o_1;
    wire                                    all_c_sat_o_0, all_c_sat_o_1;

    assign {wr_1, wr_0} = wr_i;
    assign {rd_1, rd_0} = rd_i;
    assign var_value_o = var_value_0 | var_value_1;
    assign clause_o = clause_o_0 | clause_o_1;
    assign clause_len_o = {clause_len_o_1, clause_len_o_0};
    assign all_c_sat_o = all_c_sat_o_0 | all_c_sat_o_1;

    clause2 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause2_0 (
        .clk(clk),
        .rst(rst),

        .var_value_i(var_value_i),
        .var_value_o(var_value_0),

        .wr_i(wr_0),
        .rd_i(rd_0),
        .clause_i(clause_i),
        .clause_o(clause_o_0),
        .clause_len_i(clause_len_i),
        .clause_len_o(clause_len_o_0),

        .all_c_sat_o(all_c_sat_o_0),
        .apply_impl_i(apply_impl_i),
        .apply_bkt_i(apply_bkt_i)
        );

    clause2 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause2_1 (
        .clk(clk), 
        .rst(rst), 
        
        .var_value_i(var_value_i),
        .var_value_o(var_value_1),

        .wr_i(wr_1),
        .rd_i(rd_1),
        .clause_i(clause_i),
        .clause_o(clause_o_1),
        .clause_len_i(clause_len_i),
        .clause_len_o(clause_len_o_1),

        .all_c_sat_o(all_c_sat_o_1),
        .apply_impl_i(apply_impl_i),
        .apply_bkt_i(apply_bkt_i)
        );

endmodule

module clause2 #(
        parameter NUM_CLAUSES = 2,
        parameter NUM_VARS    = 8,
        parameter WIDTH_C_LEN = 4
    )
    (
        input                                        clk,
        input                                        rst,

        //data I/O
        input [NUM_VARS*3-1:0]                       var_value_i,
        output [NUM_VARS*3-1:0]                      var_value_o,

        //load update
        input [NUM_CLAUSES-1:0]                      wr_i,
        input [NUM_CLAUSES-1:0]                      rd_i,
        input [NUM_VARS*2-1 : 0]                     clause_i,
        output [NUM_VARS*2-1 : 0]                    clause_o,
        input [WIDTH_C_LEN-1 : 0]                    clause_len_i,
        output [WIDTH_C_LEN*NUM_CLAUSES-1 : 0]       clause_len_o,

        //ctrl
        output                                       all_c_sat_o,
        input                                        apply_impl_i,
        input                                        apply_bkt_i
    );

    wire [NUM_CLAUSES/2-1:0]                wr_0, wr_1;
    wire [3*NUM_VARS-1:0]                   var_value_0, var_value_1;
    wire [NUM_VARS*2-1 : 0]                 clause_o_0, clause_o_1;
    wire [WIDTH_C_LEN*NUM_CLAUSES/2-1 : 0]  clause_len_o_0, clause_len_o_1;
    wire                                    all_c_sat_o_0, all_c_sat_o_1;

    assign {wr_1, wr_0} = wr_i;
    assign {rd_1, rd_0} = rd_i;
    assign var_value_o = var_value_0 | var_value_1;
    assign clause_o = clause_o_0 | clause_o_1;
    assign clause_len_o = {clause_len_o_1, clause_len_o_0};
    assign all_c_sat_o = all_c_sat_o_0 | all_c_sat_o_1;

    clause1 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause1_0 (
        .clk(clk),
        .rst(rst),

        .var_value_i(var_value_i),
        .var_value_o(var_value_0),

        .wr_i(wr_0),
        .rd_i(rd_0),
        .clause_i(clause_i),
        .clause_o(clause_o_0),
        .clause_len_i(clause_len_i),
        .clause_len_o(clause_len_o_0),

        .all_c_sat_o(all_c_sat_o_0),
        .apply_impl_i(apply_impl_i),
        .apply_bkt_i(apply_bkt_i)
        );

    clause1 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause1_1 (
        .clk(clk), 
        .rst(rst), 
        
        .var_value_i(var_value_i),
        .var_value_o(var_value_1),

        .wr_i(wr_1),
        .rd_i(rd_1),
        .clause_i(clause_i),
        .clause_o(clause_o_1),
        .clause_len_i(clause_len_i),
        .clause_len_o(clause_len_o_1),

        .all_c_sat_o(all_c_sat_o_1),
        .apply_impl_i(apply_impl_i),
        .apply_bkt_i(apply_bkt_i)
        );

endmodule
