`timescale 1ns/1ns
module sr_latch_network 
    #(parameter NUM_LATCHES=256) 
    (clk, enabled, b, rst_n);
input wire clk;
input wire rst_n;
input wire enabled;
output reg b; // our output bit
reg [64:0] wrote_output = 0; // perf counter

wire [NUM_LATCHES-1:0] qs;
/* verilator lint_off UNUSEDSIGNAL */
wire [NUM_LATCHES-1:0] dummy_qns;
reg xord_qs;
wire final_output;

// the initial reset state for an SR latch. is set to (r=clk, s=clk) on `enabled` for the
// non-deterministic behavior we're relying on for random numbers.
reg s = 0;
reg r = 1;

// For NUM_LATCHES, return a single bit of all latch values xor'd together into a buffer.
wire [NUM_LATCHES-1:0] latches;

genvar i;
generate
	for (i = 0; i < NUM_LATCHES; i = i + 1) begin
        sr_latch latch(.s(s), .r(r), .q(qs[i]), .qn(dummy_qns[i]));
	end
endgenerate

// Is a buffer appropiate here? do I need a dff?
buf buf0(final_output, xord_qs);

reg reset;

always @(posedge clk, negedge clk) begin
    s <= clk;
    r <= clk;

    reset <= ~rst_n;
    if (reset) begin
        b <= 0;
    end else begin
        // reduce qs to a single bit with xor.
        xord_qs <=^ qs;
        // buf0 holds the intermediate output in final_output
        b <= final_output;
        wrote_output <= wrote_output + 1;
    end
end

endmodule
