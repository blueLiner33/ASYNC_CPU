`timescale 1ns/1ps

module tb_top_level;

  // Clock and reset
  logic clk;
  logic rst;

  // Instantiate the DUT
  top_level dut (
    .clk(clk),
    .rst(rst)
    // Add more signals here if your top_level has more ports
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initial values
    clk = 0;
    rst = 1;

    $dumpfile("wave.vcd");
    $dumpvars(0, tb_top_level);

    #20;
    rst = 0;

    // Simulate for 1000ns
    #1000;
    $finish;
  end

endmodule
