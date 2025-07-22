//Sayantan Dutta	at https://www.edaplayground.com/playgrounds?searchString=async&_showAllResults=on&language=&simulator=&methodologies=&_libraries=on&_easierUVM=on&_curated=on
module dff(q,qbar,d,set,reset,clk);
  input d,set,reset,clk;
  output reg q;
  output qbar;
  
  assign qbar=~q;
  
  always @(posedge clk or negedge set or negedge reset)
    begin
      if (reset==0) q<=0;
      else if (set==0) q<=1;
      else q<=d;
    end
endmodule


module MullerCElement (
    input wire A,    // Input A
    input wire B,    // Input B
    input wire clk,  // Clock signal
    output reg Q     // Output Q
);

always @ (A or B or Q) begin
    if (A == B)
        Q <= A;
    // else retain Q
end
endmodule


//https://www.chipverify.com/verilog/verilog-single-port-ram
module single_port_sync_ram
  # (parameter ADDR_WIDTH = 4,
  parameter DATA_WIDTH = 32,
  parameter DEPTH = 16
    )

  ( 	input 					clk,
  	input [ADDR_WIDTH-1:0]	addr,
  	inout [DATA_WIDTH-1:0]	data,
  	input 					cs,
  	input 					we,
  	input 					oe
  );

  reg [DATA_WIDTH-1:0] 	tmp_data;
  reg [DATA_WIDTH-1:0] 	mem [DEPTH];

  always @ (posedge clk) begin
    if (cs & we)
      mem[addr] <= data;
  end

  always @ (posedge clk) begin
    if (cs & !we)
    	tmp_data <= mem[addr];
  end

  assign data = cs & oe & !we ? tmp_data : 'hz;
endmodule
