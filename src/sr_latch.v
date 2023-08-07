`timescale 1ns/1ns
module sr_latch(s, r, q, qn);
    input s; // initial state 0
    input r; // initial state 1
    output wire q, qn;

// Converted from a nand-gate diagram of an SR latch.
/* verilator lint_off UNOPTFLAT */
/*
wire Q_int, Qn_int;
 
assign Q_int = ~(s & Qn_int);
assign Qn_int = ~(r & Q_int);
assign q = Q_int;
assign qn = Qn_int;
*/

wire a, b;
nand(a, s, b);
nand(b, r, a);

assign q = a;
assign qn = b;

endmodule
