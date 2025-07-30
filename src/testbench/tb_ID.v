`timescale 1ns/1ps
`define OP_MOV 5'b00000 //register to register move
`define OP_LD 5'b00001 //load word from memory to register

`define OP_ADD 5'b00011 //Add two registers
`define OP_SUB 5'b00100 //subtract second register from first
`define OP_AND 5'b00101 //bitwise and between two registers
`define OP_OR 5'b00110   // 	Bitwise OR between two registers
`define OP_NOT 5'b00111  //bitwise not
`define OP_JMP 5'b01000  //unconditional jump
`define OP_NOP 5'b01001   //no operation used for timing
`define OP_OB_CHECK       5'b01010 //driving 
`define OP_VELOCITY_GUARD 5'b01111 //driving spec
//possible out comes
`define OP_MOVE_LEFT      5'b01011
`define OP_MOVE_RIGHT     5'b01100
`define OP_STOP           5'b01101
`define OP_CONTINUE       5'b01110


`define OP_CMP 5'b10000 //compare
`define OP_MULT 5'b10001 //multiplication
`define OP_DIVSION 5'b10010 //division
module ID_tb;

    // DUT interface signals
    reg  [31:0] instruction;
    reg  [15:0] WB_data;
    reg  [3:0]  WB_reg_addr;
    reg         WB_reg_write;
    reg         clk;
    reg         reset;
    wire [41:0] fifo_data;
    wire        fifo_wr_en;
    reg         fifo_wr_ready;

    // Instantiate DUT
    ID dut (
        .instruction(instruction),
        .WB_data(WB_data),
        .WB_reg_addr(WB_reg_addr),
        .WB_reg_write(WB_reg_write),
        .clk(clk),
        .reset(reset),
        .fifo_data(fifo_data),
        .fifo_wr_en(fifo_wr_en),
        .fifo_wr_ready(fifo_wr_ready)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock (10ns period)

    // Task: Apply an instruction
    task apply_instruction(
        input [4:0] opcode,
        input [3:0] rd,
        input [3:0] rs1,
        input [3:0] rs2,
        input integer wait_cycles
    );
    begin
        instruction = {opcode, rd, rs1, rs2, 15'b0}; // Padding with 0 for now
        fifo_wr_ready = 1;
        repeat(wait_cycles) @(posedge clk);
    end
    endtask

    // Test procedure
    initial begin
        $dumpfile("ID_tb.vcd");
        $dumpvars(0, ID_tb);

        // Initialize signals
        instruction    = 0;
        WB_data        = 0;
        WB_reg_addr    = 0;
        WB_reg_write   = 0;
        fifo_wr_ready  = 0;
        reset          = 1;

        // Reset sequence
        repeat(2) @(posedge clk);
        reset = 0;
        $display("=== Starting Test ===");

        // === Step 1: Test register file writeback ===
        WB_reg_write = 1;
        WB_reg_addr  = 4'h1;
        WB_data      = 16'hABCD;
        @(posedge clk);

        WB_reg_addr  = 4'h2;
        WB_data      = 16'h1234;
        @(posedge clk);
        WB_reg_write = 0;

        // === Step 2: Test ALU type instructions ===
        // MOV, ADD, SUB, AND, OR, NOT, CMP, mult, div
        $display("\n--- Testing ALU Operations ---");
        (`OP_MOV, 4'h3, 4'h1, 4'h2, 1);
        apply_instruction(`OP_ADD, 4'h3, 4'h1, 4'h2, 1);
        apply_instruction(`OP_SUB, 4'h3, 4'h1, 4'h2, 1);
        apply_instruction(`OP_AND, 4'h3, 4'h1, 4'h2, 1);
        apply_instruction(`OP_OR , 4'h3, 4'h1, 4'h2, 1);
        apply_instruction(`OP_NOT, 4'h3, 4'h1, 4'h2, 1);
        apply_instruction(`OP_CMP, 4'h3, 4'h1, 4'h2, 1);
        apply_instruction(`OP_MULT, 4'h3, 4'h1, 4'h2, 1);
        apply_instruction(`OP_DIVSION, 4'h3, 4'h1, 4'h2, 1);

        // === Step 3: Test Car operations ===
        // MOVE_LEFT, MOVE_RIGHT, STOP, CONTINUE
        $display("\n--- Testing Car Operations ---");
        apply_instruction(`OP_MOVE_LEFT, 4'h4, 0, 0, 1);
        apply_instruction(`OP_MOVE_RIGHT, 4'h4, 0, 0, 1);
        apply_instruction(`OP_STOP, 4'h4, 0, 0, 1);
        apply_instruction(`OP_CONTINUE, 4'h4, 0, 0, 1);

        // === Step 4: Test Sensor operations ===
        // OB_CHECK, VELOCITY_GUARD
        $display("\n--- Testing Sensor Operations ---");
        apply_instruction(`OP_OB_CHECK, 4'h5, 4'h1, 4'h2, 1);
        apply_instruction(`OP_VELOCITY_GUARD, 4'h5, 4'h1, 4'h2, 1);

        // === Step 5: Test FIFO not ready ===
        $display("\n--- Testing FIFO not ready ---");
        fifo_wr_ready = 0;
        apply_instruction(`OP_ADD, 4'h3, 4'h1, 4'h2, 2);

        $display("=== Test Complete ===");
        #20;
        $finish;
    end

    // Monitor outputs
    always @(posedge clk) begin
        if(fifo_wr_en)
            $display("[%0t] FIFO Write: Data=%h",$time,fifo_data);
    end

endmodule
