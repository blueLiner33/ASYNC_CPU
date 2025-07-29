`timescale 1ns / 1ps

module tb_handshakev2;

    // Inputs to DUT (driven by testbench)
    reg         in_req;
    reg         in_ack;
    reg  [15:0] in_data;

    // Outputs from DUT (monitored by testbench)
    wire        out_req;
    wire        out_ack;
    wire [15:0] out_data;

    // Instantiate the Device Under Test
    top_module dut (
        .in_req  (in_req),
        .in_ack  (in_ack),
        .in_data (in_data),
        .out_req (out_req),
        .out_ack (out_ack),
        .out_data(out_data)
    );

    // Dump all signals in this TB for GTKWave
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_handshakev3);
    end

    // Convenient task to perform one 4‑phase transaction
    task send_transaction(input [15:0] value);
    begin
        // Phase 1: sender raises request
        in_data = value;
        in_req  = 1;
        // Wait for the pipeline’s output request
        @(posedge out_req);

        // Phase 2: receiver raises acknowledge
        in_ack = 1;
        #5;    // allow some hold time

        // Phase 3: sender lowers request
        in_req = 0;
        // Wait for the pipeline’s output request to drop
        @(negedge out_req);
        #5;

        // Phase 4: receiver lowers acknowledge
        in_ack = 0;
        #5;
    end
    endtask

    // Main stimulus
    initial begin
        // Initialize signals
        in_req  = 0;
        in_ack  = 0;
        in_data = 16'h0000;
        #20;

        // Send three back‑to‑back transactions
        send_transaction(16'hA1A1);
        send_transaction(16'hB2B2);
        send_transaction(16'hC3C3);

        #50;
        $finish;
    end

    // Monitoring display
    initial begin
        $display("Time   in_data   out_data  in_req out_req in_ack out_ack");
        $monitor("%4dns   %h     %h      %b      %b      %b      %b",
                 $time, in_data, out_data, in_req, out_req, in_ack, out_ack);
    end

endmodule
