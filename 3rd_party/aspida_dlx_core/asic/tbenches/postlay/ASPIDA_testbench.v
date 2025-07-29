`timescale 1ns/10ps

//`define period 100

module ASPIDA_testbench;

reg reset_DLX_d, reset_DLX_c, reset_ctrl;   
reg sync_sel, global_g1, global_g2, INT, FREEZE, test_si,test_se;
reg use_chain, test_si_CHAIN, kill_start, STOP_fetch, memory_load_enable, scan_in, shift_clk, read, inst_ram_load;

reg del_scan_en, del_scan_in;
reg [0:10] del_vector;

wire [4:0] r_BC;
wire c_BC_ack;
wire [4:0] c_BC;
wire r_BC_ack;
wire force_bare;   
   
wire test_so, CLI, PIPEEMPTY;
wire reset_DLX_d_sync, test_so_CHAIN, ring_osc_1_out, ring_osc_2_out, ring_osc_3_out, ring_osc_4_out, ring_osc_5_out, scan_out;
   
wire ei_c_req, ei_c_we;
wire [10:0] ei_c_addr; 
wire ei_r_req, ei_c_ack; 
wire ei_r_ack;
wire [7:0] ei_data_inout;

wire [11:0] wish_adr_o;
wire  [31:0] wish_dat_io;
wire wish_clk, wish_ack_i, wish_we_o, wish_stb_cyc_o;

assign ei_c_req = 1'b0;
assign ei_r_ack = 1'b0;
assign ei_c_addr = 'd0;

assign r_BC = 5'b0;
assign c_BC_ack = 0;    
assign force_bare = 0;   
   
assign wish_clk = 0;   
assign wish_ack_i = 0;   
   
   
/*
force ASPIDA_testbench.top.processor.DM_addr[11] = 1;
force ASPIDA_testbench.top.processor.DM_addr[31] = 0;
force ASPIDA_testbench.top.processor.DM_read = 1;
*/
ASPIDA_top top (reset_DLX_d, reset_DLX_c,
    sync_sel, INT, CLI,
    FREEZE, STOP_fetch, reset_ctrl,  
    test_si, test_so,
    test_se, global_g1, global_g2,
    memory_load_enable, scan_in, scan_out,
    shift_clk, read, inst_ram_load,

    del_scan_en, del_scan_in,
    ei_c_req, ei_c_ack, ei_c_we, ei_c_addr, ei_r_req, ei_r_ack,
    ei_data_inout,

    r_BC, r_BC_ack, c_BC, c_BC_ack,
    wish_clk, wish_ack_i, wish_we_o, wish_stb_cyc_o,
    wish_adr_o, wish_dat_io);



//InstrMem IMEM ( IR, clk_IF, NPC, reset);

//DataMem DMEM (DM_read, DM_write, clk_MEM, DM_data, DM_data, DM_addr, reset);

//reg [31:0] temp_mem [0:511];
//reg [31:0] instruction;

//wire [31:0] mem0, mem1, mem2, const_addr;

/*
assign const_addr = 'hFFFFFFEC;

assign mem0 =  top.data_ram.mem[const_addr[8:0]];
assign mem1 =  top.data_ram.mem[const_addr[10:2]];
assign mem2 =  top.data_ram.mem['h1FE];
*/

integer i,j;

initial
begin

         $sdf_annotate("ASPIDA_CHIP.sdf", ASPIDA_testbench.top);

	 // $sdf_annotate("DLX_syn_extload.sdf", top.processor);
         // $sdf_annotate("aspida_net_core.sdf", top.chain_inst);
         // $sdf_annotate("ASPIDA-CHIP-Mapped_extload.sdf", top);

        reset_ctrl = 0; // independent reset of controllers //
    
        reset_DLX_d = 0;
        reset_DLX_c = 0;   
	
	INT = 0;
	FREEZE = 0;
	test_se  = 0;

	// for the aspida_top
    
	test_si_CHAIN	= 0;
	test_se = 0;
        test_si = 0;
	kill_start	= 0;
	STOP_fetch	= 0;
	memory_load_enable = 0;
	scan_in = 0;
	shift_clk = 1'b0;
        del_scan_en = 0;
        del_scan_in = 0;
	read = 0;
	inst_ram_load	= 1;

	sync_sel = 1; // 0 for synchronous, 1 for asynchronous

//	global_g1 = 0;
//	global_g2 = 0;
	del_vector = 11'b00000000000;
	#200

        top.instr_ram.mem[0] = 32'b0;

	reset_DLX_d = 1;
        reset_DLX_c = 1;
   
	#100

	for (i=0; i<5; i=i+1) begin
		cycle;
	end

	#510

        force top.n137=1; //access IM through chain

        force top.n126=1; //access DM trhough chain


	$readmemh("MemFile", top.instr_ram.mem);
	$display("\t instr_ram[0x0] = %h",top.instr_ram.mem[0]);

        // *INITIALIZE 1st WORD* SHOULD BE DONE USING SHIFT REGISTER //

        top.data_ram.mem[0] = 32'b0;

        // *INITIALIZE 2000 words* of DATA RAM //

         for (i = 0; i < 2000; i = i + 1) begin
	    top.data_ram.mem[i] = 32'b0;
	 end

         $display("\t data_ram[0x0] = %h", top.data_ram.mem[0]);

	//
	#100

        reset_DLX_c = 1;
   	
        // scan delay values //

	// give some cycles for the memory to stop producing bloody XXXX's // 

        #100

	reset_DLX_c = 0;
   
        #200

	STOP_fetch = 1;

        // asynchronous reset is NOT ALLOWED (kills pulses), STOP_fetch must be pulled first //
   
        #100

	wait (~shift_clk);

        // reset_DLX_d should be synchronized with shift_clk if it is running //
        // as shift_clk feeds the delay_scan register //
   
        reset_DLX_c = 1;
	reset_DLX_d = 0;

        if (sync_sel == 1) STOP_fetch = 0;
   
        // adjust delay elements now //

        #200

//        del_vector = 10'b1000000000;
// above vector generates the pulse delay BUG //

	  del_vector = 11'b11111111000; 

     /* Ctrl__MEMinst___Regs_1__delay_mux_sel[1], Ctrl__MEMinst___Regs_1__delay_mux_sel[0],
        Ctrl__EXinst___Regs_1__delay_mux_sel[1], Ctrl__EXinst___Regs_1__delay_mux_sel[0], 
	Ctrl__IDinst___Regs_1__delay_mux_sel[1], Ctrl__IDinst___Regs_1__delay_mux_sel[0],
	Ctrl__IFinst___Regs_1__delay_mux_sel[1], Ctrl__IFinst___Regs_1__delay_mux_sel[0],
	sram_lat_select[1], sram_lat_select[0], force_bare */
   
        wait (~shift_clk);
   
	del_scan_en = 1;

        for (i = 0; i < 11; i = i + 1)
	  begin

	     wait (~shift_clk);	     
	     del_scan_in = del_vector[i];
	     wait (shift_clk);	     
	     
	  end

        wait (~shift_clk);
        del_scan_en = 0;
        del_scan_in = 0;
   
        #200

        reset_DLX_c = 0;
   
	#200;
	  

/*
#10 reset = 1'b0;
#20 reset = 1'b1;
#50 reset = 1'b0;
read = 1'b0;
scan_in_addr = 1'b0;
scan_in_dat = 1'b0;
#100 memory_load_enable = 1'b1; scan_in_addr = 1'b1;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b1;
#20 scan_in_addr = 1'b1;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b0;
//#20 scan_in_addr = 1'b0;
//#20 scan_in_addr = 1'b1;
#20 scan_in_dat = 1'b1;
#200 scan_in_dat = 1'b1;
#20 scan_in_dat = 1'b0;
#20 scan_in_dat = 1'b1;
#20 scan_in_dat = 1'b1;
#20 scan_in_dat = 1'b0;
#420 scan_in_addr = 1'b1;
#400 scan_in_dat = 1'b1;
#20 scan_in_dat = 1'b0;
#1800 read = 1'b1; scan_in_addr=1'b1;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b1;
#20 scan_in_addr = 1'b1;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b0;
#20 scan_in_addr = 1'b0;
#10 memory_load_enable = 1'b0;
*/

//	for (i=0; i<20; i=i+1) begin
if (sync_sel == 1'b0) begin
	
	while(CLI != 1'b1) begin

		cycle;
			
	end
end
else
	wait (CLI);


//	for (i=0; i<512; i=i+1) begin
	for (i=0; i<20; i=i+1) begin

			$display("DataMem[0x%h] = 0x%h", i, top.data_ram.mem[i[8:0]]);
	end

	$stop;
end


//cycle time = 12.9 ns ~78 Mhz
//`define cycle_time 3.5
`define cycle_time 2.8
   
task cycle;

begin

	if (sync_sel == 1'b0) begin
		
	                #`cycle_time
			
			global_g1 = 1;
			#5
			global_g1 = 0;
			
			#0.1
			
			global_g2 = 1;
			#3.5
			global_g2 = 0;

//			#1

	end
end

endtask

always begin
#10 shift_clk = ~shift_clk;
end

/*
   
always @(posedge top.\\processor/DLX_sync/IDinst.branch_sig )   
  begin
     //#1
     //  $display("BRANCH, Target = %h", top.\\processor\/DLX_sync\/IDinst.branch_address);
	$display("kjfhgfjkgh");
     
  end
 
*/

/*
always @(posedge Ctrl__EXinst___Regs_1__ro_PAD && (top.DM_read == 1 || top.DM_write == 1))
begin

   if (top.DM_read)
     $display ("READ, DM_addr=%h, DM_read_data=%h", top.DM_addr, top.DM_read_data);
   else
     $display ("WRITE, DM_addr=%h, DM_write_data=%h", top.DM_addr, top.DM_write_data);
end
*/
   
/*task giveCycle;

begin
	wait(~ackin);
	#10
	reqin = 1;
//	$display("%t:Shkwsa to reqin",$time);
	wait(ackin);
	reqin = 0;
//	$display("%t:Katebasa to reqin",$time);
//	$display("\tIR-> %h",IR);
//	$display("****************************");
	if (CLI || (IR === 32'bx)) begin
		for(i=0;i<512;i=i+1) begin
			for (j=0;j<8;j=j+1) begin
				instruction[j     ]= DLX_top.block0.mem[i*8+j];
				instruction[j +  8]= DLX_top.block1.mem[i*8+j];
				instruction[j + 16]= DLX_top.block2.mem[i*8+j];
				instruction[j + 24]= DLX_top.block3.mem[i*8+j];
			end
			$display("Mem[0x%x]= %x", i, instruction);
		end
		$stop;
	end
end
endtask
*/

/*
always
begin

//	#10 

	continue = 1;

	while (continue) begin
		#`period clk = ~clk;
//		$display("IR=%h",IR);
		if (IR === 32'bx)
			continue = 0;
	end


	showRegs;
//for(i=0;i<32;i=i+1)
//	$display("RegFile[%d]=%d", i, DLX.IDinst.RegFile[i]);


//	$stop;

end
*/
endmodule
LX_sync/IDinst.branch_sig )   
  begin
     //#1
     //  $display("BRANCH, Target = %h", top.\\processor\/DLX_sync\/IDinst.branch_address);
	$display("kjfhgfjkgh");
     
  end
 
*/

/*
always @(posedge Ctrl__EXinst___Regs_1__ro_PAD && (top.DM_read == 1 || top.DM_write == 1))
begin

   if (top.DM_read)
     $display ("READ, DM_addr=%h, DM_read_data=%h", top.DM_addr, top.DM_read_data);
   else
     $display ("WRITE, DM_addr=%h, DM_write_data=%h", top.DM_addr, top.DM_write_data);
end
*/
   
/*task giveCycle;

begin
	wait(~ackin);
	#10
	reqin = 1;
//	$display("%t:Shkwsa to reqin",$time);
	wait(ackin);
	reqin = 0;
//	$display("%t:Katebasa to reqin",$time);
//	$display("\tIR-> %h",IR);
//	$display("****************************");
	if (CLI || (IR === 32'bx)) begin
		for(i=0;i<512;i=i+1) begin
			for (j=0;j<8;j=j+1) begin
				instruction[j     ]= DLX_top.block0.mem[i*8+j];
				instruction[j +  8]= DLX_top.block1.mem[i*8+j];
				instruction[j + 16]= DLX_top.block2.mem[i*8+j];
				instruction[j + 24]= DLX_top.block3.mem[i*8+j];
			end
			$display("Mem[0x%x]= %x", i, instruction);
		end
		$stop;
	end
end
endtask
*/

/*
always
begin

//	#10 

	continue = 1;

	while (continue) begin
		#`period clk = ~clk;
//		$display("IR=%h",IR);
		if (IR === 32'bx)
			continue = 0;
	end


	showRegs;
//for(i=0;i<32;i=i+1)
//	$display("RegFile[%d]=%d", i, DLX.IDinst.RegFile[i]);


//	$stop;

end
*/
endmodule
