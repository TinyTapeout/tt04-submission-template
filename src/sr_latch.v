`timescale 1ns/1ns
module sr_latch(s, r, q, qn);
    input s; // initial state 0
    input r; // initial state 1
    output wire q, qn;

// Converted from a nand-gate diagram of an SR latch.
wire a, b;
nand(a, s, b);
nand(b, r, a);

assign q = a;
assign qn = b;
endmodule
