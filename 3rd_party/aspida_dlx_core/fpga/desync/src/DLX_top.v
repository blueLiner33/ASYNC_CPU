module DLX_top( clk_vga, clk_IF, clk_IF_del, clk_ID, clk_EX, clk_DM, 
clk_MEM, reset, INT, CLI, PIPEEMPTY, FREEZE, NPC_eff, IR_MSB, 
DM_write, DM_read, DM_addr_eff, DM_write_data_0, 
red, green, blue, hsync, vsync, branch_sig, stall, 
mask, 
delay_selectIF, delay_selectID, delay_selectEX, 
delay_selectMEM, delay_selectRF, delay_selectDM, 
STOP_fetch );

input clk_vga, reset, INT, FREEZE;
//output clkdiv;
input STOP_fetch;

input [1:0] delay_selectIF, delay_selectID, delay_selectEX; 
input [1:0] delay_selectMEM, delay_selectRF, delay_selectDM;
   
output [3:0] mask;
output CLI, PIPEEMPTY;
output [7:0] IR_MSB;
output [14:0] DM_addr_eff;
//output [14:0] vga_address;
output DM_write;
output DM_read;
//output [31:0] IR, DM_addr, DM_write_data;
output [15:0] NPC_eff;

output DM_write_data_0;
output branch_sig, stall;

output [1:0] red;
output [2:0] green, blue;
output hsync, vsync;

output clk_IF, clk_ID, clk_EX, clk_MEM, clk_IF_del, clk_DM;

   // #synthesis attribute MAX_FANOUT of DLX_top is 25

   // synthesis attribute CLOCK_SIGNAL of clk_vga is YES
   // synthesis attribute CLOCK_SIGNAL of clk_IF is YES
   // synthesis attribute CLOCK_SIGNAL of clk_ID is YES
   // synthesis attribute CLOCK_SIGNAL of clk_EX is YES
   // synthesis attribute CLOCK_SIGNAL of clk_MEM is YES

   // synthesis attribute USELOWSKEWLINES of clk_IF is YES
   // synthesis attribute USELOWSKEWLINES of clk_ID is YES
   // synthesis attribute USELOWSKEWLINES of clk_EX is YES
   // synthesis attribute USELOWSKEWLINES of clk_MEM is YES
//wire [1:0] delay_selectIF, delay_selectID, delay_selectEX;
//wire [1:0] delay_selectMEM, delay_selectRF, delay_selectDM;
//assign delay_selectIF = 2'b00;  
//assign delay_selectID = 2'b00;
//assign delay_selectEX = 2'b00;
//assign delay_selectMEM = 2'b01;
//assign delay_selectRF = 2'b00;
//assign delay_selectDM = 2'b00;

wire DM_write, DM_read, byte, word;
wire [31:0]	DM_read_data, DM_write_data, DM_addr, NPC, IR;

wire ao_masterEX;
wire ao_masterIF;

wire [31:0]	RAM_read_data;	// Output from Data Mem
wire [4:0] vram_out_cpu;	// Outputs from VRAM blocks for CPU
wire [4:0] vram_out_vga;	// Outputs from VRAM blocks for VGA
reg  mem_select;			// Selecting Data Mem or VRAM
wire [3:0] mask;			// Selecting Data Mem block
wire [3:0] mask_if;
wire [4:0] vga_select;		// Selecting VRAM block
wire [5:0] vga_select_6;

assign mask = (vga_select_6[0]) ? mask_if : 4'b0000;

wire vram_out_cpu_eff;		// VRAM output for CPU
wire vram_out_vga_eff;		// VRAM output for VGA

wire [14:0] vga_address;

assign NPC_eff = NPC[15:0];
assign DM_addr_eff = DM_addr[14:0];
assign IR_MSB = IR[31:24];
assign DM_write_data_0 = DM_write_data[0];

`include "../src/mem_init_life_correct3"
`include "../src/vmem_init"

   wire clkbuf, clk0, clk0buf, clkdivub;  
   
   IBUFG clkbuf1 ( .I(clk_vga), .O(clkbuf) );
 
   CLKDLL clkdivider ( .CLKIN(clkbuf), .CLKFB(clk0buf),
		       .RST(1'b0), .CLK0(clk0),
		       .CLK90(), .CLK180(), .CLK270(),
		       .CLK2X(), .CLKDV(clkdivub), .LOCKED() );

   BUFG clkbuf2 ( .I(clk0), .O(clk0buf) );

   BUFG clkbuf3 ( .I(clkdivub), .O(clkdiv_vga) );
   
   // synthesis attribute CLKDV_DIVIDE of clkdivider is 2

   // synthesis attribute KEEP of clkdiv_vga is TRUE
   // synthesis attribute CLOCK_SIGNAL of clkdiv_vga is yes
   // synthesis attribute USELOWSKEWLINES of clkdiv_vga is YES

//DLX_sync DLX (reqin, ackin, DM_read_data, DM_write_data, DM_addr, DM_write, DM_read, NPC, reset, IR, byte, word, INT, CLI, PIPEEMPTY, FREEZE, clk, clk_ID, clk, clk_MEM,
//delay_selectIF, delay_selectID, delay_selectEX, delay_selectMEM
//);

wire [1:0] delay_selectIF1, delay_selectID1, delay_selectEX1;
wire [1:0] delay_selectMEM1, delay_selectRF1, delay_selectDM1;
assign delay_selectIF1 = delay_selectIF&2'b00;  
assign delay_selectID1 = delay_selectID&2'b00;
assign delay_selectEX1 = delay_selectEX&2'b00;
assign delay_selectMEM1 = delay_selectMEM&2'b00;
assign delay_selectRF1 = delay_selectRF&2'b00;
assign delay_selectDM1 = delay_selectDM&2'b00;


DLX_desync_fpga DLX (DM_read_data, DM_write_data, DM_addr, DM_write, 
DM_read, NPC, reset, IR, byte, word, INT, CLI, PIPEEMPTY, FREEZE, 
branch_sig, stall, clk_IF, clk_IF_del, clk_ID, clk_EX, 
clk_MEM, delay_selectIF1, delay_selectID1, delay_selectEX1, 
delay_selectMEM1, delay_selectRF1, STOP_fetch,
ao_masterEX,ao_masterIF );

mem_if mem_iface ( DM_addr[1:0], word, byte, mask_if );

vga_top vga_top (red, green, blue, hsync, vsync, clkdiv_vga, reset, clkdiv_vga,
	vram_out_vga_eff, vga_address);

always @(negedge clkdiv_vga)
	mem_select <= (~vga_select_6[0]);

assign vram_out_cpu_eff = vram_out_cpu[vga_select];
assign vram_out_vga_eff = vram_out_vga[vga_address[14:12]];
//assign DM_read_data = (mem_select) ? {{31'b0},vram_out_cpu_eff} : RAM_read_data;

assign DM_read_data =
	(vga_select_6[0]) ? RAM_read_data :
	(vga_select_6[1]) ? vram_out_cpu[0]:
	(vga_select_6[2]) ? vram_out_cpu[1]:
	(vga_select_6[3]) ? vram_out_cpu[2]:
	(vga_select_6[4]) ? vram_out_cpu[3]:
	(vga_select_6[5]) ? vram_out_cpu[4]:
	/* normally unused*/ 32'hFFFFFFFF;

	// synthesis attribute KEEP of DM_read_data is true
	// synthesis attribute KEEP of vga_select_6 is true

// assign nclk_EX = ~clk_EX;

   DM_delay DM_delay_inst (/*clk_EX,*/ao_masterEX, clk_EX_del, delay_selectDM); // delayed clock for DM read/write from BRAMS //

  // assign clk_DM = clk_EX_del & (DM_read | DM_write); 
   assign clk_DM = ao_masterEX & (DM_read | DM_write);  
   
   // synthesis attribute CLOCK_SIGNAL of clk_DM is YES
   // synthesis attribute USELOWSKEWLINES of clk_DM is YES
   // synthesis attribute KEEP of clk_DM is YES
   
// Port A: Data
// Port B: Instructions
RAMB4_S8_S8 block0 (
//X_RAMB4_S8_S8 block0 ( .GSR(glbl.GSR),
	.DOA(RAM_read_data[7:0]), .ADDRA(DM_addr[10:2]), .CLKA(clk_DM/*ao_masterEX*/), .DIA(DM_write_data[7:0]),
		.ENA(mask[0]), .RSTA(1'b0), .WEA(DM_write),
	.DOB(IR[7:0]), .ADDRB(NPC[10:2]), .CLKB(/*clk_IF*/ao_masterIF), .DIB(),
		.ENB(1'b1), .RSTB(1'b0), .WEB(1'b0)
);
RAMB4_S8_S8 block1 (
//X_RAMB4_S8_S8 block1 ( .GSR(glbl.GSR), 

	.DOA(RAM_read_data[15:8]), .ADDRA(DM_addr[10:2]), .CLKA(clk_DM/*ao_masterEX*/), .DIA(DM_write_data[15:8]),
		.ENA(mask[1]), .RSTA(1'b0), .WEA(DM_write),
	.DOB(IR[15:8]), .ADDRB(NPC[10:2]), .CLKB(/*clk_IF*/ao_masterIF), .DIB(),
		.ENB(1'b1), .RSTB(1'b0), .WEB(1'b0)
);
RAMB4_S8_S8 block2 (
//X_RAMB4_S8_S8 block2 ( .GSR(glbl.GSR),
	.DOA(RAM_read_data[23:16]), .ADDRA(DM_addr[10:2]), .CLKA(clk_DM/*ao_masterEX*/), .DIA(DM_write_data[23:16]),
		.ENA(mask[2]), .RSTA(1'b0), .WEA(DM_write),
	.DOB(IR[23:16]), .ADDRB(NPC[10:2]), .CLKB(/*clk_IF*/ao_masterIF), .DIB(),
		.ENB(1'b1), .RSTB(1'b0), .WEB(1'b0)
);
RAMB4_S8_S8 block3 (
//X_RAMB4_S8_S8 block3 ( .GSR(glbl.GSR),
	.DOA(RAM_read_data[31:24]), .ADDRA(DM_addr[10:2]), .CLKA(clk_DM/*ao_masterEX*/), .DIA(DM_write_data[31:24]),
		.ENA(mask[3]), .RSTA(1'b0), .WEA(DM_write),
	.DOB(IR[31:24]), .ADDRB(NPC[10:2]), .CLKB(/*clk_IF*/ao_masterIF), .DIB(),
		.ENB(1'b1), .RSTB(1'b0), .WEB(1'b0)
);

assign vga_select_6 = (1 << DM_addr[14:12]);
assign vga_select = vga_select_6[5:1];

// VRAM: 0x1000 to 0x5B00
// 5x4K RAMB's
/* always @(DM_addr) begin
	if (DM_addr >= 16'h1000) begin
		vga_select <= vga_select_6[5:1];
	end
	else
		vga_select <= 0;
end */

// Port A : CPU
// Port B : VGA
RAMB4_S1_S1 vga0 (
	.DOA(vram_out_cpu[0]), .ADDRA(DM_addr[11:0]), .CLKA(clk_DM/*ao_masterEX*/), .DIA(DM_write_data[0]),
		.ENA(vga_select[0]), .RSTA(reset), .WEA(DM_write),
	.DOB(vram_out_vga[0]), .ADDRB(vga_address[11:0]), .CLKB(clkdiv_vga), .DIB(),
		.ENB(1'b1), .RSTB(reset), .WEB(1'b0)
);
RAMB4_S1_S1 vga1 (
	.DOA(vram_out_cpu[1]), .ADDRA(DM_addr[11:0]), .CLKA(clk_DM/*ao_masterEX*/), .DIA(DM_write_data[0]),
		.ENA(vga_select[1]), .RSTA(reset), .WEA(DM_write),
	.DOB(vram_out_vga[1]), .ADDRB(vga_address[11:0]), .CLKB(clkdiv_vga), .DIB(),
		.ENB(1'b1), .RSTB(reset), .WEB(1'b0)
);
RAMB4_S1_S1 vga2 (
	.DOA(vram_out_cpu[2]), .ADDRA(DM_addr[11:0]), .CLKA(clk_DM/*ao_masterEX*/), .DIA(DM_write_data[0]),
		.ENA(vga_select[2]), .RSTA(reset), .WEA(DM_write),
	.DOB(vram_out_vga[2]), .ADDRB(vga_address[11:0]), .CLKB(clkdiv_vga), .DIB(),
		.ENB(1'b1), .RSTB(reset), .WEB(1'b0)
);
RAMB4_S1_S1 vga3 (
	.DOA(vram_out_cpu[3]), .ADDRA(DM_addr[11:0]), .CLKA(clk_DM/*ao_masterEX*/), .DIA(DM_write_data[0]),
		.ENA(vga_select[3]), .RSTA(reset), .WEA(DM_write),
	.DOB(vram_out_vga[3]), .ADDRB(vga_address[11:0]), .CLKB(clkdiv_vga), .DIB(),
		.ENB(1'b1), .RSTB(reset), .WEB(1'b0)
);
RAMB4_S1_S1 vga4 (
	.DOA(vram_out_cpu[4]), .ADDRA(DM_addr[11:0]), .CLKA(clk_DM/*ao_masterEX*/), .DIA(DM_write_data[0]),
		.ENA(vga_select[4]), .RSTA(reset), .WEA(DM_write),
	.DOB(vram_out_vga[4]), .ADDRB(vga_address[11:0]), .CLKB(clkdiv_vga), .DIB(),
		.ENB(1'b1), .RSTB(reset), .WEB(1'b0)
);

endmodule
