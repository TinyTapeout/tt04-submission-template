
module top_trng(
    input clk,
    output PIO1_03, // output clk
    output PIO0_02,
    output PIO0_03,
    output PIO0_04,
    output PIO0_05,
    output PIO0_06,
    output PIO0_07,
    output PIO0_08,
    output PIO0_09);

// Using the tinytapeout names for clarity.
reg rst_n;
reg ena;
reg [7:0]uo_out;

// rst_n and ena permanently enabled for this demo.
assign rst_n = 1;
assign ena = 1;
assign PIO1_03 = clk;
assign {PIO0_02,PIO0_03,PIO0_04,PIO0_05,PIO0_06,PIO0_07,PIO0_08,PIO0_09} = uo_out;

  ttrng ttrng (
      .clk (clk),
      .rst_n (rst_n),
      .number (uo_out[7:0]),
      .enabled (ena)
  );

endmodule
