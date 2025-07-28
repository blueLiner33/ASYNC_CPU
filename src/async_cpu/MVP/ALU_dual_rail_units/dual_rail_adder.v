module full_adder(

input wire a_one,
input wire a_zero,
input wire b_one,
input wire b_zero,
input wire c_one,
input wire c_zero,

output wire s_one,
output wire s_zero,
output wire cout_one,
output wire cout_zero
);
    //stage 1
    assign wire part_one = ((a_one & a_zero)|(b_one & b_zero));
    assign wire part_two = ((a_one & b_zero)|(a_zero & b_one));
    assign wire part_three = (b_zero | b_one);
    assign wire part_four = (a_one | a_zero);

    //stage 2
    assign wire s_one = ((part_one & c_one)|(c_zero & part_two));
    assign wire s_zero = ((c_zero & part_one)|(part_two & c_one));
    assign wire ccout_one = ((b_zero & b_one)|(part_three & c_one));
    assign wire ccout_zero =((a_one & a_zero)|(c_zero & part_four));
endmodule