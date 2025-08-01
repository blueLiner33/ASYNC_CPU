`include "defines.v"

module writeback (
    input logic clk,
    input logic rst,

    // Handshake with ALU
    input logic req,
    output logic ack,

    // Data from ALU
    input logic [3:0] rd,
    input logic [15:0] result,

    // Register File interface
    output logic write_en,
    output logic [3:0] write_addr,
    output logic [15:0] write_data,
    input logic reg_ack
);

    typedef enum logic [1:0] {
        IDLE,
        WRITE_REQ,
        WAIT_ACK,
        COMPLETE
    } state_t;

    state_t state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            write_en <= 0;
            ack <= 0;
        end else begin
            case (state)
                IDLE: begin
                    ack <= 0;
                    write_en <= 0;
                    if (req) begin
                        write_addr <= rd;
                        write_data <= result;
                        write_en <= 1;
                        state <= WAIT_ACK;
                    end
                end

                WAIT_ACK: begin
                    if (reg_ack) begin
                        write_en <= 0;
                        ack <= 1;
                        state <= COMPLETE;
                    end
                end

                COMPLETE: begin
                    ack <= 0;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
