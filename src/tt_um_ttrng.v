module tt_um_ttrng(
    input wire sel1,
    input wire sel2,
    output reg[8] out
);

always @(posedge clk or negedge rst_n)
    out <= 8'b0000001;

endmodule