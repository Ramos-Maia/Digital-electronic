`timescale 1ns/1ps

module tb_contador_4bits;

    // sinais do testbench
    logic clk;
    logic rst_n;
    logic en;
    logic [3:0] count;

    // instancia o DUT
    contador_4bits dut (
        .clk   (clk),
        .rst_n (rst_n),
        .en    (en),
        .count (count)
    );

    // geração do clock (período = 10 ns)
    always #5 clk = ~clk;

    // estímulos
    initial begin
        // valores iniciais
        clk   = 0;
        rst_n = 0;   // reset ativo
        en    = 0;

        // mantém reset por um tempo
        #12;
        rst_n = 1;   // libera reset

        // enable ligado
        @(posedge clk) en = 1;
        repeat (5) @(posedge clk);   // conta 5 ciclos

        // disable → mantém valor
        @(posedge clk) en = 0;
        repeat (3) @(posedge clk);   // não deve contar

        // enable novamente
        @(posedge clk) en = 1;
        repeat (10) @(posedge clk);  // força overflow

        // reset assíncrono durante a contagem
        #7 rst_n = 0;   // reset fora da borda do clock
        #5 rst_n = 1;

        // conta mais alguns ciclos
        @(posedge clk) en = 1;
        repeat (4) @(posedge clk);

        // encerra simulação
        #20;
        $finish;
    end

    // monitoramento
    initial begin
        $display("Tempo | clk | rst_n | en | count");
        $display("--------------------------------");
        $monitor("%4t  |  %b  |   %b   |  %b |  %b",
                  $time, clk, rst_n, en, count);
    end

endmodule
