`include "sr_latch_gated.v"
module sr_latch_gated_tb;

// create test registers, then instantiate our module
reg clk; // the gate is a clock
reg s, r;     // we can modify registers as we please to simulate the inputs
reg q, q_not; // we can't modify these, because they are assigned in our module
sr_latch_gated latch(s, r, clk, q, q_not);

initial begin
    // for waveform analysis
    $dumpfile("sr_latch.vcd");
    $dumpvars(sr_latch_gated_tb);

    // case 1 (latch w/o state)
    s=0; r=0; #1;
    clk = 0; #1; clk = 1; #1;
    $display("s=%b, r=%b ==> q=%b, q_not=%b # should be undefined",
              s, r, q, q_not);
end

endmodule
