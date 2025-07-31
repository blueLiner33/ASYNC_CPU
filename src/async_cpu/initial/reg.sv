module AsyncRegisterFile #(
    parameter DataWidth = 16,
    parameter NumRegs = 16,
    parameter AddrWidth = 4
)(
    input  logic clk,        // clock to synchronize write
    input  logic req,        // request signal
    output logic ack,        // acknowledge signal

    input  logic we,                                 // write enable
    input  logic [AddrWidth-1:0] addr_w,            // write address
    input  logic [AddrWidth-1:0] addr_r1,           // read address 1
    input  logic [AddrWidth-1:0] addr_r2,           // read address 2
    input  logic [DataWidth-1:0] data_in,           // data to write
    output logic [DataWidth-1:0] data_out1,         // read data 1
    output logic [DataWidth-1:0] data_out2          // read data 2
);

    logic [DataWidth-1:0] regs [0:NumRegs-1];
    logic busy;

    // Combinational reads
    assign data_out1 = regs[addr_r1];
    assign data_out2 = regs[addr_r2];

    // Ack signal tracks busy flag
    assign ack = busy;

    always_ff @(posedge clk) begin
        if (req && !busy) begin
            if (we) begin
                regs[addr_w] <= data_in;  // write on req when not busy
            end
            busy <= 1;  // operation done, ack = 1
        end else if (!req && busy) begin
            busy <= 0;  // clear busy when req low, ready for next
        end
    end

endmodule
