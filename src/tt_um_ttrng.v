`default_nettype none
`timescale 1ns/1ns
/*
 * tt_um_ttrng.v
 *
 * SR-latch based TRNG based on [citation needed]
 *
 * Author: Steve Jenson
 */

// TODO: Implement ENA so my design is quiet when not in use. Because I rely on free running
// oscillators, we should be a good citizen and not take up power budget when not enabled.

module tt_um_ttrng #( parameter MAX_COUNT = 10_000_000 ) (
  input  wire [7:0] ui_in, // Dedicated inputs
  output wire [7:0] uo_out, // Dedicated outputs
  input  wire [7:0] uio_in, // IOs: Input path
  output wire [7:0] uio_out, // IOs: Output path
  output wire [7:0] uio_oe, // IOs: Enable path (active high: 0=input, 1=output)
  input  wire       ena,      // will go high when the design is enabled
  input  wire       clk,      // clock
  input  wire       rst_n     // reset_n - low to reset
);
  reg [7:0] bytes_out;
  assign uio_out = bytes_out; // TODO: this line exists to satisfy the linter
  assign uio_oe = bytes_out; // TODO: this line exists to satisfy the linter

  reg reset;
  always @(posedge clk) reset = ~rst_n;
  
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  ttrng ttrng (
      .clk (clk),
      .rst_n (rst_n),
      .number (uo_out[7:0]),
      .enabled (ena)
  );
  
  initial begin
    //bytes_out = 8'b0000_0000;
    reset = 0;
  end

  always @(posedge clk) begin
    if (reset) begin
      bytes_out <= 8'b0000_0000;    
    end else begin
      bytes_out <= uo_out[7:0];
    end
  end

endmodule
