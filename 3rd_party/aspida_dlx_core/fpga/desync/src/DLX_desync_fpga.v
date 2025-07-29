//////////////////////////////////////////////////////////////////////
////                                                              ////
////  DLX.v							  ////
////                                                              ////
////  This file is part of the ASPIDA IP core project             ////
////  http://www.opencores.org/projects/aspida/                   ////
////		  and						  ////
///   http://www.ics.forth.gr/carv/aspida			  ////
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

module DLX_desync_fpga (DM_read_data, DM_write_data, DM_addr, DM_write, DM_read, 
NPC, reset, IR, byte, word, INT, CLI, PIPEEMPTY, FREEZE, branch_sig, 
stall, clk_IF, clk_IF_del, clk_ID, clk_EX, clk_MEM, delay_selectIF, 
delay_selectID, delay_selectEX, delay_selectMEM, 
delay_selectRF, STOP_fetch,
ao_masterEX,ao_masterIF);

input reset;                             // system reset

input STOP_fetch;   
   
input [1:0] delay_selectIF,delay_selectID,delay_selectEX,delay_selectMEM, delay_selectRF;

wire [31:0] PC;
input [31:0] IR;

output [31:0] DM_addr;
output DM_write;
output DM_read;
output stall, branch_sig;

output ao_masterEX;
output ao_masterIF;

//inout [31:0] DM_data;
input  [31:0] DM_read_data;
output [31:0] DM_write_data;
wire [31:0] DM_read_data;
//assign DM_read_data = DM_data;
wire [31:0] DM_write_data;
//assign DM_data = (DM_write)? DM_write_data:32'bz;

output [31:0] NPC;
//wire [31:0] NPC;

output byte;
output word;
//wire byte, word;

input INT;
output CLI;
output PIPEEMPTY;
//wire CLI,PIPEEMPTY;

input FREEZE;

inout clk_IF, clk_ID, clk_EX, clk_MEM, clk_IF_del;

wire [31:0] IR_latched;
wire branch_sig;
wire [31:0] branch_address;
wire stall;
wire [1:0] counter;

wire [31:0] Imm;
wire [4:0] rt_addr;
wire [4:0] rd_addr;
wire reg_dst;
wire reg_write;
wire mem_to_reg;
wire mem_write;
wire mem_read;
wire [5:0] IR_opcode_field;
wire [5:0] IR_function_field;
wire [31:0] reg_out_A;
wire [31:0] reg_out_B;
wire ex_noop, mem_noop;
wire [31:0] ALU_result;
wire [4:0] reg_dst_EX;
wire mem_to_reg_EX;
wire reg_write_EX;

wire [4:0] RF_write_index;
wire [4:0] reg_dst_of_EX;
reg [4:0] reg_dst_of_MEM;
reg [4:0] reg_dst_of_WB;
wire [4:0] reg_dst_of_EX_unsync; 
wire [4:0] reg_dst_of_MEM_unsync;

wire [31:0] RF_data_old;
//wire [31:0] ALU_result_MEM;
wire reg_write_MEM;

wire [5:0] opcode_of_EX;
reg [5:0] opcode_of_MEM;
reg [5:0] opcode_of_WB;

reg [5:0] opcode_of_MEM_sl;
reg [5:0] opcode_of_WB_sl;
reg [4:0] reg_dst_of_MEM_sl;
reg [4:0] reg_dst_of_WB_sl;

wire [5:0] opcode_of_EX_unsync;
wire [5:0] opcode_of_EX_reg;
wire [5:0] opcode_of_MEM_unsync;
wire [5:0] opcode_of_WB_unsync;

wire mem_to_reg_MEM;

wire [31:0] RF_data_in;

wire reqin_IF, ackin_IF, reqout_IF, l_IF;
wire reqin_ID, ackin_ID, reqout_ID, ackout_ID, l_ID;
wire reqout_EX, ackout_EX, l_EX;
wire reqout_MEM, l_MEM;

wire l_slave_EX;
wire l_slave_IF;
wire l_slave_ID;
wire l_slave_MEM;

//synthesis attribute KEEP of ro_masterIF is TRUE
//synthesis attribute KEEP of ao_masterIF is TRUE
//#synthesis attribute KEEP of ro_delayed1IF is TRUE
//synthesis attribute KEEP of ridmIF is TRUE
//synthesis attribute KEEP of ro_masterID is TRUE
//synthesis attribute KEEP of ao_masterID is TRUE
//#synthesis attribute KEEP of ro_delayed1ID is TRUE
//synthesis attribute KEEP of ridmID is TRUE
//synthesis attribute KEEP of ro_masterEX is TRUE
//synthesis attribute KEEP of ao_masterEX is TRUE
//#synthesis attribute KEEP of ro_delayed1EX is TRUE
//synthesis attribute KEEP of ridmEX is TRUE
//synthesis attribute KEEP of ro_masterMEM is TRUE
//synthesis attribute KEEP of ao_masterMEM is TRUE
//#synthesis attribute KEEP of ro_delayed1MEM is TRUE
//synthesis attribute KEEP of ridmMEM is TRUE
wire ro_masterIF,ao_masterIF,ro_delayed1IF,ridmIF;
wire ro_masterID,ao_masterID,ro_delayed1ID,ridmID;
wire ro_masterEX,ao_masterEX,ro_delayed1EX,ridmEX;
wire ro_masterMEM,ao_masterMEM,ro_delayed1MEM,ridmMEM;

   // synthesis attribute KEEP of reqin_IF is TRUE
   // synthesis attribute KEEP of reqout_IF is TRUE
   // synthesis attribute KEEP of reqin_ID is TRUE
   // synthesis attribute KEEP of reqout_ID is TRUE
   // synthesis attribute KEEP of ackout_ID is TRUE
   // synthesis attribute KEEP of reqout_EX is TRUE
   // synthesis attribute KEEP of reqout_MEM is TRUE
   
 IF IFinst (NPC, PC, IR_latched, clk_IF, reset, branch_sig, 
 branch_address, IR, stall, counter,/* l_slave_IF*/ao_masterIF);

 lc_semi_decIF IFlc (reset, reqin_IF, ackin_IF, reqout_IF, ackin_ID,
  l_IF, delay_selectIF, l_slave_IF,
  ro_masterIF,ao_masterIF,ro_delayed1IF,ridmIF);

   cmuller2 cg1 (reqout_IF, reqout_MEM, reqin_ID); 
   //
//   cmuller2 cg2 (reqout_ID, reqin, reqin_IF);
   cmuller2 cg3 (ackin_EX, ackin_IF, ackout_ID);  

   assign reqin_IF = reqout_ID & ~STOP_fetch;  

   RF_delay RF_delay_inst (/*clk_IF*/ao_masterIF, clk_IF_del, delay_selectRF); // delayed clock for RF read from BRAMS //

 ID IDinst (clk_IF_del, INT, CLI, PIPEEMPTY, FREEZE, branch_address, 
 branch_sig, Imm, rt_addr, rd_addr, reg_dst, reg_write, mem_to_reg, 
mem_write, mem_read, IR_opcode_field, IR_function_field, stall, counter, 
clk_ID, reset, NPC, IR_latched, opcode_of_EX, opcode_of_MEM_sl, opcode_of_WB_sl, 
reg_dst_of_EX, reg_dst_of_MEM_sl, reg_out_A, reg_out_B, reg_write_MEM, 
RF_write_index, 
 RF_data_in, RF_data_old, ex_noop, mem_noop,/* l_slave_ID*/ ao_masterID);

 lc_semi_decID IDlc (reset, reqin_ID, ackin_ID, reqout_ID, ackout_ID, 
 l_ID, delay_selectID, l_slave_ID,
 ro_masterID,ao_masterID,ro_delayed1ID,ridmID);
   
 EX EXinst (DM_addr, DM_write_data, reg_dst_EX, DM_write, DM_read, 
 mem_to_reg_EX, reg_write_EX, opcode_of_EX_unsync, opcode_of_EX_reg, 
 reg_dst_of_EX_unsync, clk_EX, reset, IR_opcode_field, IR_function_field, 
 reg_out_A, reg_out_B, Imm, rt_addr, rd_addr, reg_dst, reg_write, 
 mem_to_reg, mem_read, mem_write, byte, word, counter,
  ex_noop,/*l_slave_EX*/ao_masterEX);
   
 lc_semi_decEX EXlc (reset, reqout_ID, ackin_EX, reqout_EX, ackout_EX, 
 l_EX, delay_selectEX,l_slave_EX,
 ro_masterEX,ao_masterEX,ro_delayed1EX,ridmEX);

 MEM MEMinst (reg_dst_of_MEM_unsync, RF_write_index, /*ALU_result_MEM,*/ 
 reg_write_MEM, mem_to_reg_EX, opcode_of_MEM_unsync, opcode_of_WB_unsync,
  clk_MEM, reset, reg_dst_EX, DM_addr, reg_write_EX, mem_to_reg_MEM, 
  opcode_of_EX_reg, DM_write_data, RF_data_old, DM_read_data, 
  RF_data_in, ex_noop, mem_noop,/*l_slave_MEM*/ao_masterMEM);

 lc_semi_decMEM MEMlc (reset, reqout_EX, ackout_EX, reqout_MEM, ackin_ID, 
 l_MEM, delay_selectMEM, l_slave_MEM,
 ro_masterMEM,ao_masterMEM,ro_delayed1MEM,ridmMEM);

 assign clk_IF = ackin_IF;

 //  BUFG clkbuf1 (.I(ackin_IF), .O(clk_IF));
   
 // assign clk_ID = ackin_ID;

   BUFG clkbuf2 (.I(ackin_ID), .O(clk_ID));
		 
 // assign clk_EX = ackin_EX;

   BUFG clkbuf3 (.I(ackin_EX), .O(clk_EX));
		 
 assign clk_MEM = ackout_EX;

 //  BUFG clkbuf4 (.I(ackin_MEM), .O(clk_MEM));
   
 // synthesis attribute KEEP of clk_IF is TRUE
 // synthesis attribute KEEP of clk_ID is TRUE
 // synthesis attribute KEEP of clk_EX is TRUE
 // synthesis attribute KEEP of clk_MEM is TRUE 
 // synthesis attribute KEEP of clk_IF_del is YES

 // synthesis attribute CLOCK_SIGNAL of clk_IF is YES
 // synthesis attribute CLOCK_SIGNAL of clk_ID is YES
 // synthesis attribute CLOCK_SIGNAL of clk_EX is YES
 // synthesis attribute CLOCK_SIGNAL of clk_MEM is YES 
 // synthesis attribute CLOCK_SIGNAL of clk_IF_del is YES

 // synthesis attribute CLOCK_SIGNAL of ao_masterIF is YES
 // synthesis attribute CLOCK_SIGNAL of ao_masterID is YES
 // synthesis attribute CLOCK_SIGNAL of ao_masterEX is YES
 // synthesis attribute CLOCK_SIGNAL of ao_masterMEM is YES 


 // synthesis attribute USELOWSKEWLINES of clk_IF is YES
 // synthesis attribute USELOWSKEWLINES of clk_ID is YES
 // synthesis attribute USELOWSKEWLINES of clk_EX is YES
 // synthesis attribute USELOWSKEWLINES of clk_MEM is YES
 // synthesis attribute USELOWSKEWLINES of clk_IF_del is YES

 // synthesis attribute USELOWSKEWLINES of ao_masterIF is YES
 // synthesis attribute USELOWSKEWLINES of ao_masterID is YES
 // synthesis attribute USELOWSKEWLINES of ao_masterEX is YES
 // synthesis attribute USELOWSKEWLINES of ao_masterMEM is YES
   
assign reg_dst_of_EX = reg_dst ? rd_addr : rt_addr;
assign opcode_of_EX = IR_opcode_field;
   
always @(posedge clk_ID)
  begin
     if (reset)
       begin
	  reg_dst_of_MEM <= 4'b0;
	  reg_dst_of_WB <= 4'b0;
	  opcode_of_MEM <= 5'b0;
	  opcode_of_WB <= 5'b0;
       end
     else
       begin
	  reg_dst_of_MEM <= reg_dst_of_EX;
	  reg_dst_of_WB <= reg_dst_of_MEM;
	  opcode_of_MEM <= opcode_of_EX;
	  opcode_of_WB <= opcode_of_MEM;
       end
     
  end
always @(posedge ao_masterID)
  begin
     if (reset)
       begin
	  reg_dst_of_MEM_sl <= 4'b0;
	  reg_dst_of_WB_sl <= 4'b0;
	  opcode_of_MEM_sl <= 5'b0;
	  opcode_of_WB_sl <= 5'b0;
       end
     else
       begin
	  reg_dst_of_MEM_sl <= reg_dst_of_MEM;
	  reg_dst_of_WB_sl <= reg_dst_of_WB;
	  opcode_of_MEM_sl <= opcode_of_MEM;
	  opcode_of_WB_sl <= opcode_of_WB;
       end
     
end
  
endmodule
