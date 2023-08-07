`timescale 1ns/1ns
module d_flip_flop(d, clk, q, rst_n);
  input wire d, clk, rst_n;
  output reg q;

  reg reset;

  initial begin
    q = 1'b0;
  end

  always @(posedge clk) begin
    reset = ~rst_n;
        if (reset) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end 
endmodule
