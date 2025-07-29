//////////////////////////////////////////////////////////////////////
////                                                              ////
////  ID.v	                                                  ////
////                                                              ////
////  This file is part of the ASPIDA IP core project             ////
////  http://www.opencores.org/projects/aspida/                   ////
////		  and						  ////
////   http://www.ics.forth.gr/carv/aspida			  ////	
////                                                              ////
////  Author(s):                                                  ////
////      - Christos Sotiriou (sotiriou@ics.forth.gr)		  ////
////      - ASPIDA Consortium					  ////
////                                                              ////
////  All additional information is avaliable in the Readme.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2002-2003 Authors				  ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

// function fields of R-Type instructions
`define   ADD 	6'b100000
`define   ADDU 	6'b100001
`define   SUB 	6'b100010
`define   SUBU 	6'b100011
`define   AND 	6'b100100
`define    OR 	6'b100101
`define   XOR	6'b100110
`define   SLL	6'b000100
`define   SRL	6'b000110
`define   SRA	6'b000111
`define   SEQ	6'b101000
`define   SNE	6'b101001
`define   SLT	6'b101010
`define   SGT	6'b101011
`define   SLE	6'b101100
`define   SGE	6'b101101
`define   MOVS2I 6'b110001

// opcode fields of I-Type instructions
`define    LW 	6'b100011
`define    SW 	6'b101011

`define    LB	6'b100000
`define    LH	6'b100001
`define   LBU	6'b100100
`define   LHU	6'b100101
`define    SB	6'b101000
`define    SH	6'b101001

`define   LHI	6'b001111

`define  ADDI 	6'b001000
`define  ADDUI 	6'b001001
`define  SUBI 	6'b001010
`define  SUBUI 	6'b001011
`define  ANDI 	6'b001100
`define   ORI 	6'b001101
`define  XORI 	6'b001110
`define  SRLI 	6'b010110
`define  SLLI 	6'b010100
`define  SRAI 	6'b010111
`define  BEQZ 	6'b000100
`define  BNEZ 	6'b000101
`define  SEQI	6'b011000
`define  SNEI	6'b011001
`define  SLTI	6'b011010
`define  SGTI	6'b011011
`define  SLEI	6'b011100
`define  SGEI	6'b011101

// opcode fields of J-Type instructions
`define     J 	6'b000010
`define    JR 	6'b010010

`define   JAL 	6'b000011
`define  JALR 	6'b010011

// R-Type instructions
`define  R_TYPE 6'b000000

`define  TRAP	6'b010001
`define  RFE 	6'b010000

module ID(clk_IF_del, INT, CLI_sl, PIPEEMPTY, FREEZE, branch_address_sl, 
branch_sig_sl, Imm_sl, rt_addr_sl, rd_addr_sl, reg_dst_sl, reg_write_sl, 
mem_to_reg_sl, mem_write_sl, mem_read_sl, IR_opcode_field_sl, 
IR_function_field_sl, stall_sl, counter_sl, clk, reset, NPC,/* PC,*/ 
IR_latched_input, opcode_of_EX, opcode_of_MEM, 
opcode_of_WB, reg_dst_of_EX, reg_dst_of_MEM, reg_out_A_sl, 
reg_out_B_sl, reg_write_WB, WB_index, WB_data, WB_data_old, 
ex_noop, mem_noop, clk_sl);


input clk_IF_del; // only needed as reference for RF read //
   
input ex_noop;
input mem_noop;
// Input Ports

input clk_sl;		//slave controller pulse

input	  	 clk;						// clock 
input		 reset;						// reset pulse
input [31:0] NPC;
//input [31:0] PC;
input [31:0] IR_latched_input;

// input signals for stalling
input [5:0] opcode_of_EX;
input [5:0] opcode_of_MEM;
input [5:0] opcode_of_WB;

input [4:0] reg_dst_of_EX;
input [4:0] reg_dst_of_MEM;

// Output Ports

output [31:0] branch_address_sl;
output 	      branch_sig_sl;		// branch control signal
output [31:0] Imm_sl;
output [4:0]  rt_addr_sl;
output [4:0]  rd_addr_sl;
reg [31:0] branch_address_sl;
reg 	      branch_sig_sl;		// branch control signal
//synthesis attribute equivalent_register_removal	of Imm_sl is NO;
reg [31:0] Imm_sl;
reg [4:0]  rt_addr_sl;
reg [4:0]  rd_addr_sl;

// outputs that are control signals used at stage EX
output 		  reg_dst_sl;
output [5:0]  IR_opcode_field_sl;
output [5:0]  IR_function_field_sl;
reg 		  reg_dst_sl;
reg [5:0]  IR_opcode_field_sl;
reg [5:0]  IR_function_field_sl;
// outputs that are control signals used at stage MEM
output 		  mem_write_sl;
output	      mem_read_sl;
reg 		  mem_write_sl;
reg	      mem_read_sl;
// outputs that are control signals used at stage WB
output 		  reg_write_sl; 
output		  mem_to_reg_sl;
reg 		  reg_write_sl; 
reg		  mem_to_reg_sl;
// output signals for stalling
output stall_sl;
output [1:0] counter_sl;
reg stall_sl;
reg [1:0] counter_sl;

reg [31:0] branch_address;
reg 	   branch_sig;

//synthesis attribute equivalent_register_removal of Imm is NO;
reg [31:0] Imm;
reg [4:0]  rt_addr;
reg [4:0]  rd_addr;

reg 	   reg_dst;
reg [5:0]  IR_opcode_field;
reg [5:0]  IR_function_field;
reg 	   mem_write;
reg        mem_read;
reg 	   reg_write;
reg        mem_to_reg;

reg [1:0] counter;

reg [31:0] current_IR ;
reg [31:0] current_IR_sl;

reg stall;

//synthesis attribute KEEP of IR_latched is TRUE;
wire [31:0] IR_latched;
assign IR_latched =  (counter_sl != 2'd0 ) ? current_IR_sl : IR_latched_input;

//synthesis attribute KEEP of regA_index is TRUE;
wire [4:0] regA_index;
assign regA_index = IR_latched[25:21];
//synthesis attribute KEEP of regB_index is TRUE;
wire [4:0] regB_index;
assign regB_index = IR_latched[20:16];
//synthesis attribute KEEP of IR_opcode is TRUE;
wire [5:0] IR_opcode;
assign IR_opcode = IR_latched[31:26];

output [31:0] reg_out_A_sl;
output [31:0] reg_out_B_sl;
reg [31:0] reg_out_A_sl;
reg [31:0] reg_out_B_sl;
 
reg [31:0] reg_out_A;
reg [31:0] reg_out_B;
   
//reg [31:0] RegFile [0:31];				// CPU Register File

wire [31:0] offset = {{16{IR_latched[15]}},IR_latched[15:0]};

wire [31:0] jtarget = {{6{IR_latched[25]}}, IR_latched[25:0]};

input reg_write_WB; // write signal coming out of WB //

input [31:0] WB_data;
   
input [31:0] WB_data_old;

input [4:0] WB_index;

//synthesis attribute KEEP of WB_data_eff is TRUE;
reg [31:0] WB_data_eff;
//synthesis attribute KEEP of WB_data_eff_sl is TRUE;
reg [31:0] WB_data_eff_sl;

wire[31:0] reg_out_A_RF;
wire[31:0] reg_out_B_RF;

reg [31:0] EPC;		// exception PC //
reg [31:0] EPC_sl;

reg [31:0] Cause_Reg;	// Cause Register //
reg [31:0] Cause_Reg_sl;

//wire zflag = (RegFile[regA_index]==32'b0) ? 1 : 0;  // zero flag for branches //

wire [31:0] regA_eff = (reg_write_WB && (regA_index == WB_index) && ( regA_index != 0) ) ? WB_data : 
                       (regA_index == 0) ? 32'b0 :
	               reg_out_A_RF;

wire [31:0] regB_eff = (reg_write_WB && (regB_index == WB_index) && ( regB_index != 0) ) ? WB_data : 
	               (regB_index == 0) ? 32'b0:
	               reg_out_B_RF;   

wire zflag = (regA_eff == 32'b0) ? 1 : 0;  // zero flag for branches //			    

reg delay_slot;
reg delay_slot_sl;
reg [1:0] slot_num;
reg [1:0] slot_num_sl;

input INT;	// synchronised interrupt //

output CLI_sl;     // clear interrupt //
reg CLI_sl;
reg CLI;

output PIPEEMPTY;
//reg PIPEEMPTY_sl;

reg intr_slot;
reg intr_slot_sl;

input FREEZE;

//wire PIPEEMPTY = ((IR_latched == 0) && ex_noop && mem_noop);
wire PIPEEMPTY = (FREEZE && ex_noop && mem_noop);
// RF set 0
   // Port A: register read port A
   // Port B: write_back

   RAMB4_S16_S16 RF_block0s0 (.DOA(reg_out_A_RF[15:0]), .ADDRA({3'b0, regA_index}), .CLKA(clk_IF_del), .DIA(),
			      .ENA((regA_index != WB_index)), .RSTA((regA_index == 0)), .WEA(1'b0),
			      .DOB(), .ADDRB({3'b00, WB_index}), .CLKB(clk), .DIB(WB_data_eff[15:0]),
			      .ENB((WB_index != 0)), .RSTB(1'b0), .WEB(reg_write_WB)
			      );
   
   RAMB4_S16_S16 RF_block1s0 (.DOA(reg_out_A_RF[31:16]), .ADDRA({3'b0, regA_index}), .CLKA(clk_IF_del), .DIA(),
			      .ENA((regA_index != WB_index)), .RSTA((regA_index == 0)), .WEA(1'b0),
			      .DOB(), .ADDRB({3'b0, WB_index}), .CLKB(clk), .DIB(WB_data_eff[31:16]),
			      .ENB((WB_index != 0)), .RSTB(1'b0), .WEB(reg_write_WB)
			      );

   // RF set 1
   // Port A: register read port B
   // Port B: write_back

   RAMB4_S16_S16 RF_block0s1 (.DOA(reg_out_B_RF[15:0]), .ADDRA({3'b0, regB_index}), .CLKA(clk_IF_del), .DIA(),
			      .ENA((regB_index != WB_index)), .RSTA((regB_index == 0)), .WEA(1'b0),
			      .DOB(), .ADDRB({3'b0, WB_index}), .CLKB(clk), .DIB(WB_data_eff[15:0]),
			      .ENB((WB_index != 0)), .RSTB(1'b0), .WEB(reg_write_WB)
			      );
   
   RAMB4_S16_S16 RF_block1s1 (.DOA(reg_out_B_RF[31:16]), .ADDRA({3'b0, regB_index}), .CLKA(clk_IF_del), .DIA(),
			      .ENA((regB_index != WB_index)), .RSTA((regB_index == 0)), .WEA(1'b0),
			      .DOB(), .ADDRB({3'b0, WB_index}), .CLKB(clk), .DIB(WB_data_eff[31:16]),
			      .ENB((WB_index != 0)), .RSTB(1'b0), .WEB(reg_write_WB)
			      );
   
   // synthesis attribute KEEP of WB_index is TRUE
   // synthesis attribute KEEP of WB_data_eff is TRUE
   // synthesis attribute KEEP of regA_index is TRUE
   // synthesis attribute KEEP of regB_index is TRUE
   // synthesis attribute KEEP of regA_eff is TRUE
   // synthesis attribute KEEP of regB_eff is TRUE

always @(opcode_of_WB or WB_data /*or WB_data_old*/)
begin
	case (opcode_of_WB)

		/*
		`LB  :  WB_data_eff <= (WB_data & 32'hFFFFFF00) | WB_data_old;

		`LH  :  WB_data_eff <= (WB_data & 32'hFFFF0000) | WB_data_old;
		
		`LBU :  WB_data_eff <= (WB_data & 32'hFFFFFF00) << 24;
		
		`LHU :  WB_data_eff <= (WB_data & 32'hFFFF0000) << 16;
		*/

		`LB  :  WB_data_eff <= { {24{WB_data[7]}}, WB_data[7:0]};

		`LH  :  WB_data_eff <= { {16{WB_data[15]}}, WB_data[15:0]};
		
		`LBU  :  WB_data_eff <= {24'b0, WB_data[7:0]};

		`LHU  :  WB_data_eff <= {16'b0, WB_data[15:0]};

		 default : WB_data_eff <= WB_data;

	endcase
end
always @(posedge clk_sl or posedge reset)
begin
	if(reset)
	begin
		branch_address_sl    <= 32'd0;
		branch_sig_sl        <=  1'd0;
		Imm_sl               <= 32'd0;
		rt_addr_sl           <=  5'd0;
		rd_addr_sl           <=  5'd0;
		reg_dst_sl           <=  1'd0;
		reg_write_sl         <=  1'd0;
		mem_to_reg_sl		  <=  1'd0;
		mem_read_sl		  <=  1'd0;
		mem_write_sl		  <=  1'd0;
		IR_opcode_field_sl   <=  6'd0;
		IR_function_field_sl <=  6'd0;
		counter_sl			<=  2'd0;
		reg_out_A_sl <= 32'd0;
		reg_out_B_sl <= 32'd0;
		stall_sl <= 0;
		CLI_sl <= 0;
//		PIPEEMPTY_sl <= 0;
		current_IR_sl <= 32'd0;
		WB_data_eff_sl <= 32'd0;
		EPC_sl <= 32'd0;
		Cause_Reg_sl <= 32'd0;
		delay_slot_sl <= 1'd0;
		slot_num_sl <= 2'd0;
		intr_slot_sl <= 1'd0;	
	end
	else
	begin
	   	branch_address_sl    <= branch_address;
		branch_sig_sl        <=  branch_sig;
		Imm_sl               <= Imm;
		rt_addr_sl           <=  rt_addr;
		rd_addr_sl           <=  rd_addr;
		reg_dst_sl           <=  reg_dst;
		reg_write_sl         <=  reg_write;
		mem_to_reg_sl		  <=  mem_to_reg;
		mem_read_sl		  <=  mem_read;
		mem_write_sl		  <=  mem_write;
		IR_opcode_field_sl   <=  IR_opcode_field;
		IR_function_field_sl <=  IR_function_field;
		counter_sl			<=  counter;
		reg_out_A_sl <= reg_out_A;
		reg_out_B_sl <= reg_out_B;
		stall_sl <= stall;
		CLI_sl <= CLI;
//		PIPEEMPTY_sl <= PIPEEMPTY;
		current_IR_sl <= current_IR;
		WB_data_eff_sl <= WB_data_eff;
		EPC_sl <= EPC;
		Cause_Reg_sl <= Cause_Reg;
		delay_slot_sl <= delay_slot;
		slot_num_sl <= slot_num;
		intr_slot_sl <= intr_slot;
	end
end
// always @(posedge clk or posedge reset)

always @(posedge clk or posedge reset)
begin

if (reset)
		begin

		branch_address    <= 32'd0;
		branch_sig        <=  1'd0;

		Imm               <= 32'd0;
		rt_addr           <=  5'd0;
		rd_addr           <=  5'd0;

		reg_dst           <=  1'd0;
		reg_write         <=  1'd0;
		mem_to_reg		  <=  1'd0;
		mem_read		  <=  1'd0;
		mem_write		  <=  1'd0;
		IR_opcode_field   <=  6'd0;
		IR_function_field <=  6'd0;

		counter			<=  2'd0;	
		current_IR <= 32'd0 ;
/*	
		RegFile[0]  <= 32'd0;
		RegFile[1]  <= 32'd0;
		RegFile[2]  <= 32'd0;
		RegFile[3]  <= 32'd0;
		RegFile[4]  <= 32'd0;
		RegFile[5]  <= 32'd0;
		RegFile[6]  <= 32'd0;
		RegFile[7]  <= 32'd0;

		RegFile[8]  <= 32'd0;
		RegFile[9]  <= 32'd0;
		RegFile[10] <= 32'd0;
		RegFile[11] <= 32'd0;
		RegFile[12] <= 32'd0;
		RegFile[13] <= 32'd0;
		RegFile[14] <= 32'd0;
		RegFile[15] <= 32'd0;

		RegFile[16] <= 32'd0;
		RegFile[17] <= 32'd0;
		RegFile[18] <= 32'd0;
		RegFile[19] <= 32'd0;
		RegFile[20] <= 32'd0;
		RegFile[21] <= 32'd0;
		RegFile[22] <= 32'd0;
		RegFile[23] <= 32'd0;

		RegFile[24] <= 32'd0;
		RegFile[25] <= 32'd0;
		RegFile[26] <= 32'd0;
		RegFile[27] <= 32'd0;
		RegFile[28] <= 32'd0;
		RegFile[29] <= 32'd0;
		RegFile[30] <= 32'd0;
		RegFile[31] <= 32'd0;
 */
		reg_out_A <= 32'd0;
		reg_out_B <= 32'd0;

		stall <= 0;

		delay_slot <= 0;
		slot_num <= 2'b00;

		EPC <= 32'b0;

		CLI <= 0;
		intr_slot <= 0;		
	end

else

begin
		// RF Read/Write //
//	if (reg_write_WB) begin
//		RegFile[WB_index] <= WB_data_eff;
//	end

	if (IR_opcode == `MOVS2I) begin
		case  (regA_index)
			1: reg_out_A <= Cause_Reg_sl;
			2: reg_out_A <= EPC_sl;
			default: reg_out_A <= 0;
		endcase
	end
	else begin
		reg_out_A <= regA_eff;
	end

	reg_out_B <= regB_eff;
/*
		if (reg_write_WB == 0)
		begin
			reg_out_A <= RegFile[regA_index];
			reg_out_B <= RegFile[regB_index];
		end
		else begin // reg_write_WB == 1
			if (WB_index != 0) begin
				RegFile[WB_index] <= WB_data_eff;
				reg_out_A <= regA_eff; //(regA_index == WB_index) ? WB_data_eff : RegFile[regA_index];
				reg_out_B <= regB_eff; //(regB_index == WB_index) ? WB_data_eff : RegFile[regB_index];
			end
			else begin
				reg_out_A <= RegFile[regA_index];
				reg_out_B <= RegFile[regB_index];
			end
		end
*/
		/*if ((reg_write_WB == 1) && (regA_index != WB_index) && (regB_index != WB_index))
		begin
			RegFile[WB_index] <= WB_data_eff;
			reg_out_A <= (regA_index != 0) ? RegFile[regA_index] : 0;
			reg_out_B <= (regB_index != 0) ? RegFile[regB_index] : 0;
		end
		else if ((reg_write_WB == 1) && (regA_index == WB_index) && (regB_index != WB_index))
		begin
			RegFile[WB_index] <= WB_data_eff;
			reg_out_A <= WB_data_eff;
			reg_out_B <= (regB_index != 0) ? RegFile[regB_index] : 0;
		end
		else if ((reg_write_WB == 1) && (regA_index != WB_index) && (regB_index == WB_index))
		begin
			RegFile[WB_index] <= WB_data_eff;
			reg_out_A <= (regA_index != 0) ? RegFile[regA_index] : 0;
			reg_out_B <= WB_data_eff;
		end
		else if ((reg_write_WB == 1) && (regA_index == WB_index) && (regB_index == WB_index))
		begin
			RegFile[WB_index] <= WB_data_eff;
			reg_out_A <= WB_data_eff;
			reg_out_B <= WB_data_eff;
		end*/

		if (stall_sl == 1) stall <= 0;

if ((counter_sl != 0) || (delay_slot_sl && (slot_num_sl!=2'b11)) || intr_slot_sl || (FREEZE && !(delay_slot_sl)))
	begin
		IR_opcode_field <= 6'd0;
	       	IR_function_field <= 6'd0;
	       	mem_read <= 1'b0;
	       	mem_write <= 1'b0;
	       	reg_write <= 1'b0;
	       	branch_sig <= 1'b0;
	       	reg_dst <= 2'b00;
		mem_to_reg <= 2'b00;
		rt_addr <= 5'd0;
	        rd_addr <= 5'd0;
        	Imm <= 32'd0;
		if (counter_sl != 0)
			 counter <= counter_sl - 1; 
		
		if ((delay_slot_sl || intr_slot_sl) && (slot_num_sl == 2'b10))
		begin
			slot_num <= 2'b01;
		end
		else
		if (delay_slot_sl && (slot_num_sl == 2'b01))
		begin
			delay_slot <= 0;				// recover from delay slot //
			slot_num <= 2'd0;
		end
		else
		if (intr_slot_sl && (slot_num_sl == 2'b01))
		begin
			intr_slot <= 0;
			slot_num <= 2'd0;
		end
		else 
		if ((FREEZE == 1) && !intr_slot_sl) stall <= 1;  	// stall pipeline after delay slot, intr slot //
	end

else 

if ( ((counter_sl == 2'b00) && !stall_sl) || (delay_slot_sl && (slot_num_sl == 2'b11)))
begin   

	current_IR <= IR_latched;	

	if (IR_opcode == 6'b000000)	// R-Type format 
	begin						
		reg_dst <= 1;
		reg_write <= 1;
		mem_write <= 0;
		mem_read <= 0;
		mem_to_reg <= 0;
	end
	else if (/*IR_opcode!=0 && */(IR_opcode!=`J && IR_opcode!=`JAL && IR_opcode!=`JALR && IR_opcode!=`JR)) // I-Type format
	begin
		reg_dst <= 0;

		if ((IR_opcode == `LW) || (IR_opcode == `LB) || (IR_opcode == `LH) || (IR_opcode == `LBU) || (IR_opcode == `LHU))
		begin
			reg_write <= 1;
			mem_read <= 1;
			mem_write <= 0;
			mem_to_reg <= 1;
		end
		else if ((IR_opcode == `SW) || (IR_opcode == `SH) || (IR_opcode == `SB))
		begin
			reg_write <= 0;
			mem_read <= 0;
			mem_write <= 1;
			mem_to_reg <= 0;
		end
		else
		begin						// immediate must write to register //
			reg_write <= 1;
			mem_read <= 0;
			mem_write <= 0;
			mem_to_reg <= 0;
		end
	end
	else
	begin							// J-Type format
			reg_dst <= 0;
			reg_write <= 0;
			mem_read <= 0;
			mem_write <= 0;
			mem_to_reg <= 0;
	end

	IR_opcode_field <= IR_opcode;
	IR_function_field <= IR_latched[5:0];
	
	rt_addr <= IR_latched[20:16];
	rd_addr <= IR_latched[15:11];

	Imm[15:0] <= IR_latched[15:0];
	Imm[31:16] <= (IR_latched[15] && (IR_opcode != `ADDUI)  && (IR_opcode != `SUBUI)) ? {16{1'b1}} : {16'b0};

	if (delay_slot_sl && (slot_num_sl==2'b11))
		begin
			delay_slot <= 1;
			slot_num <= 2'b10;
		end
	else if (!delay_slot_sl)
		begin
			delay_slot <= 0;
			slot_num <= 2'b00;
		end

	intr_slot <= 0;
	
	if (IR_opcode==`JAL)
			begin
				counter <= 2'b00;
				stall <= 0;

				delay_slot <= 1;
				slot_num <= 2'b11;

				branch_sig <= 1;

				branch_address <= NPC + jtarget - 4;

				IR_opcode_field <= 6'd0;
		       		IR_function_field <= `ADD;
			       	mem_read <= 1'b0;
			       	mem_write <= 1'b0;
			       	reg_write <= 1'b1;
			       	reg_dst <= 1;
				mem_to_reg <= 2'b00;
				rt_addr <= 5'd0;
			        rd_addr <= 5'd31;
		        	Imm <= 32'd0;

				reg_out_A <= NPC;
				reg_out_B <= 32'b0;
			end
	else
	if (IR_opcode==`JALR)
			begin
				counter <= 2'b00;
				stall <= 0;

				delay_slot <= 1;
				slot_num <= 2'b11;

				branch_sig <= 1;

				branch_address <= regA_eff;

				IR_opcode_field <= 6'd0;
		       		IR_function_field <= `ADD;
			       	mem_read <= 1'b0;
			       	mem_write <= 1'b0;
			       	reg_write <= 1'b1;
			       	reg_dst <= 1;
				mem_to_reg <= 2'b00;
				rt_addr <= 5'd0;
			        rd_addr <= 5'd31;
		        	Imm <= 32'd0;

				reg_out_A <= NPC;
				reg_out_B <= 32'b0;
			end
	else
	if ((IR_opcode==`TRAP) || (INT && !delay_slot_sl && !CLI_sl))
			begin
				counter <= 2'b00;
				stall <= 0;
			
				intr_slot <= 1;
			
				delay_slot <= 0;
				slot_num <= 2'b11;

				CLI <= 1;
			
				branch_sig <= 1;

				branch_address <= 32'h80000080;
		
				EPC <= NPC;			// store return address //
				Cause_Reg <= Imm_sl;

				//IR_opcode_field <= 6'd0;
		       		//IR_function_field <= 6'd0;
			       	mem_read <= 1'b0;
			       	mem_write <= 1'b0;
			       	//reg_write <= 1'b1;
			       	reg_write <= 1'b0;
			       	//reg_dst <= 1;
				//mem_to_reg <= 2'b00;
				//rt_addr <= 5'd0;
			        //rd_addr <= 5'd0;
		        	//Imm <= 32'd0;

				//reg_out_A <= 32'b0;
				//reg_out_B <= 32'b0;
			end
	else 
	if (IR_opcode==`RFE) 
			begin
				counter <= 2'b00;
				stall <= 0;

				intr_slot <= 1;

				delay_slot <= 0;
				slot_num <= 2'b11;

				CLI <= 0;

				branch_sig <= 1;

				branch_address <= EPC_sl;        // return to EPC //

				IR_opcode_field <= 6'd0;
		       		IR_function_field <= 6'd0;
			       	mem_read <= 1'b0;
			       	mem_write <= 1'b0;
			       	reg_write <= 1'b1;
			       	reg_dst <= 1;
				mem_to_reg <= 2'b00;
				rt_addr <= 5'd0;
			        rd_addr <= 5'd0;
		        	Imm <= 32'd0;

				reg_out_A <= 32'b0;
				reg_out_B <= 32'b0;
			end
	else
	if (IR_opcode==`J)
			begin
				counter <= 2'b00;
				stall <= 0;

				delay_slot <= 1;
				slot_num <= 2'b11;

				branch_sig <= 1;

				branch_address <= NPC + jtarget - 4;

				IR_opcode_field <= 6'd0;
		       		IR_function_field <= 6'd0;
			       	mem_read <= 1'b0;
			       	mem_write <= 1'b0;
			       	reg_write <= 1'b0;
			       	reg_dst <= 2'b00;
				mem_to_reg <= 2'b00;
				rt_addr <= 5'd0;
			        rd_addr <= 5'd0;
		        	Imm <= 32'd0;				
			end
	else 

	if ((regA_index == reg_dst_of_EX) && (regA_index != 0))
		begin
			if ((opcode_of_EX==`R_TYPE) || (opcode_of_EX==`LW) || (opcode_of_EX==`LH) || (opcode_of_EX==`LB) ||
			     (opcode_of_EX==`LHU) || (opcode_of_EX==`LBU) || (opcode_of_EX==`LHI) || (opcode_of_EX==`ADDI) || 
			     (opcode_of_EX==`SUBI) || (opcode_of_EX==`ANDI) || (opcode_of_EX==`ORI) || (opcode_of_EX==`XORI) || 
			     (opcode_of_EX==`SUBUI) || (opcode_of_EX==`ADDUI) ||
			     (opcode_of_EX==`SLLI) || (opcode_of_EX==`SRLI) || (opcode_of_EX==`SRAI) || (opcode_of_EX==`SEQI) || 
			     (opcode_of_EX==`SNEI) || (opcode_of_EX==`SLTI) || (opcode_of_EX==`SGTI) || (opcode_of_EX==`SLEI) || 
			     (opcode_of_EX==`SGEI) &&
			     ((IR_opcode==`R_TYPE) || (IR_opcode==`ADDI) || (IR_opcode==`SUBI) || (IR_opcode==`ANDI) || 
				(IR_opcode==`ADDUI) || (IR_opcode==`SUBUI) ||
				(IR_opcode==`ORI) || (IR_opcode==`XORI) || (IR_opcode==`SLLI) || (IR_opcode==`SRLI) || 
				(IR_opcode==`SRAI) || (IR_opcode==`SEQI) || (IR_opcode==`SNEI) || (IR_opcode==`SLTI) ||
				(IR_opcode==`SGTI) || (IR_opcode==`SLEI) || (IR_opcode==`SGEI) || (IR_opcode==`BEQZ) || 
				(IR_opcode==`BNEZ) || (IR_opcode==`JR) || (IR_opcode==`JALR) || (IR_opcode==`LW) || 
				(IR_opcode==`LH) || (IR_opcode==`LB) || (IR_opcode==`SW) || (IR_opcode==`SH) || 
				(IR_opcode==`SB) ))
			begin
				counter <= 2'b01;
				stall <= 1;
				
				IR_opcode_field <= 6'd0;
		       		IR_function_field <= 6'd0;
			       	mem_read <= 1'b0;
			       	mem_write <= 1'b0;
			       	reg_write <= 1'b0;
			       	branch_sig <= 1'b0;
				branch_address <= 32'b0;
			       	reg_dst <= 2'b00;
				mem_to_reg <= 2'b00;
				rt_addr <= 5'd0;
			        rd_addr <= 5'd0;
		        	Imm <= 32'd0;
	
			end
			else
				counter <= 2'b00;
		end

	else

	if ((regB_index == reg_dst_of_EX) && (regB_index != 0))
		begin
			if ((opcode_of_EX==`R_TYPE) || (opcode_of_EX==`LW) || (opcode_of_EX==`LH) || (opcode_of_EX==`LB) ||
			     (opcode_of_EX==`LHU) || (opcode_of_EX==`LBU) || (opcode_of_EX==`LHI) || (opcode_of_EX==`ADDI) || 
			     (opcode_of_EX==`SUBUI) || (opcode_of_EX==`ADDUI) ||
			     (opcode_of_EX==`SUBI) || (opcode_of_EX==`ANDI) || (opcode_of_EX==`ORI) || (opcode_of_EX==`XORI) || 
			     (opcode_of_EX==`SLLI) || (opcode_of_EX==`SRLI) || (opcode_of_EX==`SRAI) || (opcode_of_EX==`SEQI) || 
			     (opcode_of_EX==`SNEI) || (opcode_of_EX==`SLTI) || (opcode_of_EX==`SGTI) || (opcode_of_EX==`SLEI) || 
			     (opcode_of_EX==`SGEI) &&
			     ((IR_opcode==`R_TYPE) || (IR_opcode==`SW) || (IR_opcode==`SH) || (IR_opcode==`SB) ))
			begin
				counter <= 2'b01;
				stall <= 1;

				IR_opcode_field <= 6'd0;
	       			IR_function_field <= 6'd0;
		       		mem_read <= 1'b0;
			       	mem_write <= 1'b0;
			       	reg_write <= 1'b0;
			       	branch_sig <= 1'b0;
				branch_address <= 32'b0;
			       	reg_dst <= 2'b00;
				mem_to_reg <= 2'b00;
				rt_addr <= 5'd0;
			        rd_addr <= 5'd0;
		        	Imm <= 32'd0;
			
			end
	         	else            
        	                counter <= 2'b00;
	
		end
	else
	
	if ((regA_index == reg_dst_of_MEM) && (regA_index != 0))
		begin
			if ((opcode_of_MEM==`R_TYPE) || (opcode_of_MEM==`LW) || (opcode_of_MEM==`LH) || (opcode_of_MEM==`LB) ||
			     (opcode_of_MEM==`LHU) ||  (opcode_of_MEM==`LBU) || (opcode_of_MEM==`LHI) || (opcode_of_MEM==`ADDI) || 
			     (opcode_of_MEM==`SUBUI) || (opcode_of_MEM==`ADDUI) ||
			     (opcode_of_MEM==`SUBI) || (opcode_of_MEM==`ANDI) || (opcode_of_MEM==`ORI) || (opcode_of_MEM==`XORI) || 
			     (opcode_of_MEM==`SLLI) || (opcode_of_MEM==`SRLI) || (opcode_of_MEM==`SRAI) || (opcode_of_MEM==`SEQI) || 
			     (opcode_of_MEM==`SNEI) || (opcode_of_MEM==`SLTI) || (opcode_of_MEM==`SGTI) || (opcode_of_MEM==`SLEI) || 
			     (opcode_of_MEM==`SGEI) &&
			     ((IR_opcode==`R_TYPE) || (IR_opcode==`ADDI) || (IR_opcode==`SUBI) || (IR_opcode==`ANDI) || 
				(IR_opcode==`ADDUI) || (IR_opcode==`SUBUI) ||
				(IR_opcode==`ORI) || (IR_opcode==`XORI) || (IR_opcode==`SLLI) || (IR_opcode==`SRLI) || 
				(IR_opcode==`SRAI) || (IR_opcode==`SEQI) || (IR_opcode==`SNEI) || (IR_opcode==`SLTI) ||
				(IR_opcode==`SGTI) || (IR_opcode==`SLEI) || (IR_opcode==`SGEI) || (IR_opcode==`BEQZ) || 
				(IR_opcode==`BNEZ) || (IR_opcode==`JR) || (IR_opcode==`JALR) || (IR_opcode==`LW) || 
				(IR_opcode==`LH) || (IR_opcode==`LB) || (IR_opcode==`SW) || (IR_opcode==`SH) || 
				(IR_opcode==`SB) ))
			begin
				counter <= 2'b00;
				stall <= 1;
				
				IR_opcode_field <= 6'd0;
		       		IR_function_field <= 6'd0;
			       	mem_read <= 1'b0;
			       	mem_write <= 1'b0;
			       	reg_write <= 1'b0;
			       	branch_sig <= 1'b0;
				branch_address <= 32'b0;
			       	reg_dst <= 2'b00;
				mem_to_reg <= 2'b00;
				rt_addr <= 5'd0;
			        rd_addr <= 5'd0;
		        	Imm <= 32'd0;
		
			end
		  	else            
	                        counter <= 2'b00;

		end
	else

	if ((regB_index == reg_dst_of_MEM) && (regB_index != 0))
		begin
			if ((opcode_of_MEM==`R_TYPE) || (opcode_of_MEM==`LW) || (opcode_of_MEM==`LH) || (opcode_of_MEM==`LB) ||
			     (opcode_of_MEM==`LHU) ||  (opcode_of_MEM==`LBU) || (opcode_of_MEM==`LHI) || (opcode_of_MEM==`ADDI) || 
			     (opcode_of_MEM==`SUBUI) || (opcode_of_MEM==`ADDUI) ||
			     (opcode_of_MEM==`SUBI) || (opcode_of_MEM==`ANDI) || (opcode_of_MEM==`ORI) || (opcode_of_MEM==`XORI) || 
			     (opcode_of_MEM==`SLLI) || (opcode_of_MEM==`SRLI) || (opcode_of_MEM==`SRAI) || (opcode_of_MEM==`SEQI) || 
			     (opcode_of_MEM==`SNEI) || (opcode_of_MEM==`SLTI) || (opcode_of_MEM==`SGTI) || (opcode_of_MEM==`SLEI) || 
			     (opcode_of_MEM==`SGEI) &&
			     ((IR_opcode==`R_TYPE) || (IR_opcode==`SW) || (IR_opcode==`SH) || (IR_opcode==`SB) ))
			begin
				counter <= 2'b00;
				stall <= 1;

				IR_opcode_field <= 6'd0;
		       		IR_function_field <= 6'd0;
			       	mem_read <= 1'b0;
			       	mem_write <= 1'b0;
			       	reg_write <= 1'b0;
			       	branch_sig <= 1'b0;
				branch_address <= 32'b0;
			       	reg_dst <= 2'b00;
				mem_to_reg <= 2'b00;
				rt_addr <= 5'd0;
			        rd_addr <= 5'd0;
		        	Imm <= 32'd0;

			end
			else            
	                        counter <= 2'b00;

		end
	else

	if ((IR_opcode==`BEQZ) || (IR_opcode==`BNEZ))
			begin							
				counter <= 2'b00;
				stall <= 0;

				branch_address <= NPC + offset - 4;
				//if (offset[15]) branch_address <= NPC + offset;
				//else branch_address <= NPC - offset;

	
				branch_sig <= ((zflag && (IR_opcode==`BEQZ)) || ((!zflag) && (IR_opcode==`BNEZ)));

				if ( (zflag && (IR_opcode==`BEQZ)) || ((!zflag) && (IR_opcode==`BNEZ)) ) 
					begin
						delay_slot <= 1;
						slot_num <= 2'b11;
					end

				IR_opcode_field <= 6'd0;
		       		IR_function_field <= 6'd0;
			       	mem_read <= 1'b0;
			       	mem_write <= 1'b0;
			       	reg_write <= 1'b0;
			       	reg_dst <= 2'b00;
				mem_to_reg <= 2'b00;
				rt_addr <= 5'd0;
			        rd_addr <= 5'd0;
		        	Imm <= 32'd0;
			
			end
		
	else 

	if (IR_opcode==`JR)
			begin
				counter <= 2'b00;
				stall <= 0;

				delay_slot <= 1;
				slot_num <= 2'b11;

				branch_sig <= 1;

				branch_address <= regA_eff;

				IR_opcode_field <= 6'd0;
		       		IR_function_field <= 6'd0;
			       	mem_read <= 1'b0;
			       	mem_write <= 1'b0;
			       	reg_write <= 1'b0;
			       	reg_dst <= 2'b00;
				mem_to_reg <= 2'b00;
				rt_addr <= 5'd0;
			        rd_addr <= 5'd0;
		        	Imm <= 32'd0;				
			end
	else 
			begin
				counter <= 2'b00;
				stall <= 0;
				branch_address <= 32'b0;
				branch_sig <= 0;
			end

end

end
end

endmodule

