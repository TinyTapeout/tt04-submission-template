`timescale 1ns/1ns
module sr_latch_gated(q, qn, g, s, r);
   output q, qn;
   input g, s, r;   

   wire s1;
   wire r1;
   
   and(s1, g, s);
   and(r1, g, r);   
   nor(qn, s1, q);
   nor(q, r1, qn);
endmodule