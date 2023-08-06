`timescale 1 ns/1 ns
`include "d_flip_flop.v"

module d_flip_flop_tb;

reg d;
wire q;
reg clk;
reg rst_n;

d_flip_flop d_flip_flop(.d(d), .clk(clk), .q(q), .rst_n(rst_n));

initial begin
    $dumpfile("d_flip_flop_tb.vcd");
    $dumpvars(0, d_flip_flop_tb);
    assign rst_n = 1'b1;
    assign d = 1'b0;
    assign clk = 1'b1; #20;
    assign clk = ~clk; #20;
    #20;
    $display("q should be 0: ", q);

    assign d = 1'b1;
    assign clk = 1'b1; #20;
    assign clk = ~clk; #20;
    #20;
    $display("q should be 1: ", q);

    assign d = 1'b0;
    assign clk = 1'b1; #20;
    assign clk = ~clk; #20
    #20;
    $display("q should be 0: ", q);
    assign d = 1'b1;
    assign clk = 1'b1; #20;
    assign clk = ~clk; #20;
    #20;
    $display("q should be 1: ", q);

    repeat (10) begin
        assign rst_n = 1;
        #20;
    end
    $display("Test is done");
end

endmodule
