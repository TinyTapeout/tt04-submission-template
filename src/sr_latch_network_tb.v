`include "sr_latch_network.v"
`include "sr_latch.v"
`include "d_flip_flop.v"
module sr_latch_network_tb;

reg clk;
reg enabled;
reg rst_n;

wire bit0;
sr_latch_network latch0(.clk(clk), .enabled(enabled), .b(bit0), .rst_n(rst_n));

initial begin
    // for waveform analysis
    $dumpfile("sr_latch_network.vcd");
    $dumpvars(0, sr_latch_network_tb);
    enabled = 0; #5; enabled = 1;
    clk = 0; #5; clk = 1; #5;
    $display("latch0 %b", bit0);
    clk = 0; #5; clk = 1; #5;
    $display("latch0 %b", bit0);
end

endmodule
