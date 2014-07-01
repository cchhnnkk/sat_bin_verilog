module clause1 #(
        parameter NUM_VARS = 8,
        parameter NUM_CLAUSES = 1,
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

    wire [1:0]                     freelitcnt;
    wire                           imp_drv;
    wire                           cclause;
    wire                           cclause_drv;
    wire                           clausesat;
    wire [NUM_VARS*2-1 : 0]        clause_lits;

    lit8 lit8(
        .clk(clk),
        .rst(rst),

        .var_value_i(var_value_i),
        .var_value_o(var_value_o),

        .wr_i(wr_i),
        .lit_i(clause_i),
        .lit_o(clause_lits),

        .freelitcnt_pre(0),
        .freelitcnt_next(freelitcnt),

        .imp_drv_i(imp_drv),

        .cclause_o(cclause),
        .cclause_drv_i(cclause_drv),

        .clausesat_o(clausesat)
    );

    assign clause_o = rd_i? clause_lits : 0;

    wire                           cclause_drv_o;
    assign cclause_drv=cclause_drv_o;

    terminal_cell terminal_cell(
        .clk(clk),
        .rst(rst),
        .clausesat_i(clausesat),
        .freelitcnt_i(freelitcnt),
        .imp_drv_o(imp_drv),
        .cclause_i(cclause),
        .cclause_drv_o(cclause_drv_o)
    );

    reg                            need_clear;
    reg                            is_reason_r;

    always @(posedge clk) begin: set_need_clear
        if(~rst)
            need_clear <= 0;
        else if(is_reason_r && cclause_drv_o)
            need_clear <= 1;
        else if(~is_reason_r)
            need_clear <= 0;
        else
            need_clear <= need_clear;
    end

    always @(posedge clk) begin: set_is_reason_r
        if(~rst)
            is_reason_r <= 0;
        else if(apply_impl_i && imp_drv)
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

    assign all_c_sat_o = clausesat;
endmodule
