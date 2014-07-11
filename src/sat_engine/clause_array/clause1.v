module clause1 #(
        parameter NUM_VARS    = 8,
        parameter NUM_CLAUSES = 1,
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
        input                                  apply_bkt_i
    );

    wire [1:0]                     freelitcnt;
    wire                           imp_drv;
    wire                           conflict_c;
    wire                           conflict_c_drv;
    wire                           csat_from_lits, csat_from_term;
    wire [NUM_VARS*2-1 : 0]        clause_lits;
    wire [WIDTH_LVL-1:0]           cmax_lvl_from_term, cmax_lvl_from_lits;

    lit8 lit8(
        .clk             (clk),
        .rst             (rst),
        
        .var_value_i     (var_value_i),
        .var_value_down_i(var_value_down_i),
        .var_value_down_o(var_value_down_o),
        
        .var_lvl_i       (var_lvl_i),
        .var_lvl_down_i  (var_lvl_down_i),
        .var_lvl_down_o  (var_lvl_down_o),
        
        .cmax_lvl_i      (cmax_lvl_from_term),
        .cmax_lvl_o      (cmax_lvl_from_lits),
        
        .wr_i            (wr_i),
        .lit_i           (clause_i),
        .lit_o           (clause_lits),
        
        .freelitcnt_pre  (0),
        .freelitcnt_next (freelitcnt),
        
        .imp_drv_i       (imp_drv),
        
        .conflict_c_o    (conflict_c),
        .conflict_c_drv_i(conflict_c_drv),
        
        .csat_o          (csat_from_lits),
        .csat_drv_i      (csat_from_term),
        
        .apply_imply_i   (apply_imply_i),
        .apply_analyze_i (apply_analyze_i),
        .apply_bkt_i     (apply_bkt_i)
    );

    assign clause_o = rd_i? clause_lits : 0;

    wire   conflict_c_drv_o;
    assign conflict_c_drv=conflict_c_drv_o;

    terminal_cell #(
        .WIDTH_LVL(WIDTH_LVL)
    )
    terminal_cell(
        .clk             (clk),
        .rst             (rst),
        .csat_i          (csat_from_lits),
        .csat_drv_o      (csat_from_term),
        .freelitcnt_i    (freelitcnt),
        .imp_drv_o       (imp_drv),
        .conflict_c_i    (conflict_c),
        .conflict_c_drv_o(conflict_c_drv_o),
        .cmax_lvl_i      (cmax_lvl_from_lits),
        .cmax_lvl_o      (cmax_lvl_from_term)
    );

    reg                            need_clear;
    reg                            is_reason_r;

    always @(posedge clk) begin: set_need_clear
        if(~rst)
            need_clear <= 0;
        else if(is_reason_r && conflict_c_drv_o)
            need_clear <= 1;
        else if(~is_reason_r)
            need_clear <= 0;
        else
            need_clear <= need_clear;
    end

    always @(posedge clk) begin: set_is_reason_r
        if(~rst)
            is_reason_r <= 0;
        else if(apply_imply_i && imp_drv)
            is_reason_r <= 1;
        else if(apply_bkt_i && need_clear)
            is_reason_r <= 0;
        else
            is_reason_r <= is_reason_r;
    end

    reg [WIDTH_C_LEN-1 : 0] clause_len_r;
    always @(posedge clk) begin: set_clause_len_r
        if(~rst)
            clause_len_r <= 0;
        else if(wr_i)
            clause_len_r <= clause_len_i;
        else
            clause_len_r <= clause_len_r;
    end
    //当该子句不是原因子句时，才将其长度输出
    assign clause_len_o = is_reason_r? 0:clause_len_r;

    assign all_c_sat_o = csat_from_lits || clause_lits==0;
endmodule
