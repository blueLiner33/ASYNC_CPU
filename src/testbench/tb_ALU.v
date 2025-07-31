`timescale 1ns/1ps
`include "Main/defines.v"

module tb_ALU;
    reg [31:0] A, B;
    reg [5:0] ALUControl;
    wire [31:0] Result;
    wire Zero, Overflow, CarryOut, Negative;

    // Instantiate ALU
    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .Zero(Zero),
        .Overflow(Overflow),
        .CarryOut(CarryOut),
        .Negative(Negative)
    );

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, tb_ALU);

        // Test ADD
        A = 32'd10; B = 32'd5; ALUControl = `OP_ADD; #10;
        $display("ADD: %d + %d = %d", A, B, Result);

        // Test SUB
        A = 32'd15; B = 32'd20; ALUControl = `OP_SUB; #10;
        $display("SUB: %d - %d = %d", A, B, Result);

        // Test AND
        A = 32'hFF00FF00; B = 32'h0F0F0F0F; ALUControl = `OP_AND; #10;
        $display("AND: %h & %h = %h", A, B, Result);

        // Test OR
        A = 32'hFF00FF00; B = 32'h0F0F0F0F; ALUControl = `OP_OR; #10;
        $display("OR:  %h | %h = %h", A, B, Result);

        // Test CMP
        A = 32'd8; B = 32'd12; ALUControl = `OP_CMP; #10;
        $display("CMP: (%d < %d) = %d", A, B, Result);

        $finish;
    end
endmodule
