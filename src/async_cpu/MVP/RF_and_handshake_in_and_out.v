module AsyncRegisterFile #(
    parameter DataWidth = 16,
    parameter NumRegs = 16,
    parameter AddrWidth = 4
)(
    input logic req,
    output logic ack,

    input logic we,
    input logic [AddrWidth-1:0] addr_w,
    input logic [AddrWidth-1:0] addr_r1,
    input logic [AddrWidth-1:0] addr_r2,
    input logic [DataWidth-1:0] data_in,
    output logic [DataWidth-1:0] data_out1,
    output logic [DataWidth-1:0] data_out2
);

    logic [DataWidth-1:0] regs [0:NumRegs-1];
    logic busy = 0;

    assign ack = busy;

    always_ff @(posedge req or negedge req) begin
        if (req && !busy) begin
            if (we) begin
                regs[addr_w] <= data_in;
            end
            data_out1 <= regs[addr_r1];
            data_out2 <= regs[addr_r2];
            busy <= 1;
        end else if (!req && busy) begin
            busy <= 0;
        end
    end

endmodule
