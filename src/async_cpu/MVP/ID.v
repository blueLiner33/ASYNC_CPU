`define op_MOV 5'b00000 //register to register move
`define op_LD 5'b00001 //load word from memory to register
`define op_ST 5'b00010 //store word from register to memory
`define op_ADD 5'b00011 //Add two registers
`define op_SUB 5'b00100 //subtract second register from first
`define op_AND 5'b00101 //bitwise and between two registers
`define op_OR 5'b00110   // 	Bitwise OR between two registers
`define op_NOT 5'b00111  //bitwise not
`define op_JMP 5'b01000  //unconditional jump
`define op_NOP 5'b01001   //no operation used for timing

module ID (
    input wire [15:0] instruction,
    input wire [15:0] WB_data,
    input wire [3:0] WB_reg_addr,
    input wire WB_reg_write,
    input wire clk,
    input wire reset,

    output wire [15:0] reg_out_A,
    output wire [15:0] reg_out_B.
    output wire [15:0] immediate,
    output wire [3:0] dest_reg_addr,
    output wire [3:0] opcode
)

endmodule