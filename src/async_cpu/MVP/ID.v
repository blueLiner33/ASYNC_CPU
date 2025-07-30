`define OP_MOV 5'b00000 //register to register move
`define OP_LD 5'b00001 //load word from memory to register

`define OP_ADD 5'b00011 //Add two registers
`define OP_SUB 5'b00100 //subtract second register from first
`define OP_AND 5'b00101 //bitwise and between two registers
`define OP_OR 5'b00110   // 	Bitwise OR between two registers
`define OP_NOT 5'b00111  //bitwise not
`define OP_JMP 5'b01000  //unconditional jump
`define OP_NOP 5'b01001   //no operation used for timing
`define OP_OB_CHECK       5'b01010 //driving 
`define OP_VELOCITY_GUARD 5'b01111 //driving spec
//possible out comes
`define OP_MOVE_LEFT      5'b01011
`define OP_MOVE_RIGHT     5'b01100
`define OP_STOP           5'b01101
`define OP_CONTINUE       5'b01110


`define OP_CMP 5'b10000 //compare
`define OP_MULT 5'b10001 //multiplication
`define OP_DIV 5'b10010 //division

module ID (
    input wire [31:0] instruction,
    input wire [15:0] WB_data,//write back
    input wire [3:0] WB_reg_addr,//which to write data to
    input wire WB_reg_write,//enables register file write
    input wire clk,
    input wire reset,
        // FIFO interface
    output reg  [41:0] fifo_data,
    output reg         fifo_wr_en,
    input  wire        fifo_wr_ready
);
    wire [4:0] opcode = instruction [31:27];
    wire [3:0] rd = instruction [26:23];
    wire [3:0] rsone = instruction [22:19];
    wire [3:0] rstwo = instruction [18:15];


    wire [15:0] reg_out_A, reg_out_B;
    regfile RF (
        .clk(clk),
        .we(WB_reg_write),
        .waddr(WB_reg_addr),
        .wdata(WB_data),
        .raddr1(rsone),
        .raddr2(rstwo),
        .rdata1(reg_out_A),
        .rdata2(reg_out_B)
    );

    always@(*)begin
    fifo_wr_en = 0;
    fifo_data  = 0;

    if (fifo_wr_ready) begin
        case (opcode)
        //alu ops
        `OP_MOV, `OP_ADD, `OP_SUB, `OP_AND, `OP_OR, `OP_NOT,
        `OP_CMP, `OP_MULT, `OP_DIVSION:
            fifo_data = {reg_out_B, reg_out_A, opcode, rd};

        //car ops
        `OP_MOVE_LEFT, `OP_MOVE_RIGHT, `OP_STOP, `OP_CONTINUE:
            fifo_data = {16'b0, 16'b0, opcode, rd};

        //sen ops
        `OP_OB_CHECK, `OP_VELOCITY_GUARD:
            fifo_data = {reg_out_B, reg_out_A, opcode, rd};

        default:
            fifo_data = 0;
        endcase
        fifo_wr_en = 1;  
    
        end
    end

endmodule