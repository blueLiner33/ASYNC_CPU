module top_level (
    input  wire clk_if,
    input  wire clk_id,
    input  wire clk_alu,
    input  wire clk_wb,
    input  wire clk_regfile,
    input  wire reset
);

    // -----------------------
    // Handshake signals
    // -----------------------
    logic req_if_id,  ack_if_id;
    logic req_id_alu, ack_id_alu;
    logic req_alu_wb, ack_alu_wb;
    logic ack_wb_rf;  // Driven by Register File

    // -----------------------
    // Data buses
    // -----------------------
    logic [31:0] instr;
    logic [7:0]  pc;

    logic [15:0] reg_data1, reg_data2;
    logic [15:0] alu_result;
    logic [3:0]  addr_r1, addr_r2;
    logic [3:0]  addr_w_rf;
    logic [3:0] addr_w_id;
    logic [15:0] data_wb;

    logic [7:0]  branch_addr;
    logic        branch_en;
    logic [4:0]  alu_op;

    logic we_rf;
    logic alu_valid;

    // -----------------------
    // Instruction Fetch Stage
    // -----------------------
    instr_fetch_top if_stage (
        .clk(clk_if),
        .reset(reset),
        .branch_en(branch_en),
        .branch_addr(branch_addr),
        .pc_out(pc),
        .instr_out(instr)
    );

    // -----------------------
    // Instruction Decode Stage
    // -----------------------
    ID id_stage (
    .clk(clk_id),
    .reset(reset),
    .instruction(instr),
    .reg_out_A(reg_data1),
    .reg_out_B(reg_data2),
    .handshake_data(),
    .req(req_if_id),
    .ack(ack_if_id),
    .rsone(addr_r1),
    .rstwo(addr_r2),
    .rd(addr_w_id) // <-- renamed
);

    // -----------------------
    // Register File
    // -----------------------
    AsyncRegisterFile rf (
    .clk(clk_regfile),
    .req(req_alu_wb),
    .ack(ack_wb_rf),
    .we(we_rf),
    .addr_w(addr_w_rf), // ONLY written by WB
    .addr_r1(addr_r1),
    .addr_r2(addr_r2),
    .data_in(data_wb),
    .data_out1(reg_data1),
    .data_out2(reg_data2)
);


    // -----------------------
    // ALU Stage
    // -----------------------
    custom_alu alu_unit (
        .clk(clk_alu),
        .rst(reset),
        .opcode(alu_op),
        .A(reg_data1),
        .B(reg_data2),
        .car_x(4'd0),          // Stubbed input
        .img_row(16'd0),
        .velocity_en(1'b0),
        .result(alu_result),
        .zero_flag(),
        .negative_flag(),
        .valid_out(alu_valid)
    );

    // -----------------------
    // Writeback Stage
    // -----------------------
    writeback wb_stage (
    .clk(clk_wb),
    .rst(reset),
    .req(req_alu_wb),
    .ack(ack_alu_wb),
    .rd(addr_w_id), // still passing from ID
    .result(alu_result),
    .write_en(we_rf),
    .write_addr(addr_w_rf), // final write address
    .write_data(data_wb)
);


endmodule
