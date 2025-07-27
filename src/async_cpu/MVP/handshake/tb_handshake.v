`timescale 1ns / 1ps

module tb_four_phase_hand;

    // Inputs to DUT
    reg in_ack = 0;
    reg in_req = 0;
    reg [15:0] in_data = 16'h0000;

    // Outputs from DUT
    wire out_ack;
    wire out_req;
    wire [15:0] out_data;

    // Instantiate the DUT
    four_phase_hand dut (
        .in_ack(in_ack),
        .in_req(in_req),
        .in_data(in_data),
        .out_ack(out_ack),
        .out_req(out_req),
        .out_data(out_data)
    );

    // === Task: Standard 4-phase send ===
    task send_data(input [15:0] val);
        begin
            $display("Sending data: 0x%04x", val);
            in_data = val;
            in_req = 1;                  // Phase 1: Raise request
            wait(out_ack == 1);         // Phase 2: Wait for acknowledge
            #5;
            in_req = 0;                 // Phase 3: Lower request
            wait(out_ack == 0);         // Phase 4: Wait for ack to clear
        end
    endtask

    // === Task: Send with delayed ack ===
    task send_data_with_ack_delay(input [15:0] val, input integer delay_ns);
        begin
            $display("Sending with delayed ack: 0x%04x", val);
            in_data = val;
            in_req = 1;

            fork
                begin
                    #delay_ns;
                    in_ack = 1;
                    #5;
                    in_ack = 0;
                end
                begin
                    wait(out_ack == 1);
                    #5;
                    in_req = 0;
                    wait(out_ack == 0);
                end
            join
        end
    endtask

    // Clock-free testbench logic
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_four_phase_hand);  // Important for GTKWave

        $display("Starting 4-phase async FIFO test...");
        $monitor("T=%0t | in_req=%b in_ack=%b | out_req=%b out_ack=%b | in_data=0x%04x out_data=0x%04x",
                 $time, in_req, in_ack, out_req, out_ack, in_data, out_data);

        // Wait a moment before starting
        #10;

        // === Test 1: Normal handshake ===
        send_data(16'h1234);
        #50;

        // === Test 2: Edge Case - ack is delayed ===
        send_data_with_ack_delay(16'hABCD, 40); // 40ns delay on ack
        #100;

        // === Test 3: Simultaneous toggling ===
        in_data = 16'h5555;
        in_req = 1;
        #2;
        in_ack = 1; // Shouldn't acknowledge before req is lowered
        #10;
        in_req = 0;
        #10;
        in_ack = 0;
        #30;

        // === Test 4: Idle state ===
        #50;
        $display("Idle test complete. No data should be flowing.");

        $finish;
    end

endmodule
