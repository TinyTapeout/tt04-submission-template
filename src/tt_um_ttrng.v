/*
 * tt_um_ttrng.v
 *
 * SR-latch based TRNG based on [citation needed]
 *
 * Author: Steve Jenson
 */


`default_nettype none

// TODO: Implement ENA so my design is quiet when not in use. Because I rely on free running
// oscillators, we should be a good citizen and not take up power budget when not enabled.

module tt_um_ttrng #( parameter MAX_COUNT = 10_000_000 ) (
	input  wire [7:0] ui_in,	// Dedicated inputs
	output wire [7:0] uo_out,	// Dedicated outputs
	input  wire [7:0] uio_in,	// IOs: Input path
	output wire [7:0] uio_out,	// IOs: Output path
	output wire [7:0] uio_oe,	// IOs: Enable path (active high: 0=input, 1=output)
	input  wire       ena,      // will go high when the design is enabled
	input  wire       clk,      // clock
	input  wire       rst_n     // reset_n - low to reset
);
	reg [7:0] bytes_out;
	assign uo_out = bytes_out;
	assign uio_out = bytes_out; // TODO: this line exists to satisfy the linter
	assign uio_oe = bytes_out; // TODO: this line exists to satisfy the linter

	always @(posedge clk) begin
		bytes_out <= 8'b0000001;
	end

endmodule