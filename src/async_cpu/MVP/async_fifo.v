module async_fifo(
    input  wire        wr_clk,
    input  wire        wr_en,
    input  wire [41:0] wr_data,
    input  wire        rd_clk,
    input  wire        rd_en,

    output wire        wr_ready,
    output reg  [41:0] rd_data,
    output wire        rd_valid
);

    reg full = 0;
    reg [41:0] storage;  

    assign wr_ready = ~full;
    assign rd_valid = full;

    // Write side
    always @(posedge wr_clk) begin 
        if (wr_en && ~full) begin
            storage <= wr_data;
            full <= 1;
        end
    end

    // Read side
    always @(posedge rd_clk) begin 
        if (rd_en && full) begin
            rd_data <= storage;
            full <= 0;
        end
    end

endmodule
