// Handles storing ALU results into the register file using 4-phase handshaking


`include "Main/defines.v"

module ALU (
    input [31:0] A,
    input [31:0] B,
    input [5:0] ALUControl,

    output reg [31:0] Result,
    output Zero,
    output reg Overflow,
    output reg CarryOut,
    output reg Negative
);

    always @(*) begin
        Overflow = 0;
        CarryOut = 0;
        Negative = 0;
        Result = 32'b0;

        case (ALUControl)
            `OP_ADD: begin
                {CarryOut, Result} = A + B;
                Overflow = (A[31] == B[31]) && (Result[31] != A[31]);
            end
            `OP_SUB: begin
                {CarryOut, Result} = A - B;
                Overflow = (A[31] != B[31]) && (Result[31] != A[31]);
            end
            `OP_AND: Result = A & B;
            `OP_OR:  Result = A | B;
            `OP_XOR: Result = A ^ B;
            `OP_SLL: Result = A << B[4:0];
            `OP_SRL: Result = A >> B[4:0];
            `OP_SRA: Result = $signed(A) >>> B[4:0];
            `OP_NOR: Result = ~(A | B);
            `OP_MOV_A: Result = A;
            `OP_MOV_B: Result = B;

            `OP_MULT: Result = A * B;

            `OP_DIV: Result = (B != 0) ? A / B : 32'b0;

            `OP_REMDER: Result = (B != 0) ? A % B : 32'b0;

            `OP_CMP: begin
                reg [31:0] temp;
                {CarryOut, temp} = A - B;
                Overflow = (A[31] != B[31]) && (temp[31] != A[31]);
                Negative = temp[31];
            end

            default: Result = 32'b0;
        endcase

        Negative = Result[31]; // For all normal ops
    end

    assign Zero = (Result == 32'b0);

endmodule
