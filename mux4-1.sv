module mux4_1 (
    input  logic [3:0] d, //A adição dos canais da Mux (Como são 2 bits são 4 canais)
    input  logic [1:0] sel,//O seletor de canal
    output logic y //A saída 
);

    always @(*) begin
        case (sel)
            2'b00: y = d[0];
            2'b01: y = d[1];
            2'b10: y = d[2];
            2'b11: y = d[3];
            default: y = 1'b0;
        endcase
        //A lógica que seleciona o canal
    end
endmodule

