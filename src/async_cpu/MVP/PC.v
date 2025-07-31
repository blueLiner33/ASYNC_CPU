module program_counter #(
    parameter WIDTH = 8   // 8-bit PC -> 256 instructions
)(
    input  wire clk,
    input  wire reset,
    input  wire branch_en,
    input  wire [WIDTH-1:0] branch_addr,
    output reg  [WIDTH-1:0] pc
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;                     // start program at address 0
        else if (branch_en)
            pc <= branch_addr;           // jump to new address
        else
            pc <= pc + 1;                // fetch next instruction
    end

endmodule
