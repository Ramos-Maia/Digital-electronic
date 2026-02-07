module moore_101 (
    input  logic clk,
    input  logic rst_n,   // reset assíncrono ativo em nível baixo
    input  logic x,       // entrada serial
    output logic z        // 1 quando detectar 101
);

    typedef enum logic [1:0] {
        S0,   // nenhum bit válido
        S1,   // recebeu '1'
        S2,   // recebeu '10'
        S3    // recebeu '101' (detecção)
    } state_t;

    state_t state, next_state;

    // Registro de estado
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    // Próximo estado
    always_comb begin
        next_state = state;

        case (state)
            S0:  next_state = x ? S1 : S0;
            S1:  next_state = x ? S1 : S2;
            S2:  next_state = x ? S3 : S0;
            S3:  next_state = x ? S1 : S2; // chave da sobreposição, a estrutura x ? Sx : Sy, é equivalente a:
                                                                                                                        //if(x)
                                                                                                                            //next_state = S1;
                                                                                                                        //else
                                                                                                                            //next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Saída Moore
    always_comb begin
        z = (state == S3);
    end

endmodule
