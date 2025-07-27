//transparent when en1
//holds if en is 0
module enable_gate (
    input wire en,    
    input wire[15:0] d,
    output reg [15:0] q
);

always @(*) begin
    if (en)
        q = d;
    else
        q = q;  
end

endmodule


// 1 if a and b are 1
// 0 both 0
//else hold previous state
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



module four_phase_hand(
    input in_ack,
    input in_req,
    input [15:0] in_data,

    output out_ack,
    output out_req,
    output [15:0] out_data
);

    // Stage 1
    wire splitter_wire_one;
    wire [15:0] data_wire_one;

    CElement cgate_one(
        .a(~stage1_ack),   
        .b(in_req),
        .y(splitter_wire_one)
    );
    enable_gate gate_one(
        .en(splitter_wire_one),
        .d(in_data),
        .q(data_wire_one)
    );

    // Stage 2
    wire splitter_wire_two;
    wire [15:0] data_wire_two;

    CElement cgate_two(
        .a(~stage2_ack),   
        .b(splitter_wire_one),
        .y(splitter_wire_two)
    );
    enable_gate gate_two(
        .en(splitter_wire_two),
        .d(data_wire_one),
        .q(data_wire_two)
    );

    // Stage 3
    wire splitter_wire_three;

    CElement cgate_three(
        .a(~in_ack),                  
        .b(splitter_wire_two),
        .y(splitter_wire_three)
    );
    enable_gate gate_three(
        .en(splitter_wire_three),
        .d(data_wire_two),
        .q(out_data)
    );

    wire stage1_ack = splitter_wire_two;
    wire stage2_ack = splitter_wire_three;

    // Outputs
    assign out_req = splitter_wire_three; 
    assign out_ack = splitter_wire_one;  

endmodule
