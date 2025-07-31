`include "defines.v"
module ID (
    input wire [31:0] instruction,
    input wire [15:0] WB_data,//write back
    input wire [3:0] WB_reg_addr,//which to write data to
    input wire WB_reg_write,//enables register file write
    input wire clk,
    input wire reset,
        // FIFO interface
    output reg  [41:0] fifo_data,
    output reg         fifo_wr_en,
    input  wire        fifo_wr_ready
);
    wire [4:0] opcode = instruction [31:27];
    wire [3:0] rd = instruction [26:23];
    wire [3:0] rsone = instruction [22:19];
    wire [3:0] rstwo = instruction [18:15];


    wire [15:0] reg_out_A, reg_out_B;
    AsyncRegisterFile #(.DataWidth(16), .NumRegs(16), .AddrWidth(4)) RF (
        .clk(clk),
        .req(1'b0),            // ID does not write directly
        .ack(),                // ignore ack
        .we(WB_reg_write),
        .addr_w(WB_reg_addr),
        .addr_r1(rsone),
        .addr_r2(rstwo),
        .data_in(WB_data),
        .data_out1(reg_out_A),
        .data_out2(reg_out_B)
    );

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            fifo_wr_en <= 0;
            fifo_data  <= 0;
        end else begin
            fifo_wr_en <= 0; // default
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