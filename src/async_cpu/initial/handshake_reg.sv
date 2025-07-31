module handshake_reg #(
    parameter WIDTH = 42
)(
    input  wire              wr_clk,
    input  wire              rd_clk,
    input  wire              req,
    output wire              ack,
    input  wire [WIDTH-1:0]  data_in,
    output reg  [WIDTH-1:0]  data_out
);

    reg full = 0;

    assign ack = full;

    always @(posedge wr_clk) begin
        if (req && !full) begin
            data_out <= data_in;
            full <= 1;
        end
    end

    always @(posedge rd_clk) begin
        if (full) begin
            // Receiver ready immediately acknowledges and clears full
            full <= 0;
        end
    end

endmodule
