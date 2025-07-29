module latch_ctrl (rst, ri, ai, ro, ao, l_master, l_slave, ro_master, ao_master);
input rst, ri, ao;
output l_slave,l_master, ai, ro;
output ro_master,ao_master;

//synthesis attribute KEEP of ao_master is TRUE
//synthesis attribute KEEP of ro_master is TRUE
wire ro_master, ao_master;

lc_semi_dec_master master_ctrl(rst,ri,ai,ro_master,ao_master,l_master);
lc_semi_dec_slave  slave_ctrl (rst,ro_master,ao_master,ro,ao,l_slave);


endmodule


module cmuller (a,b,c);
input a,b;
output c;
wire ab,bc,ca;
and cmand1(ab,a,b);
and cmand2(bc,c,b);
and cmand3(ca,a,c);
or cmor(c,ab,bc,ca);
endmodule


module lc_semi_dec_master(rst, ri, ai, ro, ao, l);

input rst, ri, ao;
output l, ai, ro;

wire ro,ao;
wire ridp, ridm; // pulse and matched delayed ri //
wire nl;
wire nrst, lninp1, lninp2;
wire roainp;
wire ridp1,ridp2,ridp3;

//synthesis attribute keep of ridp2 is true
not not3(ridp2,ridp1);
//synthesis attribute keep of ridp3 is true
not not4(ridp3,ridp2);

//##synthesis attribute keep_hierarchy of pd is yes
 pulse_delay pd(.inp(ri), .outp(ridp), .outp1(ridp1));
//##synthesis attribute keep_hierarchy of md is yes
 matched_delay md (.inp2(ridp), .inp3(ridp3), .outp2(ridm));

 not dnot (nridm, ridm);

 not rnot (nrst, rst);
 
 nand rnand (ainrst, ai, nrst);
 
// nor (ainrst, ai, rst);
 
 and andl1 (lninp1, ainrst, nridm);
 and andl2 (lninp2, ro, ao, nridm);
 
 nor norl (nl, lninp1, lninp2);
 assign ai = nl; 

 not notl (l, nl);
 
 not notro (nro, ro);
 and andro (roainp, nro, ao);
 nor norro (ro, roainp, l);

endmodule

module lc_semi_dec_slave(rst, ri, ai, ro, ao, l);

input rst, ri, ao;
output l, ai, ro;

wire ridp, ridm; // pulse and matched delayed ri //
wire nl;
wire /*nrst,*/ lninp1, lninp2;
wire roainp;
wire ridp1,ridp2,ridp3;

//synthesis attribute keep of ridp2 is true
not not3(ridp2,ridp1);
//synthesis attribute keep of ridp3 is true
not not4(ridp3,ridp2);

//##synthesis attribute keep_hierarchy of pd is yes
 pulse_delay pd(.inp(ri), .outp(ridp), .outp1(ridp1));
//##synthesis attribute keep_hierarchy of md is yes
 matched_delay md (.inp2(ridp), .inp3(ridp3), .outp2(ridm));

//assign ridm = ridp;
 not dnot (nridm, ridm);

// not rnot (nrst, rst);
 
// nand rnand (ainrst, ai, nrst);

 nor (ainrst, ai, rst);
 
 and andl1 (lninp1, ainrst, nridm);
 and andl2 (lninp2, ro, ao, nridm);
 
 nor norl (nl, lninp1, lninp2);
 assign ai = nl; 

 not notl (l, nl);
 
 not notro (nro, ro);
 and andro (roainp, nro, ao);
 nor norro (ro, roainp, rst, l);

endmodule

module pulse_delay(inp, outp,outp1);

input inp;
output outp;
output outp1;
wire outp1;

wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9;

// synthesis attribute KEEP of wint1 is TRUE
not pda1 (wint1, inp);
// synthesis attribute KEEP of wint2 is TRUE
not pda2 (wint2, wint1);
// synthesis attribute KEEP of wint3 is TRUE
not pda3 (wint3, wint2);
// synthesis attribute KEEP of wint4 is TRUE
not pda4 (wint4, wint3);
// synthesis attribute KEEP of wint5 is TRUE
not pda5 (wint5, wint4);
// synthesis attribute KEEP of wint6 is TRUE
not pda6 (wint6, wint5);
// synthesis attribute KEEP of wint7 is TRUE
not pda7 (wint7, wint6);
// synthesis attribute KEEP of wint8 is TRUE
not pda8 (wint8, wint7);
// synthesis attribute KEEP of wint9 is TRUE
not pda9 (wint9, wint8);
// synthesis attribute KEEP of outp is TRUE
not pda10 (outp, wint9);
//synthesis attribute keep of outp1 is true
and and1 (outp1,outp,outp);

endmodule

module matched_delay(inp2, inp3, outp2);

input inp2;
input inp3;
output outp2;

wire outp2;

wire wint12, wint22, wint32, wint42, wint52, wint62, wint72, wint82, wint92, wint102;

// ##synthesis attribute KEEP of inp2 is TRUE
// synthesis attribute KEEP of wint12 is TRUE
myand mda1 (wint12, inp2, inp3);
// synthesis attribute KEEP of wint22 is TRUE
myand mda2 (wint22, inp2, wint12);
// synthesis attribute KEEP of wint32 is TRUE
myand mda3 (wint32, inp2, wint22);
// synthesis attribute KEEP of wint42 is TRUE
myand mda4 (wint42, inp2, wint32);
// synthesis attribute KEEP of wint52 is TRUE
myand mda5 (wint52, inp2, wint42);
// synthesis attribute KEEP of wint62 is TRUE
myand mda6 (wint62, inp2, wint52);
// synthesis attribute KEEP of wint72 is TRUE
myand mda7 (wint72, inp2, wint62);
// synthesis attribute KEEP of wint82 is TRUE
myand mda8 (wint82, inp2, wint72);
// synthesis attribute KEEP of wint92 is TRUE
myand mda9 (wint92, inp2, wint82);
// synthesis attribute KEEP of wint102 is TRUE
myand mda10 (wint102, inp2, wint92);
/*// synthesis attribute KEEP of outp2 is TRUE
myand mda11 (outp2, inp2, wint102);
*/
assign outp2 = wint102;

endmodule

module myand(a,b,c);

output a;
input b,c;
and(a,b,c);
endmodule
