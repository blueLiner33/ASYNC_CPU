//alu made by chat
`include "Main/defines.v"

module ALU (
    input  [31:0] A,
    input  [31:0] B,
    input  [5:0]  ALUControl, // 6-bit ALU operation selector

    output reg [31:0] Result,
    output      Zero,
    output reg  Overflow,
    output reg  CarryOut,
    output reg  Negative,

    input        valid_in,     // handshake in (data valid)
    output       ready_out,    // handshake out (ready for next)
    output reg   done          // optional: marks op complete (1-cycle pulse)
);

    reg [31:0] temp_result;
    wire [31:0] mult_result;
    wire [31:0] div_result;
    wire [31:0] rem_result;

    assign mult_result = A * B;
    assign div_result  = (B != 0) ? A / B : 32'hFFFFFFFF; // handle div by zero
    assign rem_result  = (B != 0) ? A % B : 32'hFFFFFFFF;

    // Bundle handshake logic: ALU only processes if valid_in = 1 and it's ready
    assign ready_out = 1'b1;  // Always ready in this simple async version

    always @(*) begin
        // Default values
        Result   = 32'b0;
        Overflow = 1'b0;
        CarryOut = 1'b0;
        Negative = 1'b0;
        done     = 1'b0;

        if (valid_in) begin
            case (ALUControl)
                OP_ADD: begin
                    {CarryOut, Result} = A + B;
                    Overflow = (A[31] == B[31]) && (Result[31] != A[31]);
                end
                OP_SUB: begin
                    {CarryOut, Result} = A - B;
                    Overflow = (A[31] != B[31]) && (Result[31] != A[31]);
                end
                OP_AND: Result = A & B;
                OP_OR:  Result = A | B;
                OP_XOR: Result = A ^ B;
                OP_SLL: Result = A << B[4:0];
                OP_SRL: Result = A >> B[4:0];
                OP_SRA: Result = $signed(A) >>> B[4:0];
                OP_NOR: Result = ~(A | B);
                OP_MOV_A: Result = A;
                OP_MOV_B: Result = B;
                OP_MULT: Result = mult_result;
                OP_DIV:  Result = div_result;
                OP_REMDER: Result = rem_result;
                default: Result = 32'b0;
            endcase

            Negative = Result[31];
            done = 1'b1; // Assert done for one cycle
        end
    end

    assign Zero = (Result == 32'b0);

endmodule
