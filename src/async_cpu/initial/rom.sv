module instr_rom #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32
)(
    input  wire [ADDR_WIDTH-1:0] addr,
    output reg  [DATA_WIDTH-1:0] instr
);

    // ROM storage
    reg [DATA_WIDTH-1:0] memory [0:(1<<ADDR_WIDTH)-1];

    // Load program from file
    initial begin
        $readmemh("program.hex", memory);
    end

    // Combinational read
    always @(*) begin
        instr = memory[addr];
    end

endmodule
