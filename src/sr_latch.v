`timescale 1ns/1ns
/**
 * Designed to match Figure 4 of 'ASIC implementation of
 * random number generators using SR latches and its
 * evaluation'
 */
module sr_latch(s, r, q, qn);
    input s; // initial state 0
    input r; // initial state 1
    output wire q, qn;

/* verilator lint_off UNOPTFLAT */
wire a, b;

buf buf_q(q, a);
buf buf_qn(qn, b);

nand(a, s, b);
nand(b, r, a);

endmodule
