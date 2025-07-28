`timescale 1ns/1ps

module tb_pipeline;
    reg        in_req;
    reg        in_ack;
    reg [15:0] in_data;

    wire       out_req;
    wire       out_ack;
    wire [15:0] out_data;

    // Instantiate the pipeline
    top_module dut (
        .in_req(in_req),
        .in_ack(in_ack),
        .in_data(in_data),
        .out_req(out_req),
        .out_ack(out_ack),
        .out_data(out_data)
    );

    // Internal signals for checking progress
    initial begin
        $display("Time\tin_data\tout_data\tout_req");
        $monitor("%g\t%h\t%h\t%b", $time, in_data, out_data, out_req);

        // Initial conditions
        in_req = 0;
        in_ack = 0;
        in_data = 16'h0000;

        #5;

        // First transaction
        in_data = 16'hA1A1;
        in_req = 1;    // Start handshake
        #10;
        in_req = 0;    // Complete request phase
        #20;

        in_ack = 1;    // Allow stage 3 to proceed
        #10;
        in_ack = 0;
        #30;

        // Second transaction
        in_data = 16'hB2B2;
        in_req = 1;
        #10;
        in_req = 0;
        #20;

        in_ack = 1;
        #10;
        in_ack = 0;
        #30;

        // Third transaction
        in_data = 16'hC3C3;
        in_req = 1;
        #10;
        in_req = 0;
        #20;

        in_ack = 1;
        #10;
        in_ack = 0;
        #50;

        $finish;
    end

endmodule
