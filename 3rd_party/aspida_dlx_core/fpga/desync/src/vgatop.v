module vga_top(red,green,blue,hsync,vsync,clk,reset,clkin,
	Whichpattern, address);

input reset,clkin,Whichpattern,clk;
output [1:0] red;
output [2:0] green,blue;
output hsync,vsync;
//output clk;
output [14:0] address;

//reg ren,wen,datain;

wire [7:0]  data;
wire [14:0] patternbit;//, vdata1, vdata2;
wire Whichpattern;
wire [14:0] address;
wire [1:0] red;
wire [2:0] blue,green;
wire hsync,vsync,clk;
wire reset;
wire clkin;

wire [11:0] vga_address;
assign vga_address = address[11:0];

/*always
begin
	ren = 1;
	wen = 0;
	datain = 0;
end*/

vga vga1(data,Whichpattern,address,patternbit,red,green,blue,hsync,vsync,clk,reset,clkin);
//vmem mem1(address,Whichpattern,reset);
vmem mem2(clk, patternbit,data,reset);
//bram videoram(address,Whichpattern,clkin,datain,ren,reset,wen);



endmodule
