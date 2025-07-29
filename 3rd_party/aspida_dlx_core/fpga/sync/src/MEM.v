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
module MEM (reg_dst_of_MEM, reg_dst_out,/* ALU_result_MEM,*/ reg_write_MEM, mem_to_reg_EX, opcode_of_MEM, opcode_of_WB, clk, reset, reg_dst_EX, ALU_result, reg_write_EX, mem_to_reg_MEM, opcode_of_EX, reg_out_B_EX, reg_out_B_MEM, DM_read_data, RF_data_in, noop_in, noop);

input noop_in;
output noop;

// Input Ports
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
output [4:0]   reg_dst_of_MEM;
output [4:0]   reg_dst_out;
//output [31:0]  ALU_result_MEM;

output [31:0]  reg_out_B_MEM;

output [31:0]  RF_data_in;

// outputs that are control signals
output reg_write_MEM;
output mem_to_reg_MEM;

output [5:0] opcode_of_MEM;
output [5:0] opcode_of_WB;

reg noop;

reg [4:0] reg_dst_out;

//reg [31:0] ALU_result_MEM;
reg reg_write_MEM;
reg mem_to_reg_MEM;

reg [31:0] reg_out_B_MEM;

wire [5:0] opcode_of_MEM = opcode_of_EX;
wire [4:0] reg_dst_of_MEM = reg_dst_EX;

reg [5:0] opcode_of_WB;

reg [31:0] RF_data_in;

// always @(posedge clk or posedge reset)

always @(posedge clk)
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
		RF_data_in <= 32'b0;
	end
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




