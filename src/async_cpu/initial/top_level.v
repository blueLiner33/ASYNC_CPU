module cpu_top(
    input  wire        clk_if,
    input  wire        clk_id,
    input  wire        clk_alu,
    input  wire        clk_wb,
    input  wire        clk_regfile,
    input  wire        reset
);

    // -----------------------
    // Handshake signals
    // -----------------------
    logic req_if_id,  ack_if_id;
    logic req_id_alu, ack_id_alu;
    logic req_alu_wb, ack_alu_wb;
    logic req_wb_rf,  ack_wb_rf;

    // -----------------------
    // Data buses
    // -----------------------
    logic [31:0] instr;
    logic [7:0]  pc;
    
    logic [15:0] reg_data1, reg_data2; // From RF to ID
    logic [15:0] alu_in1, alu_in2;     // From ID to ALU
    logic [15:0] alu_result;
    
    logic [3:0]  addr_r1, addr_r2;     // From ID to RF
    logic [3:0]  addr_w_rf;            // From WB to RF
    logic        we_rf;
    logic [15:0] data_wb;

    logic [7:0]  branch_addr;
    logic        branch_en;
    logic [4:0]  alu_op;

    // -----------------------
    // Instruction Fetch (IF) stage
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
    // Instruction Decode (ID) stage
    // -----------------------
    ID id_stage (
        .clk(clk_id),
        .reset(reset),
        .req(req_if_id),
        .ack(ack_if_id),
        .instr(instr),
        .pc(pc),
        .reg_data1(reg_data1),     // From RF
        .reg_data2(reg_data2),     // From RF
        .reg_addr1(addr_r1),       // To RF
        .reg_addr2(addr_r2),       // To RF
        .alu_in1(alu_in1),         // To ALU
        .alu_in2(alu_in2),         // To ALU
        .alu_op(alu_op),           // To ALU
        .branch_en(branch_en),
        .branch_addr(branch_addr),
        .we(we_rf),                // To RF + WB
        .addr_w(addr_w_rf)        // To RF + WB
    );

    // -----------------------
    // Register File (RF)
    // -----------------------
    AsyncRegisterFile rf (
        .clk(clk_regfile),
        .req(req_wb_rf),
        .ack(ack_wb_rf),
        .we(we_rf),
        .addr_w(addr_w_rf),
        .addr_r1(addr_r1),
        .addr_r2(addr_r2),
        .data_in(data_wb),
        .data_out1(reg_data1),
        .data_out2(reg_data2)
    );

    // -----------------------
    // ALU stage
    // -----------------------
    custom_alu alu_unit (
        .clk(clk_alu),
        .rst(reset),
        .opcode(alu_op),
        .A(alu_in1),
        .B(alu_in2),
        .car_x(4'b0),          // Tie off if unused
        .img_row(16'b0),       // Tie off if unused
        .velocity_en(1'b0),    // Tie off if unused
        .result(alu_result),
        .zero_flag(),          // Can connect if needed
        .negative_flag(),
        .valid_out()
    );

    // -----------------------
    // Write-Back (WB) stage
    // -----------------------
    writeback wb_stage (
        .clk(clk_wb),
        .req(req_alu_wb),
        .ack(ack_alu_wb),
        .alu_result(alu_result),
        .write_reg(we_rf),
        .write_addr(addr_w_rf),
        .write_data(data_wb),
        .reg_ack(ack_wb_rf)
    );

    // -----------------------
    // Handshake FSMs
    // -----------------------

    // IF -> ID
    always_ff @(posedge clk_if or posedge reset) begin
        if (reset)
            req_if_id <= 0;
        else if (!req_if_id && !ack_if_id)
            req_if_id <= 1;
        else if (req_if_id && ack_if_id)
            req_if_id <= 0;
    end

    // ID -> ALU
    always_ff @(posedge clk_id or posedge reset) begin
        if (reset)
            req_id_alu <= 0;
        else if (!req_id_alu && !ack_id_alu)
            req_id_alu <= 1;
        else if (req_id_alu && ack_id_alu)
            req_id_alu <= 0;
    end

    // ALU -> WB
    always_ff @(posedge clk_alu or posedge reset) begin
        if (reset)
            req_alu_wb <= 0;
        else if (!req_alu_wb && !ack_alu_wb)
            req_alu_wb <= 1;
        else if (req_alu_wb && ack_alu_wb)
            req_alu_wb <= 0;
    end

    // WB -> Register File
    always_ff @(posedge clk_wb or posedge reset) begin
        if (reset)
            req_wb_rf <= 0;
        else if (!req_wb_rf && !ack_wb_rf)
            req_wb_rf <= 1;
        else if (req_wb_rf && ack_wb_rf)
            req_wb_rf <= 0;
    end

endmodule
