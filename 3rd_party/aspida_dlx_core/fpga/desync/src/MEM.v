//////////////////////////////////////////////////////////////////////
////                                                              ////
////  MEM.v	                                                  ////
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
module MEM (reg_dst_of_MEM_sl,
//reg_dst_out, 
reg_dst_out_sl,/* ALU_result_MEM,*/ 
reg_write_MEM_sl,
// reg_write_MEM, 
 mem_to_reg_EX, opcode_of_MEM, 
opcode_of_WB_sl, clk, reset, reg_dst_EX, ALU_result, 
reg_write_EX, mem_to_reg_MEM_sl, opcode_of_EX, reg_out_B_EX, 
reg_out_B_MEM_sl, DM_read_data, 
RF_data_in_sl, 
//RF_data_in,
noop_in, noop_sl,clk_sl);

input noop_in;
reg noop;

output noop_sl;

// Input Ports

input clk_sl;		//slave controller pulse

input 		 clk;			// clk
input		 reset;			// reset pulse
input [4:0]	 reg_dst_EX;
input [31:0]	 ALU_result;

// inputs that are control signals
input		 reg_write_EX;
input 		 mem_to_reg_EX;
input [5:0]  	 opcode_of_EX;

input [31:0]     reg_out_B_EX;

input [31:0]     DM_read_data;


// Output ports
//reg [4:0]   reg_dst_of_MEM;



//output [31:0]  ALU_result_MEM;

output [4:0]   reg_dst_of_MEM_sl;
//output [4:0] reg_dst_out;
output [4:0]   reg_dst_out_sl;
reg [4:0]   reg_dst_of_MEM_sl;
reg [4:0]   reg_dst_out_sl;

reg [4:0]   reg_dst_out;

output [31:0]  reg_out_B_MEM_sl;
reg [31:0]  reg_out_B_MEM;
reg [31:0]  reg_out_B_MEM_sl;

//synthesis attribute KEEP of RF_data_in is TRUE;
output [31:0]  RF_data_in_sl;
//output [31:0] RF_data_in;
reg [31:0]  RF_data_in;
//synthesis attribute KEEP of RF_data_in_sl is TRUE;
reg [31:0]  RF_data_in_sl;

// outputs that are control signals
reg mem_to_reg_MEM;
output reg_write_MEM_sl;
//output reg_write_MEM;
output mem_to_reg_MEM_sl;
reg reg_write_MEM;
reg reg_write_MEM_sl;
reg mem_to_reg_MEM_sl;

reg [5:0] opcode_of_WB;
output [5:0] opcode_of_MEM;
output [5:0] opcode_of_WB_sl;

reg noop_sl;


//reg [31:0] ALU_result_MEM;

//reg [5:0] opcode_of_MEM_sl;


wire [5:0] opcode_of_MEM = opcode_of_EX;
wire [4:0] reg_dst_of_MEM = reg_dst_EX;

reg [5:0] opcode_of_WB_sl;


// always @(posedge clk or posedge reset)
always @(posedge clk_sl or posedge reset)
begin
	if(reset)
	begin
		reg_write_MEM_sl <= 1'd0;
		mem_to_reg_MEM_sl <= 1'd0;
		reg_dst_out_sl <= 5'd0;
		reg_out_B_MEM_sl <= 32'b0;
		opcode_of_WB_sl <= 6'b0;
		noop_sl <= 1;
		RF_data_in_sl <= 32'd0;
	//	opcode_of_MEM_sl <= 6'd0;
		reg_dst_of_MEM_sl <= 5'd0;
	end
	else
	begin
		reg_write_MEM_sl <= reg_write_MEM;
		mem_to_reg_MEM_sl <= mem_to_reg_MEM;
		reg_dst_out_sl <= reg_dst_out;
		reg_out_B_MEM_sl <= reg_out_B_MEM;
		opcode_of_WB_sl <= opcode_of_WB;
		noop_sl <= noop;
		RF_data_in_sl <= RF_data_in;
	//	opcode_of_MEM_sl <= opcode_of_MEM;
		reg_dst_of_MEM_sl <= reg_dst_of_MEM;
	end
end		
always @(posedge clk or posedge reset /*or posedge clk_sl*/)
begin
	if (reset)
	begin
//		ALU_result_MEM <= 32'd0;
		reg_write_MEM <= 1'd0;
		mem_to_reg_MEM <= 1'd0;
		reg_dst_out <= 5'd0;
		reg_out_B_MEM <= 32'b0;
		opcode_of_WB <= 6'b0;
		noop <= 1;
		RF_data_in <= 32'd0;
	/*
		reg_write_MEM_sl <= 1'd0;
		mem_to_reg_MEM_sl <= 1'd0;
		reg_dst_out_sl <= 5'd0;
		reg_out_B_MEM_sl <= 32'b0;
		opcode_of_WB_sl <= 6'b0;
		noop_sl <= 1;
		RF_data_in_sl <= 32'b0;
		opcode_of_MEM_sl <= 6'd0;
		reg_dst_of_MEM_sl <= 5'd0;
	*/
	end
	/*
	else if(clk_sl) begin
		reg_write_MEM_sl <= reg_write_MEM;
		mem_to_reg_MEM_sl <= mem_to_reg_MEM;
		reg_dst_out_sl <= reg_dst_out;
		reg_out_B_MEM_sl <= reg_out_B_MEM;
		opcode_of_WB_sl <= opcode_of_WB;
		noop_sl <= noop;
		RF_data_in_sl <= RF_data_in;
		opcode_of_MEM_sl <= opcode_of_MEM;
		reg_dst_of_MEM_sl <= reg_dst_of_MEM;
	end
	*/
	else
	begin
//		ALU_result_MEM <= ALU_result;
		reg_write_MEM <= reg_write_EX;
		mem_to_reg_MEM <= mem_to_reg_EX;
		reg_dst_out <= reg_dst_EX;
		reg_out_B_MEM <= reg_out_B_EX;
		opcode_of_WB <= opcode_of_MEM;
		noop <= noop_in;
		RF_data_in <= (mem_to_reg_EX == 1'b1) ? DM_read_data : ALU_result;
	end	
end

endmodule




