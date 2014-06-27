`timescale 1ns/1ps

module test_clause1(input clk, input rst);

    /* --- 测试free_lit_count --- */
    task run();
        begin
            @(posedge clk);
                test_clause1_task();
        end
    endtask

    parameter NUM_VARS = 8;
    reg wr_i;
    reg [NUM_VARS*3-1:0] var_value_i;
    wire [NUM_VARS*3-1:0] var_value_o;
    reg [4:0] clause_len_i;
    wire [4:0] clause_len_o;
    reg apply_backtrack_i;

    clause1 #(
        .NUM_VARS(NUM_VARS)
    )
    clause1
    (
        .clk(clk),
        .rst(rst),
        .wr_i(wr_i),
        .var_value_i(var_value_i),
        .var_value_o(var_value_o),
        .clause_len_i(clause_len_i),
        .clause_len_o(clause_len_o),
        .apply_backtrack_i(apply_backtrack_i)
    );

    `include "../tb/class_clause_data.sv";
    class_clause_data #(8) cdata_i = new;
    class_clause_data #(8) cdata_o = new;

    /* --- 测试free_lit_count --- */
    task test_clause1_task();
        begin
            $display("test_clause1_task");
            var_value_i = 0;
            cdata_i.reset();

            @ (posedge clk);
                cdata_i.set_lits('{0, 1, 0, 2, 0, 2, 0, 0});
                cdata_i.set_imps('{0, 0, 0, 0, 0, 0, 0, 0});
                cdata_i.get(var_value_i);
                // $display("%b", var_value_i);
                wr_i = 1;

            @ (posedge clk);
                wr_i = 0;
                #1
                assert(clause1.clausesat_0 == 1);

            @ (posedge clk);
                cdata_i.reset();
                cdata_i.get(var_value_i);
                #1
                assert(clause1.freelitcnt_0 == 3);

            @ (posedge clk);
                cdata_i.set_lits('{0, 2, 0, 0, 0, 1, 0, 0});
                cdata_i.set_imps('{0, 0, 0, 0, 0, 0, 0, 0});
                cdata_i.get(var_value_i);
                #1
                assert(clause1.freelitcnt_0 == 1);
                assert(clause1.imp_drv_0 == 1);
                cdata_o.set_c(var_value_o);
                cdata_o.assert_lit(3, 3'b101);

            @ (posedge clk);
                cdata_i.set_value(3, 3'b111);
                cdata_i.get(var_value_i);
                #1
                assert(clause1.cclause_drv_0 == 1);
                cdata_o.set_c(var_value_o);
                cdata_o.assert_lit(1, 3'b110);
                cdata_o.assert_lit(3, 3'b111);
                cdata_o.assert_lit(5, 3'b110);
        end
    endtask

endmodule


module test_clause1_top;
    reg  clk;
    reg  rst;

    always #5 clk<=~clk;

    initial begin: init
        clk = 0;
        rst=0;
    end

    task reset();
        begin
            @(posedge clk);
                rst=0;
                clk=0;

            @(posedge clk);
                rst=1;
        end
    endtask

    test_clause1 test_clause1(
        .clk(clk),
        .rst(rst)
    );

    initial begin
        reset();
        test_clause1.run();
        $display("done");
    end
endmodule
