module dff (
    input clk,
    input d,
    output reg q
);

    always@(posedge clk)begin
        q<=d;
    end
endmodule 


module async_fifo(
input wr_clk,
input wr_en,
input wr_data [15:0],
input rd_clk,
input rd_en,

output wr_ready,
output rd_data [15:0],
output rd_valid
);
reg full = 0;
reg [15:0] storage;

assign wr_ready = ~full;
assign rd_valid = full;

always@(posedge wr_clk)
begin 
    if (wr_en && ~full) begin
        storage <= wr_data;
        full <=1;
    end
end

always@(posedge rd_clk)
begin 
    if (rd_en && full)begin
        rd_data <=storage;
        full<=0;
    end
end

endmodule