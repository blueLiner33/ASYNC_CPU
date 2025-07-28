module enable_gate (
    input wire en,
    input wire [15:0] d,
    output reg [15:0] q
);
    initial q = 16'h0000;

    always @(*) begin
        if (en)
            #1 q = d;  // simulate latch delay
        // else retain old value (latch)
    end
endmodule

module CElement (
    input wire a,
    input wire b,
    output reg y
);
    initial y = 1'b0;

    always @(*) begin
        if (a & b)
            #1 y = 1'b1;
        else if (~a & ~b)
            #1 y = 1'b0;
        // else retain old value (latch)
    end
endmodule



// Asynchronous 3-stage pipeline using 4-phase handshake
module top_module (
    input wire        in_req,
    input wire        in_ack,
    input wire [15:0] in_data,

    output wire       out_req,
    output wire       out_ack,
    output wire [15:0] out_data
);

    // Internal wires for stage request control
    wire stage1_req, stage2_req, stage3_req;
    wire [15:0] stage1_data, stage2_data;

    // Ack signals for feedback
    wire stage1_ack, stage2_ack;

    // Stage 1
    CElement c1 (
        .a(~stage1_ack),
        .b(in_req),
        .y(stage1_req)
    );
    enable_gate latch1 (
        .en(stage1_req),
        .d(in_data),
        .q(stage1_data)
    );

    // Stage 2
    CElement c2 (
        .a(~stage2_ack),
        .b(stage1_req),
        .y(stage2_req)
    );
    enable_gate latch2 (
        .en(stage2_req),
        .d(stage1_data),
        .q(stage2_data)
    );

    // Stage 3
    CElement c3 (
        .a(~in_ack),
        .b(stage2_req),
        .y(stage3_req)
    );
    enable_gate latch3 (
        .en(stage3_req),
        .d(stage2_data),
        .q(out_data)
    );

    // Feedback paths
    assign stage1_ack = stage2_req;
    assign stage2_ack = stage3_req;

    // External handshake signals
    assign out_req = stage3_req;
    assign out_ack = stage1_req;

endmodule
