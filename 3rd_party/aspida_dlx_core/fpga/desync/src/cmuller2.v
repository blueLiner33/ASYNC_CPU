module cmuller2 (a, b, c);

input a, b;
output c;

wire ab, bc, ac;

 and cmand1 (ab, a, b); 
 and cmand2 (bc, b, c);
 and cmand3 (ac, a, c);
  
 or cmor (c, ab, bc, ac);

endmodule
