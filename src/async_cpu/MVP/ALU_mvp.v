`include "Main/MVP/defines_mvp.v"
`define ALU_NOP   4'b0000
`define ALU_ADD   4'b0001
`define ALU_SUB   4'b0010
`define ALU_AND   4'b0011
`define ALU_OR    4'b0100
`define ALU_SHL   4'b0101
`define ALU_SHR   4'b0110
`define ALU_SLT   4'b0111
`define ALU_MUL   4'b1000 


module ALU (
    input [15:0] A,
    input [15:0] B,
    input [3:0] ALUControl, 

    output reg [15:0] Result,
    output Zero,
    output reg Overflow,
    output reg CarryOut,
    output reg Negative
);

    always @(*) begin
        Overflow = 0;
        CarryOut = 0;
        Negative = 0;
        Result = 16'b0;

        case (ALUControl)
            `ALU_ADD: begin
                {CarryOut, Result} = A + B;
                Overflow = (A[15] == B[15]) && (Result[15] != A[15]);
            end
            `ALU_SUB: begin
                {CarryOut, Result} = A - B;
                Overflow = (A[15] != B[15]) && (Result[15] != A[15]);
            end
            `ALU_AND: Result = A & B;
            `ALU_OR:  Result = A | B;
            `ALU_SHL: Result = A << B;
            `ALU_SHR: Result = A >> B;
            `ALU_SLT: Result = (A < B) ? 16'b1 : 16'b0;
            `ALU_MUL: Result = A * B; // need to make seprate module
            `ALU_NOP: Result = 16'b0;
            default: Result = 16'b0;
        endcase

        Negative = Result[15];
    end

    assign Zero = (Result == 16'b0);

endmodule
