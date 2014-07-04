module terminal_cell #(
        parameter WIDTH_LVL   = 16
    )
    (
     input 		 clk,
     input 		 rst,

     input 		 clausesat_i,

     input [1:0] freelitcnt_i,

     output 	 imp_drv_o,

     input 		 cclause_i,
     output 	 cclause_drv_o,

     input [WIDTH_LVL-1:0]           max_lvl_i,
     output reg [WIDTH_LVL-1:0]      max_lvl_o
     );

    wire 		 clausesat;
    assign clausesat = clausesat_i;

    assign imp_drv_o = freelitcnt_i==2'b01;

    assign cclause_drv_o = |cclause_i;

    always @(posedge clk) begin
        if(~rst)
            max_lvl_o <= 0;
        else
            max_lvl_o <= max_lvl_i;
    end

endmodule
