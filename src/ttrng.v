`timescale 1ns/1ns
module ttrng #(parameter NUM_BITS=8) (clk, rst_n, number, enabled);
input wire clk;
input wire rst_n;
input wire enabled;
output reg [7:0] number;
reg [7:0] counter;
wire [7:0] bits;
wire [NUM_BITS-1:0] latches;

// For each bit in NUM_BITS, we generate a sr_latch_network of size NUM_LATCHES.
sr_latch_network latch0(.clk(clk), .enabled(enabled), .b(bits[0]), .rst_n(rst_n));
sr_latch_network latch1(.clk(clk), .enabled(enabled), .b(bits[1]), .rst_n(rst_n));
sr_latch_network latch2(.clk(clk), .enabled(enabled), .b(bits[2]), .rst_n(rst_n));
sr_latch_network latch3(.clk(clk), .enabled(enabled), .b(bits[3]), .rst_n(rst_n));
sr_latch_network latch4(.clk(clk), .enabled(enabled), .b(bits[4]), .rst_n(rst_n));
sr_latch_network latch5(.clk(clk), .enabled(enabled), .b(bits[5]), .rst_n(rst_n));
sr_latch_network latch6(.clk(clk), .enabled(enabled), .b(bits[6]), .rst_n(rst_n));
sr_latch_network latch7(.clk(clk), .enabled(enabled), .b(bits[7]), .rst_n(rst_n));

reg reset;
always @(posedge clk) begin
  reset <= ~rst_n;
end
// set this back to wire if you want assign to work.
//assign number = {bit7, bit6, bit5, bit4, bit3, bit2, bit1, bit0};
initial begin
  counter = 0;
  number = 8'b1010_1010; // 0xAA in hex, 170 in base-10
end

always @(posedge clk) begin
  // trying to see if I can get a counter to return in my testbench.
  if (reset) begin
    counter <= 10;
  end
  counter <= (counter + 1) % 8;
    if (reset) begin
      number <= 8'b0000_0100; // decimal 4 is a debugging marker
    end else begin
      number <= bits;
    end
end

endmodule
