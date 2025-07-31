`include "defines.v"

module ID (
    input wire [31:0] instruction,
    input wire [15:0] reg_out_A,           // from AsyncRegisterFile
    input wire [15:0] reg_out_B,           // from AsyncRegisterFile

    input wire clk,
    input wire reset,

    output wire [3:0] rsone,               // read address 1
    output wire [3:0] rstwo,               // read address 2
    output wire [3:0] rd,                  // destination register for writeback

    // FIFO interface
    output reg  [41:0] fifo_data,
    output reg         fifo_wr_en,
    input  wire        fifo_wr_ready
);

    // Extract instruction fields
    wire [4:0] opcode = instruction[31:27];
    assign rd    = instruction[26:23];
    assign rsone = instruction[22:19];
    assign rstwo = instruction[18:15];

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            fifo_wr_en <= 0;
            fifo_data  <= 0;
        end else begin
            fifo_wr_en <= 0; // default low
            if (fifo_wr_ready) begin
                case (opcode)
                    `OP_MOV, `OP_ADD, `OP_SUB, `OP_AND, `OP_OR, `OP_NOT,
                    `OP_CMP, `OP_MULT, `OP_DIV:
                        fifo_data <= {reg_out_B, reg_out_A, opcode, rd};

                    `OP_MOVE_LEFT, `OP_MOVE_RIGHT, `OP_STOP, `OP_CONTINUE:
                        fifo_data <= {16'b0, 16'b0, opcode, rd};

                    `OP_OB_CHECK, `OP_VELOCITY_GUARD:
                        fifo_data <= {reg_out_B, reg_out_A, opcode, rd};

                    default:
                        fifo_data <= 0;
                endcase
                fifo_wr_en <= 1;
            end
        end
    end

endmodule
