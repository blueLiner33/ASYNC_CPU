`timescale 1ns/10ps

//`define period 100

module DLX_testbench;


wire /*ackin, */PIPEEMPTY, CLI;
//wire byte, DM_write, DM_read, word, clk_MEM, clk_ID, clk_EX, clk_IF;
//wire [31:0] DM_addr,NPC,IR;
wire [7:0] IR_MSB;
wire [14:0] DM_addr_eff;   
wire [3:0] mask;
      
//wire clk_IF, clk_ID, clk_EX, clk_MEM;
//wire [15:0] DM_data;

reg INT,FREEZE,reset/*,reqin*/;
reg clk;

/*DLX_desync_fpga DLX (
	ackin,byte, DM_write, DM_read, PIPEEMPTY, word, CLI, clk_MEM, clk_IF, clk_ID, clk_EX, INT, FREEZE, reset, reqin, DM_addr, NPC, DM_data, IR
);*/

wire hsync, vsync;
wire [1:0] red;
wire [2:0] blue, green;
wire DM_read, DM_write;
wire [31:0] DM_addr, DM_write_data;

wire [15:0] NPC_eff;
wire DM_write_data_0;   
   
//DLX_top DLX_top( ackin, PIPEEMPTY, CLI, INT, FREEZE, reset, reqin );
//DLX_top DLX_top( reqin, ackin, reset, INT, CLI, PIPEEMPTY, FREEZE, IR, clk_IF, clk_ID, clk_EX, clk_MEM,
//	.delay_selectIF(2'b10),.delay_selectID(2'b11),.delay_selectEX(2'b11),.delay_selectMEM(2'b10));
//	2'b11,2'b01,2'b01,2'b11);
DLX_top DLX_top (
//  hsync, DM_write, PIPEEMPTY, vsync, CLI, INT, FREEZE, reset, clk, red, DM_addr, NPC, IR, green, blue,
//	DM_write_data );
 stall, branch_sig, hsync, DM_write, DM_write_data_0, DM_read, PIPEEMPTY, vsync, CLI, INT, FREEZE, reset, 
 clk, DM_addr_eff, mask, red, NPC_eff, IR_MSB, green, blue
);
//InstrMem IMEM ( IR, clk_IF, NPC, reset);

//DataMem DMEM (DM_read, DM_write, clk_MEM, DM_data, DM_data, DM_addr, reset);

/*reg [31:0] temp_mem [0:511];
reg [31:0] instruction;

reg [20479:0] temp_vga_mem;*/

integer i,j;
integer continue;
integer pixel,pixel_value;

integer file, file2, file3;   
   
initial
begin

   file = $fopen("ID_current_IR_trace.txt");
   file2 = $fopen("IR_trace.txt");
   file3 = $fopen("DM_trace.txt");
   
//	$sdf_annotate("master_slave_timesim.sdf", DLX_top.DLX.msctrl);

#1

/*
	$readmemh("test/src/MemFile", temp_mem);
	$display("\t temp_mem[0x0] = %h",temp_mem[0]);

	for(i=0;i<512;i=i+1) begin
		instruction = temp_mem[i];
		for(j=0;j<8;j=j+1) begin
			//instruction = temp_mem[i];
			DLX_top.block0.mem[i*8 + j] = instruction[j     ];
			DLX_top.block1.mem[i*8 + j] = instruction[j +  8];
			DLX_top.block2.mem[i*8 + j] = instruction[j + 16];
			DLX_top.block3.mem[i*8 + j] = instruction[j + 24];
		end
	end

	$display("\t block0[0x0] = %h",DLX_top.block0.mem[7:0]);
	$display("\t block1[0x0] = %h",DLX_top.block1.mem[7:0]);
	$display("\t block2[0x0] = %h",DLX_top.block2.mem[7:0]);
	$display("\t block3[0x0] = %h",DLX_top.block3.mem[7:0]);
	
	$readmemb("test/src/VMemFile", temp_vga_mem);
	
	DLX_top.vga0.mem[4095:0] = temp_vga_mem[4095:0];
	DLX_top.vga1.mem[4095:0] = temp_vga_mem[8191:4096];
	DLX_top.vga2.mem[4095:0] = temp_vga_mem[12287:8192];
	DLX_top.vga3.mem[4095:0] = temp_vga_mem[16383:12288];
	DLX_top.vga4.mem[4095:0] = temp_vga_mem[20479:16384];
	
	$stop;*/

	reset = 0;  INT = 0; FREEZE = 0;
	//clk = 0;
	//reqin = 0;



	reset = 1;
	#100 reset=0;
	#1000;
	/*while(1) begin
		wait(~reset);
		giveCycle;
	end*/
end

`define VGA_DIV 4

/* Show VGA Display */
always @( negedge DM_write
	or DLX_top.vga0.mem
	or DLX_top.vga1.mem
	or DLX_top.vga2.mem
	or DLX_top.vga3.mem
	or DLX_top.vga4.mem
		) begin
	
	#1
	
	/* Whole screen */
	for (i=0; i<480/`VGA_DIV; i=i+1) begin
		/* Each row */
		for (j=0; j<640/`VGA_DIV; j=j+1) begin
			pixel = (i*640/`VGA_DIV + j);
			case (pixel/4096)
				0: pixel_value = DLX_top.vga0.mem[pixel%4096];
				1: pixel_value = DLX_top.vga1.mem[pixel%4096];
				2: pixel_value = DLX_top.vga2.mem[pixel%4096];
				3: pixel_value = DLX_top.vga3.mem[pixel%4096];
				4: pixel_value = DLX_top.vga4.mem[pixel%4096];
			endcase
			if (pixel_value)
				$write("@");
			else
				$write(".");
		end
		$display("");
	end
	
	// Lines between screens
	$display("---");
	$display("---");
	$display("---");
end

always @(posedge DLX_top.clkdiv)
  begin

     $fdisplay(file, "%x %x", DLX_top.NPC_eff, DLX_top.DLX_IDinst_current_IR);
     $fdisplay(file2, "%x %x", DLX_top.NPC_eff, DLX_top.IR_MSB);     
       
  end

always @(negedge DLX_top.clkdiv)

  begin

     if (DM_write)
       $fdisplay(file3, "time = %d, DM_write = 1, DM_addr_eff = %x, DM_write_data = %x", $time, DM_addr_eff, DLX_top.DLX_EXinst_reg_out_B_EX);
     
  end

always @(posedge DLX_top.clkdiv)
  begin
     
   if (DM_read)
       $fdisplay(file3, "time = %d, DM_read = 1, DM_add_eff = %x, DM_read_data = %x", $time, DM_addr_eff, DLX_top.DM_read_data); 

  end
     
always begin


	continue = 1;
	clk = 0;

	while (continue) begin
		#30 clk = ~clk;
		if (CLI)
			continue = 0;
	end
	
		/*for(i=468;i<512;i=i+1) begin
			for (j=0;j<8;j=j+1) begin
				instruction[j     ]= DLX_top.block0.mem[i*8+j];
				instruction[j +  8]= DLX_top.block1.mem[i*8+j];
				instruction[j + 16]= DLX_top.block2.mem[i*8+j];
				instruction[j + 24]= DLX_top.block3.mem[i*8+j];
			end
			$display("Mem[0x%x]= %x", i, instruction);
		end*/
	$stop;
end

endmodule
