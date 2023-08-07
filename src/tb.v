//`default_nettype none
`timescale 1ns/1ns

module tb();

reg clk;
reg rst_n;
reg ena;
reg [7:0] ui_in;
reg [7:0] uio_in;
wire [7:0] uo_out;
wire [7:0] uio_out;
wire [7:0] uio_oe;

tt_um_ttrng tt_um_ttrng (
  `ifdef GL_TEST
    .VPWR( 1'b1),
    .VGND( 1'b0),
  `endif
    .ui_in      (ui_in),    // Dedicated inputs
    .uo_out     (uo_out),   // Dedicated outputs
    .uio_in     (uio_in),   // IOs: Input path
    .uio_out    (uio_out),  // IOs: Output path
    .uio_oe     (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
    .ena        (ena),      // enable - goes high when design is selected
    .clk        (clk),      // clock
    .rst_n      (rst_n)     // not reset
  );

initial begin

  // TODO
  // The latch network never comes out of s=0, r=0 caused by the initial clock pulse.
  // Ensure that our sr latches are initialized with s=0,r=1 for initial reset.
  // This might require us to start with S and R not being clk and then being set to clk
  // by the enabled state.

  $dumpfile ("tb.vcd");
  $dumpvars (0, tb);
  $display("going to start the test bench");
  rst_n = 1;
  $display("rst_n = 1");
  ena = 0; #5;
  clk = 0; #5;
  $display("Going to enable design.");
  // setting enabled freezes the design.
  ena = 1; clk = 1; #5; 
  $display("clk = 1");
  clk = 0; #5;
  $display("clk = 0");
  $display("drove the clock forward");
  $display("output currently: %b", uo_out);
  clk = 1; #5; clk = 0; #5;
  $display("now what's in the output: %b", uo_out);
	forever begin 
    clk=1; #5; clk=0; #5;
  end
end

initial begin
    #1000; $finish;
end

/*
  initial begin
    $monitor($time, clk);
    #10ns $finish;
  end
always #1 clk = ~clk;
/*
  initial begin
    rst_n <= 0;
    clk <= 0;
    repeat (10) @(posedge clk); 
    rst_n <= 1;
    
    repeat (25) @(posedge clk);
    rst_n <= 1;
    $finish;
    $display("Test complete");
  end
*/

endmodule
