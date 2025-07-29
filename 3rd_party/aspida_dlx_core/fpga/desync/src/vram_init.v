module vram_init;

//reg [20479:0] temp_vga_mem;
reg [0:0] temp_vga_mem [20479:0];
reg [255:0] mem_data;

integer i,j,k;

integer file;

initial
begin

/*
	DLX_top.vga0.mem[4095:0] = temp_vga_mem[ 4095:    0];
	DLX_top.vga1.mem[4095:0] = temp_vga_mem[ 8191: 4096];
	DLX_top.vga2.mem[4095:0] = temp_vga_mem[12287: 8192];
	DLX_top.vga3.mem[4095:0] = temp_vga_mem[16383:12288];
	DLX_top.vga4.mem[4095:0] = temp_vga_mem[20479:16384];
*/
	$readmemb("test/src/VMemFile",temp_vga_mem);

	file = $fopen("vmem_init");
	
	for (i=0;i<5;i=i+1) begin
		for (j=0;j<16;j=j+1) begin
			for (k=0;k<256;k=k+1) begin
				mem_data[k] = temp_vga_mem[i*4096 + j*256 + k];
				if (mem_data[k] === 1'bx)
					mem_data[k] = 0;
			end
			$fdisplay(file,"// synthesis attribute INIT_%h of vga%d is %h", j[7:0], i[2:0], mem_data);
		end
		$fdisplay(file,"");
	end

	$finish;

end

endmodule
