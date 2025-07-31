`include "defines.v"
module custom_alu (
    input  wire        clk,
    input  wire        rst,
    input  wire [4:0]  opcode,
    input  wire [15:0] A,
    input  wire [15:0] B,
    input  wire [3:0]  car_x,
    input  wire [15:0] img_row,
    input  wire        velocity_en,
    output reg  [15:0] result,
    output reg         zero_flag,
    output reg         negative_flag,
    output reg         valid_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result        <= 16'b0;
            zero_flag     <= 1'b0;
            negative_flag <= 1'b0;
            valid_out     <= 1'b0;
        end else begin
            valid_out <= 1'b1; // Result is always valid 1 cycle after opcode is applied

            case (opcode)

                // --- General-Purpose Ops ---
                `OP_MOV: result <= B;
                `OP_LD:  result <= B;
                `OP_ST:  result <= B;
                `OP_ADD: result <= A + B;
                `OP_SUB: result <= A - B;
                `OP_AND: result <= A & B;
                `OP_OR:  result <= A | B;
                `OP_NOT: result <= ~A;
                `OP_JMP: result <= A;
                `OP_NOP: result <= 16'b0;

                // --- Obstacle Logic ---
                `OP_OB_CHECK:
                    result <= img_row[car_x] ? `ACTION_STOP : `ACTION_CONTINUE;

                `OP_MOVE_LEFT:      result <= `ACTION_LEFT;
                `OP_MOVE_RIGHT:     result <= `ACTION_RIGHT;
                `OP_STOP:           result <= `ACTION_STOP;
                `OP_CONTINUE:       result <= `ACTION_CONTINUE;

                `OP_VELOCITY_GUARD:
                    result <= velocity_en ? `ACTION_CONTINUE : `ACTION_STOP;

                default: begin
                    result     <= 16'b0;
                    valid_out  <= 1'b0; // Invalid instruction = not valid
                end
            endcase

            zero_flag     <= (result == 0);
            negative_flag <= result[15];
        end
    end

endmodule