`timescale 1ns/1ps

module tb_mux4_1;

    // sinais do testbench
    logic [3:0] d;
    logic [1:0] sel;
    logic y;

    // instancia o DUT
    mux4_1 dut (
        .d   (d),
        .sel (sel),
        .y   (y)
    );

    // estímulos
    initial begin
        $display("Tempo |   d   | sel | y");
        $display("------------------------");

        // padrão inicial
        d   = 4'b0000;
        sel = 2'b00;
        #5;

        // Teste 1
        d = 4'b1010;  // d[3]=1 d[2]=0 d[1]=1 d[0]=0
        sel = 2'b00;  #5; // espera y = d[0] = 0
        $display("%4t  | %b |  %b  | %b", $time, d, sel, y);

        sel = 2'b01;  #5; // espera y = d[1] = 1
        $display("%4t  | %b |  %b  | %b", $time, d, sel, y);

        sel = 2'b10;  #5; // espera y = d[2] = 0
        $display("%4t  | %b |  %b  | %b", $time, d, sel, y);

        sel = 2'b11;  #5; // espera y = d[3] = 1
        $display("%4t  | %b |  %b  | %b", $time, d, sel, y);

        // Teste 2 (outro padrão)
        d = 4'b0111;
        sel = 2'b00;  #5; // y = 1
        $display("%4t  | %b |  %b  | %b", $time, d, sel, y);

        sel = 2'b01;  #5; // y = 1
        $display("%4t  | %b |  %b  | %b", $time, d, sel, y);

        sel = 2'b10;  #5; // y = 1
        $display("%4t  | %b |  %b  | %b", $time, d, sel, y);

        sel = 2'b11;  #5; // y = 0
        $display("%4t  | %b |  %b  | %b", $time, d, sel, y);

        // fim da simulação
        #10;
        $finish;
    end

endmodule
