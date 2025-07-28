`timescale 1ns / 1ps

module tb_handshakev2;

    reg         in_req;
    reg         in_ack;
    reg  [15:0] in_data;

    wire        out_req;
    wire        out_ack;
    wire [15:0] out_data;

    // Instantiate your top module (DUT)
    top_module dut (
        .in_req(in_req),
        .in_ack(in_ack),
        .in_data(in_data),
        .out_req(out_req),
        .out_ack(out_ack),
        .out_data(out_data)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_handshakev2);

        // Initialize signals
        in_req  = 0;
        in_ack  = 0;
        in_data = 16'h0000;
        #20;

        // ---- Transaction 1 ----
        in_data = 16'hA1A1;
        in_req = 1;            // Request data transfer
        @(posedge out_req);    // Wait until pipeline output requests
        in_req = 0;            // Lower request

        @(negedge out_req);    // Wait for output request to go low

        in_ack = 1;            // Acknowledge reception
        #10;
        in_ack = 0;            // Lower acknowledge

        // ---- Transaction 2 ----
        in_data = 16'hB2B2;
        in_req = 1;
        @(posedge out_req);
        in_req = 0;

        @(negedge out_req);

        in_ack = 1;
        #10;
        in_ack = 0;

        // ---- Transaction 3 ----
        in_data = 16'hC3C3;
        in_req = 1;
        @(posedge out_req);
        in_req = 0;

        @(negedge out_req);

        in_ack = 1;
        #10;
        in_ack = 0;

        #50;
        $finish;
    end

    // Optional monitoring output
    initial begin
        $display("Time\tin_data\tout_data\tout_req");
        $monitor("%0dns\t%h\t%h\t%b", $time, in_data, out_data, out_req);
    end

endmodule
