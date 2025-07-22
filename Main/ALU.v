`include "Main\defines.v"
module ALU (
    input [31:0] A,
    input [31:0] B,
    input [5:0] ALUControl, //6 bit instructions

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

        case (ALUControl)
            OP_ADD: begin // ADD
                {CarryOut, Result} = A + B;
                Overflow = (A[31] == B[31]) && (Result[31] != A[31]);
            end
            OP_SUB: begin // SUB
                {CarryOut, Result} = A - B;
                Overflow = (A[31] != B[31]) && (Result[31] != A[31]);
            end
            OP_AND: Result = A & B;       // AND
            OP_OR: Result = A | B;       // OR
            OP_XOR: Result = A ^ B;       // XOR
            OP_SLL: Result = A << B[4:0]; // SLL
            OP_SRL: Result = A >> B[4:0]; // SRL
            OP_SRA: Result = $signed(A) >>> B[4:0]; // SRA
            OP_NOR: Result = (~(A|B));//NOR
            OP_MOV_A: Result = A;//pass A through
            OP_MOV_B: Result = B;//pass B 
            OP_DIV: ;//divde
            OP_MULT: ;//multiple
            OP_REMDER: ;//reminder
            default: Result = 32'b0;
        endcase

        Negative = Result[31];
    end

    assign Zero = (Result == 32'b0);

endmodule
