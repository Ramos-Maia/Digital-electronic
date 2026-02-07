module mealy_101 (
    input  logic clk,
    input  logic rst_n,   // reset assíncrono ativo em nível baixo
    input  logic x,       // entrada serial
    output logic z        // saída (1 quando detectar 101)
);

    // Definição dos estados
    typedef enum logic [1:0] {
        S0,   // estado inicial
        S1,   // recebeu '1'
        S2    // recebeu '10'
    } state_t;

    state_t state, next_state;

    // Registro de estado (síncrono)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    // Lógica combinacional (próximo estado + saída)
    always_comb begin
        // valores padrão
        next_state = state;
        z = 1'b0;

        case (state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (!x)
                    next_state = S2;
                else
                    next_state = S1;
            end

            S2: begin
                if (x) begin
                    z = 1'b1;          // sequência 101 detectada
                    next_state = S1;   // permite sobreposição
                end
                else
                    next_state = S0;
            end

            default: begin
                next_state = S0;
                z = 1'b0;
            end
        endcase
    end

endmodule
