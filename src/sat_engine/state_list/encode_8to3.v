/**
 8-to-3 译码器
 */
module encode_8to3 #(
    parameter WIDTH_I = 8,
    parameter WIDTH_O = 3
)
(
    input [WIDTH_I-1 : 0]     data_i,
    output [WIDTH_O-1 : 0]    data_o
);

    case(data_i)
        1: data_o = 0;
        1<<1: data_o = 1;
        1<<2: data_o = 2;
        1<<3: data_o = 3;
        1<<4: data_o = 4;
        1<<5: data_o = 5;
        1<<6: data_o = 6;
        1<<7: data_o = 7;
    endcase

endmodule

