`timescale 1ns/1ns
module clocked_sr_latch(clk, s, r, q, qn);
  input wire clk, s, r;
  output wire q, qn;
  wire i, j;
  nand #20 (i, clk, s);
  nand #20 (j, clk, r);
  nand #20 (qn, j, q);
  nand #20 (q, i, qn);
endmodule
