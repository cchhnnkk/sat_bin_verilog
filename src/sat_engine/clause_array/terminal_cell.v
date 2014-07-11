module terminal_cell #(
        parameter WIDTH_LVL   = 16
    )
    (
        input                  clk,
        input                  rst,
        
        input                  csat_i,
        output                 csat_drv_o,
        
        input  [1:0]           freelitcnt_i,
        
        output                 imp_drv_o,
        
        input                  conflict_c_i,
        output                 conflict_c_drv_o,
        
        input  [WIDTH_LVL-1:0] cmax_lvl_i,
        output [WIDTH_LVL-1:0] cmax_lvl_o
     );

    assign csat_drv_o = csat_i;

    assign imp_drv_o = freelitcnt_i==2'b01;

    assign conflict_c_drv_o = |conflict_c_i;

    //先用组合逻辑，后优化
    reg [WIDTH_LVL-1:0] cmax_lvl_w;
    assign cmax_lvl_o = cmax_lvl_w;

    always @(*) begin
        if(~rst)
            cmax_lvl_w <= 0;
        else
            cmax_lvl_w <= cmax_lvl_i;
    end

endmodule
