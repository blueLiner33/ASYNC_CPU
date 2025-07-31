// General-purpose operations
`define OP_MOV             5'b00000 // Register to register move
`define OP_LD              5'b00001 // Load word from memory to register
`define OP_ST              5'b00010 // Store word to memory
`define OP_ADD             5'b00011 // Add two registers
`define OP_SUB             5'b00100 // Subtract second register from first
`define OP_AND             5'b00101 // Bitwise AND
`define OP_OR              5'b00110 // Bitwise OR
`define OP_NOT             5'b00111 // Bitwise NOT
`define OP_JMP             5'b01000 // Unconditional jump
`define OP_NOP             5'b01001 // No operation

// Driving / Sensor operations
`define OP_OB_CHECK        5'b01010 // Obstacle check
`define OP_MOVE_LEFT       5'b01011
`define OP_MOVE_RIGHT      5'b01100
`define OP_STOP            5'b01101
`define OP_CONTINUE        5'b01110
`define OP_VELOCITY_GUARD  5'b01111

// Extended ALU operations
`define OP_CMP             5'b10000 // Compare
`define OP_MULT            5'b10001 // Multiply
`define OP_DIV             5'b10010 // Divide

`define ACTION_STOP        16'd0
`define ACTION_LEFT        16'd1
`define ACTION_RIGHT       16'd2
`define ACTION_CONTINUE    16'd3