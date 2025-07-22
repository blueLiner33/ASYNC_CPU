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
            6'b000000: begin // ADD
                {CarryOut, Result} = A + B;
                Overflow = (A[31] == B[31]) && (Result[31] != A[31]);
            end
            6'b000001: begin // SUB
                {CarryOut, Result} = A - B;
                Overflow = (A[31] != B[31]) && (Result[31] != A[31]);
            end
            6'b000010: Result = A & B;       // AND
            6'b000011: Result = A | B;       // OR
            6'b000100: Result = A ^ B;       // XOR
            6'b000101: Result = A << B[4:0]; // SLL
            6'b000110: Result = A >> B[4:0]; // SRL
            6'b000111: Result = $signed(A) >>> B[4:0]; // SRA
            6'b001000: Result = (~(A|B));//NOR
            6'b001001: Result = A;//pass A through
            6'b001010: Result = B;//pass B 
            6'b001011: ;//divde
            6'b001100: ;//multiple
            6'b001101:://reminder
            6'b001110:Result = 
            default: Result = 32'b0;
        endcase

        Negative = Result[31];
    end

    assign Zero = (Result == 32'b0);

endmodule
