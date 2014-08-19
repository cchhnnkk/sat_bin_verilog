`timescale 1ns/1ps

module bram_param #(
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 10,
    parameter DEPTH      = 1024
)
(
  clka,
  wea,
  addra,
  dina,
  douta,
  clkb,
  web,
  addrb,
  dinb,
  doutb
);

input clka;
input [0 : 0] wea;
input [ADDR_WIDTH-1 : 0] addra;
input [DATA_WIDTH-1 : 0] dina;
output reg [DATA_WIDTH-1 : 0] douta;
input clkb;
input [0 : 0] web;
input [ADDR_WIDTH-1 : 0] addrb;
input [DATA_WIDTH-1 : 0] dinb;
output reg [DATA_WIDTH-1 : 0] doutb;

reg [DATA_WIDTH-1:0] data[DEPTH];

reg[31:0] i;

initial
    for(i=0; i<DEPTH; i++)
        data[i] = 0;

always @(posedge clka) begin
    douta <= data[addra];
end

always @(posedge clka) begin
    if(wea==1)
        data[addra] = dina;
    if(web==1)
        data[addrb] = dinb;
end

always @(posedge clkb) begin
    doutb <= data[addrb];
end

int j;
task display(int istart, int iend);
    $display("\taddr:%1d-%1d", istart, iend-1);
    for(j=istart; j<iend; j++) begin
        $display("\t%6d:%b", j, data[j]);
    end
endtask

reg [2:0]     var_value;
reg [15:0]    var_lvl;
task display_vs(int istart, int iend);
    $display("\taddr:%1d-%1d", istart, iend-1);
    $display("\t%8s : %8s %8s", "addr", "value", "level");
    for(j=istart; j<iend; j++) begin
        {var_value, var_lvl} = data[j+1];
        $display("\t%8d : %8b %8d", j+1, var_value, var_lvl);
    end
endtask

reg [9:0] dcd_bin;
reg       has_bkt;
task display_ls(int istart, int iend);
    $display("\taddr:%1d-%1d", istart, iend-1);
    $display("\t%8s : %8s %8s", "addr", "dcd_bin", "has_bkt");
    for(j=istart; j<iend; j++) begin
        {dcd_bin, has_bkt} = data[j+1];
        $display("\t%8d : %8d %8d", j+1, dcd_bin, has_bkt);
    end
endtask

endmodule
