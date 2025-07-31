module writeback (
    input  logic clk,
    input  logic reset,

    input  logic req,                // handshake request from ALU
    output logic ack,               // handshake ack back to ALU

    input  logic [15:0] alu_result, // ALU output
    input  logic [3:0] dest_reg,    // destination register (from ALU or pipeline)

    output logic write_en,          // to register file
    output logic [3:0] write_addr,
    output logic [15:0] write_data,

    input  logic reg_ack            // ack from register file
);

    typedef enum logic [1:0] {
        IDLE,
        ISSUE_WRITE,
        WAIT_RF_ACK
    } state_t;

    state_t state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state      <= IDLE;
            ack        <= 0;
            write_en   <= 0;
            write_addr <= 0;
            write_data <= 0;
        end else begin
            case (state)
                IDLE: begin
                    ack <= 0;
                    if (req) begin
                        write_addr <= dest_reg;
                        write_data <= alu_result;
                        write_en   <= 1;
                        state      <= WAIT_RF_ACK;
                    end
                end

                WAIT_RF_ACK: begin
                    if (reg_ack) begin
                        write_en <= 0;
                        ack      <= 1; // tell ALU we’re done
                        state    <= IDLE;
                    end
                end
            endcase
        end
    end

endmodule
