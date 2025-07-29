module ram_init;

reg [31:0] temp_mem [0:511];
reg [255:0] mem_data;
reg [31:0] instruction;

integer i,j,k;
integer file;

initial
begin


	
	$readmemh("test/src/MemFile", temp_mem);
	
	file = $fopen("mem_init");
	
	for (i=0;i<4;i=i+1) begin
		for (j=0;j<16;j=j+1) begin
			for (k=0;k<256;k=k+1) begin
				instruction = temp_mem[j*32 + (k[7:3])];
				mem_data[k] = instruction[i*8 + (k[2:0])];
				//instruction = temp_mem[j*32 + k/8 ];
				//mem_data[k] = instruction[i*8 + k%8 ];
				if (mem_data[k] === 1'bx)
					mem_data[k] = 0;
			end
			$fdisplay(file,"// synthesis attribute INIT_%h of block%d is %h", j[7:0], i[2:0], mem_data);
		end
		$fdisplay(file,"");
	end
	
end

endmodule




