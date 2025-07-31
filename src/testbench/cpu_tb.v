`timescale 1ns/1ps

module tb_cpu_top;

    // Clocks and reset
    logic clk_if, clk_id, clk_alu, clk_wb, clk_rf;
    logic reset;

    // DUT I/O for branch
    logic        branch_en;
    logic [7:0]  branch_addr;

    // Instantiate DUT
    cpu_top dut (
        .clk_if(clk_if),
        .clk_id(clk_id),
        .clk_alu(clk_alu),
        .clk_wb(clk_wb),
        .clk_regfile(clk_rf),
        .reset(reset)
        // branch_en/branch_addr can be wired internally or added to top-level if desired
    );

    // -----------------------
    // Clock generation
    // -----------------------
    initial begin
        clk_if  = 0;
        clk_id  = 0;
        clk_alu = 0;
        clk_wb  = 0;
        clk_rf  = 0;
    end

    always #5  clk_if  = ~clk_if;   // 100 MHz
    always #7  clk_id  = ~clk_id;   // ~71 MHz
    always #9  clk_alu = ~clk_alu;  // ~55 MHz
    always #11 clk_wb  = ~clk_wb;   // ~45 MHz
    always #13 clk_rf  = ~clk_rf;   // ~38 MHz

    // -----------------------
    // Reset sequence
    // -----------------------
    initial begin
        reset = 1;
        #50;        // hold reset for 50ns
        reset = 0;
    end

    // -----------------------
    // Optional branch stimulus
    // -----------------------
    initial begin
        branch_en   = 0;
        branch_addr = 0;

        // Wait 200ns then branch
        #200;
        branch_en   = 1;
        branch_addr = 8'h10; // example branch to address 0x10
        #10;
        branch_en   = 0;
    end

    // -----------------------
    // Monitor key signals
    // -----------------------
    initial begin
        $display("Time\tPC\tInstruction\tALU_Result\tRF_We\tRF_WAddr\tRF_WData");
        $monitor("%0t\t%h\t%h\t%h\t%b\t%h\t%h",
                 $time,
                 dut.pc,
                 dut.instr,
                 dut.alu_result,
                 dut.we_rf,
                 dut.addr_w_rf,
                 dut.data_wb
        );
    end

    // -----------------------
    // VCD waveform dump
    // -----------------------
    initial begin
        $dumpfile("cpu_top.vcd");
        $dumpvars(0, tb_cpu_top);
        #1000;   // run for 1000ns
        $finish;
    end

endmodule
