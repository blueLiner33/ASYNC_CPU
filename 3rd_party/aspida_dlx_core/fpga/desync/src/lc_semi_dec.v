module lc_semi_decIF(rst, ri, ai, ro, ao, l, delay_select,l_slave_IF,
				 ro_master,ao_master,ro_delayed1,ridm);

input rst, ri, ao;
input [1:0] delay_select;
output l, ai, ro;

output ro_master,ao_master,ro_delayed1,ridm;


output l_slave_IF;



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
 pulse_delayIF pd(.inp(ri), .outp(ridp), .outp1(ridp1));
//##synthesis attribute keep_hierarchy of md is yes
 matched_delayIF md (.inp2(ridp), .inp3(ridp3), .outp2(ridm), .delay_select(delay_select));

 wire ro_master,ao_master,l_slave;
 
 //pulse delay for slave
wire ro_delayed1, ro_delayed2;
pulse_delay_slaveIF pd_slave(.inp(ro_master), .outp(ro_delayed1), .outp1(ro_delayed2));
//pulse_delay_slaveIF pd_slave(.inp(ro_master), .outp(ro_delayed1), .outp1(ro_delayed2));
 
 assign l_slave_IF = l_slave;
 
 master_ctrl master_ctrlIF(rst, ridm, ai, ro_master, ao_master, l);
 //master_ctrl slave_ctrlIF(rst, ro_master, ao_master, ro, ao, l_slave);
 slave_ctrl  slave_ctrlIF(rst, /*ro_master,*/ro_delayed1, ao_master, ro, ao, l_slave);

 // #synthesis attribute CLOCK_SIGNAL of l is YES
 // #synthesis attribute CLOCK_SIGNAL of ai is YES 
 // synthesis attribute TIG of ri
 // synthesis attribute TIG of ao
 // #synthesis attribute MAX_FANOUT of lc_semi_decIF is 30
   
endmodule

module pulse_delayIF(inp, outp,outp1);

input inp;
output outp;
output outp1;
wire outp1;

wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9;

// synthesis attribute KEEP of wint1 is TRUE
not pda1 (wint1, inp);
/*
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
//# synthesis attribute KEEP of wint8 is TRUE
not pda8 (wint8, wint7);
//# synthesis attribute KEEP of wint9 is TRUE
not pda9 (wint9, wint8);
*/
// synthesis attribute KEEP of outp is TRUE
not pda14 (outp, wint1);
//synthesis attribute keep of outp1 is true
and and1 (outp1,outp,outp);

endmodule

module pulse_delay_slave(inp, outp,outp1);

input inp;
output outp;
output outp1;
wire outp1;

wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9;

// synthesis attribute KEEP of wint1 is TRUE
not pda1 (wint1, inp);

/*//# synthesis attribute KEEP of wint2 is TRUE
not pda2 (wint2, wint1);
//# synthesis attribute KEEP of wint3 is TRUE
not pda3 (wint3, wint2);
//# synthesis attribute KEEP of wint4 is TRUE
not pda4 (wint4, wint3);
//# synthesis attribute KEEP of wint5 is TRUE
not pda5 (wint5, wint4);

//# synthesis attribute KEEP of wint6 is TRUE
not pda6 (wint6, wint5);
//# synthesis attribute KEEP of wint7 is TRUE
not pda7 (wint7, wint6);
//# synthesis attribute KEEP of wint8 is TRUE
not pda8 (wint8, wint7);
//# synthesis attribute KEEP of wint9 is TRUE
not pda9 (wint9, wint8);
*/
// synthesis attribute KEEP of outp is TRUE
not pda14 (outp, wint1);
//synthesis attribute keep of outp1 is true
and and1 (outp1,outp,outp);

endmodule

module pulse_delay_slaveID (inp, outp,outp1);

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
/*// synthesis attribute KEEP of wint6 is TRUE
not pda6 (wint6, wint5);
// synthesis attribute KEEP of wint7 is TRUE
not pda7 (wint7, wint6);
// synthesis attribute KEEP of wint8 is TRUE
not pda8 (wint8, wint7);
// synthesis attribute KEEP of wint9 is TRUE
not pda9 (wint9, wint8);
// synthesis attribute KEEP of wint10 is TRUE
not pda10 (wint10, wint9);
// synthesis attribute KEEP of wint11 is TRUE
not pda11 (wint11, wint10);
// synthesis attribute KEEP of wint12 is TRUE
not pda12 (wint12, wint11);
// synthesis attribute KEEP of wint13 is TRUE
not pda13 (wint13, wint12);
// synthesis attribute KEEP of wint14 is TRUE
not pda14 (wint14, wint13);
// synthesis attribute KEEP of wint15 is TRUE
not pda15 (wint15, wint14);
// synthesis attribute KEEP of wint16 is TRUE
not pda16 (wint16, wint15);
// synthesis attribute KEEP of wint17 is TRUE
not pda17 (wint17, wint16);
// synthesis attribute KEEP of wint14 is TRUE
not pda18 (wint18, wint17);
// synthesis attribute KEEP of wint15 is TRUE
not pda19 (wint19, wint18);
// synthesis attribute KEEP of wint16 is TRUE
not pda20 (wint20, wint19);
// synthesis attribute KEEP of wint17 is TRUE
not pda21 (wint21, wint20);
  */
// synthesis attribute KEEP of outp is TRUE
not pda30 (outp, wint5);
//synthesis attribute keep of outp1 is true
and and1 (outp1,outp,outp);

endmodule

module pulse_delay_slaveIF (inp, outp,outp1);

input inp;
output outp;
output outp1;
wire outp1;

wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9, wint10, wint11;

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
/*// synthesis attribute KEEP of wint6 is TRUE
not pda6 (wint6, wint5);
// synthesis attribute KEEP of wint7 is TRUE
not pda7 (wint7, wint6);
// synthesis attribute KEEP of wint8 is TRUE
not pda8 (wint8, wint7);
// synthesis attribute KEEP of wint9 is TRUE
not pda9 (wint9, wint8);
// synthesis attribute KEEP of wint10 is TRUE
not pda10 (wint10, wint9);
// synthesis attribute KEEP of wint11 is TRUE
not pda11 (wint11, wint10);
//# synthesis attribute KEEP of wint12 is TRUE
not pda12 (wint12, wint11);
//# synthesis attribute KEEP of wint13 is TRUE
not pda13 (wint13, wint12);
//# synthesis attribute KEEP of wint14 is TRUE
not pda14 (wint14, wint13);
//# synthesis attribute KEEP of wint15 is TRUE
not pda15 (wint15, wint14);
  */
// synthesis attribute KEEP of outp is TRUE
not pda16 (outp, wint5);
//synthesis attribute keep of outp1 is true
and and1 (outp1,outp,outp);

endmodule

module pulse_delay_slaveEX (inp, outp,outp1);

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
/*// synthesis attribute KEEP of wint6 is TRUE
not pda6 (wint6, wint5);
// synthesis attribute KEEP of wint7 is TRUE
not pda7 (wint7, wint6);
// synthesis attribute KEEP of wint8 is TRUE
not pda8 (wint8, wint7);
// synthesis attribute KEEP of wint9 is TRUE
not pda9 (wint9, wint8);
// synthesis attribute KEEP of wint10 is TRUE
not pda10 (wint10, wint9);
// synthesis attribute KEEP of wint11 is TRUE
not pda11 (wint11, wint10);
// synthesis attribute KEEP of wint12 is TRUE
not pda12 (wint12, wint11);
// synthesis attribute KEEP of wint13 is TRUE
not pda13 (wint13, wint12);
// synthesis attribute KEEP of wint14 is TRUE
not pda14 (wint14, wint13);
// synthesis attribute KEEP of wint15 is TRUE
not pda15 (wint15, wint14);
// synthesis attribute KEEP of wint16 is TRUE
not pda16 (wint16, wint15);
// synthesis attribute KEEP of wint17 is TRUE
not pda17 (wint17, wint16);
// synthesis attribute KEEP of wint18 is TRUE
not pda18 (wint18, wint17);
// synthesis attribute KEEP of wint19 is TRUE
not pda19 (wint19, wint18);
// synthesis attribute KEEP of wint20 is TRUE
not pda20 (wint20, wint19);
// synthesis attribute KEEP of wint21 is TRUE
not pda21 (wint21, wint20);
  */
// synthesis attribute KEEP of outp is TRUE
not pda114 (outp, wint5);
//synthesis attribute keep of outp1 is true
myand and1 (outp1,outp,outp);

endmodule

module pulse_delay_slaveMEM (inp, outp,outp1);

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
/*// synthesis attribute KEEP of wint6 is TRUE
not pda6 (wint6, wint5);
// synthesis attribute KEEP of wint7 is TRUE
not pda7 (wint7, wint6);
//# synthesis attribute KEEP of wint8 is TRUE
not pda8 (wint8, wint7);
//# synthesis attribute KEEP of wint9 is TRUE
not pda9 (wint9, wint8);
  */
// synthesis attribute KEEP of outp is TRUE
not pda14 (outp, wint5);
//synthesis attribute keep of outp1 is true
and and1 (outp1,outp,outp);

endmodule

module matched_delayIF(inp2, inp3, outp2, delay_select);

input inp2;
input inp3;
input [1:0] delay_select;
output outp2;

wire outp2;

wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9, wint10;
wire wint11, wint12, wint13, wint14, wint15, wint16, wint17, wint18, wint19, wint20;
wire wint21, wint22, wint23, wint24, wint25, wint26, wint27, wint28, wint29, wint30;
wire IF_delay_el1, IF_delay_el2, IF_delay_el3, IF_delay_el4;
// ##synthesis attribute KEEP of inp2 is TRUE
// synthesis attribute KEEP of wint1 is TRUE
myand mda1 (wint1, inp2, inp3);
// synthesis attribute KEEP of wint2 is TRUE
myand mda2 (wint2, inp2, wint1);
// synthesis attribute KEEP of wint3 is TRUE
myand mda3 (wint3, inp2, wint2);
// synthesis attribute KEEP of wint4 is TRUE
myand mda4 (wint4, inp2, wint3);
// synthesis attribute KEEP of wint5 is TRUE
myand mda5 (wint5, inp2, wint4);
// synthesis attribute KEEP of wint6 is TRUE
myand mda6 (wint6, inp2, wint5);
// synthesis attribute KEEP of wint7 is TRUE
myand mda7 (wint7, inp2, wint6);
// synthesis attribute KEEP of wint8 is TRUE
myand mda8 (wint8, inp2, wint7);
// synthesis attribute KEEP of wint9 is TRUE
myand mda9 (wint9, inp2, wint8);
// synthesis attribute KEEP of wint10 is TRUE
myand mda10 (wint10, inp2, wint9);
// synthesis attribute KEEP of wint11 is TRUE
myand mda11 (wint11, inp2, wint10);
// synthesis attribute KEEP of wint12 is TRUE
myand mda12 (wint12, inp2, wint11);
// synthesis attribute KEEP of wint13 is TRUE
myand mda13 (wint13, inp2, wint12);
// synthesis attribute KEEP of wint14 is TRUE
myand mda14 (wint14, inp2, wint13);
// synthesis attribute KEEP of wint15 is TRUE
myand mda15 (wint15, inp2, wint14);
// synthesis attribute KEEP of wint16 is TRUE
myand mda16 (wint16, inp2, wint15);
// synthesis attribute KEEP of wint17 is TRUE
myand mda17 (wint17, inp2, wint16);
// synthesis attribute KEEP of wint18 is TRUE
myand mda18 (wint18, inp2 , wint17);
// synthesis attribute KEEP of wint19 is TRUE
myand mda19 (wint19, inp2, wint18);
// synthesis attribute KEEP of wint20 is TRUE
myand mda20 (wint20, inp2, wint19);
// synthesis attribute KEEP of wint21 is TRUE
myand mda21 (wint21 , inp2, wint20);
// synthesis attribute KEEP of wint22 is TRUE
myand mda22 (wint22, inp2 , wint21);
// synthesis attribute KEEP of wint23 is TRUE
myand mda23 (wint23, inp2 , wint22);
// synthesis attribute KEEP of wint24 is TRUE
myand mda24 (wint24, inp2 , wint23);
// synthesis attribute KEEP of wint25 is TRUE
myand mda25 (wint25, inp2 , wint24);
// synthesis attribute KEEP of wint26 is TRUE
myand mda26 (wint26, inp2 , wint25);
// synthesis attribute KEEP of wint27 is TRUE
myand mda27 (wint27, inp2, wint26);
// synthesis attribute KEEP of wint28 is TRUE
myand mda28 (wint28, inp2 , wint27);
// synthesis attribute KEEP of wint29 is TRUE
myand mda29 (wint29, inp2, wint28);
// synthesis attribute KEEP of wint30 is TRUE
myand mda30 (wint30, inp2, wint29);
// synthesis attribute KEEP of wint31 is TRUE
myand mda31 (wint31, inp2, wint30);
// synthesis attribute KEEP of wint32 is TRUE
myand mda32 (wint32 , inp2, wint31);
// synthesis attribute KEEP of wint33 is TRUE
myand mda33 (wint33, inp2 , wint32);
// synthesis attribute KEEP of wint34 is TRUE
myand mda34 (wint34, inp2 , wint33);
// synthesis attribute KEEP of wint35 is TRUE
myand mda35 (wint35, inp2 , wint34);
// synthesis attribute KEEP of wint36 is TRUE
myand mda36 (wint36, inp2 , wint35);
// synthesis attribute KEEP of wint37 is TRUE
myand mda37 (wint37, inp2 , wint36);
// synthesis attribute KEEP of wint38 is TRUE
myand mda38 (wint38, inp2, wint37);
// synthesis attribute KEEP of wint39 is TRUE
myand mda39 (wint39, inp2 , wint38);
// synthesis attribute KEEP of wint40 is TRUE
myand mda40 (wint40, inp2, wint39);
/*
// synthesis attribute KEEP of wint41 is TRUE
myand mda41 (wint41, inp2, wint40);
// synthesis attribute KEEP of wint42 is TRUE
myand mda42 (wint42, inp2, wint41);
// synthesis attribute KEEP of wint43 is TRUE
myand mda43 (wint43, inp2, wint42);
// synthesis attribute KEEP of wint44 is TRUE
myand mda44 (wint44, inp2, wint43);
// synthesis attribute KEEP of wint45 is TRUE
myand mda45 (wint45, inp2, wint44);
// synthesis attribute KEEP of wint46 is TRUE
myand mda46 (wint46, inp2, wint45);
// synthesis attribute KEEP of wint47 is TRUE
myand mda47 (wint47, inp2, wint46);
// synthesis attribute KEEP of wint48 is TRUE
myand mda48 (wint48, inp2, wint47);
// synthesis attribute KEEP of wint49 is TRUE
myand mda49 (wint49, inp2, wint48);
// synthesis attribute KEEP of wint50 is TRUE
myand mda50 (wint50, inp2, wint49);
// synthesis attribute KEEP of wint51 is TRUE
myand mda51 (wint51 , inp2, wint50);
// synthesis attribute KEEP of wint52 is TRUE
myand mda52 (wint52, inp2 , wint51);
// synthesis attribute KEEP of wint53 is TRUE
myand mda53 (wint53, inp2 , wint52);
// synthesis attribute KEEP of wint54 is TRUE
myand mda54 (wint54, inp2 , wint53);
// synthesis attribute KEEP of wint55 is TRUE
myand mda55 (wint55, inp2 , wint54);
// synthesis attribute KEEP of wint56 is TRUE
myand mda56 (wint56, inp2 , wint55);
// synthesis attribute KEEP of wint57 is TRUE
myand mda57 (wint57, inp2, wint56);
// synthesis attribute KEEP of wint58 is TRUE
myand mda58 (wint58, inp2 , wint57);
// synthesis attribute KEEP of wint59 is TRUE
myand mda59 (wint59, inp2, wint58);
// synthesis attribute KEEP of wint60 is TRUE
myand mda60 (wint60, inp2, wint59);
// synthesis attribute KEEP of wint61 is TRUE
myand mda61 (wint61 , inp2, wint60);
// synthesis attribute KEEP of wint62 is TRUE
myand mda62 (wint62, inp2 , wint61);
// synthesis attribute KEEP of wint63 is TRUE
myand mda63 (wint63, inp2 , wint62);
// synthesis attribute KEEP of wint64 is TRUE
myand mda64 (wint64, inp2 , wint63);
// synthesis attribute KEEP of wint65 is TRUE
myand mda65 (wint65, inp2 , wint64);
// synthesis attribute KEEP of wint66 is TRUE
myand mda66 (wint66, inp2 , wint65);
// synthesis attribute KEEP of wint67 is TRUE
myand mda67 (wint67, inp2, wint66);
// synthesis attribute KEEP of wint68 is TRUE
myand mda68 (wint68, inp2 , wint67);
// synthesis attribute KEEP of wint69 is TRUE
myand mda69 (wint69, inp2, wint68);
// synthesis attribute KEEP of wint70 is TRUE
myand mda70 (wint70, inp2, wint69);
// synthesis attribute KEEP of wint71 is TRUE
myand mda71 (wint71, inp2, wint70);
// synthesis attribute KEEP of wint72 is TRUE
myand mda72 (wint72 , inp2, wint71);
// synthesis attribute KEEP of wint73 is TRUE
myand mda73 (wint73, inp2 , wint72);
// synthesis attribute KEEP of wint74 is TRUE
myand mda74 (wint74, inp2 , wint73);
// synthesis attribute KEEP of wint75 is TRUE
myand mda75 (wint75, inp2 , wint74);
// synthesis attribute KEEP of wint76 is TRUE
myand mda76 (wint76, inp2 , wint75);
// synthesis attribute KEEP of wint77 is TRUE
myand mda77 (wint77, inp2 , wint76);
// synthesis attribute KEEP of wint78 is TRUE
myand mda78 (wint78, inp2, wint77);
// synthesis attribute KEEP of wint79 is TRUE
myand mda79 (wint79, inp2 , wint78);
// synthesis attribute KEEP of wint80 is TRUE
myand mda80 (wint80, inp2, wint79);
*/


// synthesis attribute KEEP of outp2 is TRUE   
// synthesis attribute KEEP of IF_delay_el1 is TRUE
// synthesis attribute KEEP of IF_delay_el2 is TRUE
// synthesis attribute KEEP of IF_delay_el3 is TRUE
// synthesis attribute KEEP of IF_delay_el4 is TRUE

assign IF_delay_el1 = wint8;
assign IF_delay_el2 = wint14;
assign IF_delay_el3 = wint30;
assign IF_delay_el4 = wint40;
assign outp2 = delay_select == 'b00 ? IF_delay_el1  :
	       delay_select == 'b01 ? IF_delay_el2  :
	       delay_select == 'b10 ? IF_delay_el3  :
	       delay_select == 'b11 ? IF_delay_el4  : IF_delay_el4;

endmodule

module myand(a,b,c);

output a;
input b,c;
and(a,b,c);
endmodule
module mynot(a,b);
output a;
input b;
not(a,b);
endmodule
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
module lc_semi_decID(rst, ri, ai, ro, ao, l,delay_select,l_slave_ID,
				 ro_master,ao_master,ro_delayed1,ridm);

input rst, ri, ao;
input [1:0] delay_select;
output l, ai, ro;

output ro_master,ao_master,ro_delayed1,ridm;

output l_slave_ID;

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
 pulse_delayID pd(.inp(ri), .outp(ridp), .outp1(ridp1));
//##synthesis attribute keep_hierarchy of md is yes
 matched_delayID md (.inp2(ridp), .inp3(ridp3), .outp2(ridm), .delay_select(delay_select));

wire ro_master,ao_master,l_slave;
 
 //pulse delay for slave
wire ro_delayed1, ro_delayed2;
pulse_delay_slaveID pd_slave(.inp(ro_master), .outp(ro_delayed1), .outp1(ro_delayed2));


assign l_slave_ID = l_slave; 

 master_ctrl master_ctrlID(rst, ridm, ai, ro_master, ao_master, l);
 slave_ctrl  slave_ctrlID(rst, /*ro_master,*/ro_delayed1, ao_master, ro, ao, l_slave);

 // #synthesis attribute CLOCK_SIGNAL of l is YES 
 // #synthesis attribute CLOCK_SIGNAL of ai is YES
 // synthesis attribute TIG of ri
 // synthesis attribute TIG of ao  
 // #synthesis attribute MAX_FANOUT of lc_semi_decID is 30
   
endmodule

module pulse_delayID(inp, outp,outp1);

input inp;
output outp;
output outp1;
wire outp1;

wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9;

// synthesis attribute KEEP of wint1 is TRUE
not pda1 (wint1, inp);
/*
//# synthesis attribute KEEP of wint2 is TRUE
not pda2 (wint2, wint1);
//# synthesis attribute KEEP of wint3 is TRUE
not pda3 (wint3, wint2);
//# synthesis attribute KEEP of wint4 is TRUE
not pda4 (wint4, wint3);
//# synthesis attribute KEEP of wint5 is TRUE
not pda5 (wint5, wint4);
//# synthesis attribute KEEP of wint6 is TRUE
not pda6 (wint6, wint5);
//# synthesis attribute KEEP of wint7 is TRUE
not pda7 (wint7, wint6);
//# synthesis attribute KEEP of wint8 is TRUE
not pda8 (wint8, wint7);
//# synthesis attribute KEEP of wint9 is TRUE
not pda9 (wint9, wint8);
*/
// synthesis attribute KEEP of outp is TRUE
not pda10 (outp, wint1);
//synthesis attribute keep of outp1 is true
and and1 (outp1,outp,outp);

endmodule

module matched_delayID(inp2, inp3, outp2, delay_select);

input inp2;
input inp3;
input [1:0] delay_select;
output outp2;

wire outp2;

wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9, wint10;
wire wint11,wint12,wint13,wint14,wint15,wint16,wint17,wint18,wint19,wint20;
wire wint21,wint22,wint23,wint24,wint25,wint26,wint27,wint28,wint29,wint30;
wire wint31,wint32,wint33,wint34,wint35,wint36,wint37,wint38,wint39,wint40;
wire wint41,wint42,wint43,wint44,wint45,wint46,wint47,wint48,wint49,wint50;
wire wint51,wint52,wint53,wint54,wint55,wint56,wint57,wint58,wint59,wint60;
wire wint61,wint62,wint63,wint64,wint65,wint66,wint67,wint68,wint69,wint70;
wire wint71,wint72,wint73,wint74,wint75,wint76,wint77,wint78,wint79,wint80;
wire ID_delay_el1, ID_delay_el2, ID_delay_el3, ID_delay_el4;
// synthesis attribute KEEP of wint1 is TRUE
myand mda1 (wint1, inp2, inp3);
// synthesis attribute KEEP of wint2 is TRUE
myand mda2 (wint2, inp2, wint1);
// synthesis attribute KEEP of wint3 is TRUE
myand mda3 (wint3, inp2, wint2);
// synthesis attribute KEEP of wint4 is TRUE
myand mda4 (wint4, inp2, wint3);
// synthesis attribute KEEP of wint5 is TRUE
myand mda5 (wint5, inp2, wint4);
// synthesis attribute KEEP of wint6 is TRUE
myand mda6 (wint6, inp2, wint5);
// synthesis attribute KEEP of wint7 is TRUE
myand mda7 (wint7, inp2, wint6);
// synthesis attribute KEEP of wint8 is TRUE
myand mda8 (wint8, inp2, wint7);
// synthesis attribute KEEP of wint9 is TRUE
myand mda9 (wint9, inp2, wint8);
// synthesis attribute KEEP of wint10 is TRUE
myand mda10 (wint10, inp2, wint9);
// synthesis attribute KEEP of wint11 is TRUE
myand mda11 (wint11 , inp2, wint10);
// synthesis attribute KEEP of wint12 is TRUE
myand mda12 (wint12, inp2 , wint11);
// synthesis attribute KEEP of wint13 is TRUE
myand mda13 (wint13, inp2 , wint12);
// synthesis attribute KEEP of wint14 is TRUE
myand mda14 (wint14, inp2 , wint13);
// synthesis attribute KEEP of wint15 is TRUE
myand mda15 (wint15, inp2 , wint14);
// synthesis attribute KEEP of wint16 is TRUE
myand mda16 (wint16, inp2 , wint15);
// synthesis attribute KEEP of wint17 is TRUE
myand mda17 (wint17, inp2, wint16);
// synthesis attribute KEEP of wint18 is TRUE
myand mda18 (wint18, inp2 , wint17);
// synthesis attribute KEEP of wint19 is TRUE
myand mda19 (wint19, inp2, wint18);
// synthesis attribute KEEP of wint20 is TRUE
myand mda20 (wint20, inp2, wint19);
// synthesis attribute KEEP of wint21 is TRUE
myand mda21 (wint21 , inp2, wint20);
// synthesis attribute KEEP of wint22 is TRUE
myand mda22 (wint22, inp2 , wint21);
// synthesis attribute KEEP of wint23 is TRUE
myand mda23 (wint23, inp2 , wint22);
// synthesis attribute KEEP of wint24 is TRUE
myand mda24 (wint24, inp2 , wint23);
// synthesis attribute KEEP of wint25 is TRUE
myand mda25 (wint25, inp2 , wint24);
// synthesis attribute KEEP of wint26 is TRUE
myand mda26 (wint26, inp2 , wint25);
// synthesis attribute KEEP of wint27 is TRUE
myand mda27 (wint27, inp2, wint26);
// synthesis attribute KEEP of wint28 is TRUE
myand mda28 (wint28, inp2 , wint27);
// synthesis attribute KEEP of wint29 is TRUE
myand mda29 (wint29, inp2, wint28);
// synthesis attribute KEEP of wint30 is TRUE
myand mda30 (wint30, inp2, wint29);
// synthesis attribute KEEP of wint31 is TRUE
myand mda31 (wint31, inp2, wint30);
// synthesis attribute KEEP of wint32 is TRUE
myand mda32 (wint32 , inp2, wint31);
// synthesis attribute KEEP of wint33 is TRUE
myand mda33 (wint33, inp2 , wint32);
// synthesis attribute KEEP of wint34 is TRUE
myand mda34 (wint34, inp2 , wint33);
// synthesis attribute KEEP of wint35 is TRUE
myand mda35 (wint35, inp2 , wint34);
// synthesis attribute KEEP of wint36 is TRUE
myand mda36 (wint36, inp2 , wint35);
// synthesis attribute KEEP of wint37 is TRUE
myand mda37 (wint37, inp2 , wint36);
// synthesis attribute KEEP of wint38 is TRUE
myand mda38 (wint38, inp2, wint37);
// synthesis attribute KEEP of wint39 is TRUE
myand mda39 (wint39, inp2 , wint38);
// synthesis attribute KEEP of wint40 is TRUE
myand mda40 (wint40, inp2, wint39);

// synthesis attribute KEEP of wint41 is TRUE
myand mda41 (wint41, inp2, wint40);
// synthesis attribute KEEP of wint42 is TRUE
myand mda42 (wint42, inp2, wint41);
// synthesis attribute KEEP of wint43 is TRUE
myand mda43 (wint43, inp2, wint42);
// synthesis attribute KEEP of wint44 is TRUE
myand mda44 (wint44, inp2, wint43);
// synthesis attribute KEEP of wint45 is TRUE
myand mda45 (wint45, inp2, wint44);
// synthesis attribute KEEP of wint46 is TRUE
myand mda46 (wint46, inp2, wint45);
// synthesis attribute KEEP of wint47 is TRUE
myand mda47 (wint47, inp2, wint46);
// synthesis attribute KEEP of wint48 is TRUE
myand mda48 (wint48, inp2, wint47);
// synthesis attribute KEEP of wint49 is TRUE
myand mda49 (wint49, inp2, wint48);
// synthesis attribute KEEP of wint50 is TRUE
myand mda50 (wint50, inp2, wint49);
// synthesis attribute KEEP of wint51 is TRUE
myand mda51 (wint51 , inp2, wint50);
// synthesis attribute KEEP of wint52 is TRUE
myand mda52 (wint52, inp2 , wint51);
// synthesis attribute KEEP of wint53 is TRUE
myand mda53 (wint53, inp2 , wint52);
// synthesis attribute KEEP of wint54 is TRUE
myand mda54 (wint54, inp2 , wint53);
// synthesis attribute KEEP of wint55 is TRUE
myand mda55 (wint55, inp2 , wint54);
// synthesis attribute KEEP of wint56 is TRUE
myand mda56 (wint56, inp2 , wint55);
// synthesis attribute KEEP of wint57 is TRUE
myand mda57 (wint57, inp2, wint56);
// synthesis attribute KEEP of wint58 is TRUE
myand mda58 (wint58, inp2 , wint57);
// synthesis attribute KEEP of wint59 is TRUE
myand mda59 (wint59, inp2, wint58);
// synthesis attribute KEEP of wint60 is TRUE
myand mda60 (wint60, inp2, wint59);
// synthesis attribute KEEP of wint61 is TRUE
myand mda61 (wint61 , inp2, wint60);
// synthesis attribute KEEP of wint62 is TRUE
myand mda62 (wint62, inp2 , wint61);
// synthesis attribute KEEP of wint63 is TRUE
myand mda63 (wint63, inp2 , wint62);
// synthesis attribute KEEP of wint64 is TRUE
myand mda64 (wint64, inp2 , wint63);
// synthesis attribute KEEP of wint65 is TRUE
myand mda65 (wint65, inp2 , wint64);
// synthesis attribute KEEP of wint66 is TRUE
myand mda66 (wint66, inp2 , wint65);
// synthesis attribute KEEP of wint67 is TRUE
myand mda67 (wint67, inp2, wint66);
// synthesis attribute KEEP of wint68 is TRUE
myand mda68 (wint68, inp2 , wint67);
// synthesis attribute KEEP of wint69 is TRUE
myand mda69 (wint69, inp2, wint68);
// synthesis attribute KEEP of wint70 is TRUE
myand mda70 (wint70, inp2, wint69);
/*// synthesis attribute KEEP of wint71 is TRUE
myand mda71 (wint71, inp2, wint70);
// synthesis attribute KEEP of wint72 is TRUE
myand mda72 (wint72 , inp2, wint71);
// synthesis attribute KEEP of wint73 is TRUE
myand mda73 (wint73, inp2 , wint72);
// synthesis attribute KEEP of wint74 is TRUE
myand mda74 (wint74, inp2 , wint73);
// synthesis attribute KEEP of wint75 is TRUE
myand mda75 (wint75, inp2 , wint74);
// synthesis attribute KEEP of wint76 is TRUE
myand mda76 (wint76, inp2 , wint75);
// synthesis attribute KEEP of wint77 is TRUE
myand mda77 (wint77, inp2 , wint76);
// synthesis attribute KEEP of wint78 is TRUE
myand mda78 (wint78, inp2, wint77);
// synthesis attribute KEEP of wint79 is TRUE
myand mda79 (wint79, inp2 , wint78);
// synthesis attribute KEEP of wint80 is TRUE
myand mda80 (wint80, inp2, wint79);
*/

// synthesis attribute KEEP of outp2 is TRUE      
// synthesis attribute KEEP of ID_delay_el1 is TRUE
// synthesis attribute KEEP of ID_delay_el2 is TRUE
// synthesis attribute KEEP of ID_delay_el3 is TRUE
// synthesis attribute KEEP of ID_delay_el4 is TRUE
   
assign ID_delay_el1 = wint28;
assign ID_delay_el2 = wint30;
assign ID_delay_el3 = wint32;
assign ID_delay_el4 = wint40;
assign outp2 =  delay_select == 'b00 ? ID_delay_el1 :
		delay_select == 'b01 ? ID_delay_el2 :
		delay_select == 'b10 ? ID_delay_el3 :
		delay_select == 'b11 ? ID_delay_el4 : ID_delay_el4;

endmodule

/****************************************************************************/
/****************************************************************************/
/****************************************************************************/
/****************************************************************************/
module lc_semi_decEX(rst, ri, ai, ro, ao, l, delay_select,l_slave_EX,
				ro_master,ao_master,ro_delayed1,ridm);

input rst, ri, ao;
input [1:0] delay_select;
output l, ai, ro;

output ro_master,ao_master,ro_delayed1,ridm;

output l_slave_EX;

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
 pulse_delayEX pd(.inp(ri), .outp(ridp), .outp1(ridp1));
//##synthesis attribute keep_hierarchy of md is yes
 matched_delayEX md (.inp2(ridp), .inp3(ridp3), .outp2(ridm), .delay_select(delay_select));

 wire ro_master,ao_master,l_slave;

//pulse delay for slave
wire ro_delayed1, ro_delayed2;
pulse_delay_slaveEX pd_slave(.inp(ro_master), .outp(ro_delayed1), .outp1(ro_delayed2));
 
 assign l_slave_EX = l_slave;

 master_ctrl master_ctrlEX(rst, ridm, ai, ro_master, ao_master, l);
 slave_ctrl  slave_ctrlEX(rst, /*ro_master,*/ro_delayed1, ao_master, ro, ao, l_slave);

  // #synthesis attribute CLOCK_SIGNAL of l is YES 
  // #synthesis attribute CLOCK_SIGNAL of ai is YES
  // synthesis attribute TIG of ri
  // synthesis attribute TIG of ao  
  // #synthesis attribute MAX_FANOUT of lc_semi_decEX is 30
   
endmodule

module pulse_delayEX(inp, outp,outp1);

input inp;
output outp;
output outp1;
wire outp1;

wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9;

// synthesis attribute KEEP of wint1 is TRUE
not pda1 (wint1, inp);
/*
// synthesis attribute KEEP of wint2 is TRUE
not pda2 (wint2, wint1);
// synthesis attribute KEEP of wint3 is TRUE
not pda3 (wint3, wint2);
// synthesis attribute KEEP of wint4 is TRUE
not pda4 (wint4, wint3);   
// synthesis attribute KEEP of wint5 is TRUE
not pda5 (wint5, wint4);
   
//# synthesis attribute KEEP of wint6 is TRUE
not pda6 (wint6, wint5);
//# synthesis attribute KEEP of wint7 is TRUE
not pda7 (wint7, wint6);
//# synthesis attribute KEEP of wint8 is TRUE
not pda8 (wint8, wint7);
//# synthesis attribute KEEP of wint9 is TRUE
not pda9 (wint9, wint8);
*/
// synthesis attribute KEEP of outp is TRUE
not pda10 (outp, wint1);
//synthesis attribute keep of outp1 is true
and and1 (outp1,outp,outp);

endmodule

module matched_delayEX(inp2, inp3, outp2, delay_select);

input inp2;
input inp3;
input [1:0] delay_select;
output outp2;

wire outp2;

wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9, wint10;
wire wint11,wint12,wint13,wint14,wint15,wint16,wint17,wint18,wint19,wint20;
wire wint21,wint22,wint23,wint24,wint25,wint26,wint27,wint28,wint29,wint30;
wire wint31,wint32,wint33,wint34,wint35,wint36,wint37,wint38,wint39,wint40;
wire wint41,wint42,wint43,wint44,wint45,wint46,wint47,wint48,wint49,wint50;
wire wint51,wint52,wint53,wint54,wint55,wint56,wint57,wint58,wint59,wint60;
wire wint61,wint62,wint63,wint64,wint65,wint66,wint67,wint68,wint69,wint70;
wire wint71,wint72,wint73,wint74,wint75,wint76,wint77,wint78,wint79,wint80;
wire ID_delay_el1, ID_delay_el2, ID_delay_el3, ID_delay_el4;
// synthesis attribute KEEP of wint1 is TRUE
myand mda1 (wint1, inp2, inp3);
// synthesis attribute KEEP of wint2 is TRUE
myand mda2 (wint2, inp2, wint1);
// synthesis attribute KEEP of wint3 is TRUE
myand mda3 (wint3, inp2, wint2);
// synthesis attribute KEEP of wint4 is TRUE
myand mda4 (wint4, inp2, wint3);
// synthesis attribute KEEP of wint5 is TRUE
myand mda5 (wint5, inp2, wint4);
// synthesis attribute KEEP of wint6 is TRUE
myand mda6 (wint6, inp2, wint5);
// synthesis attribute KEEP of wint7 is TRUE
myand mda7 (wint7, inp2, wint6);
// synthesis attribute KEEP of wint8 is TRUE
myand mda8 (wint8, inp2, wint7);
// synthesis attribute KEEP of wint9 is TRUE
myand mda9 (wint9, inp2, wint8);
// synthesis attribute KEEP of wint10 is TRUE
myand mda10 (wint10, inp2, wint9);
// synthesis attribute KEEP of wint11 is TRUE
myand mda11 (wint11 , inp2, wint10);
// synthesis attribute KEEP of wint12 is TRUE
myand mda12 (wint12, inp2 , wint11);
// synthesis attribute KEEP of wint13 is TRUE
myand mda13 (wint13, inp2 , wint12);
// synthesis attribute KEEP of wint14 is TRUE
myand mda14 (wint14, inp2 , wint13);
// synthesis attribute KEEP of wint15 is TRUE
myand mda15 (wint15, inp2 , wint14);
// synthesis attribute KEEP of wint16 is TRUE
myand mda16 (wint16, inp2 , wint15);
// synthesis attribute KEEP of wint17 is TRUE
myand mda17 (wint17, inp2, wint16);
// synthesis attribute KEEP of wint18 is TRUE
myand mda18 (wint18, inp2 , wint17);
// synthesis attribute KEEP of wint19 is TRUE
myand mda19 (wint19, inp2, wint18);
// synthesis attribute KEEP of wint20 is TRUE
myand mda20 (wint20, inp2, wint19);
// synthesis attribute KEEP of wint21 is TRUE
myand mda21 (wint21 , inp2, wint20);
// synthesis attribute KEEP of wint22 is TRUE
myand mda22 (wint22, inp2 , wint21);
// synthesis attribute KEEP of wint23 is TRUE
myand mda23 (wint23, inp2 , wint22);
// synthesis attribute KEEP of wint24 is TRUE
myand mda24 (wint24, inp2 , wint23);
// synthesis attribute KEEP of wint25 is TRUE
myand mda25 (wint25, inp2 , wint24);
// synthesis attribute KEEP of wint26 is TRUE
myand mda26 (wint26, inp2 , wint25);
// synthesis attribute KEEP of wint27 is TRUE
myand mda27 (wint27, inp2, wint26);
// synthesis attribute KEEP of wint28 is TRUE
myand mda28 (wint28, inp2 , wint27);
// synthesis attribute KEEP of wint29 is TRUE
myand mda29 (wint29, inp2, wint28);
// synthesis attribute KEEP of wint30 is TRUE
myand mda30 (wint30, inp2, wint29);
// synthesis attribute KEEP of wint31 is TRUE
myand mda31 (wint31, inp2, wint30);
// synthesis attribute KEEP of wint32 is TRUE
myand mda32 (wint32 , inp2, wint31);
// synthesis attribute KEEP of wint33 is TRUE
myand mda33 (wint33, inp2 , wint32);
// synthesis attribute KEEP of wint34 is TRUE
myand mda34 (wint34, inp2 , wint33);
// synthesis attribute KEEP of wint35 is TRUE
myand mda35 (wint35, inp2 , wint34);
// synthesis attribute KEEP of wint36 is TRUE
myand mda36 (wint36, inp2 , wint35);
// synthesis attribute KEEP of wint37 is TRUE
myand mda37 (wint37, inp2 , wint36);
// synthesis attribute KEEP of wint38 is TRUE
myand mda38 (wint38, inp2, wint37);
// synthesis attribute KEEP of wint39 is TRUE
myand mda39 (wint39, inp2 , wint38);
// synthesis attribute KEEP of wint40 is TRUE
myand mda40 (wint40, inp2, wint39);
/*
// synthesis attribute KEEP of wint41 is TRUE
myand mda41 (wint41, inp2, wint40);
// synthesis attribute KEEP of wint42 is TRUE
myand mda42 (wint42, inp2, wint41);
// synthesis attribute KEEP of wint43 is TRUE
myand mda43 (wint43, inp2, wint42);
// synthesis attribute KEEP of wint44 is TRUE
myand mda44 (wint44, inp2, wint43);
// synthesis attribute KEEP of wint45 is TRUE
myand mda45 (wint45, inp2, wint44);
// synthesis attribute KEEP of wint46 is TRUE
myand mda46 (wint46, inp2, wint45);
// synthesis attribute KEEP of wint47 is TRUE
myand mda47 (wint47, inp2, wint46);
// synthesis attribute KEEP of wint48 is TRUE
myand mda48 (wint48, inp2, wint47);
// synthesis attribute KEEP of wint49 is TRUE
myand mda49 (wint49, inp2, wint48);
// synthesis attribute KEEP of wint50 is TRUE
myand mda50 (wint50, inp2, wint49);
// synthesis attribute KEEP of wint51 is TRUE
myand mda51 (wint51 , inp2, wint50);
// synthesis attribute KEEP of wint52 is TRUE
myand mda52 (wint52, inp2 , wint51);
// synthesis attribute KEEP of wint53 is TRUE
myand mda53 (wint53, inp2 , wint52);
// synthesis attribute KEEP of wint54 is TRUE
myand mda54 (wint54, inp2 , wint53);
// synthesis attribute KEEP of wint55 is TRUE
myand mda55 (wint55, inp2 , wint54);
// synthesis attribute KEEP of wint56 is TRUE
myand mda56 (wint56, inp2 , wint55);
// synthesis attribute KEEP of wint57 is TRUE
myand mda57 (wint57, inp2, wint56);
// synthesis attribute KEEP of wint58 is TRUE
myand mda58 (wint58, inp2 , wint57);
// synthesis attribute KEEP of wint59 is TRUE
myand mda59 (wint59, inp2, wint58);
// synthesis attribute KEEP of wint60 is TRUE
myand mda60 (wint60, inp2, wint59);
// synthesis attribute KEEP of wint61 is TRUE
myand mda61 (wint61 , inp2, wint60);
// synthesis attribute KEEP of wint62 is TRUE
myand mda62 (wint62, inp2 , wint61);
// synthesis attribute KEEP of wint63 is TRUE
myand mda63 (wint63, inp2 , wint62);
// synthesis attribute KEEP of wint64 is TRUE
myand mda64 (wint64, inp2 , wint63);
// synthesis attribute KEEP of wint65 is TRUE
myand mda65 (wint65, inp2 , wint64);
// synthesis attribute KEEP of wint66 is TRUE
myand mda66 (wint66, inp2 , wint65);
// synthesis attribute KEEP of wint67 is TRUE
myand mda67 (wint67, inp2, wint66);
// synthesis attribute KEEP of wint68 is TRUE
myand mda68 (wint68, inp2 , wint67);
// synthesis attribute KEEP of wint69 is TRUE
myand mda69 (wint69, inp2, wint68);
// synthesis attribute KEEP of wint70 is TRUE
myand mda70 (wint70, inp2, wint69);
// synthesis attribute KEEP of wint71 is TRUE
myand mda71 (wint71, inp2, wint70);
// synthesis attribute KEEP of wint72 is TRUE
myand mda72 (wint72 , inp2, wint71);
// synthesis attribute KEEP of wint73 is TRUE
myand mda73 (wint73, inp2 , wint72);
// synthesis attribute KEEP of wint74 is TRUE
myand mda74 (wint74, inp2 , wint73);
// synthesis attribute KEEP of wint75 is TRUE
myand mda75 (wint75, inp2 , wint74);
// synthesis attribute KEEP of wint76 is TRUE
myand mda76 (wint76, inp2 , wint75);
// synthesis attribute KEEP of wint77 is TRUE
myand mda77 (wint77, inp2 , wint76);
// synthesis attribute KEEP of wint78 is TRUE
myand mda78 (wint78, inp2, wint77);
// synthesis attribute KEEP of wint79 is TRUE
myand mda79 (wint79, inp2 , wint78);
// synthesis attribute KEEP of wint80 is TRUE
myand mda80 (wint80, inp2, wint79);
*/

// synthesis attribute KEEP of outp2 is TRUE   
// synthesis attribute KEEP of EX_delay_el1 is TRUE
// synthesis attribute KEEP of EX_delay_el2 is TRUE
// synthesis attribute KEEP of EX_delay_el3 is TRUE
// synthesis attribute KEEP of EX_delay_el4 is TRUE
   
assign EX_delay_el1 = wint20;
assign EX_delay_el2 = wint30;
assign EX_delay_el3 = wint34;
assign EX_delay_el4 = wint40;
assign outp2 =  delay_select == 'b00 ? EX_delay_el1 :
		delay_select == 'b01 ? EX_delay_el2 :
		delay_select == 'b10 ? EX_delay_el3 :
		delay_select == 'b11 ? EX_delay_el4 : EX_delay_el4;


endmodule

/*********************************************************************/
/*********************************************************************/
/*********************************************************************/
/*********************************************************************/
module lc_semi_decMEM(rst, ri, ai, ro, ao, l, delay_select,l_slave_MEM,
					ro_master,ao_master,ro_delayed1,ridm);

input rst, ri, ao;
input [1:0] delay_select;
output l, ai, ro;

output ro_master,ao_master,ro_delayed1,ridm;

output l_slave_MEM;

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
 pulse_delayMEM pd(.inp(ri), .outp(ridp), .outp1(ridp1));
//##synthesis attribute keep_hierarchy of md is yes
 matched_delayMEM md (.inp2(ridp), .inp3(ridp3), .outp2(ridm), .delay_select(delay_select));

 wire ro_master,ao_master,l_slave;

//pulse delay for slave
wire ro_delayed1, ro_delayed2;
pulse_delay_slaveMEM pd_slave(.inp(ro_master), .outp(ro_delayed1), .outp1(ro_delayed2));
 

 
assign l_slave_MEM = l_slave;

 master_ctrl master_ctrlMEM(rst, ridm, ai, ro_master, ao_master, l);
 slave_ctrl  slave_ctrlMEM(rst,/* ro_master,*/ro_delayed1, ao_master, ro, ao, l_slave);

 // #synthesis attribute CLOCK_SIGNAL of l is YES 
 // #synthesis attribute CLOCK_SIGNAL of ai is YES
 // synthesis attribute TIG of ri
 // synthesis attribute TIG of ao  
 // #synthesis attribute MAX_FANOUT of lc_semi_decMEM is 30

endmodule

module pulse_delayMEM(inp, outp,outp1);

input inp;
output outp;
output outp1;
wire outp1;

wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9;

// synthesis attribute KEEP of wint1 is TRUE
not pda1 (wint1, inp);
/*
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
*/
// synthesis attribute KEEP of outp is TRUE
not pda10 (outp, wint1);
//synthesis attribute keep of outp1 is true
and and1 (outp1,outp,outp);

endmodule

module matched_delayMEM(inp2, inp3, outp2,delay_select);

input inp2;
input inp3;
input [1:0] delay_select;
output outp2;

wire outp2;
wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9, wint10;
wire wint11, wint12, wint13, wint14, wint15, wint16, wint17, wint18, wint19, wint20;
wire wint21, wint22, wint23, wint24, wint25, wint26, wint27, wint28, wint29, wint30;
wire IF_delay_el1, IF_delay_el2, IF_delay_el3, IF_delay_el4;
// ##synthesis attribute KEEP of inp2 is TRUE
// synthesis attribute KEEP of wint1 is TRUE
myand mda1 (wint1, inp2, inp3);
// synthesis attribute KEEP of wint2 is TRUE
myand mda2 (wint2, inp2, wint1);
// synthesis attribute KEEP of wint3 is TRUE
myand mda3 (wint3, inp2, wint2);
// synthesis attribute KEEP of wint4 is TRUE
myand mda4 (wint4, inp2, wint3);
// synthesis attribute KEEP of wint5 is TRUE
myand mda5 (wint5, inp2, wint4);
// synthesis attribute KEEP of wint6 is TRUE
myand mda6 (wint6, inp2, wint5);
// synthesis attribute KEEP of wint7 is TRUE
myand mda7 (wint7, inp2, wint6);
// synthesis attribute KEEP of wint8 is TRUE
myand mda8 (wint8, inp2, wint7);
// synthesis attribute KEEP of wint9 is TRUE
myand mda9 (wint9, inp2, wint8);
// synthesis attribute KEEP of wint10 is TRUE
myand mda10 (wint10, inp2, wint9);
// synthesis attribute KEEP of wint11 is TRUE
myand mda11 (wint11, inp2, wint10);
// synthesis attribute KEEP of wint12 is TRUE
myand mda12 (wint12, inp2, wint11);
// synthesis attribute KEEP of wint13 is TRUE
myand mda13 (wint13, inp2, wint12);
// synthesis attribute KEEP of wint14 is TRUE
myand mda14 (wint14, inp2, wint13);
// synthesis attribute KEEP of wint15 is TRUE
myand mda15 (wint15, inp2, wint14);
// synthesis attribute KEEP of wint16 is TRUE
myand mda16 (wint16, inp2, wint15);
// synthesis attribute KEEP of wint17 is TRUE
myand mda17 (wint17, inp2, wint16);
// synthesis attribute KEEP of wint18 is TRUE
myand mda18 (wint18, inp2 , wint17);
// synthesis attribute KEEP of wint19 is TRUE
myand mda19 (wint19, inp2, wint18);
// synthesis attribute KEEP of wint20 is TRUE
myand mda20 (wint20, inp2, wint19);

// synthesis attribute KEEP of wint21 is TRUE
myand mda21 (wint21 , inp2, wint20);
// synthesis attribute KEEP of wint22 is TRUE
myand mda22 (wint22, inp2 , wint21);
// synthesis attribute KEEP of wint23 is TRUE
myand mda23 (wint23, inp2 , wint22);
// synthesis attribute KEEP of wint24 is TRUE
myand mda24 (wint24, inp2 , wint23);
// synthesis attribute KEEP of wint25 is TRUE
myand mda25 (wint25, inp2 , wint24);
// synthesis attribute KEEP of wint26 is TRUE
myand mda26 (wint26, inp2 , wint25);
// synthesis attribute KEEP of wint27 is TRUE
myand mda27 (wint27, inp2, wint26);
// synthesis attribute KEEP of wint28 is TRUE
myand mda28 (wint28, inp2 , wint27);
// synthesis attribute KEEP of wint29 is TRUE
myand mda29 (wint29, inp2, wint28);
// synthesis attribute KEEP of wint30 is TRUE
myand mda30 (wint30, inp2, wint29);   
// synthesis attribute KEEP of outp2 is TRUE
/* */
   
// synthesis attribute KEEP of outp2 is TRUE
// synthesis attribute KEEP of MEM_delay_el1 is TRUE
// synthesis attribute KEEP of MEM_delay_el2 is TRUE
// synthesis attribute KEEP of MEM_delay_el3 is TRUE
// synthesis attribute KEEP of MEM_delay_el4 is TRUE
   
assign MEM_delay_el1 = wint6;
assign MEM_delay_el2 = wint20;
assign MEM_delay_el3 = wint24;
assign MEM_delay_el4 = wint30;
   
assign outp2 = delay_select == 'b00 ? MEM_delay_el1  :
	       delay_select == 'b01 ? MEM_delay_el2  :
	       delay_select == 'b10 ? MEM_delay_el3  :
	       delay_select == 'b11 ? MEM_delay_el4  : MEM_delay_el4;

endmodule

// SEMI-DECOUPLED Controllers //
  
module master_ctrl(rst, ri, ai, ro, ao, l);

input rst, ri, ao;
output l, ai, ro;

wire nl;
wire nrst, lninp1, lninp2;
wire roainp;
wire ridp1,ridp2,ridp3;

 not dnot (nridm, ri);

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

module slave_ctrl(rst, ri, ai, ro, ao, l);

input rst, ri, ao;
output l, ai, ro;

wire nl;
wire nrst, lninp1, lninp2;
wire roainp;
wire ridp1,ridp2,ridp3;

 not dnot (nridm, ri);

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
