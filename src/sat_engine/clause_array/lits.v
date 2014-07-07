
/**
 *  该文件是使用gen_num_verilog.py生成的
 *  gen_num_verilog ../src/sat_engine/clause_array/lits.gen 8
 */

 
module lit8 #(
        parameter NUM_LITS = 8,
        parameter WIDTH_LVL   = 16
    )
    (
        input                           clk,
        input                           rst,
        
        input  [NUM_LITS*3-1 : 0]       var_value_i,
        output [NUM_LITS*3-1 : 0]       var_value_o,
        
        input  [NUM_LITS*WIDTH_LVL-1:0] var_lvl_i,
        input  [NUM_LITS*WIDTH_LVL-1:0] var_lvl_down_i,
        output [NUM_LITS*WIDTH_LVL-1:0] var_lvl_down_o,
        
        input                           wr_i,
        input  [NUM_LITS*2-1:0]         lit_i,
        output [NUM_LITS*2-1:0]         lit_o,
        
        input  [1 : 0]                  freelitcnt_pre,
        output [1 : 0]                  freelitcnt_next,
        
        input                           imp_drv_i,
        
        output                          cclause_o,
        input                           cclause_drv_i,
        
        output                          clausesat_o,
        
        //连接terminal cell
        input  [WIDTH_LVL-1:0]          max_lvl_i,
        output [WIDTH_LVL-1:0]          max_lvl_o
    );

    wire [NUM_LITS/2*3-1:0]           var_value_i_0,  var_value_i_1;
    wire [NUM_LITS/2*3-1:0]           var_value_o_0,  var_value_o_1;
    wire [NUM_LITS*WIDTH_LVL/2-1 : 0] var_lvl_i_0,    var_lvl_i_1;
    wire [NUM_LITS*WIDTH_LVL/2-1 : 0] var_lvl_down_i_0,    var_lvl_down_i_1;
    wire [NUM_LITS*WIDTH_LVL/2-1 : 0] var_lvl_down_o_0,    var_lvl_down_o_1;
    wire [WIDTH_LVL/2-1 : 0]          max_lvl_o_0,    max_lvl_o_1;
    wire [NUM_LITS/2*2-1:0]           lit_i_0,        lit_i_1;
    wire [NUM_LITS/2*2-1:0]           lit_o_0,        lit_o_1;
    wire [1:0]                        freelitcnt_0;
    wire                              imp_drv_0,      imp_drv_1;
    wire                              cclause_0,      cclause_1;
    wire                              clausesat_0,    clausesat_1;

    assign {var_value_i_1, var_value_i_0} = var_value_i;
    assign var_value_o = {var_value_o_1, var_value_o_0};
    
    assign {var_lvl_i_1, var_lvl_i_0} = var_lvl_i;
    assign {var_lvl_down_i_1, var_lvl_down_i_0} = var_lvl_down_i;
    assign var_lvl_down_o = {var_lvl_down_o_1, var_lvl_down_o_0};
    assign max_lvl_o = max_lvl_o_1 > max_lvl_o_0? max_lvl_o_1 : max_lvl_o_0;
    
    assign {lit_i_1, lit_i_0} = lit_i;
    assign lit_o = {lit_o_1, lit_o_0};
    
    assign clausesat_o = clausesat_1 | clausesat_0;
    assign cclause_o = cclause_1 | cclause_0;
    
    assign imp_drv_0 = imp_drv_i;
    assign imp_drv_1 = imp_drv_i;

    lit4 #(
        .WIDTH_LVL(WIDTH_LVL)
    )
    lit4_0(
        .clk            (clk),
        .rst            (rst),
        
        .var_value_i    (var_value_i_0),
        .var_value_o    (var_value_o_0),
        
        .var_lvl_i      (var_lvl_i_0),
        .var_lvl_down_i (var_lvl_down_i_0),
        .var_lvl_down_o (var_lvl_down_o_0),
        
        .wr_i           (wr_i),
        .lit_i          (lit_i_0),
        .lit_o          (lit_o_0),
        
        .freelitcnt_pre (freelitcnt_pre),
        .freelitcnt_next(freelitcnt_0),
        
        .imp_drv_i      (imp_drv_0),
        
        .cclause_o      (cclause_0),
        .cclause_drv_i  (cclause_drv_i),
        
        .clausesat_o    (clausesat_0),
        
        .max_lvl_i      (max_lvl_i),
        .max_lvl_o      (max_lvl_o_0)
        );

    lit4 #(
        .WIDTH_LVL(WIDTH_LVL)
    )
    lit4_1(
        .clk            (clk),
        .rst            (rst),
        
        .var_value_i    (var_value_i_1),
        .var_value_o    (var_value_o_1),
        
        .var_lvl_i      (var_lvl_i_1),
        .var_lvl_down_i (var_lvl_down_i_1),
        .var_lvl_down_o (var_lvl_down_o_1),
        
        .wr_i           (wr_i),
        .lit_i          (lit_i_1),
        .lit_o          (lit_o_1),
        
        .freelitcnt_pre (freelitcnt_0),
        .freelitcnt_next(freelitcnt_next),
        
        .imp_drv_i      (imp_drv_1),
        
        .cclause_o      (cclause_1),
        .cclause_drv_i  (cclause_drv_i),
        
        .clausesat_o    (clausesat_1),
        
        .max_lvl_i      (max_lvl_i),
        .max_lvl_o      (max_lvl_o_1)
        );
 
endmodule


 
module lit4 #(
        parameter NUM_LITS = 4,
        parameter WIDTH_LVL   = 16
    )
    (
        input                           clk,
        input                           rst,
        
        input  [NUM_LITS*3-1 : 0]       var_value_i,
        output [NUM_LITS*3-1 : 0]       var_value_o,
        
        input  [NUM_LITS*WIDTH_LVL-1:0] var_lvl_i,
        input  [NUM_LITS*WIDTH_LVL-1:0] var_lvl_down_i,
        output [NUM_LITS*WIDTH_LVL-1:0] var_lvl_down_o,
        
        input                           wr_i,
        input  [NUM_LITS*2-1:0]         lit_i,
        output [NUM_LITS*2-1:0]         lit_o,
        
        input  [1 : 0]                  freelitcnt_pre,
        output [1 : 0]                  freelitcnt_next,
        
        input                           imp_drv_i,
        
        output                          cclause_o,
        input                           cclause_drv_i,
        
        output                          clausesat_o,
        
        //连接terminal cell
        input  [WIDTH_LVL-1:0]          max_lvl_i,
        output [WIDTH_LVL-1:0]          max_lvl_o
    );

    wire [NUM_LITS/2*3-1:0]           var_value_i_0,  var_value_i_1;
    wire [NUM_LITS/2*3-1:0]           var_value_o_0,  var_value_o_1;
    wire [NUM_LITS*WIDTH_LVL/2-1 : 0] var_lvl_i_0,    var_lvl_i_1;
    wire [NUM_LITS*WIDTH_LVL/2-1 : 0] var_lvl_down_i_0,    var_lvl_down_i_1;
    wire [NUM_LITS*WIDTH_LVL/2-1 : 0] var_lvl_down_o_0,    var_lvl_down_o_1;
    wire [WIDTH_LVL/2-1 : 0]          max_lvl_o_0,    max_lvl_o_1;
    wire [NUM_LITS/2*2-1:0]           lit_i_0,        lit_i_1;
    wire [NUM_LITS/2*2-1:0]           lit_o_0,        lit_o_1;
    wire [1:0]                        freelitcnt_0;
    wire                              imp_drv_0,      imp_drv_1;
    wire                              cclause_0,      cclause_1;
    wire                              clausesat_0,    clausesat_1;

    assign {var_value_i_1, var_value_i_0} = var_value_i;
    assign var_value_o = {var_value_o_1, var_value_o_0};
    
    assign {var_lvl_i_1, var_lvl_i_0} = var_lvl_i;
    assign {var_lvl_down_i_1, var_lvl_down_i_0} = var_lvl_down_i;
    assign var_lvl_down_o = {var_lvl_down_o_1, var_lvl_down_o_0};
    assign max_lvl_o = max_lvl_o_1 > max_lvl_o_0? max_lvl_o_1 : max_lvl_o_0;
    
    assign {lit_i_1, lit_i_0} = lit_i;
    assign lit_o = {lit_o_1, lit_o_0};
    
    assign clausesat_o = clausesat_1 | clausesat_0;
    assign cclause_o = cclause_1 | cclause_0;
    
    assign imp_drv_0 = imp_drv_i;
    assign imp_drv_1 = imp_drv_i;

    lit2 #(
        .WIDTH_LVL(WIDTH_LVL)
    )
    lit2_0(
        .clk            (clk),
        .rst            (rst),
        
        .var_value_i    (var_value_i_0),
        .var_value_o    (var_value_o_0),
        
        .var_lvl_i      (var_lvl_i_0),
        .var_lvl_down_i (var_lvl_down_i_0),
        .var_lvl_down_o (var_lvl_down_o_0),
        
        .wr_i           (wr_i),
        .lit_i          (lit_i_0),
        .lit_o          (lit_o_0),
        
        .freelitcnt_pre (freelitcnt_pre),
        .freelitcnt_next(freelitcnt_0),
        
        .imp_drv_i      (imp_drv_0),
        
        .cclause_o      (cclause_0),
        .cclause_drv_i  (cclause_drv_i),
        
        .clausesat_o    (clausesat_0),
        
        .max_lvl_i      (max_lvl_i),
        .max_lvl_o      (max_lvl_o_0)
        );

    lit2 #(
        .WIDTH_LVL(WIDTH_LVL)
    )
    lit2_1(
        .clk            (clk),
        .rst            (rst),
        
        .var_value_i    (var_value_i_1),
        .var_value_o    (var_value_o_1),
        
        .var_lvl_i      (var_lvl_i_1),
        .var_lvl_down_i (var_lvl_down_i_1),
        .var_lvl_down_o (var_lvl_down_o_1),
        
        .wr_i           (wr_i),
        .lit_i          (lit_i_1),
        .lit_o          (lit_o_1),
        
        .freelitcnt_pre (freelitcnt_0),
        .freelitcnt_next(freelitcnt_next),
        
        .imp_drv_i      (imp_drv_1),
        
        .cclause_o      (cclause_1),
        .cclause_drv_i  (cclause_drv_i),
        
        .clausesat_o    (clausesat_1),
        
        .max_lvl_i      (max_lvl_i),
        .max_lvl_o      (max_lvl_o_1)
        );
 
endmodule


 
module lit2 #(
        parameter NUM_LITS = 2,
        parameter WIDTH_LVL   = 16
    )
    (
        input                           clk,
        input                           rst,
        
        input  [NUM_LITS*3-1 : 0]       var_value_i,
        output [NUM_LITS*3-1 : 0]       var_value_o,
        
        input  [NUM_LITS*WIDTH_LVL-1:0] var_lvl_i,
        input  [NUM_LITS*WIDTH_LVL-1:0] var_lvl_down_i,
        output [NUM_LITS*WIDTH_LVL-1:0] var_lvl_down_o,
        
        input                           wr_i,
        input  [NUM_LITS*2-1:0]         lit_i,
        output [NUM_LITS*2-1:0]         lit_o,
        
        input  [1 : 0]                  freelitcnt_pre,
        output [1 : 0]                  freelitcnt_next,
        
        input                           imp_drv_i,
        
        output                          cclause_o,
        input                           cclause_drv_i,
        
        output                          clausesat_o,
        
        //连接terminal cell
        input  [WIDTH_LVL-1:0]          max_lvl_i,
        output [WIDTH_LVL-1:0]          max_lvl_o
    );

    wire [NUM_LITS/2*3-1:0]           var_value_i_0,  var_value_i_1;
    wire [NUM_LITS/2*3-1:0]           var_value_o_0,  var_value_o_1;
    wire [NUM_LITS*WIDTH_LVL/2-1 : 0] var_lvl_i_0,    var_lvl_i_1;
    wire [NUM_LITS*WIDTH_LVL/2-1 : 0] var_lvl_down_i_0,    var_lvl_down_i_1;
    wire [NUM_LITS*WIDTH_LVL/2-1 : 0] var_lvl_down_o_0,    var_lvl_down_o_1;
    wire [WIDTH_LVL/2-1 : 0]          max_lvl_o_0,    max_lvl_o_1;
    wire [NUM_LITS/2*2-1:0]           lit_i_0,        lit_i_1;
    wire [NUM_LITS/2*2-1:0]           lit_o_0,        lit_o_1;
    wire [1:0]                        freelitcnt_0;
    wire                              imp_drv_0,      imp_drv_1;
    wire                              cclause_0,      cclause_1;
    wire                              clausesat_0,    clausesat_1;

    assign {var_value_i_1, var_value_i_0} = var_value_i;
    assign var_value_o = {var_value_o_1, var_value_o_0};
    
    assign {var_lvl_i_1, var_lvl_i_0} = var_lvl_i;
    assign {var_lvl_down_i_1, var_lvl_down_i_0} = var_lvl_down_i;
    assign var_lvl_down_o = {var_lvl_down_o_1, var_lvl_down_o_0};
    assign max_lvl_o = max_lvl_o_1 > max_lvl_o_0? max_lvl_o_1 : max_lvl_o_0;
    
    assign {lit_i_1, lit_i_0} = lit_i;
    assign lit_o = {lit_o_1, lit_o_0};
    
    assign clausesat_o = clausesat_1 | clausesat_0;
    assign cclause_o = cclause_1 | cclause_0;
    
    assign imp_drv_0 = imp_drv_i;
    assign imp_drv_1 = imp_drv_i;

    lit1 #(
        .WIDTH_LVL(WIDTH_LVL)
    )
    lit1_0(
        .clk            (clk),
        .rst            (rst),
        
        .var_value_i    (var_value_i_0),
        .var_value_o    (var_value_o_0),
        
        .var_lvl_i      (var_lvl_i_0),
        .var_lvl_down_i (var_lvl_down_i_0),
        .var_lvl_down_o (var_lvl_down_o_0),
        
        .wr_i           (wr_i),
        .lit_i          (lit_i_0),
        .lit_o          (lit_o_0),
        
        .freelitcnt_pre (freelitcnt_pre),
        .freelitcnt_next(freelitcnt_0),
        
        .imp_drv_i      (imp_drv_0),
        
        .cclause_o      (cclause_0),
        .cclause_drv_i  (cclause_drv_i),
        
        .clausesat_o    (clausesat_0),
        
        .max_lvl_i      (max_lvl_i),
        .max_lvl_o      (max_lvl_o_0)
        );

    lit1 #(
        .WIDTH_LVL(WIDTH_LVL)
    )
    lit1_1(
        .clk            (clk),
        .rst            (rst),
        
        .var_value_i    (var_value_i_1),
        .var_value_o    (var_value_o_1),
        
        .var_lvl_i      (var_lvl_i_1),
        .var_lvl_down_i (var_lvl_down_i_1),
        .var_lvl_down_o (var_lvl_down_o_1),
        
        .wr_i           (wr_i),
        .lit_i          (lit_i_1),
        .lit_o          (lit_o_1),
        
        .freelitcnt_pre (freelitcnt_0),
        .freelitcnt_next(freelitcnt_next),
        
        .imp_drv_i      (imp_drv_1),
        
        .cclause_o      (cclause_1),
        .cclause_drv_i  (cclause_drv_i),
        
        .clausesat_o    (clausesat_1),
        
        .max_lvl_i      (max_lvl_i),
        .max_lvl_o      (max_lvl_o_1)
        );
 
endmodule

