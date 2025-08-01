`include "defines.v"

module ID (
    input wire [31:0] instruction,
    input wire [15:0] reg_out_A,           // from AsyncRegisterFile
    input wire [15:0] reg_out_B,           // from AsyncRegisterFile

    input wire clk,
    input wire reset,

    // Handshake
    output reg  [41:0] handshake_data,
    output reg req,
    input wire ack,

    output wire [3:0] rsone,               // read address 1
    output wire [3:0] rstwo,               // read address 2
    output wire [3:0] rd                   // destination register for writeback
);

    assign rd    = instruction[26:23];
    assign rsone = instruction[22:19];
    assign rstwo = instruction[18:15];

    wire [4:0] opcode = instruction [31:27];

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            req <= 0;
            handshake_data <= 0;
        end else begin
            if (!req) begin
                case (opcode)
                    `OP_MOV, `OP_ADD, `OP_SUB, `OP_AND, `OP_OR, `OP_NOT,
                    `OP_CMP, `OP_MULT, `OP_DIV:
                        handshake_data <= {reg_out_B, reg_out_A, opcode, rd};

                    `OP_MOVE_LEFT, `OP_MOVE_RIGHT, `OP_STOP, `OP_CONTINUE:
                        handshake_data <= {16'b0, 16'b0, opcode, rd};

                    `OP_OB_CHECK, `OP_VELOCITY_GUARD:
                        handshake_data <= {reg_out_B, reg_out_A, opcode, rd};

                    default:
                        handshake_data <= 0;
                endcase
                req <= 1;
            end else if (req && ack) begin
                req <= 0;
            end
        end
    end

endmodule
