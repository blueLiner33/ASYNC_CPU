`timescale 1ns / 1ps

module tb_top_level;

    // Clock signals
    logic clk_if = 0;
    logic clk_id = 0;
    logic clk_alu = 0;
    logic clk_wb = 0;
    logic clk_regfile = 0;
    logic reset = 1;

    // Clock toggles every 5ns (100MHz)
    always #5 clk_if = ~clk_if;
    always #7 clk_id = ~clk_id;
    always #9 clk_alu = ~clk_alu;
    always #11 clk_wb = ~clk_wb;
    always #13 clk_regfile = ~clk_regfile;

    // DUT
    cpu_top dut (
        .clk_if(clk_if),
        .clk_id(clk_id),
        .clk_alu(clk_alu),
        .clk_wb(clk_wb),
        .clk_regfile(clk_regfile),
        .reset(reset)
    );

    initial begin
        $dumpfile("cpu_top.vcd");     // For waveform viewing in GTKWave
        $dumpvars(0, tb_top_level);

        // Apply reset
        #20 reset = 0;

        // Run simulation
        #500 $finish;
    end

endmodule
