// file: sr_latch_tb.v
// Using a testbench to simulate our module
`timescale 1ns/1ns
`include "clocked_sr_latch.v"
module sr_latch_tb;

// create test registers, then instantiate our module
reg clk;
reg s, r;     // we can modify registers as we please to simulate the inputs
wire q, q_not; // we can't modify these, because they are assigned in our module
clocked_sr_latch latch(clk, s, r, q, q_not);

// not a verilog construct,
// just for the testbench
integer x;

initial begin
    clk = 0; #1; clk=1; #1;
    // for waveform analysis
    $dumpfile("sr_latch.vcd");
    $dumpvars(clk, s, r, q, q_not);

    // case 1 (latch w/o state)
    s=0; r=0; #1
    clk=1; #1; clk=0; #1;
    $display("s=%b, r=%b ==> q=%b, q_not=%b # should be undefined",
              s, r, q, q_not);

    // case 2 (reset)
    s=0; r=1; #1
    clk=1; #1; clk=0; #1;
    $display("s=%b, r=%b ==> q=%b, q_not=%b # reset, so q=0",
              s, r, q, q_not);

    // case 3 (set)
    clk=1; #1; clk=0; #1;
    s=1; r=0; #1
    $display("s=%b, r=%b ==> q=%b, q_not=%b # set, so q=1",
              s, r, q, q_not);

    // case 4 (latch with state)
    s=0; r=0; #1
    clk=1; #1; clk=0; #1;
    $display("s=%b, r=%b ==> q=%b, q_not=%b # latch, so q=q (keep state)",
              s, r, q, q_not);

    // case 5 (invalid state)
    s=1; r=1; #1
    clk=1; #1; clk=0; #1;
    $display("s=%b, r=%b ==> q=%b, q_not=%b # invalid state, so discount error",
              s, r, q, q_not);
end

endmodule