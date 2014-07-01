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

    reg [WIDTH_O-1 : 0]    data_r;
    assign data_o = data_r;
    
    always@(*)
    begin
        case(data_i)
            1: data_r = 0;
            1<<1: data_r = 1;
            1<<2: data_r = 2;
            1<<3: data_r = 3;
            1<<4: data_r = 4;
            1<<5: data_r = 5;
            1<<6: data_r = 6;
            1<<7: data_r = 7;
            default: data_r = 0;
        endcase
    end

endmodule

