module clause2 #(
                 parameter NUM_CLAUSES_A_BIN = 2,
                 parameter NUM_VARS_A_BIN = 8,
                 parameter WIDTH_VAR_STATES = 30,
                 parameter WIDTH_C_LEN = 5
                 )
    (
     input                                        clk,
     input                                        rst,

     input [NUM_CLAUSES_A_BIN-1:0]                wr_i,
     input [NUM_VARS_A_BIN*3-1:0]                 var_value_frombase_i,
     output [NUM_VARS_A_BIN*3-1:0]                var_value_tobase_o,

     //用于find_learntc_index
     input [WIDTH_C_LEN-1 : 0]                    clause_len_i,
     output [WIDTH_C_LEN*NUM_CLAUSES_A_BIN-1 : 0] clause_len_o,
     input                                        apply_impl_i,
     input                                        apply_bkt_i
     );

    wire [NUM_CLAUSES_A_BIN/2-1:0]                wr_0, wr_1;
    assign {wr_1, wr_0} = wr_i;

    wire [3*NUM_VARS_A_BIN-1:0]                   var_value_tobase_0, var_value_tobase_1;

    assign var_value_tobase_o = var_value_tobase_0 | var_value_tobase_1;

    wire [WIDTH_C_LEN*NUM_CLAUSES_A_BIN/2-1 : 0]  clause_len_o_0, clause_len_o_1;
    assign clause_len_o = {clause_len_o_1, clause_len_o_0};

    clause1 #(
              .NUM_VARS_A_BIN(NUM_VARS_A_BIN),
              .WIDTH_C_LEN(WIDTH_C_LEN)
              )
    clause1_0 (
               .clk(clk),
               .rst(rst), 
               .wr_i(wr_0),
               .var_value_frombase_i(var_value_frombase_i),
               .var_value_tobase_o(var_value_tobase_0),

               .clause_len_i(clause_len_i),
               .clause_len_o(clause_len_o_0),
               .apply_impl_i(apply_impl_i),
               .apply_bkt_i(apply_bkt_i)
               );

    clause1 #(
              .NUM_VARS_A_BIN(NUM_VARS_A_BIN),
              .WIDTH_C_LEN(WIDTH_C_LEN)
              )
    clause1_1 (
               .clk(clk), 
               .rst(rst), 
               .wr_i(wr_1),
               .var_value_frombase_i(var_value_frombase_i),
               .var_value_tobase_o(var_value_tobase_1),

               .clause_len_i(clause_len_i),
               .clause_len_o(clause_len_o_1),
               .apply_impl_i(apply_impl_i),
               .apply_bkt_i(apply_bkt_i)
               );

endmodule
