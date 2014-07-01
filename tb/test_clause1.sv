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
    reg [NUM_VARS*2-1:0] clause_i;
    wire [NUM_VARS*2-1:0] clause_o;
    reg [4:0] clause_len_i;
    wire [4:0] clause_len_o;
    reg apply_bkt_i;

    clause1 #(
        .NUM_VARS(NUM_VARS)
    )
    clause1
    (
        .clk(clk),
        .rst(rst),
        .var_value_i(var_value_i),
        .var_value_o(var_value_o),

        .wr_i(wr_i),
        .clause_i(clause_i),
        .clause_o(clause_o),
        .clause_len_i(clause_len_i),
        .clause_len_o(clause_len_o),

        .apply_bkt_i(apply_bkt_i)
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
                cdata_i.display();
                cdata_i.get(var_value_i);
                cdata_i.get_clause(clause_i);
                $display("var_value_i = %b", var_value_i);
                $display("clause_i    = %b", clause_i);
                wr_i = 1;

            @ (posedge clk);
                wr_i = 0;
                #1
                assert(clause1.all_c_sat_o == 1);

            @ (posedge clk);
                cdata_i.reset();
                cdata_i.get(var_value_i);
                #1
                assert(clause1.freelitcnt == 3);

            @ (posedge clk);
                cdata_i.set_lits('{0, 2, 0, 0, 0, 1, 0, 0});
                cdata_i.set_imps('{0, 0, 0, 0, 0, 0, 0, 0});
                cdata_i.display();
                cdata_i.get(var_value_i);
                cdata_i.get_clause(clause_i);
                $display("var_value_i = %b", var_value_i);
                $display("clause_i    = %b", clause_i);
                #1
                assert(clause1.freelitcnt == 1);
                assert(clause1.imp_drv == 1);
                cdata_o.set(var_value_o);
                cdata_o.assert_index(3, 3'b101);

            @ (posedge clk);
                cdata_i.set_index(3, 3'b111);
                cdata_i.get(var_value_i);
                cdata_i.display();
                #1
                assert(clause1.cclause_drv == 1);
                cdata_o.set(var_value_o);
                cdata_o.display();
                cdata_o.assert_index(1, 3'b110);
                cdata_o.assert_index(3, 3'b111);
                cdata_o.assert_index(5, 3'b110);
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
