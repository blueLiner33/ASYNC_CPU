module instr_fetch_top(
    input  wire clk,
    input  wire reset,

    // Branch interface
    input  wire branch_en,
    input  wire [7:0] branch_addr,

    // Outputs
    output wire [7:0] pc_out,
    output wire [15:0] instr_out
);

    wire [7:0] pc;
    wire [15:0] instr;

    // Program Counter
    program_counter #(.WIDTH(8)) pc_unit (
        .clk(clk),
        .reset(reset),
        .branch_en(branch_en),
        .branch_addr(branch_addr),
        .pc(pc)
    );

    // Instruction ROM
    instr_rom #(.ADDR_WIDTH(8), .DATA_WIDTH(16)) rom (
        .addr(pc),
        .instr(instr)
    );

    assign pc_out = pc;
    assign instr_out = instr;

endmodule
