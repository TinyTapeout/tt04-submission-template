`timescale 1ns/1ns
module sr_latch_network(clk, enabled, b, rst_n);
input wire clk;
input wire rst_n;
input wire enabled;
output reg b; // our output bit.

wire [7:0] qs; // = 8'b0000_0000;
/* verilator lint_off UNUSEDSIGNAL */
wire [7:0] dummy_qns = 8'b0000_0000; // TODO: these wires are unused, can we elide?
reg xord_qs = 0;
wire final_output = 0;

// the initial reset state for an SR latch. is set to (r=clk, s=clk) on `enabled` for the
// non-deterministic behavior we're relying on for random numbers.
reg s = 0;
reg r = 1;

// For NUM_LATCHES, return a single bit of all latch values xor'd together into a DFF.
// the `always` block xors all the latches into the DFF the xor'ing happens in an always block.
sr_latch latch0(.s(s), .r(r), .q(qs[0]), .qn(dummy_qns[0]));
sr_latch latch1(.s(s), .r(r), .q(qs[1]), .qn(dummy_qns[1]));
sr_latch latch2(.s(s), .r(r), .q(qs[2]), .qn(dummy_qns[2]));
sr_latch latch3(.s(s), .r(r), .q(qs[3]), .qn(dummy_qns[3]));
sr_latch latch4(.s(s), .r(r), .q(qs[4]), .qn(dummy_qns[4]));
sr_latch latch5(.s(s), .r(r), .q(qs[5]), .qn(dummy_qns[5]));
sr_latch latch6(.s(s), .r(r), .q(qs[6]), .qn(dummy_qns[6]));
sr_latch latch7(.s(s), .r(r), .q(qs[7]), .qn(dummy_qns[7]));
d_flip_flop dff(.d(xord_qs), .clk(clk), .rst_n(rst_n), .q(final_output));

initial begin
    b = 0;
end

reg reset;

always @(negedge clk) begin
    s <= clk;
    r <= clk;
end

always @(posedge clk) begin
    // when enabled happens, bring the latches out of reset.
    if (enabled) begin
        s <= clk;
        r <= clk;
    end

    reset <= ~rst_n;
    if (reset) begin
        b <= 0;
    end else begin
        // reduce qs to a single bit with xor.
        xord_qs <=^ qs;
        b <=^ xord_qs;
    end
end

endmodule
