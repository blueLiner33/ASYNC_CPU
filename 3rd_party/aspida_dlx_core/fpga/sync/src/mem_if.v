//`define	ADDR	32
//`define	DATA	32

module mem_if( DM_addr, word, byte, mask);
	//DM_addr, DM_read_data_CPU, DM_read_CPU, DM_write_CPU, word, byte,
	//DM_addr_MEM, DM_data_MEM, DM_read_MEM, DM_write_MEM, mask);

input	[1:0] DM_addr;
//inout	[`DATA - 1:0] DM_data_CPU;

//input	DM_read_CPU;
//input	DM_write_CPU;

input	word;
input	byte;


//output	[`ADDR - 3:0] DM_addr_MEM;
//inout	[`DATA - 1:0] DM_data_MEM;

//output	DM_read_MEM;
//output	DM_write_MEM;

output	[3:0]	mask;
reg	[3:0]	mask;

//assign DM_addr_MEM = DM_addr[`ADDR - 1:2];

//assign DM_read_MEM  = DM_read_CPU;
//assign DM_write_MEM = DM_write_CPU;

always @(word or byte or DM_addr) begin
	if (byte) begin
		case (DM_addr)
			2'b00: mask <= 4'b1000;
			2'b01: mask <= 4'b0100;
			2'b10: mask <= 4'b0010;
			2'b11: mask <= 4'b0001;
		endcase
	end
	else if (word) begin
		if (DM_addr[0])
			mask <= 4'b0011;
		else
			mask <= 4'b1100;
	end
	else begin
		mask <= 4'b1111;
	end
end

/*assign DM_data_CPU = (!DM_read_CPU) ? 32'bz :
		(mask[3]) ? DM_data_MEM :
		(mask[2]) ? DM_data_MEM >> 8:
		(mask[1]) ? DM_data_MEM >> 16:
		/ *mask[0]* / DM_data_MEM >> 24;

assign DM_data_MEM = (!DM_write_CPU) ? 32'bz :
		(mask[3]) ? DM_data_CPU :
		(mask[2]) ? DM_data_CPU << 8:
		(mask[1]) ? DM_data_CPU << 16:
		/ *mask[0]* / DM_data_CPU << 24;
*/

endmodule
