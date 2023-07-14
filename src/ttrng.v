module ttrng (
    input wire [1:0] selector,
    output reg [7:0] number
);

always @(*) begin
    case(selector)
        default:
        number = 8'b0000001;
    endcase
end

endmodule