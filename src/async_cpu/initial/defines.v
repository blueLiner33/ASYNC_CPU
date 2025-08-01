// ==== OPCODES ====
`define OP_MOV            5'b00000
`define OP_LD             5'b00001
`define OP_ST             5'b00010
`define OP_ADD            5'b00011
`define OP_SUB            5'b00100
`define OP_AND            5'b00101
`define OP_OR             5'b00110
`define OP_NOT            5'b00111
`define OP_JMP            5'b01000
`define OP_NOP            5'b01001

`define OP_OB_CHECK       5'b01010
`define OP_MOVE_LEFT      5'b01011
`define OP_MOVE_RIGHT     5'b01100
`define OP_STOP           5'b01101
`define OP_CONTINUE       5'b01110
`define OP_VELOCITY_GUARD 5'b01111

`define OP_CMP            5'b10000
`define OP_MULT           5'b10001
`define OP_DIV            5'b10010

// ==== ACTION CODES ====
`define ACTION_STOP       16'd0
`define ACTION_LEFT       16'd1
`define ACTION_RIGHT      16'd2
`define ACTION_CONTINUE   16'd3
