
/**
 *  该文件是使用gen_num_verilog.py生成的
 *  gen_num_verilog ../src/sat_engine/clause_array/clauses.gen 8
 */
module clause8 #(
        parameter NUM_CLAUSES = 8,
        parameter NUM_VARS    = 8,
        parameter WIDTH_LVL   = 16,
        parameter WIDTH_C_LEN = 4
    )
    (
        input                                  clk,
        input                                  rst,
        
        //data I/O
        input  [NUM_VARS*3-1:0]                var_value_i,
        input  [NUM_VARS*3-1:0]                var_value_down_i,
        output [NUM_VARS*3-1:0]                var_value_down_o,
        
        //用于推理时求得剩余最大lvl
        input  [NUM_VARS*WIDTH_LVL-1:0]        var_lvl_i,
        input  [NUM_VARS*WIDTH_LVL-1:0]        var_lvl_down_i,
        output [NUM_VARS*WIDTH_LVL-1:0]        var_lvl_down_o,
        
        //load update
        input  [NUM_CLAUSES-1:0]               wr_i,
        input  [NUM_CLAUSES-1:0]               rd_i,
        input  [NUM_VARS*2-1 : 0]              clause_i,
        output [NUM_VARS*2-1 : 0]              clause_o,
        input  [WIDTH_C_LEN-1 : 0]             clause_len_i,
        output [WIDTH_C_LEN*NUM_CLAUSES-1 : 0] clause_len_o,
        
        //ctrl
        output                                 all_c_sat_o,
        input                                  apply_imply_i,
        input                                  apply_analyze_i,
        input                                  apply_bkt_i,

        //用于调试的信号
        input  [31 : 0]                        debug_cid_down_i,
        output [31 : 0]                        debug_cid_down_o
    );

    wire [NUM_CLAUSES/2-1:0]                wr_0, wr_1;
    wire [NUM_CLAUSES/2-1:0]                rd_0, rd_1;
    wire [3*NUM_VARS-1:0]                   var_value_temp;
    wire [NUM_VARS*WIDTH_LVL-1 : 0]         var_lvl_temp;
    wire [31 : 0]                           debug_cid_temp;
    wire [NUM_VARS*2-1 : 0]                 clause_o_0, clause_o_1;
    wire [WIDTH_C_LEN*NUM_CLAUSES/2-1 : 0]  clause_len_o_0, clause_len_o_1;
    wire                                    all_c_sat_o_0, all_c_sat_o_1;

    assign {wr_1, wr_0} = wr_i;
    assign {rd_1, rd_0} = rd_i;
    assign clause_o     = clause_o_1 | clause_o_0;
    assign clause_len_o = {clause_len_o_1, clause_len_o_0};
    assign all_c_sat_o  = all_c_sat_o_1 & all_c_sat_o_0;

    clause4 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause4_0 (
        .clk             (clk),
        .rst             (rst),
        
        .var_value_i     (var_value_i),
        .var_value_down_i(var_value_down_i),
        .var_value_down_o(var_value_temp),
        
        .var_lvl_i       (var_lvl_i),
        .var_lvl_down_i  (var_lvl_down_i),
        .var_lvl_down_o  (var_lvl_temp),
        
        .wr_i            (wr_0),
        .rd_i            (rd_0),
        .clause_i        (clause_i),
        .clause_o        (clause_o_0),
        .clause_len_i    (clause_len_i),
        .clause_len_o    (clause_len_o_0),
        
        .all_c_sat_o     (all_c_sat_o_0),
        .apply_imply_i   (apply_imply_i),
        .apply_analyze_i (apply_analyze_i),
        .apply_bkt_i     (apply_bkt_i),

        .debug_cid_down_i(debug_cid_down_i),
        .debug_cid_down_o(debug_cid_temp)
        );

    clause4 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause4_1 (
        .clk             (clk), 
        .rst             (rst), 
        
        .var_value_i     (var_value_i),
        .var_value_down_i(var_value_temp),
        .var_value_down_o(var_value_down_o),
        
        .var_lvl_i       (var_lvl_i),
        .var_lvl_down_i  (var_lvl_temp),
        .var_lvl_down_o  (var_lvl_down_o),
        
        .wr_i            (wr_1),
        .rd_i            (rd_1),
        .clause_i        (clause_i),
        .clause_o        (clause_o_1),
        .clause_len_i    (clause_len_i),
        .clause_len_o    (clause_len_o_1),
        
        .all_c_sat_o     (all_c_sat_o_1),
        .apply_imply_i   (apply_imply_i),
        .apply_analyze_i (apply_analyze_i),
        .apply_bkt_i     (apply_bkt_i),

        .debug_cid_down_i(debug_cid_temp),
        .debug_cid_down_o(debug_cid_down_o)
        );

endmodule

module clause4 #(
        parameter NUM_CLAUSES = 4,
        parameter NUM_VARS    = 8,
        parameter WIDTH_LVL   = 16,
        parameter WIDTH_C_LEN = 4
    )
    (
        input                                  clk,
        input                                  rst,
        
        //data I/O
        input  [NUM_VARS*3-1:0]                var_value_i,
        input  [NUM_VARS*3-1:0]                var_value_down_i,
        output [NUM_VARS*3-1:0]                var_value_down_o,
        
        //用于推理时求得剩余最大lvl
        input  [NUM_VARS*WIDTH_LVL-1:0]        var_lvl_i,
        input  [NUM_VARS*WIDTH_LVL-1:0]        var_lvl_down_i,
        output [NUM_VARS*WIDTH_LVL-1:0]        var_lvl_down_o,
        
        //load update
        input  [NUM_CLAUSES-1:0]               wr_i,
        input  [NUM_CLAUSES-1:0]               rd_i,
        input  [NUM_VARS*2-1 : 0]              clause_i,
        output [NUM_VARS*2-1 : 0]              clause_o,
        input  [WIDTH_C_LEN-1 : 0]             clause_len_i,
        output [WIDTH_C_LEN*NUM_CLAUSES-1 : 0] clause_len_o,
        
        //ctrl
        output                                 all_c_sat_o,
        input                                  apply_imply_i,
        input                                  apply_analyze_i,
        input                                  apply_bkt_i,

        //用于调试的信号
        input  [31 : 0]                        debug_cid_down_i,
        output [31 : 0]                        debug_cid_down_o
    );

    wire [NUM_CLAUSES/2-1:0]                wr_0, wr_1;
    wire [NUM_CLAUSES/2-1:0]                rd_0, rd_1;
    wire [3*NUM_VARS-1:0]                   var_value_temp;
    wire [NUM_VARS*WIDTH_LVL-1 : 0]         var_lvl_temp;
    wire [31 : 0]                           debug_cid_temp;
    wire [NUM_VARS*2-1 : 0]                 clause_o_0, clause_o_1;
    wire [WIDTH_C_LEN*NUM_CLAUSES/2-1 : 0]  clause_len_o_0, clause_len_o_1;
    wire                                    all_c_sat_o_0, all_c_sat_o_1;

    assign {wr_1, wr_0} = wr_i;
    assign {rd_1, rd_0} = rd_i;
    assign clause_o     = clause_o_1 | clause_o_0;
    assign clause_len_o = {clause_len_o_1, clause_len_o_0};
    assign all_c_sat_o  = all_c_sat_o_1 & all_c_sat_o_0;

    clause2 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause2_0 (
        .clk             (clk),
        .rst             (rst),
        
        .var_value_i     (var_value_i),
        .var_value_down_i(var_value_down_i),
        .var_value_down_o(var_value_temp),
        
        .var_lvl_i       (var_lvl_i),
        .var_lvl_down_i  (var_lvl_down_i),
        .var_lvl_down_o  (var_lvl_temp),
        
        .wr_i            (wr_0),
        .rd_i            (rd_0),
        .clause_i        (clause_i),
        .clause_o        (clause_o_0),
        .clause_len_i    (clause_len_i),
        .clause_len_o    (clause_len_o_0),
        
        .all_c_sat_o     (all_c_sat_o_0),
        .apply_imply_i   (apply_imply_i),
        .apply_analyze_i (apply_analyze_i),
        .apply_bkt_i     (apply_bkt_i),

        .debug_cid_down_i(debug_cid_down_i),
        .debug_cid_down_o(debug_cid_temp)
        );

    clause2 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause2_1 (
        .clk             (clk), 
        .rst             (rst), 
        
        .var_value_i     (var_value_i),
        .var_value_down_i(var_value_temp),
        .var_value_down_o(var_value_down_o),
        
        .var_lvl_i       (var_lvl_i),
        .var_lvl_down_i  (var_lvl_temp),
        .var_lvl_down_o  (var_lvl_down_o),
        
        .wr_i            (wr_1),
        .rd_i            (rd_1),
        .clause_i        (clause_i),
        .clause_o        (clause_o_1),
        .clause_len_i    (clause_len_i),
        .clause_len_o    (clause_len_o_1),
        
        .all_c_sat_o     (all_c_sat_o_1),
        .apply_imply_i   (apply_imply_i),
        .apply_analyze_i (apply_analyze_i),
        .apply_bkt_i     (apply_bkt_i),

        .debug_cid_down_i(debug_cid_temp),
        .debug_cid_down_o(debug_cid_down_o)
        );

endmodule

module clause2 #(
        parameter NUM_CLAUSES = 2,
        parameter NUM_VARS    = 8,
        parameter WIDTH_LVL   = 16,
        parameter WIDTH_C_LEN = 4
    )
    (
        input                                  clk,
        input                                  rst,
        
        //data I/O
        input  [NUM_VARS*3-1:0]                var_value_i,
        input  [NUM_VARS*3-1:0]                var_value_down_i,
        output [NUM_VARS*3-1:0]                var_value_down_o,
        
        //用于推理时求得剩余最大lvl
        input  [NUM_VARS*WIDTH_LVL-1:0]        var_lvl_i,
        input  [NUM_VARS*WIDTH_LVL-1:0]        var_lvl_down_i,
        output [NUM_VARS*WIDTH_LVL-1:0]        var_lvl_down_o,
        
        //load update
        input  [NUM_CLAUSES-1:0]               wr_i,
        input  [NUM_CLAUSES-1:0]               rd_i,
        input  [NUM_VARS*2-1 : 0]              clause_i,
        output [NUM_VARS*2-1 : 0]              clause_o,
        input  [WIDTH_C_LEN-1 : 0]             clause_len_i,
        output [WIDTH_C_LEN*NUM_CLAUSES-1 : 0] clause_len_o,
        
        //ctrl
        output                                 all_c_sat_o,
        input                                  apply_imply_i,
        input                                  apply_analyze_i,
        input                                  apply_bkt_i,

        //用于调试的信号
        input  [31 : 0]                        debug_cid_down_i,
        output [31 : 0]                        debug_cid_down_o
    );

    wire [NUM_CLAUSES/2-1:0]                wr_0, wr_1;
    wire [NUM_CLAUSES/2-1:0]                rd_0, rd_1;
    wire [3*NUM_VARS-1:0]                   var_value_temp;
    wire [NUM_VARS*WIDTH_LVL-1 : 0]         var_lvl_temp;
    wire [31 : 0]                           debug_cid_temp;
    wire [NUM_VARS*2-1 : 0]                 clause_o_0, clause_o_1;
    wire [WIDTH_C_LEN*NUM_CLAUSES/2-1 : 0]  clause_len_o_0, clause_len_o_1;
    wire                                    all_c_sat_o_0, all_c_sat_o_1;

    assign {wr_1, wr_0} = wr_i;
    assign {rd_1, rd_0} = rd_i;
    assign clause_o     = clause_o_1 | clause_o_0;
    assign clause_len_o = {clause_len_o_1, clause_len_o_0};
    assign all_c_sat_o  = all_c_sat_o_1 & all_c_sat_o_0;

    clause1 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause1_0 (
        .clk             (clk),
        .rst             (rst),
        
        .var_value_i     (var_value_i),
        .var_value_down_i(var_value_down_i),
        .var_value_down_o(var_value_temp),
        
        .var_lvl_i       (var_lvl_i),
        .var_lvl_down_i  (var_lvl_down_i),
        .var_lvl_down_o  (var_lvl_temp),
        
        .wr_i            (wr_0),
        .rd_i            (rd_0),
        .clause_i        (clause_i),
        .clause_o        (clause_o_0),
        .clause_len_i    (clause_len_i),
        .clause_len_o    (clause_len_o_0),
        
        .all_c_sat_o     (all_c_sat_o_0),
        .apply_imply_i   (apply_imply_i),
        .apply_analyze_i (apply_analyze_i),
        .apply_bkt_i     (apply_bkt_i),

        .debug_cid_down_i(debug_cid_down_i),
        .debug_cid_down_o(debug_cid_temp)
        );

    clause1 #(
        .NUM_VARS(NUM_VARS),
        .WIDTH_C_LEN(WIDTH_C_LEN)
        )
    clause1_1 (
        .clk             (clk), 
        .rst             (rst), 
        
        .var_value_i     (var_value_i),
        .var_value_down_i(var_value_temp),
        .var_value_down_o(var_value_down_o),
        
        .var_lvl_i       (var_lvl_i),
        .var_lvl_down_i  (var_lvl_temp),
        .var_lvl_down_o  (var_lvl_down_o),
        
        .wr_i            (wr_1),
        .rd_i            (rd_1),
        .clause_i        (clause_i),
        .clause_o        (clause_o_1),
        .clause_len_i    (clause_len_i),
        .clause_len_o    (clause_len_o_1),
        
        .all_c_sat_o     (all_c_sat_o_1),
        .apply_imply_i   (apply_imply_i),
        .apply_analyze_i (apply_analyze_i),
        .apply_bkt_i     (apply_bkt_i),

        .debug_cid_down_i(debug_cid_temp),
        .debug_cid_down_o(debug_cid_down_o)
        );

endmodule

