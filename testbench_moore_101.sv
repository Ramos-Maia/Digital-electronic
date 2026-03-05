`timescale 1ns/1ps

module testbench_moore_101;

    logic clk;
    logic rst_n;
    logic x;
    logic z;

    // Instancia o módulo
    moore_101 uut (
        .clk(clk),
        .rst_n(rst_n),
        .x(x),
        .z(z)
    );

    // Clock de 10ns
    initial clk = 0;
    always #5 clk = ~clk;

    // Estímulos
    initial begin
        // Inicialização
        rst_n = 0;
        x = 0;
        #12;
        rst_n = 1;

        // Sequência de teste
        // Testando detecção 101
        x = 1; #10;  // S1
        x = 0; #10;  // S2
        x = 1; #10;  // S3 -> saída z=1
        x = 1; #10;  // S1
        x = 0; #10;  // S2
        x = 1; #10;  // S3 -> saída z=1
        x = 0; #10;  // S0
        x = 1; #10;  // S1
        x = 1; #10;  // S1
        x = 0; #10;  // S2
        x = 1; #10;  // S3 -> saída z=1

        // Finaliza simulação
        #20;
        $finish;
    end

    // Monitor
    initial begin
        $display("Time\tclk\trst_n\tx\tz");
        $monitor("%0t\t%b\t%b\t%b\t%b", $time, clk, rst_n, x, z);
    end

    // Gerar waveform
    initial begin
        $dumpfile("moore_101.vcd");
        $dumpvars(0, testbench_moore_101);
    end

endmodule
        $monitor("%4t  |  %b  |   %b   | %b | %b",
                  $time, clk, rst_n, x, z);
    end

endmodule
