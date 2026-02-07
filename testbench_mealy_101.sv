`timescale 1ns/1ps

module tb_mealy_101;

    // sinais do testbench
    logic clk;
    logic rst_n;
    logic x;
    logic z;

    // instancia o DUT (Device Under Test)
    mealy_101 dut (
        .clk   (clk),
        .rst_n (rst_n),
        .x     (x),
        .z     (z)
    );

    // gera clock (período = 10 ns)
    always #5 clk = ~clk;

    // estímulos
    initial begin
        // inicialização
        clk   = 0;
        rst_n = 0;
        x     = 0;

        // reset assíncrono
        #12;
        rst_n = 1;

        // sequência: 01010101000011
        @(posedge clk) x = 0;
        @(posedge clk) x = 1;
        @(posedge clk) x = 0;
        @(posedge clk) x = 1;
        @(posedge clk) x = 0;
        @(posedge clk) x = 1;
        @(posedge clk) x = 0;
        @(posedge clk) x = 1;
        @(posedge clk) x = 0;
        @(posedge clk) x = 0;
        @(posedge clk) x = 0;
        @(posedge clk) x = 0;
        @(posedge clk) x = 1;
        @(posedge clk) x = 1;

        // finaliza simulação
        #20;
        $finish;
    end

    // monitoramento
    initial begin
        $display("Tempo | clk | rst_n | x | z");
        $display("-----------------------------");
        $monitor("%4t  |  %b  |   %b   | %b | %b",
                  $time, clk, rst_n, x, z);
    end

endmodule
