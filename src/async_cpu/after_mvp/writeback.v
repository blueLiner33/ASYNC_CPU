module writeback (
    input logic clk,
    input logic rst,

    // FIFO input from ALU
    input logic fifo_valid,             // indicates ALU has pushed data
    output logic fifo_ack,             // ack back to ALU FIFO
    input logic [3:0] rd,              // destination register index
    input logic [15:0] result,         // ALU result to be written

    // Register file interface
    output logic write_en,             // enables register write
    output logic [3:0] write_addr,     // target register
    output logic [15:0] write_data,    // data to write
    input logic reg_ack                // register file acknowledges write complete
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
            fifo_ack <= 0;
        end else begin
            case (state)
                IDLE: begin
                    fifo_ack <= 0;
                    if (fifo_valid) begin
                        write_addr <= rd;
                        write_data <= result;
                        write_en <= 1;
                        state <= WAIT_ACK;
                    end
                end

                WAIT_ACK: begin
                    if (reg_ack) begin
                        write_en <= 0;
                        fifo_ack <= 1;   // tell ALU FIFO we’re done with this item
                        state <= COMPLETE;
                    end
                end

                COMPLETE: begin
                    fifo_ack <= 0;       // return to neutral
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
