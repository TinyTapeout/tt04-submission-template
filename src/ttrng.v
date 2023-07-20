module ttrng (
    input wire [1:0] selector,
    output reg [7:0] number
);

// Wire 64 SR Latches into an xor then into an 8-bit D flip flop.
// The SR Latch inputs are the clock, and the Q outputs are all xor'd together into a D flip flop

always_comb begin
    case(selector)
        default:
        number = 8'b0000001;
    endcase
end

endmodule