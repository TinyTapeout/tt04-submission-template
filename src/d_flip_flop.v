module d_flip_flop(D, clk, Q);
  input D;
  input clk;
  output reg Q;

  always @(posedge clk) 
    begin
      Q <= D; 
    end 
endmodule
