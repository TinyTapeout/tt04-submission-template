`timescale 1ns/1ns
// Q and Qn are circular so verilator can't optimize.
/* verilator lint_off UNOPTFLAT */
module sr_latch(s, r, q, qn);
    input s; // initial state 0
    input r; // initial state 1
    output reg q, qn;

always @(*) begin
  if (1) begin
     q <= ~(r | qn); 
     qn <= ~(s | q); 
  end
end

    //assign q = ~(r | qn);
    //assign qn = ~(s | q);
endmodule
