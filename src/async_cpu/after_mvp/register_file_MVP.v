// Simple 16-register file with 1 write port, 2 read ports, and handshake-based write

module register_file (
    input logic clk,
    input logic rst,

    // Write interface
    input logic write_en,
    input logic [3:0] write_addr,
    input logic [15:0] write_data,
    output logic reg_ack,

    // Read port A
    input logic [3:0] read_addr_a,
    output logic [15:0] read_data_a,

    // Read port B
    input logic [3:0] read_addr_b,
    output logic [15:0] read_data_b
);

    logic [15:0] registers [15:0];

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_ack <= 0;
        end else begin
            reg_ack <= 0; // default unless write happens
            if (write_en) begin
                registers[write_addr] <= write_data;
                reg_ack <= 1;  // acknowledge immediately after write
            end
        end
    end

    // Combinational reads
    assign read_data_a = registers[read_addr_a];
    assign read_data_b = registers[read_addr_b];

endmodule
