`timescale 1ns/1ns
module ttrng (clk, rst_n, number, enabled);
input wire clk;
input wire rst_n;
input wire enabled;
output reg [7:0] number;
reg [31:0] cycles;

// For each bit in NUM_BITS, we generate a sr_latch_network of size NUM_LATCHES.
wire bit0;
sr_latch_network latch0(.clk(clk), .enabled(enabled), .b(bit0), .rst_n(rst_n));

wire bit1;
sr_latch_network latch1(.clk(clk), .enabled(enabled), .b(bit1), .rst_n(rst_n));

wire bit2;
sr_latch_network latch2(.clk(clk), .enabled(enabled), .b(bit2), .rst_n(rst_n));

wire bit3;
sr_latch_network latch3(.clk(clk), .enabled(enabled), .b(bit3), .rst_n(rst_n));

wire bit4;
sr_latch_network latch4(.clk(clk), .enabled(enabled), .b(bit4), .rst_n(rst_n));

wire bit5;
sr_latch_network latch5(.clk(clk), .enabled(enabled), .b(bit5), .rst_n(rst_n));

wire bit6;
sr_latch_network latch6(.clk(clk), .enabled(enabled), .b(bit6), .rst_n(rst_n));

wire bit7;
sr_latch_network latch7(.clk(clk), .enabled(enabled), .b(bit7), .rst_n(rst_n));

reg reset;
always @(posedge clk) begin
  reset <= ~rst_n;
end

initial begin
  cycles = 32'hFFFFFFFF;
  number = 8'b1010_1010; // 0xAA
end

always @(posedge clk) begin
  cycles <= cycles + 1'b1; // todo: ifdef for PERF
    if (reset) begin
      number <= 8'b0000_0000;
    end else begin
      number <= {bit7, bit6, bit5, bit4, bit3, bit2, bit1, bit0};
    end
end

endmodule
