`define width 11
 
/* serial in, parallel out register */
module delay_shifter(reset, enable, shift_clk, scan_in, par_out);

input shift_clk, scan_in, enable, reset;
output [`width-1:0] par_out;

reg [`width-1:0] par_out;   
   
integer i;
   
always @(posedge shift_clk or posedge reset)
  begin
     if (reset)
       begin
          par_out <= `width'b0;   
       end
     else if (enable)
       begin
          par_out[0] <= scan_in;          
          for (i = 0; i <= `width-2; i = i+1)
            par_out[i+1] <= par_out[i];   
       end
  end

endmodule // delay_shifter

`undef width

module mutex ( r1, r2, g1, g2 );
input  r1, r2;
output g1, g2;
    wire gr2, gr1;
    nand2_1 mg2 ( .x(gr2), .a(r2), .b(gr1) );
    nand2_1 U1 ( .x(gr1), .a(r1), .b(gr2) );
    nor3_1 U2 ( .x(g2), .a(gr2), .b(gr2), .c(gr2) );
    nor3_1 U3 ( .x(g1), .a(gr1), .b(gr1), .c(gr1) );
endmodule


module mem_load (start, scan_in, scan_out, scan_clk, data_out, data_in, 
		data_write, read, addr_out);

input scan_in, scan_clk;
input [31:0] data_in;
input start;
input read;

output [10:0] addr_out;
output scan_out;
output data_write;
output [31:0] data_out;

reg [43:0] shifter;   
reg rw;
reg data;   
reg data_write;

reg [10:0] addr_out;
reg [31:0] data_out;
reg [2:0] unload;   
   
assign scan_out = shifter[0];   
   
 always @(posedge scan_clk)
  begin
   //  #5  
     if (start)  
       begin
	  rw <= read; // 1 for reads, 0 for writes //
	  shifter <= {1'b1, 43'b0};
	  unload <= 0;
       end
     else
       if ((shifter[0]) && rw && (unload == 3'b0)) 
	 begin
	    addr_out <= shifter[43:33];
	    unload <= 3'b001;
	 end
       else if ((shifter[0]) && !rw)
	 begin
	    data_out <= shifter[32:1];
	    addr_out <= shifter[43:33];
	    data_write <=  1;
	 end
       else if (unload == 3'b010) 
	 begin
	    shifter <= { 12'b0, data_in };
	    unload <= 3'b111;
	 end
       else
	 begin
	    shifter <= {scan_in, shifter[43:1]};
	    data_write <= 0;
	    unload <= {unload[0], unload[2:1]};
	 end
         
  end
endmodule

// 9.45/7.48/5.51/4.68 ns  Delay //

/*
na alaksow se buf4
*/
module sram_latency ( in, out, mux_sel );

input [1:0] mux_sel;
input  in;
output out;
    wire net46;
    wire net1, net2, net3, n1, n2, n3, net4, net5, net6, net7, net8, net9, 
        net10, net11, net12, net13, net14, net15, net16, net17, net18, net19, 
        net20, net21, net22, net23, net24, net25, net26, net27, net28, net29, 
        net30, net31, net32, net33, net34, net35, net36, net37, net38, net39, 
        net40, net41, net42, net43, net44, net45;
    buf_1 U1 ( .x(n1), .a(in) );
    buf_4 U2 ( .x(n2), .a(n1) );
   // buf_16 U3 ( .x(n3), .a(n2) );
    and2_1 and1 ( .x(net1), .a(n2), .b(n1) );
    and2_1 and2 ( .x(net2), .a(n2), .b(net1) );
    and2_1 and3 ( .x(net3), .a(n2), .b(net2) );
    and2_1 and4 ( .x(net4), .a(n2), .b(net3) );

    and2_1 and5 ( .x(net5), .a(n2), .b(net4) );
    and2_1 and6 ( .x(net6), .a(n2), .b(net5) );
    and2_1 and7 ( .x(net7), .a(n2), .b(net6) );
    and2_1 and8 ( .x(net8), .a(n2), .b(net7) );
    and2_1 and9 ( .x(net9), .a(n2), .b(net8) );
    and2_1 and10 ( .x(net10), .a(n2), .b(net9) );
    and2_1 and11 ( .x(net11), .a(n2), .b(net10) );
    and2_1 and12 ( .x(net12), .a(n2), .b(net11) );
    and2_1 and13 ( .x(net13), .a(n2), .b(net12) );
    and2_1 and14 ( .x(net14), .a(n2), .b(net13) );
    and2_1 and15 ( .x(net15), .a(n2), .b(net14) );
    and2_1 and16 ( .x(net16), .a(n2), .b(net15) );

    and2_1 and17 ( .x(net17), .a(n2), .b(net16) );
    and2_1 and18 ( .x(net18), .a(n2), .b(net17) );
    and2_1 and19 ( .x(net19), .a(n2), .b(net18) );
    and2_1 and20 ( .x(net20), .a(n2), .b(net19) );
    and2_1 and21 ( .x(net21), .a(n2), .b(net20) );
    and2_1 and22 ( .x(net22), .a(n2), .b(net21) );
    and2_1 and23 ( .x(net23), .a(n2), .b(net22) );
    and2_1 and24 ( .x(net24), .a(n2), .b(net23) );
    and2_1 and25 ( .x(net25), .a(n2), .b(net24) );
    and2_1 and26 ( .x(net26), .a(n2), .b(net25) );
    and2_1 and27 ( .x(net27), .a(n2), .b(net26) );
    and2_1 and28 ( .x(net28), .a(n2), .b(net27) );
    and2_1 and29 ( .x(net29), .a(n2), .b(net28) );
    and2_1 and30 ( .x(net30), .a(n2), .b(net29) );
    and2_1 and31 ( .x(net31), .a(n2), .b(net30) );
    and2_1 and32 ( .x(net32), .a(n2), .b(net31) );
    and2_1 and33 ( .x(net33), .a(n2), .b(net32) );
    and2_1 and34 ( .x(net34), .a(n2), .b(net33) );
    and2_1 and35 ( .x(net35), .a(n2), .b(net34) );
    and2_1 and36 ( .x(net36), .a(n2), .b(net35) );
    and2_1 and37 ( .x(net37), .a(n2), .b(net36) );
    and2_1 and38 ( .x(net38), .a(n2), .b(net37) );
    and2_1 and39 ( .x(net39), .a(n2), .b(net38) );
    and2_1 and40 ( .x(net40), .a(n2), .b(net39) );
    and2_1 and41 ( .x(net41), .a(n2), .b(net40) );
    and2_1 and42 ( .x(net42), .a(n2), .b(net41) );
    and2_1 and43 ( .x(net43), .a(n2), .b(net42) );
    and2_1 and44 ( .x(net44), .a(n2), .b(net43) );
    and2_1 and45 ( .x(net45), .a(n2), .b(net44) );
    and2_1 and46 ( .x(net46), .a(n2), .b(net45) );
 
//    mymux4 mux ( .mux_sel(mux_sel), .out(out), .in({net1, net4, net8, net16 }) );

//    mymux4 mux ( .mux_sel(mux_sel), .out(out), .in({net6,net12,net32,net46}) );

mymux4 mux ( .mux_sel(mux_sel), .out(out), .in({net13,net18,net24,net32}) );//1,35 logarithmic
endmodule

`define	ADDR_IN 	32
`define	ADDR_OUT	9
`define	DATA	32

/* MEM_IF */
module mem_if(	DM_addr_CPU, DM_read_data_CPU, DM_write_data_CPU, word, byte,
				DM_addr_MEM, DM_read_data_MEM, DM_write_data_MEM, DM_write, mask);

input	[`ADDR_IN - 1:0] DM_addr_CPU;

input	word, byte, DM_write;

input	[`DATA - 1:0] DM_read_data_MEM, DM_write_data_CPU;
output	[`DATA - 1:0] DM_read_data_CPU, DM_write_data_MEM;

reg 	[`DATA - 1:0] DM_read_data_CPU, DM_write_data_MEM;

output	[`ADDR_OUT - 1:0] DM_addr_MEM;

output	[3:0]	mask;
reg 	[3:0]	mask;

assign DM_addr_MEM = DM_addr_CPU[`ADDR_OUT + 1 : 2];

always @(word or byte or DM_addr_CPU or DM_write or DM_write_data_CPU or DM_read_data_MEM ) begin
//	#1
	if (byte) begin
		case (DM_addr_CPU[1:0])
			2'b00:
				begin
					mask <= 4'b1000;
					DM_write_data_MEM	<= {DM_write_data_CPU[7:0], 24'b0};
					DM_read_data_CPU	<= {24'b0, DM_read_data_MEM[31:24]};
				end
			2'b01:
				begin
					mask <= 4'b0100;
					DM_write_data_MEM	<= {8'b0, DM_write_data_CPU[7:0], 16'b0};
					DM_read_data_CPU	<= {24'b0, DM_read_data_MEM[23:16]};
				end
			2'b10:
				begin
					mask <= 4'b0010;
					DM_write_data_MEM	<= {16'b0, DM_write_data_CPU[7:0], 8'b0};
					DM_read_data_CPU	<= {24'b0, DM_read_data_MEM[15:8]};
				end
			2'b11:
				begin
					mask <= 4'b0001;
					DM_write_data_MEM	<= {24'b0, DM_write_data_CPU[7:0]};
					DM_read_data_CPU	<= {24'b0, DM_read_data_MEM[7:0]};
				end
		endcase
	end
	else if (word) begin
		if (DM_addr_CPU[1]) begin 
			mask <= 4'b0011;
			DM_write_data_MEM	<= {16'b0, DM_write_data_CPU[15:0]};
			DM_read_data_CPU	<= {16'b0, DM_read_data_MEM[15:0]};
		end
		else begin
			mask <= 4'b1100;
			DM_write_data_MEM	<= {DM_write_data_CPU[15:0], 16'b0};
			DM_read_data_CPU	<= {16'b0, DM_read_data_MEM[31:16]};
		end
	end
	else begin
		mask <= 4'b1111;
		DM_write_data_MEM	<= DM_write_data_CPU;
		DM_read_data_CPU	<= DM_read_data_MEM;
	end
end

endmodule

`undef ADDR_IN
`undef ADDR_OUT
`undef DATA

module ASPIDA_top (reset_DLX_d_PAD, reset_DLX_c_PAD,
	sync_async_PAD,INT_PAD, CLI_PAD, FREEZE_PAD, STOP_FETCH_PAD, reset_ctrl_PAD, 
	test_si_DLX_PAD, test_so_DLX_PAD, 
	test_se_PAD, global_g1_PAD, global_g2_PAD,

	memory_load_enable_PAD, scan_in_PAD, scan_out_PAD, 
	shift_clk_PAD, read_PAD, inst_ram_load_PAD, 
		   
	del_scan_en_PAD, del_scan_in_PAD,
	ei_c_req_PAD, ei_c_ack_PAD, ei_c_we_PAD, ei_c_addr_PAD, ei_r_req_PAD, ei_r_ack_PAD, 
	ei_data_inout_PAD,

	r_BC_PAD, r_BC_ack_PAD, c_BC_PAD, c_BC_ack_PAD, 
	wish_clk_PAD, wish_ack_i_PAD, wish_we_o_PAD, wish_stb_cyc_o_PAD, 
	wish_adr_o_PAD, wish_dat_io_PAD,
	/*PAVLOS START*/
	stuckAtVdd_PAD //PIN ALWAYS 1
	/*END*/
 );

input wish_clk_PAD;
input wish_ack_i_PAD;
output wish_we_o_PAD;
output wish_stb_cyc_o_PAD;
output [11:0] wish_adr_o_PAD;
inout [31:0] wish_dat_io_PAD;

input sync_async_PAD;
input reset_DLX_c_PAD, reset_DLX_d_PAD;
input INT_PAD;
output CLI_PAD ;
input test_se_PAD;
input test_si_DLX_PAD;
output test_so_DLX_PAD;
input global_g1_PAD, global_g2_PAD;   

wire Ctrl__EXinst___Regs_1__ai, Ctrl__IDinst___Regs_1__ai, 
     Ctrl__IDinst___Regs_1__ro, Ctrl__MEMinst___Regs_1__ro,
     Ctrl__IFinst___Regs_1__ri, Ctrl__IFinst___Regs_1__ai, 
     Ctrl__MEMinst___Regs_1__ri, Ctrl__MEMinst___Regs_1__ai, 
     Ctrl__EXinst___Regs_1__ro, Ctrl__EXinst___Regs_1__ao, 
     Ctrl__IFinst___Regs_1__ro, Ctrl__IFinst___Regs_1__ao;


input del_scan_en_PAD, del_scan_in_PAD;   


//Shift register inputs/outputs
input memory_load_enable_PAD; 
input FREEZE_PAD;
input reset_ctrl_PAD;
input STOP_FETCH_PAD;
input scan_in_PAD; 
output scan_out_PAD;
input shift_clk_PAD;
input read_PAD; 
input inst_ram_load_PAD;

input ei_c_req_PAD, ei_c_we_PAD;
input [10:0]  ei_c_addr_PAD; 
output ei_r_req_PAD, ei_c_ack_PAD; 
input ei_r_ack_PAD;
inout [7:0] ei_data_inout_PAD;

   
wire ei_c_req, ei_c_we;
wire [10:0] ei_c_addr; 
wire ei_r_req, ei_c_ack; 
wire ei_r_ack;
wire [7:0] ei_data_in;
wire [7:0] ei_data_out;
   
wire Ctrl__EXinst___Regs_1__en1, Ctrl__EXinst___Regs_1__en2,
	Ctrl__IDinst___Regs_1__en1, Ctrl__IDinst___Regs_1__en2,
	Ctrl__IFinst___Regs_1__en1, Ctrl__IFinst___Regs_1__en2,
	Ctrl__MEMinst___Regs_1__en1,Ctrl__MEMinst___Regs_1__en2;

wire reset_DLX_d, reset_DLX_c, reset_ctrl, sync_async,
	INT, CLI, PIPEEMPTY, FREEZE,
	test_si_DLX, test_se, test_so_DLX,
    test_so_CHAIN,
	global_g1, global_g2,
	STOP_fetch;

input [4:0] r_BC_PAD;
input c_BC_ack_PAD;
output [4:0] c_BC_PAD;
output r_BC_ack_PAD;

	/*PAVLOS START*/
output stuckAtVdd_PAD;
	/*END*/
   
wire [4:0] c_BC;
wire  [4:0] r_BC;
wire c_BC_ack;
wire r_BC_ack;
wire force_bare;   
   
wire [11:0] wish_adr_o;
wire  [31:0] wish_dat_i;
wire [31:0] wish_dat_o;
wire wish_clk, wish_ack_i, wish_we_o, wish_stb_cyc_o;
 
 
wire del_scan_en, del_scan_in;   
wire [1:0] sram_lat_select;
wire [1:0] Ctrl__EXinst___Regs_1__delay_mux_sel, Ctrl__IDinst___Regs_1__delay_mux_sel;
wire [1:0] Ctrl__IFinst___Regs_1__delay_mux_sel, Ctrl__MEMinst___Regs_1__delay_mux_sel;

wire memory_load_enable, scan_in, scan_out, shift_clk, read, inst_ram_load;

inbuf3_16 stop_fetch_pad_(.di(STOP_fetch), .pad(STOP_FETCH_PAD)); 
inbuf3_16 reset_ctrl_pad_(.di(reset_ctrl), .pad(reset_ctrl_PAD));
inbuf3_16 freeze_pad_(.di(FREEZE), .pad(FREEZE_PAD));

/**Shift register pads**/
inbuf3_16 memory_load_enable_pad_(.di(memory_load_enable), .pad(memory_load_enable_PAD)); 
inbuf3_16 scan_in_pad_(.di(scan_in), .pad(scan_in_PAD)); 
iobuf3_16_12 scan_out_pad_(.pad(scan_out_PAD), .do(scan_out), .en(1'b1));
inbuf3_16 shift_clk_pad_(.di(shift_clk), .pad(shift_clk_PAD));
inbuf3_16 read_pad_(.di(read), .pad(read_PAD)); 
inbuf3_16 inst_ram_load_pad_(.di(inst_ram_load), .pad(inst_ram_load_PAD));   
/** End of shift register pads**/

/** Mux pads**/

inbuf3_16 del_scan_en_pad_(.di(del_scan_en), .pad(del_scan_en_PAD));
inbuf3_16 del_scan_in_pad_(.di(del_scan_in), .pad(del_scan_in_PAD));

/** End of Mux pads**/

   
inbuf3_16 reset_DLX_d_pad_(.di(reset_DLX_d), .pad(reset_DLX_d_PAD));
inbuf3_16 reset_DLX_c_pad_(.di(reset_DLX_c), .pad(reset_DLX_c_PAD));
inbuf3_16 sync_async_pad_(.di(sync_async), .pad(sync_async_PAD));
inbuf3_16 int_pad_(.di(INT), .pad(INT_PAD));
inbuf3_16 test_si_DLX_pad_(.di(test_si_DLX), .pad(test_si_DLX_PAD));
inbuf3_16 test_se_pad_(.di(test_se), .pad(test_se_PAD));
inbuf3_16 global_g1_pad_(.di(global_g1), .pad(global_g1_PAD));
inbuf3_16 global_g2_pad_(.di(global_g2), .pad(global_g2_PAD));

/**CHAIN pads**/
inbuf3_16 r_BC_pad_0(.di(r_BC[0]), .pad(r_BC_PAD[0]));
inbuf3_16 r_BC_pad_1(.di(r_BC[1]), .pad(r_BC_PAD[1]));
inbuf3_16 r_BC_pad_2(.di(r_BC[2]), .pad(r_BC_PAD[2]));
inbuf3_16 r_BC_pad_3(.di(r_BC[3]), .pad(r_BC_PAD[3]));
inbuf3_16 r_BC_pad_4(.di(r_BC[4]), .pad(r_BC_PAD[4]));
iobuf3_16_12 r_BC_ack_pad_(.pad(r_BC_ack_PAD), .do(r_BC_ack), .en(1'b1));  
inbuf3_16 c_BC_ack_pad_(.di(c_BC_ack), .pad(c_BC_ack_PAD));
iobuf3_16_12 c_BC_pad_0(.pad(c_BC_PAD[0]), .do(c_BC[0]), .en(1'b1));
iobuf3_16_12 c_BC_pad_1(.pad(c_BC_PAD[1]), .do(c_BC[1]), .en(1'b1));
iobuf3_16_12 c_BC_pad_2(.pad(c_BC_PAD[2]), .do(c_BC[2]), .en(1'b1));
iobuf3_16_12 c_BC_pad_3(.pad(c_BC_PAD[3]), .do(c_BC[3]), .en(1'b1));
iobuf3_16_12 c_BC_pad_4(.pad(c_BC_PAD[4]), .do(c_BC[4]), .en(1'b1));

inbuf3_16 ei_c_req_pad_(.di(ei_c_req), .pad(ei_c_req_PAD));
inbuf3_16 ei_c_we_pad_(.di(ei_c_we), .pad(ei_c_we_PAD));
inbuf3_16 ei_c_addr_pad_0(.di(ei_c_addr[0]),  .pad(ei_c_addr_PAD[0]));
inbuf3_16 ei_c_addr_pad_1(.di(ei_c_addr[1]),  .pad(ei_c_addr_PAD[1]));
inbuf3_16 ei_c_addr_pad_2(.di(ei_c_addr[2]),  .pad(ei_c_addr_PAD[2]));
inbuf3_16 ei_c_addr_pad_3(.di(ei_c_addr[3]),  .pad(ei_c_addr_PAD[3]));
inbuf3_16 ei_c_addr_pad_4(.di(ei_c_addr[4]),  .pad(ei_c_addr_PAD[4]));
inbuf3_16 ei_c_addr_pad_5(.di(ei_c_addr[5]),  .pad(ei_c_addr_PAD[5]));
inbuf3_16 ei_c_addr_pad_6(.di(ei_c_addr[6]),  .pad(ei_c_addr_PAD[6]));
inbuf3_16 ei_c_addr_pad_7(.di(ei_c_addr[7]),  .pad(ei_c_addr_PAD[7]));
inbuf3_16 ei_c_addr_pad_8(.di(ei_c_addr[8]),  .pad(ei_c_addr_PAD[8]));
inbuf3_16 ei_c_addr_pad_9(.di(ei_c_addr[9]),  .pad(ei_c_addr_PAD[9]));
inbuf3_16 ei_c_addr_pad_10(.di(ei_c_addr[10]),.pad(ei_c_addr_PAD[10]));
iobuf3_16_12 ei_c_ack_pad_(.pad(ei_c_ack_PAD), .do(ei_c_ack), .en(1'b1));

iobuf3_16_12 ei_r_req_pad_(.pad(ei_r_req_PAD), .do(ei_r_req), .en(1'b1));
iobuf3_16_12 ei_data_inout_pad_0(.pad(ei_data_inout_PAD[0]), .di(ei_data_in[0]), .do(ei_data_out[0]), .en(!ei_c_we));
iobuf3_16_12 ei_data_inout_pad_1(.pad(ei_data_inout_PAD[1]), .di(ei_data_in[1]), .do(ei_data_out[1]), .en(!ei_c_we));
iobuf3_16_12 ei_data_inout_pad_2(.pad(ei_data_inout_PAD[2]), .di(ei_data_in[2]), .do(ei_data_out[2]), .en(!ei_c_we));
iobuf3_16_12 ei_data_inout_pad_3(.pad(ei_data_inout_PAD[3]), .di(ei_data_in[3]), .do(ei_data_out[3]), .en(!ei_c_we));
iobuf3_16_12 ei_data_inout_pad_4(.pad(ei_data_inout_PAD[4]), .di(ei_data_in[4]), .do(ei_data_out[4]), .en(!ei_c_we));
iobuf3_16_12 ei_data_inout_pad_5(.pad(ei_data_inout_PAD[5]), .di(ei_data_in[5]), .do(ei_data_out[5]), .en(!ei_c_we));
iobuf3_16_12 ei_data_inout_pad_6(.pad(ei_data_inout_PAD[6]), .di(ei_data_in[6]), .do(ei_data_out[6]), .en(!ei_c_we));
iobuf3_16_12 ei_data_inout_pad_7(.pad(ei_data_inout_PAD[7]), .di(ei_data_in[7]), .do(ei_data_out[7]), .en(!ei_c_we)); 
inbuf3_16 ei_r_ack_pad_(.di(ei_r_ack), .pad(ei_r_ack_PAD));


inbuf3_16 wish_ack_i_pad(.di(wish_ack_i), .pad(wish_ack_i_PAD));
inbuf3_16 wish_clk_pad(.di(wish_clk), .pad(wish_clk_PAD));
iobuf3_16_12 wish_stb_cyc_o_pad(.pad(wish_stb_cyc_o_PAD), .do(wish_stb_cyc_o), .en(1'b1));
iobuf3_16_12 wish_we_o_pad(.pad(wish_we_o_PAD), .do(wish_we_o), .en(1'b1));

iobuf3_16_12 wish_adr_o_pad_0(.pad(wish_adr_o_PAD[0]), .do(wish_adr_o[0]), .en(1'b1));
iobuf3_16_12 wish_adr_o_pad_1(.pad(wish_adr_o_PAD[1]), .do(wish_adr_o[1]), .en(1'b1));
iobuf3_16_12 wish_adr_o_pad_2(.pad(wish_adr_o_PAD[2]), .do(wish_adr_o[2]), .en(1'b1));
iobuf3_16_12 wish_adr_o_pad_3(.pad(wish_adr_o_PAD[3]), .do(wish_adr_o[3]), .en(1'b1));
iobuf3_16_12 wish_adr_o_pad_4(.pad(wish_adr_o_PAD[4]), .do(wish_adr_o[4]), .en(1'b1));
iobuf3_16_12 wish_adr_o_pad_5(.pad(wish_adr_o_PAD[5]), .do(wish_adr_o[5]), .en(1'b1));
iobuf3_16_12 wish_adr_o_pad_6(.pad(wish_adr_o_PAD[6]), .do(wish_adr_o[6]), .en(1'b1));
iobuf3_16_12 wish_adr_o_pad_7(.pad(wish_adr_o_PAD[7]), .do(wish_adr_o[7]), .en(1'b1));
iobuf3_16_12 wish_adr_o_pad_8(.pad(wish_adr_o_PAD[8]), .do(wish_adr_o[8]), .en(1'b1));
iobuf3_16_12 wish_adr_o_pad_9(.pad(wish_adr_o_PAD[9]), .do(wish_adr_o[9]), .en(1'b1));
iobuf3_16_12 wish_adr_o_pad_10(.pad(wish_adr_o_PAD[10]), .do(wish_adr_o[10]), .en(1'b1));
iobuf3_16_12 wish_adr_o_pad_11(.pad(wish_adr_o_PAD[11]), .do(wish_adr_o[11]), .en(1'b1));

iobuf3_16_12 wish_dat_io_pad_0(.pad(wish_dat_io_PAD[0]), .di(wish_dat_i[0]), .do(wish_dat_o[0]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_1(.pad(wish_dat_io_PAD[1]), .di(wish_dat_i[1]), .do(wish_dat_o[1]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_2(.pad(wish_dat_io_PAD[2]), .di(wish_dat_i[2]), .do(wish_dat_o[2]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_3(.pad(wish_dat_io_PAD[3]), .di(wish_dat_i[3]), .do(wish_dat_o[3]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_4(.pad(wish_dat_io_PAD[4]), .di(wish_dat_i[4]), .do(wish_dat_o[4]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_5(.pad(wish_dat_io_PAD[5]), .di(wish_dat_i[5]), .do(wish_dat_o[5]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_6(.pad(wish_dat_io_PAD[6]), .di(wish_dat_i[6]), .do(wish_dat_o[6]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_7(.pad(wish_dat_io_PAD[7]), .di(wish_dat_i[7]), .do(wish_dat_o[7]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_8(.pad(wish_dat_io_PAD[8]), .di(wish_dat_i[8]), .do(wish_dat_o[8]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_9(.pad(wish_dat_io_PAD[9]), .di(wish_dat_i[9]), .do(wish_dat_o[9]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_10(.pad(wish_dat_io_PAD[10]), .di(wish_dat_i[10]), .do(wish_dat_o[10]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_11(.pad(wish_dat_io_PAD[11]), .di(wish_dat_i[11]), .do(wish_dat_o[11]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_12(.pad(wish_dat_io_PAD[12]), .di(wish_dat_i[12]), .do(wish_dat_o[12]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_13(.pad(wish_dat_io_PAD[13]), .di(wish_dat_i[13]), .do(wish_dat_o[13]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_14(.pad(wish_dat_io_PAD[14]), .di(wish_dat_i[14]), .do(wish_dat_o[14]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_15(.pad(wish_dat_io_PAD[15]), .di(wish_dat_i[15]), .do(wish_dat_o[15]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_16(.pad(wish_dat_io_PAD[16]), .di(wish_dat_i[16]), .do(wish_dat_o[16]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_17(.pad(wish_dat_io_PAD[17]), .di(wish_dat_i[17]), .do(wish_dat_o[17]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_18(.pad(wish_dat_io_PAD[18]), .di(wish_dat_i[18]), .do(wish_dat_o[18]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_19(.pad(wish_dat_io_PAD[19]), .di(wish_dat_i[19]), .do(wish_dat_o[19]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_20(.pad(wish_dat_io_PAD[20]), .di(wish_dat_i[20]), .do(wish_dat_o[20]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_21(.pad(wish_dat_io_PAD[21]), .di(wish_dat_i[21]), .do(wish_dat_o[21]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_22(.pad(wish_dat_io_PAD[22]), .di(wish_dat_i[22]), .do(wish_dat_o[22]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_23(.pad(wish_dat_io_PAD[23]), .di(wish_dat_i[23]), .do(wish_dat_o[23]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_24(.pad(wish_dat_io_PAD[24]), .di(wish_dat_i[24]), .do(wish_dat_o[24]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_25(.pad(wish_dat_io_PAD[25]), .di(wish_dat_i[25]), .do(wish_dat_o[25]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_26(.pad(wish_dat_io_PAD[26]), .di(wish_dat_i[26]), .do(wish_dat_o[26]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_27(.pad(wish_dat_io_PAD[27]), .di(wish_dat_i[27]), .do(wish_dat_o[27]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_28(.pad(wish_dat_io_PAD[28]), .di(wish_dat_i[28]), .do(wish_dat_o[28]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_29(.pad(wish_dat_io_PAD[29]), .di(wish_dat_i[29]), .do(wish_dat_o[29]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_30(.pad(wish_dat_io_PAD[30]), .di(wish_dat_i[30]), .do(wish_dat_o[30]), .en(wish_we_o));
iobuf3_16_12 wish_dat_io_pad_31(.pad(wish_dat_io_PAD[31]), .di(wish_dat_i[31]), .do(wish_dat_o[31]), .en(wish_we_o));
  
/**End of CHAIN pads**/
   
iobuf3_16_12 cli_pad_(.pad(CLI_PAD), .do(CLI), .en(1'b1));
iobuf3_16_12 test_so_DLX_pad_(.pad(test_so_DLX_PAD), .do(test_so_DLX), .en(1'b1));

/*PAVLOS START*/
iobuf3_16_12 stuckAtVdd_pad_(.pad(stuckAtVdd_PAD), .do(1'b1), .en(1'b1));
/*END*/

wire reset_DLX_d_ff1, reset_DLX_d_ff2, reset_DLX_d_ff1_shift, reset_DLX_d_ff2_shift;
wire reset_DLX_D_sync_async = sync_async ? reset_DLX_d: reset_DLX_d_ff2;  	// 1 == ASYNC
wire reset_DLX_ctrl = reset_ctrl ? reset_DLX_D_sync_async : reset_DLX_c;	// 1 == Datapath Reset

dffn_1	sync1g2(.d(reset_DLX_d), .ckb(global_g2), .q(reset_DLX_d_ff1), .qb());
dffn_1	sync2g2(.d(reset_DLX_d_ff1), .ckb(global_g2), .q(reset_DLX_d_ff2), .qb());

dffp_1	sync1shift(.d(reset_DLX_d), .ck(shift_clk), .q(reset_DLX_d_ff1_shift), .qb());
dffp_1	sync2shift(.d(reset_DLX_d_ff1_shift), .ck(shift_clk), .q(reset_DLX_d_ff2_shift), .qb());
   
wire DMem_clk_sa;   
wire IMem_clk_sa;
wire DMem_clk;   
wire IMem_clk;

wire [31:0] DM_read_data_MIF;
wire [31:0] DM_write_data_MIF;
wire [31:0] DM_write_data_mem;
wire [31:0] DM_write_data_to_mem;
wire [31:0] DM_read_data_mem;
reg [31:0] DM_read_data_mem_latched;
wire [31:0] DM_addr_CPU;
wire [31:0] DM_addr_to_mem;
wire [31:0] DM_addr_MEM;
wire [31:0] DM_addr_MEM_mem;   
wire [31:0] DM_read_data_CPU;
wire [31:0] DM_write_data_CPU;   

wire DM_write;
wire DM_read;
   
wire [31:0] IM_addr;
wire [31:0] IM_addr_to_mem;
wire [31:0] IM_addr_MEM_mem;
wire [31:0] IM_read_data_mem;
reg  [31:0] IM_read_data_mem_latched;
wire [31:0] IM_write_data_mem;
wire [31:0] IM_write_data_MEM;
wire [31:0] IM_read_data;

wire byte0, word;

wire [31:0] addr_out_load_full;
wire [3:0] IM_mask_oe;
wire [3:0] IM_mask_we;
wire [3:0] DM_mask_oe;
wire [3:0] DM_mask_we;
wire IM_write_mem;
wire DM_write_mem;
wire [31:0] data_out_load;

wire [3:0] mask_to_mem;

wire [31:0] data_in_to_sh_reg;
   
wire data_write_load_im, data_write_load_dm;

assign test_so_DLX = IM_addr[31];   

wire  [2:0] ip_c_ts;
wire  [3:0] ip_c_sel;
wire  [31:0] ip_c_adr;
wire  [31:0] ip_c_dat;
wire [2:0] ip_r_ts;
wire [3:0] ip_r_sel;
wire [31:0] ip_r_dat;
wire  [2:0] dp_c_ts;
wire  [3:0] dp_c_sel;
wire  [31:0] dp_c_adr;
wire  [31:0] dp_c_dat;
wire [2:0] dp_r_ts;
wire [3:0] dp_r_sel;
wire [31:0] dp_r_dat;
wire [2:0] dm_c_ts;
wire [4:0] dm_c_st;
wire [3:0] dm_c_sel;
wire [31:0] dm_c_adr;
wire [31:0] dm_c_dat;
wire  [2:0] dm_r_ts;
wire  [4:0] dm_r_rt;
wire  [3:0] dm_r_sel;
wire  [31:0] dm_r_dat;
wire [2:0] im_c_ts;
wire [4:0] im_c_st;
wire [3:0] im_c_sel;
wire [31:0] im_c_adr;
wire [31:0] im_c_dat;

reg [2:0] im_c_ts_latched;
reg [3:0] im_c_sel_latched;
reg [31:0] im_c_adr_latched;
reg [31:0] im_c_dat_latched;
reg im_c_we_latched;
reg im_c_mult_latched;

reg [2:0] dm_c_ts_latched;
reg [3:0] dm_c_sel_latched;
reg [31:0] dm_c_adr_latched;
reg [31:0] dm_c_dat_latched;
reg dm_c_we_latched;
reg dm_c_mult_latched;

wire  [2:0] im_r_ts;
wire  [4:0] im_r_rt;
wire  [3:0] im_r_sel;
wire  [31:0] im_r_dat;
   
wire nrst, ip_c_req, ip_c_we, ip_c_mult, ip_c_prd, ip_c_seq, ip_r_ack, 
    dp_c_req, dp_c_we, dp_c_mult, dp_c_prd, dp_c_seq, dp_r_ack,
    dm_c_ack, dm_r_req, dm_r_err,
    dm_r_rty, dm_r_acc, dm_r_mult, im_c_ack, im_r_req, im_r_err, im_r_rty, 
    im_r_acc, im_r_mult;
wire ip_c_ack, ip_r_req, ip_r_we, ip_r_err, ip_r_rty, ip_r_acc, dp_c_ack, 
    dp_r_req, dp_r_we, dp_r_err, dp_r_rty, dp_r_acc, 
    dm_c_req, dm_c_we, dm_c_mult, 
    dm_c_seq, dm_c_prd, dm_r_ack, im_c_req, im_c_we, im_c_mult, im_c_seq, 
    im_c_prd, im_r_ack;

wire ip_complete, dp_complete;

wire IM_complete, DM_complete, IM_complete_latched, DM_complete_latched;
wire nIM_complete_latched, nDM_complete_latched;

wire [10:0] addr_out_load;

wire data_write_load;
wire im_decup;
wire dm_decup;

wire im_grant_local, im_grant_chain;
wire dm_grant_local, dm_grant_chain;
wire im_grant_local_d, im_grant_chain_d;
wire dm_grant_local_d, dm_grant_chain_d;
wire ip_local, ip_not_local;
wire dp_local, dp_not_local, dp_no_access;
wire IM_start, DM_start;
wire imem_use_chain, dmem_use_chain;   
   
assign nrst = !reset_DLX_c;   

/************Mux interfaces****************/

/*
Ao-----------------------*-------Ai
                 ___     |
Ro------+  +----| c \____|______ Ri
        |  |  +-|___/    |
        |  |  |          |
        |  |  +-------+  |
        |  |          |  |
      +------+      +------+
      | R  A |      | R  A |
      |      |      |      |
      | Cmnd |      | Reply|
      +------+      +------+
*/
//DLX <-> CHAIN iport interface

C_gate2 sync_ip_complete (ip_r_req, ip_c_ack, ip_complete);
assign imem_use_chain = (IM_addr[31] ||   IM_addr[11] ||   IM_addr[12]); 
//assign imem_use_chain = (IM_addr[31] || (~IM_addr[11] & IM_addr[12]));   
  
//assign imem_use_chain = 1;   
 
//assign ip_local =     Ctrl__IFinst___Regs_1__ro & ~IM_addr[31] & ~IM_addr[11];
//assign ip_not_local = Ctrl__IFinst___Regs_1__ro & (IM_addr[31] || IM_addr[11]);

// IMEM at 0x1000 for CHAIN access //   
   
assign ip_local = Ctrl__IFinst___Regs_1__ro & ~imem_use_chain;
assign ip_not_local = Ctrl__IFinst___Regs_1__ro & imem_use_chain; 
   
assign ip_c_req = ip_not_local;
assign ip_c_we = 1'b0;
assign ip_c_mult = 1'b0;
assign ip_c_prd = 1'b0;
assign ip_c_seq = 'd0;
assign ip_c_ts = 'd0;
assign ip_c_sel = 4'b1111;
assign ip_c_adr = IM_addr;
assign ip_c_dat = 'd0;

// IM_read_data goes to the CPU (IR) //

assign nIM_complete_latched = ~IM_complete_latched || (sync_async == 1'b0); 
   
always @(nIM_complete_latched or IM_read_data_mem) begin 
   if (nIM_complete_latched == 1) IM_read_data_mem_latched  <= IM_read_data_mem;
end

assign IM_read_data = ip_not_local ? ip_r_dat : IM_read_data_mem_latched; 

assign ip_r_ack = Ctrl__IFinst___Regs_1__ai & ip_complete;


C_gate2 sync_im_complete (ip_local, IM_complete & im_grant_local_d, IM_complete_latched);

assign Ctrl__IFinst___Regs_1__ri = ip_complete || (IM_complete_latched & ~STOP_fetch);

//DLX <-> CHAIN dport interface

C_gate2 sync_dp_complete (dp_r_req, dp_c_ack, dp_complete);

//assign dmem_use_chain = (DM_addr_CPU[31] || (DM_addr_CPU[11] & DM_addr_CPU[12]));   

assign dmem_use_chain = (DM_addr_CPU[31] || ~DM_addr_CPU[11] || DM_addr_CPU[12]); 

//assign dmem_use_chain = 1;   
   
//assign dp_local =     Ctrl__EXinst___Regs_1__ro & ~DM_addr_CPU[31] &   DM_addr_CPU[11]  & (DM_read || DM_write);
//assign dp_not_local = Ctrl__EXinst___Regs_1__ro & (DM_addr_CPU[31] || ~DM_addr_CPU[11]) & (DM_read || DM_write);
   
// DMEM at 0x1800 for CHAIN access //
   
assign dp_local =     Ctrl__EXinst___Regs_1__ro & ~dmem_use_chain & (DM_read || DM_write);
assign dp_not_local = Ctrl__EXinst___Regs_1__ro & dmem_use_chain & (DM_read || DM_write);
   
assign dp_no_access = Ctrl__EXinst___Regs_1__ro & ~(DM_read || DM_write);

assign dp_c_req =  dp_not_local;
assign dp_c_we = DM_write;
assign dp_c_mult = 1'b0;
assign dp_c_prd = 1'b0;
assign dp_c_seq = 1'b0;
assign dp_c_ts = 'd0;
assign dp_c_sel = mask_to_mem;

assign dp_c_adr = DM_addr_CPU;
   
assign dp_c_dat = DM_write_data_MIF;

assign nDM_complete_latched = ~DM_complete_latched || (sync_async == 1'b0);

always @(nDM_complete_latched or DM_read_data_mem) begin
   if (nDM_complete_latched == 1) DM_read_data_mem_latched  <= DM_read_data_mem;
end

assign DM_read_data_MIF = dp_not_local ? dp_r_dat : DM_read_data_mem_latched;
   
assign dp_r_ack = Ctrl__MEMinst___Regs_1__ai & dp_complete;
 

C_gate2 sync_dm_complete (dp_local, DM_complete & dm_grant_local_d, DM_complete_latched);

assign Ctrl__MEMinst___Regs_1__ri = dp_complete || DM_complete_latched ||dp_no_access;

/**********End of Mux interfaces************/


/**********Demux interfaces************/

/*
      +------+           +------+
      | Cmnd |           | Reply|
      |      |           |      |
      | R  A |           | R  A |
      +------+           +------+
        |  |               |  |
        |  +----+          |  |
        |  ___  |  ______  |  |
        +-| c \_+-(____|_)-+  |
       +-o|___/               |
       |                      |
       +----------------------+
*/
//IM <->      CHAIN interface


C_gate2 sync_im_decup (im_c_req, !im_r_ack & !reset_DLX_c, im_decup);

C_gate2 sync_dm_decup0 (im_grant_local, ~IM_complete & !reset_DLX_c, im_grant_local_d);
C_gate2 sync_dm_decup1 (im_grant_chain, ~IM_complete & !reset_DLX_c, im_grant_chain_d);

mutex arb_im0 (ip_local & !IM_complete_latched, im_decup, im_grant_local, im_grant_chain);

assign IM_write_mem = im_grant_chain ? im_c_we : 1'b0;

assign IM_mask_oe = im_grant_chain ? im_c_sel_latched : 4'b1111;

assign IM_mask_we = im_grant_chain ? im_c_sel : 4'b1111;

assign IM_addr_to_mem = im_grant_chain ? im_c_adr : IM_addr;

assign IM_write_data_MEM = im_c_dat;

assign im_c_ack = im_grant_chain_d;

always @(posedge im_c_req or posedge reset_DLX_c) begin // reset by reset_DLX_c //
if (reset_DLX_c)
  begin
     im_c_mult_latched <= 0;
     im_c_ts_latched <= 3'b0;
     im_c_we_latched <= 0;
     im_c_sel_latched <= 4'b0;
     im_c_adr_latched <= 32'b0;
     im_c_dat_latched <= 32'b0;
  end
else
  begin
     im_c_mult_latched <= im_c_mult;
     im_c_ts_latched <= im_c_ts;
     im_c_we_latched <= im_c_we;
     im_c_sel_latched <= im_c_sel;
     im_c_adr_latched <= im_c_adr;
     im_c_dat_latched <= im_c_dat;
  end
end

assign IM_start = im_grant_local_d || im_grant_chain_d;
sram_latency sramlat_imem (IM_start, IM_complete, sram_lat_select);

assign im_r_req = IM_complete & im_grant_chain_d;

assign im_r_err = 'd0;
assign im_r_rty = 'd0;
assign im_r_acc = 'd0;
assign im_r_mult = im_c_mult_latched;
assign im_r_ts = im_c_ts_latched;
assign im_r_rt = 'd0;
assign im_r_sel = im_c_sel_latched;
assign im_r_dat = IM_read_data_mem;

//DM <-> CHAIN interface

C_gate2 sync_dm_decup2 (dm_c_req, !dm_r_ack & !reset_DLX_c, dm_decup);

mutex arb_im1 (dp_local & !DM_complete_latched, dm_decup, dm_grant_local, dm_grant_chain);

C_gate2 sync_dm_decup3 (dm_grant_local, ~DM_complete & !reset_DLX_c, dm_grant_local_d);
C_gate2 sync_dm_decup4 (dm_grant_chain, ~DM_complete & !reset_DLX_c, dm_grant_chain_d);

assign DM_write_mem = dm_grant_chain ? dm_c_we : DM_write;   

assign DM_mask_oe = dm_grant_chain ? dm_c_sel_latched : mask_to_mem; 

assign DM_mask_we = dm_grant_chain ? dm_c_sel : mask_to_mem; 

assign DM_addr_to_mem = dm_grant_chain ? dm_c_adr : DM_addr_MEM;

assign DM_write_data_to_mem = dm_grant_chain ? dm_c_dat : DM_write_data_MIF;

assign dm_c_ack = dm_grant_chain_d;

always @(posedge dm_c_req or posedge reset_DLX_c) begin // reset by reset_DLX_c //
if (reset_DLX_c)
  begin
     dm_c_mult_latched <= 0;
     dm_c_ts_latched <= 3'b0;
     dm_c_we_latched <= 0;     
     dm_c_sel_latched <= 4'b0;
     dm_c_adr_latched <= 32'b0;     
     dm_c_dat_latched <= 32'b0;
  end
else
  begin
     dm_c_mult_latched <= dm_c_mult;
     dm_c_ts_latched <= dm_c_ts;
     dm_c_we_latched <= dm_c_we;
     dm_c_sel_latched <= dm_c_sel;
     dm_c_adr_latched <= dm_c_adr;
     dm_c_dat_latched <= dm_c_dat;
  end
end

assign DM_start = dm_grant_local_d || dm_grant_chain_d;
sram_latency sramlat_dmem (DM_start, DM_complete, sram_lat_select);

assign dm_r_req = DM_complete & dm_grant_chain_d;
assign dm_r_err = 'd0;
assign dm_r_rty = 'd0;
assign dm_r_acc = 'd0;
assign dm_r_mult = dm_c_mult_latched;
assign dm_r_ts = dm_c_ts_latched;
assign dm_r_rt = 'd0;
assign dm_r_sel = dm_c_sel_latched;
assign dm_r_dat = DM_read_data_mem;
   
/**********End of demux interfaces************/


/**********Mem Scan Interface*******/

//for memory_load use

assign IM_write_data_mem = memory_load_enable ? data_out_load : IM_write_data_MEM;
assign DM_write_data_mem = memory_load_enable ? data_out_load : DM_write_data_to_mem;

assign addr_out_load_full[10:0] = addr_out_load;

assign IM_addr_MEM_mem = memory_load_enable ? addr_out_load_full : IM_addr_to_mem;
assign DM_addr_MEM_mem = memory_load_enable ? addr_out_load_full : DM_addr_to_mem;

/**********End of Mem Scan Interface*******/

delay_shifter delem_shift_reg (.reset(reset_DLX_d), .enable(del_scan_en), .shift_clk(shift_clk), .scan_in(del_scan_in), 

 .par_out({Ctrl__MEMinst___Regs_1__delay_mux_sel[1], Ctrl__MEMinst___Regs_1__delay_mux_sel[0],
 Ctrl__EXinst___Regs_1__delay_mux_sel[1], Ctrl__EXinst___Regs_1__delay_mux_sel[0], 
 Ctrl__IDinst___Regs_1__delay_mux_sel[1], Ctrl__IDinst___Regs_1__delay_mux_sel[0],
 Ctrl__IFinst___Regs_1__delay_mux_sel[1], Ctrl__IFinst___Regs_1__delay_mux_sel[0],
 sram_lat_select[1], sram_lat_select[0], force_bare})
);

/**********The DLX and memory Interface*******/
   
DLX_sync_desync_with_ctrls processor(DM_read_data_CPU, DM_write_data_CPU, DM_addr_CPU,
	DM_write, DM_read, IM_addr, reset_DLX_D_sync_async, IM_read_data, byte0, word, INT, CLI, PIPEEMPTY, FREEZE,
	test_si_DLX, test_se, sync_async, global_g1, global_g2, reset_DLX_ctrl,
				       
	Ctrl__EXinst___Regs_1__ai, Ctrl__IDinst___Regs_1__ai, Ctrl__IDinst___Regs_1__ro, 
	Ctrl__MEMinst___Regs_1__ro, Ctrl__IFinst___Regs_1__ri, Ctrl__IFinst___Regs_1__ai,
	Ctrl__MEMinst___Regs_1__ri, Ctrl__MEMinst___Regs_1__ai, Ctrl__EXinst___Regs_1__ro,
	Ctrl__EXinst___Regs_1__ao, Ctrl__IFinst___Regs_1__ro, Ctrl__IFinst___Regs_1__ao,
				       
	Ctrl__EXinst___Regs_1__delay_mux_sel, Ctrl__IDinst___Regs_1__delay_mux_sel,
	Ctrl__IFinst___Regs_1__delay_mux_sel, Ctrl__MEMinst___Regs_1__delay_mux_sel,
				       
	Ctrl__EXinst___Regs_1__en1, Ctrl__EXinst___Regs_1__en2,
	Ctrl__IDinst___Regs_1__en1, Ctrl__IDinst___Regs_1__en2,
	Ctrl__IFinst___Regs_1__en1, Ctrl__IFinst___Regs_1__en2,
	Ctrl__MEMinst___Regs_1__en1, Ctrl__MEMinst___Regs_1__en2 /* ,

	Ctrl__EXinst___Regs_1__en1_new, Ctrl__EXinst___Regs_1__en2_new, Ctrl__IFinst___Regs_1__en1_new,
	Ctrl__IFinst___Regs_1__en2_new, Ctrl__IDinst___Regs_1__en1_new, Ctrl__IDinst___Regs_1__en2_new,
	Ctrl__MEMinst___Regs_1__en1_new, Ctrl__MEMinst___Regs_1__en2_new 			     */

);

mem_if mem_iface ( DM_addr_CPU, DM_read_data_CPU, DM_write_data_CPU, word, byte0,
				DM_addr_MEM[10:2], DM_read_data_MIF, DM_write_data_MIF, DM_write, mask_to_mem);
   
assign DM_addr_MEM[31:11] = 21'b0;
assign DM_addr_MEM[1:0] = 2'b0;
   
mem_load mem_load_inst (memory_load_enable, scan_in, scan_out, shift_clk, data_out_load, data_in_to_sh_reg, data_write_load, read, addr_out_load);  
   
assign data_in_to_sh_reg = inst_ram_load ? IM_read_data_mem : DM_read_data_MIF;
assign data_write_load_im = (memory_load_enable&  inst_ram_load)  ? data_write_load : IM_write_mem;
assign data_write_load_dm = (memory_load_enable&(~inst_ram_load)) ? data_write_load : DM_write_mem;

assign Ctrl__IFinst___Regs_1__ao = Ctrl__IFinst___Regs_1__ai;     
assign Ctrl__EXinst___Regs_1__ao = Ctrl__MEMinst___Regs_1__ai;


aspida_net_core chain_inst (nrst, wish_clk, ip_c_req, ip_c_we, ip_c_mult, ip_c_prd, 
    ip_c_seq, ip_c_ts, ip_c_sel, ip_c_adr, ip_c_dat, ip_c_ack, ip_r_req, 
    ip_r_we, ip_r_err, ip_r_rty, ip_r_acc, ip_r_ts, ip_r_sel, ip_r_dat, 
    ip_r_ack, dp_c_req, dp_c_we, dp_c_mult, dp_c_prd, dp_c_seq, dp_c_ts, 
    dp_c_sel, dp_c_adr, dp_c_dat, dp_c_ack, dp_r_req, dp_r_we, dp_r_err, 
    dp_r_rty, dp_r_acc, dp_r_ts, dp_r_sel, dp_r_dat, dp_r_ack, ei_c_req, 
    ei_c_ack, ei_c_we, ei_c_addr, ei_r_req, ei_r_ack, ei_data_in, ei_data_out, 
    c_BC, c_BC_ack, r_BC, r_BC_ack, wish_we_o, wish_stb_cyc_o, wish_ack_i, 
    wish_adr_o, wish_dat_i, wish_dat_o, dm_c_req, dm_c_we, dm_c_mult, dm_c_seq, 
    dm_c_prd, dm_c_ts, dm_c_st, dm_c_sel, dm_c_adr, dm_c_dat, dm_c_ack, 
    dm_r_req, dm_r_err, dm_r_rty, dm_r_acc, dm_r_mult, dm_r_ts, dm_r_rt, 
    dm_r_sel, dm_r_dat, dm_r_ack, im_c_req, im_c_we, im_c_mult, im_c_seq, 
    im_c_prd, im_c_ts, im_c_st, im_c_sel, im_c_adr, im_c_dat, im_c_ack, 
    im_r_req, im_r_err, im_r_rty, im_r_acc, im_r_mult, im_r_ts, im_r_rt, 
    im_r_sel, im_r_dat, im_r_ack, 1'b0, test_so_CHAIN, 1'b0, 1'b1, 1'b0, 1'b1, 
    force_bare );        //       test_si_CHAIN     test_se phi1  phi2  phi3,
assign IMem_clk_sa = (sync_async == 1'b0) ? !global_g2 : IM_start;

assign DMem_clk_sa = (sync_async == 1'b0) ? !global_g2 : DM_start;   

assign IMem_clk = memory_load_enable ? shift_clk : IMem_clk_sa;
assign DMem_clk = memory_load_enable ? shift_clk : DMem_clk_sa;


/**************Memories************/

sram2k_pin instr_ram(.do0(IM_read_data_mem[0]), .do1(IM_read_data_mem[1]), .do2(IM_read_data_mem[2]), .do3(IM_read_data_mem[3]),
		     .do4(IM_read_data_mem[4]), .do5(IM_read_data_mem[5]), .do6(IM_read_data_mem[6]), .do7(IM_read_data_mem[7]),
		     .do8(IM_read_data_mem[8]), .do9(IM_read_data_mem[9]), .do10(IM_read_data_mem[10]), .do11(IM_read_data_mem[11]),
		     .do12(IM_read_data_mem[12]), .do13(IM_read_data_mem[13]), .do14(IM_read_data_mem[14]), .do15(IM_read_data_mem[15]), 
		     .do16(IM_read_data_mem[16]), .do17(IM_read_data_mem[17]), .do18(IM_read_data_mem[18]), .do19(IM_read_data_mem[19]), 
		     .do20(IM_read_data_mem[20]), .do21(IM_read_data_mem[21]), .do22(IM_read_data_mem[22]), .do23(IM_read_data_mem[23]),
		     .do24(IM_read_data_mem[24]), .do25(IM_read_data_mem[25]), .do26(IM_read_data_mem[26]), .do27(IM_read_data_mem[27]),
		     .do28(IM_read_data_mem[28]), .do29(IM_read_data_mem[29]), .do30(IM_read_data_mem[30]), .do31(IM_read_data_mem[31]),

		     .di0(IM_write_data_mem[0]), .di1(IM_write_data_mem[1]), .di2(IM_write_data_mem[2]), .di3(IM_write_data_mem[3]),
		     .di4(IM_write_data_mem[4]), .di5(IM_write_data_mem[5]), .di6(IM_write_data_mem[6]), .di7(IM_write_data_mem[7]),
		     .di8(IM_write_data_mem[8]), .di9(IM_write_data_mem[9]), .di10(IM_write_data_mem[10]), .di11(IM_write_data_mem[11]),
		     .di12(IM_write_data_mem[12]), .di13(IM_write_data_mem[13]), .di14(IM_write_data_mem[14]), .di15(IM_write_data_mem[15]),
		     .di16(IM_write_data_mem[16]), .di17(IM_write_data_mem[17]), .di18(IM_write_data_mem[18]), .di19(IM_write_data_mem[19]),
		     .di20(IM_write_data_mem[20]), .di21(IM_write_data_mem[21]), .di22(IM_write_data_mem[22]), .di23(IM_write_data_mem[23]),
		     .di24(IM_write_data_mem[24]), .di25(IM_write_data_mem[25]), .di26(IM_write_data_mem[26]), .di27(IM_write_data_mem[27]), 
		     .di28(IM_write_data_mem[28]), .di29(IM_write_data_mem[29]), .di30(IM_write_data_mem[30]), .di31(IM_write_data_mem[31]),

		     .a0(IM_addr_MEM_mem[2]), .a1(IM_addr_MEM_mem[3]), 
		     .a2(IM_addr_MEM_mem[4]), .a3(IM_addr_MEM_mem[5]), 
		     .a4(IM_addr_MEM_mem[6]), .a5(IM_addr_MEM_mem[7]), 
		     .a6(IM_addr_MEM_mem[8]), .a7(IM_addr_MEM_mem[9]), 
		     .a8(IM_addr_MEM_mem[10]), 

		      .oen0(IM_mask_oe[0]),  .oen1(IM_mask_oe[1]),  .oen2(IM_mask_oe[2]),  .oen3(IM_mask_oe[3]),
		     .iwen0(IM_mask_we[0]), .iwen1(IM_mask_we[1]), .iwen2(IM_mask_we[2]), .iwen3(IM_mask_we[3]),
		     .clk(IMem_clk), .wrb(data_write_load_im), .ceb(1'b0));



sram2k_pin data_ram(.do0(DM_read_data_mem[0]), .do1(DM_read_data_mem[1]), .do2(DM_read_data_mem[2]), .do3(DM_read_data_mem[3]),
		    .do4(DM_read_data_mem[4]), .do5(DM_read_data_mem[5]), .do6(DM_read_data_mem[6]), .do7(DM_read_data_mem[7]),
		    .do8(DM_read_data_mem[8]), .do9(DM_read_data_mem[9]), .do10(DM_read_data_mem[10]), .do11(DM_read_data_mem[11]),
		    .do12(DM_read_data_mem[12]), .do13(DM_read_data_mem[13]), .do14(DM_read_data_mem[14]), .do15(DM_read_data_mem[15]), 
		    .do16(DM_read_data_mem[16]), .do17(DM_read_data_mem[17]), .do18(DM_read_data_mem[18]), .do19(DM_read_data_mem[19]), 
		    .do20(DM_read_data_mem[20]), .do21(DM_read_data_mem[21]), .do22(DM_read_data_mem[22]), .do23(DM_read_data_mem[23]),
		    .do24(DM_read_data_mem[24]), .do25(DM_read_data_mem[25]), .do26(DM_read_data_mem[26]), .do27(DM_read_data_mem[27]),
		    .do28(DM_read_data_mem[28]), .do29(DM_read_data_mem[29]), .do30(DM_read_data_mem[30]), .do31(DM_read_data_mem[31]),
		    
		    .di0(DM_write_data_mem[0]), .di1(DM_write_data_mem[1]), .di2(DM_write_data_mem[2]), .di3(DM_write_data_mem[3]),
		    .di4(DM_write_data_mem[4]), .di5(DM_write_data_mem[5]), .di6(DM_write_data_mem[6]), .di7(DM_write_data_mem[7]),
		    .di8(DM_write_data_mem[8]), .di9(DM_write_data_mem[9]), .di10(DM_write_data_mem[10]), .di11(DM_write_data_mem[11]),
		    .di12(DM_write_data_mem[12]), .di13(DM_write_data_mem[13]), .di14(DM_write_data_mem[14]), .di15(DM_write_data_mem[15]),
		    .di16(DM_write_data_mem[16]), .di17(DM_write_data_mem[17]), .di18(DM_write_data_mem[18]), .di19(DM_write_data_mem[19]),
		    .di20(DM_write_data_mem[20]), .di21(DM_write_data_mem[21]), .di22(DM_write_data_mem[22]), .di23(DM_write_data_mem[23]),
		    .di24(DM_write_data_mem[24]), .di25(DM_write_data_mem[25]), .di26(DM_write_data_mem[26]), .di27(DM_write_data_mem[27]), 
		    .di28(DM_write_data_mem[28]), .di29(DM_write_data_mem[29]), .di30(DM_write_data_mem[30]), .di31(DM_write_data_mem[31]),

		    .a0(DM_addr_MEM_mem[2]), .a1(DM_addr_MEM_mem[3]), 
		    .a2(DM_addr_MEM_mem[4]), .a3(DM_addr_MEM_mem[5]), 
		    .a4(DM_addr_MEM_mem[6]), .a5(DM_addr_MEM_mem[7]), 
		    .a6(DM_addr_MEM_mem[8]), .a7(DM_addr_MEM_mem[9]), 
		    .a8(DM_addr_MEM_mem[10]),

		     .oen0(DM_mask_oe[0]),  .oen1(DM_mask_oe[1]),  .oen2(DM_mask_oe[2]),  .oen3(DM_mask_oe[3]),
		    .iwen0(DM_mask_we[0]), .iwen1(DM_mask_we[1]), .iwen2(DM_mask_we[2]), .iwen3(DM_mask_we[3]),
		    .clk(DMem_clk), .wrb(data_write_load_dm), .ceb(1'b0));



endmodule
