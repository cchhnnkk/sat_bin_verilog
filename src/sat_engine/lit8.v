module lit8 #(
              parameter NUM_LITS = 8
              )
    (
        input                     clk,
        input                     rst,

        input [NUM_LITS*3-1 : 0]  var_value_i,
        output [NUM_LITS*3-1 : 0] var_value_o,

        input                     wr_i,
        input [NUM_LITS*2-1:0]    lit_i,
        output [NUM_LITS*2-1:0]   lit_o,

        input [1 : 0]             freelitcnt_pre,
        output [1 : 0]            freelitcnt_next,

        input                     imp_drv_i,

        output                    cclause_o,
        input                     cclause_drv_i,

        output                    clausesat_o
    );

    wire [NUM_LITS/2*3-1:0]    var_value_0, var_value_1;
    wire [NUM_LITS/2*3-1:0]    var_value_0, var_value_1;
    wire [NUM_LITS/2*2-1:0]    lit_i_0, lit_i_1;
    wire [NUM_LITS/2*2-1:0]    lit_o_0, lit_o_1;
    wire [1:0]                 freelitcnt_0;
    wire                       imp_drv_0, imp_drv_1;
    wire                       cclause_0, cclause_1;
    wire                       clausesat_0, clausesat_1;

    assign {var_value_0,var_value_1} = var_value_i;
    assign var_value_o = {var_value_0, var_value_1};

    assign {lit_i_0, lit_i_1} = lit_i;
    assign lit_o = {lit_o_0, lit_o_1};

    assign clausesat_o = clausesat_0 | clausesat_1;
    assign cclause_o = cclause_0 | cclause_1;

    assign imp_drv_0 = imp_drv_i;
    assign imp_drv_1 = imp_drv_i;

    lit4 lit4_0(
                .clk(clk),
                .rst(rst),

                .var_value_i(var_value_i_0),
                .var_value_o(var_value_o_0),

                .wr_i(wr_i),
                .lit_i(lit_i_0),
                .lit_o(lit_o_0),

                .freelitcnt_pre(freelitcnt_pre),
                .freelitcnt_next(freelitcnt_0),

                .imp_drv_i(imp_drv_0),

                .cclause_o(cclause_0),
                .cclause_drv_i(cclause_drv_i),

                .clausesat_o(clausesat_0)
                );

    lit4 lit4_1(
                .clk(clk),
                .rst(rst),

                .var_value_i(var_value_i_1),
                .var_value_o(var_value_o_1),

                .wr_i(wr_i),
                .lit_i(lit_i_1),
                .lit_o(lit_o_1),

                .freelitcnt_pre(freelitcnt_0),
                .freelitcnt_next(freelitcnt_next),

                .imp_drv_i(imp_drv_1),

                .cclause_o(cclause_1),
                .cclause_drv_i(cclause_drv_i),

                .clausesat_o(clausesat_1)
                );

endmodule
