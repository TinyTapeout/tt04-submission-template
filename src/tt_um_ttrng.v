/*
 * tt_um_ttrng.v
 *
 * SR-latch based TRNG based on [citation needed]
 *
 * Author: Steve Jenson
 */


`default_nettype none

module tt_um_ttrng(
   	input  wire [7:0] ui_in,	// Dedicated inputs
	output wire [7:0] uo_out,	// Dedicated outputs
	input  wire [7:0] uio_in,	// IOs: Input path
	output wire [7:0] uio_out,	// IOs: Output path
	output wire [7:0] uio_oe,	// IOs: Enable path (active high: 0=input, 1=output)
	input  wire       ena,
	input  wire       clk,
	input  wire       rst_n
);

always @(posedge clk)        
    uio_out <= 8'b0000001;

endmodule