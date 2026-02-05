module contador_4bits (
    input  logic        clk,    // Clock
    input  logic        rst_n,  // Reset assíncrono ativo em nível baixo
    input  logic        en,     // Enable síncrono ativo em nível alto
    output logic [3:0]  count   // Saída do contador
);

    // Contador síncrono com reset assíncrono
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'b0000;          // Reset imediato
        else if (en)
            count <= count + 4'b0001;  // Incrementa (overflow automático)
        else
            count <= count;            // Mantém valor
    end

endmodule
