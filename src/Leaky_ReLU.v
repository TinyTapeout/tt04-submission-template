

module Leaky_ReLU (
    input wire clk,          // Reloj
    input wire rst_n,        // Reset activo en bajo
    input wire [7:0] x,      // Entrada de 8 bits
    output reg [7:0] y       // Salida de 8 bits
);

    // Constante alpha (0.01 en punto fijo con 6 bits decimales)
    reg [7:0] alpha = 8'h03; 

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            y <= 8'h00; // Reset
        end else begin
            if (x[7] == 1'b0) begin // x > 0
                y <= x;
            end else begin // x <= 0
                y <= (x * alpha) >>> 6; // Multiplicación por alpha y desplazamiento para ajustar punto fijo
            end
        end
    end

endmodule
