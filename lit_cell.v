module lit_cell
    (
     input            clk,
     input            rst,

     input            wr_i,
     input [2:0]      var_value_frombase_i,
     output reg [2:0] var_value_tobase_o,

     input [1:0]      freelitcnt_pre,
     output reg [1:0] freelitcnt_next,

     input            imp_drv_i,

     output           cclause_o,
     input            cclause_drv_i,

     output           clausesat_o
     );

    reg [1:0]         lit_of_clause_r;
    reg               var_implied_r;

    wire              participate;
    assign participate = lit_of_clause_r[0] | lit_of_clause_r[1];

    wire              isfree;
    assign isfree = var_value_frombase_i[2:1]==2'b00;

    assign clausesat_o = participate && lit_of_clause_r==var_value_frombase_i[2:1];

    //free lit cnt
    always @(*) begin: set_free_lit_cnt
        if (participate && isfree) begin
            if(freelitcnt_pre==2'b00)
                freelitcnt_next = 2'b01;
            else
                freelitcnt_next = 2'b11;
        end
        else begin
            freelitcnt_next = freelitcnt_pre;
        end
    end


    // synthesis translate_off
    property p9;
        @(posedge clk) disable iff(~rst)
            (participate && isfree && freelitcnt_pre==2'b00)
            |->
                                                     freelitcnt_next == 2'b01;
    endproperty
    assert property(p9);
    // synthesis translate_on


    //find conflict
    assign cclause_o = participate && var_implied_r && var_value_frombase_i[2:1]==2'b11;

    //var, var_bar to base cell
    always @(*) begin: set_var_value_tobase
        if (participate && isfree && imp_drv_i)
            var_value_tobase_o[2:1] = lit_of_clause_r[1:0];
        else if(participate && cclause_drv_i)
            var_value_tobase_o[2:1] = 2'b11;
        else
            var_value_tobase_o[2:1] = 2'b00;
    end

    always @(*) begin: set_var_value_tobase_o_0
        if (participate && isfree && imp_drv_i)
            var_value_tobase_o[0] = 1;
        else
            var_value_tobase_o[0] = var_implied_r;
    end


    always @(posedge clk) begin: set_var_implied_r
        if (~rst)
            var_implied_r <= 0;
        else if (participate && isfree && imp_drv_i)
            var_implied_r <= 1;
        else
            var_implied_r <= var_implied_r;
    end

    always @(posedge clk) begin: set_lit_of_clause_r
        if (~rst)
            lit_of_clause_r <= 0;
        else if (wr_i)
            lit_of_clause_r <= var_value_frombase_i[2:1];
        else
            lit_of_clause_r <= lit_of_clause_r;
    end
endmodule
