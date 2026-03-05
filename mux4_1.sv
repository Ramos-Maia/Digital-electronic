module mux4_1 (
    input  logic [3:0] d,    // A adição dos canais da Mux (Como são 2 bits são 4 canais)
    input  logic [1:0] sel,  // O seletor de canal
    output logic y            // A saída 
);

    // Lógica combinacional que seleciona o canal
    logic y_comb;

    always @(*) begin
        case (sel)
            2'b00: y_comb = d[0];
            2'b01: y_comb = d[1];
            2'b10: y_comb = d[2];
            2'b11: y_comb = d[3];
            default: y_comb = 1'b0;
        endcase
        // A lógica que seleciona o canal
    end

endmodule
