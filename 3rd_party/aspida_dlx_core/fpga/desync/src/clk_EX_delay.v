module DM_delay (inp, outp, delay_select);

input inp;
input [1:0] delay_select;
output outp;

wire wint1, wint2, wint3, wint4, wint5, wint6, wint7, wint8, wint9, wint10;
wire wint11, wint12, wint13, wint14, wint15, wint16, wint17, wint18, wint19, wint20;
wire wint21, wint22, wint23, wint24, wint25, wint26, wint27, wint28, wint29, wint30;
wire wint31, wint32, wint33, wint34, wint35, wint36, wint37, wint38, wint39, wint40;
wire wint41, wint42, wint43, wint44, wint45, wint46, wint47, wint48, wint49, wint50;
wire  DM_delay_el1, DM_delay_el2, DM_delay_el3, DM_delay_el4;

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
// synthesis attribute KEEP of wint22 is TRUE
not pda22 (wint22, wint21);
// synthesis attribute KEEP of wint23 is TRUE
not pda23 (wint23, wint22);
// synthesis attribute KEEP of wint24 is TRUE
not pda24 (wint24, wint23);
// synthesis attribute KEEP of wint25 is TRUE
not pda25 (wint25, wint24);
// synthesis attribute KEEP of wint26 is TRUE
not pda26 (wint26, wint25);
// synthesis attribute KEEP of wint27 is TRUE
not pda27 (wint27, wint26);
// synthesis attribute KEEP of wint28 is TRUE
not pda28 (wint28, wint27);
// synthesis attribute KEEP of wint29 is TRUE
not pda29 (wint29, wint28);
// synthesis attribute KEEP of wint30 is TRUE
not pda30 (wint30, wint29);
// synthesis attribute KEEP of wint31 is TRUE
not pda31 (wint31, wint30);
// synthesis attribute KEEP of wint32 is TRUE
not pda32 (wint32, wint31);
// synthesis attribute KEEP of wint33 is TRUE
not pda33 (wint33, wint32);
// synthesis attribute KEEP of wint34 is TRUE
not pda34 (wint34, wint33);
// synthesis attribute KEEP of wint35 is TRUE
not pda35 (wint35, wint34);
// synthesis attribute KEEP of wint36 is TRUE
not pda36 (wint36, wint35);
// synthesis attribute KEEP of wint37 is TRUE
not pda37 (wint37, wint36);
// synthesis attribute KEEP of wint38 is TRUE
not pda38 (wint38, wint37);
// synthesis attribute KEEP of wint39 is TRUE
not pda39 (wint39, wint38);
// synthesis attribute KEEP of wint40 is TRUE
not pda40 (wint40, wint39);
   
// synthesis attribute KEEP of wint41 is TRUE
not pda41 (wint41, wint40);
// synthesis attribute KEEP of wint42 is TRUE
not pda42 (wint42, wint41);
// synthesis attribute KEEP of wint43 is TRUE
not pda43 (wint43, wint42);
// synthesis attribute KEEP of wint44 is TRUE
not pda44 (wint44, wint43);
// synthesis attribute KEEP of wint45 is TRUE
not pda45 (wint45, wint44);
// synthesis attribute KEEP of wint46 is TRUE
not pda46 (wint46, wint45);
// synthesis attribute KEEP of wint47 is TRUE
not pda47 (wint47, wint46);
// synthesis attribute KEEP of wint48 is TRUE
not pda48 (wint48, wint47);
// synthesis attribute KEEP of wint49 is TRUE
not pda49 (wint49, wint48);
// synthesis attribute KEEP of wint50 is TRUE
not pda50 (wint50, wint49);
/**/
    
// synthesis attribute KEEP of DM_delay_el1 is TRUE
// synthesis attribute KEEP of DM_delay_el2 is TRUE
// synthesis attribute KEEP of DM_delay_el3 is TRUE
// synthesis attribute KEEP of DM_delay_el4 is TRUE
       
assign DM_delay_el1 = wint2;
assign DM_delay_el2 = wint10;
assign DM_delay_el3 = wint18;
assign DM_delay_el4 = wint40;
assign outp =  delay_select == 'b00 ? DM_delay_el1  :
               delay_select == 'b01 ? DM_delay_el2  :
               delay_select == 'b10 ? DM_delay_el3  :
               delay_select == 'b11 ? DM_delay_el4  : DM_delay_el4;

   
endmodule
