`timescale 1 ns / 1 ns
`include "d_flip_flop.v"

module d_flip_flop_tb;

reg D;
wire Q;
reg clk;

d_flip_flop d_flip_flop(.D(D), .clk(clk), .Q(Q));

initial begin
    $dumpfile("d_flip_flop_tb.vcd");
    $dumpvars(0, d_flip_flop_tb);

    assign D = 0;
    assign clk = 1; #1;
    assign clk = 0; #1;
    #20;

    assign D = 1;
    assign clk = 1; #1;
    assign clk = 0; #1;
    #20;

    assign D = 0;
    assign clk = 1; #1;
    assign clk = 0; #1
    #20;

    assign D = 1;
    assign clk = 1; #1;
    assign clk = 0; #1;
    #20;

    $display("Q: ", Q);
    $display("Test is done");
end

endmodule
