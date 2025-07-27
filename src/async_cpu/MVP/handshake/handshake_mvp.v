// Transparent latch: holds if en is 0, transparent when en is 1
module enable_gate (
    input wire en,    
    input wire [15:0] d,
    output reg [15:0] q
);
    always @(*) begin
        if (en)
            q = d;
        else
            q = q;  // Hold value
    end
endmodule

// C-Element: 1 if both inputs are 1, 0 if both are 0, otherwise hold previous
module CElement (
    input wire a,
    input wire b,
    output reg y
);
    always @(*) begin
        case ({a, b})
            2'b11: y = 1'b1;
            2'b00: y = 1'b0;
            default: y = y;  // Hold previous value
        endcase
    end
endmodule

// Four-phase handshake pipeline with 3 stages
module four_phase_hand (
    input wire        in_ack,
    input wire        in_req,
    input wire [15:0] in_data,

    output wire       out_ack,
    output wire       out_req,
    output wire [15:0] out_data
);

    // Internal Wires
    wire splitter_wire_one;
    wire splitter_wire_two;
    wire splitter_wire_three;

    wire [15:0] data_wire_one;
    wire [15:0] data_wire_two;

    // Acknowledgments for each stage (from later stages)
    wire stage1_ack;
    wire stage2_ack;

    // Stage 1
    CElement cgate_one(
        .a(~stage1_ack),    // Inverted ack from Stage 2
        .b(in_req),
        .y(splitter_wire_one)
    );
    enable_gate gate_one(
        .en(splitter_wire_one),
        .d(in_data),
        .q(data_wire_one)
    );

    // Stage 2
    CElement cgate_two(
        .a(~stage2_ack),    // Inverted ack from Stage 3
        .b(splitter_wire_one),
        .y(splitter_wire_two)
    );
    enable_gate gate_two(
        .en(splitter_wire_two),
        .d(data_wire_one),
        .q(data_wire_two)
    );

    // Stage 3
    CElement cgate_three(
        .a(~in_ack),         // Inverted external ack
        .b(splitter_wire_two),
        .y(splitter_wire_three)
    );
    enable_gate gate_three(
        .en(splitter_wire_three),
        .d(data_wire_two),
        .q(out_data)
    );

    // Ack feedback signals
    assign stage1_ack = splitter_wire_two;
    assign stage2_ack = splitter_wire_three;

    // Outputs
    assign out_req = splitter_wire_three; 
    assign out_ack = splitter_wire_one;

endmodule
