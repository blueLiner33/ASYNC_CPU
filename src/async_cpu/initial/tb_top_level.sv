`timescale 1ns / 1ps

module tb_top_level;

    reg clk_if = 0;
    reg clk_id = 0;
    reg clk_alu = 0;
    reg clk_wb = 0;
    reg clk_regfile = 0;
    reg reset = 1;

    // Clock generation
    always #5  clk_if      = ~clk_if;
    always #6  clk_id      = ~clk_id;
    always #7  clk_alu     = ~clk_alu;
    always #8  clk_wb      = ~clk_wb;
    always #9  clk_regfile = ~clk_regfile;

    top_level uut (
        .clk_if(clk_if),
        .clk_id(clk_id),
        .clk_alu(clk_alu),
        .clk_wb(clk_wb),
        .clk_regfile(clk_regfile),
        .reset(reset)
    );

    initial begin
        $dumpfile("cpu_top.vcd");
        $dumpvars(0, tb_top_level);

        // Initial Reset
        #20 reset = 0;

        // Run simulation for enough time to process instructions
        #5000;

        $finish;
    end

endmodule
