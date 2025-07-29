/*
 *  DLX "Linker" (yacc parser)
 *  Copyright (C) 1995,1996 Peter Bergner, Aaron Sawdey
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *  Email: bergner@mountains.ee.umn.edu or sawdey@mountains.ee.umn.edu
 *
 *  Snail Mail:
 *
 *  Department of Electrical Engineering
 *  University of Minnesota
 *  4-174 EE/CSci Building
 *  200 Union Street S.E.
 *  Minneapolis, MN 55455
 *
 *
 */

%{
#include  <stdio.h>
#include  <stdlib.h>
#include  <string.h>
#include  <time.h>
#include  <sys/time.h>
#include  <ctype.h>
#include  <math.h>
#include  <varargs.h>
#include  "globals.h"

int yylineno;
void yyerror (char *);

%}

%token   IREG FREG SREG INT REAL IDENT STRING SHIFTL SHIFTR CR OTHER
%token   ALU_RRR_ID ALU_RRX_ID ALU_RRI_ID ALU_RIX_ID ALU_IXX_ID ALU_XXX_ID
%token   LOAD_ID STORE_ID TRAP_ID
%token   BRANCH_RL_ID BRANCH_LX_ID SUBCALL_LX_ID SUBCALL_RX_ID
%token   ASM_BEGINFUNC ASM_ENDFUNC
%token   ASM_ALIGN ASM_ASCII ASM_ASCIIZ ASM_BYTE ASM_DATA ASM_DOUBLE
%token   ASM_FLOAT ASM_GLOBAL ASM_SPACE ASM_TEXT ASM_WORD ASM_HALF
%token   UNIMPLEMENTED_OP COMMENT

%right	 '!' '~'
%left    '*' '/' '%'
%left    '+' '-'
%left    SHIFTL SHIFTR
%left    '&'
%left    '^'
%left    '|'

%start   asm_lines

%%

asm_lines	: asm_lines asm_line
		| asm_line
		;

asm_line        :  label opt_comment CR	
                   { if(pass==2 && PRINTSYM) putc('\n',outfp); }
                |  '#' INT STRING CR
                |  asm_cmd opt_comment CR   
                   { if(pass==2 && PRINTSYM) putc('\n',outfp); }
                |  insn opt_comment CR      
                   { 
		     inc_addr(BYTES_PER_INSN); 
		     if(pass==2) putc('\n',outfp); 
		   }
                |  opt_comment CR		
                   { if(pass==2) putc('\n',outfp); }
                ;

opt_comment	:  COMMENT	{ if(pass==2) fputs($1.text,outfp); }
                |
                ;

label           :  IDENT ':'
                   { Symbol *s;
		     if(pass==1) {
		       s=newsymbol($1.text,curfile);
		       lastsym=s;
		       s->flags |= (tLABEL|tDEF); 
		       s->flags &= ~tUNK;
		       s->addr = get_addr();
		       s->flags |= get_addr_state();
		     } else if(pass==2) {
		       s=findsymbol($1.text,curfile);
		       lastsym=s;
		       if(PRINTSYM) {
			 fprintf(outfp,"%s:",outname($1.text));
		       }
		     }
		   }
                ;

asm_cmd         :  ASM_ALIGN num
                   {
		     if(pass==1) align_addr($2.ival);
		     if(pass==2) {
		       fprintf(outfp,"%s %s",$1.text,$2.text);
		       if(!(PRINTSYM)) putc('\n',outfp);
		     }
		   }
                |  ASM_GLOBAL IDENT 
                   { Symbol *s;
		     if(pass==1) {
		       s=newsymbol($2.text,curfile);
		       s->flags |= tGLOBAL; 
		       s->flags &= ~tUNK;
		       lastsym=s;
		     } else if(pass==2) {
		       s=findsymbol($2.text,curfile);
		       lastsym=s; 
		       if(PRINTSYM) {
			 fprintf(outfp,"%s %s",$1.text,outname($2.text));
		       }
		     }
		   }
                |  ASM_BEGINFUNC IDENT
                   { Symbol *s;
		     if(pass==1) {
		       s=newsymbol($2.text,curfile);
		       s->flags &= ~tUNK;
		       s->flags |= tFUNC; 
		     } else if(pass==2) {
		       fprintf(outfp,"%s %s",$1.text,outname($2.text));
		     }
		   }
                |  ASM_ENDFUNC IDENT 
                   { 
		     if(pass==2) fprintf(outfp,"%s %s",$1.text,
					 outname($2.text));
		   }
		|  ASM_TEXT opt_address 
                   { lastsym=NULL;
		     if(pass==1) {
		       /* if($2.ival >=0) set_addr($2.ival); */
		     } else if(pass==2) {
		       if(get_addr_state() != tTEXT)
			 fputs(".text",outfp);
		     }
		     set_addr_state(tTEXT);
		   }
                |  ASM_DATA opt_address
                   { lastsym=NULL;
		     if(pass==1) {
		       /* if($2.ival >=0) set_addr($2.ival); */
		     } else if(pass==2) {
		       if(get_addr_state() != tDATA)
			 fputs(".data",outfp);
		     }
		     set_addr_state(tDATA);
		   }
                |  ASM_ASCII strings
                        {   
			  if(pass==1) {
			    if (!(get_addr_state() & tDATA))
			      err(".ascii directive must occur" 
				  "in the data section");
			    while (!queue_empty()) 
			      { int i;
				i = actual_string_length(pop_item());
				symsize(i,1);
				inc_addr(i);
			      }
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",$1.text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
                        }
                |  ASM_ASCIIZ strings
                        {   
			  if(pass==1) {
			    if (!(get_addr_state() & tDATA))
			      err(".ascii directive must occur" 
				  "in the data section\n");
			    while (!queue_empty())
			      { int i;
				i = 1+actual_string_length(pop_item());
				symsize(i,1);
				inc_addr(i);
			      }
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",$1.text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
                        }
                |  ASM_BYTE exprs      
                        {   
			  if(pass==1) {
			    inc_addr($2.ival*BYTES_PER_BYTE);
			    symsize($2.ival*BYTES_PER_BYTE,1);
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",$1.text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
			}
                |  ASM_DOUBLE exprs    
                        {   
			  if(pass==1) {
			    inc_addr($2.ival*BYTES_PER_DOUBLE);
			    symsize($2.ival*BYTES_PER_DOUBLE,1);
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",$1.text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
			}
                |  ASM_FLOAT exprs     
                        {   
			  if(pass==1) {
			    inc_addr($2.ival*BYTES_PER_FLOAT);
			    symsize($2.ival*BYTES_PER_FLOAT,1);
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",$1.text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
			}
		|  ASM_WORD exprs      
                        {   
			  if(pass==1) {
			    inc_addr($2.ival*BYTES_PER_WORD);
			    symsize($2.ival*BYTES_PER_WORD,1);
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",$1.text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
			}
		|  ASM_HALF exprs      
                        {   
			  if(pass==1) {
			    inc_addr($2.ival*2);
			    symsize($2.ival*2,1);
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",$1.text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
			}
 		|  ASM_SPACE num      
                   {
		     if(pass==1) {
		       symsize($2.ival,0);
		       inc_addr($2.ival);
		     } else if(pass==2 && PRINTSYM) {
		       fprintf(outfp,"%s %s",$1.text,$2.text);
		     }
		   }
                ;

insn            :  load_insn
                |  store_insn
                |  branch_insn
		|  alu_insn
		|  trap_insn
                ;

alu_insn        :  ALU_RRR_ID  reg ',' reg',' reg
                   {	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s,%s",
					 $1.text,$2.text,$4.text,$6.text);
		   }
		|  ALU_RRI_ID  reg ',' reg ',' expr
                   {	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s,%s",
					 $1.text,$2.text,$4.text,$6.text);
		   }
		|  ALU_RRX_ID  reg ',' reg
                   {	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s",
					 $1.text,$2.text,$4.text);
		   }
		|  ALU_RIX_ID  reg ',' expr
                   {	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s",
					 $1.text,$2.text,$4.text);
		   }
		|  ALU_IXX_ID  expr
                   {	
		     if(pass==2) fprintf(outfp,"\t%s\t%s",
					 $1.text,$2.text);
		   }
		|  ALU_XXX_ID  { if(pass==2) fprintf(outfp,"\t%s",$1.text); }
                ;

trap_insn	:  TRAP_ID  expr
                   {	
		     if(pass==2) fprintf(outfp,"\t%s\t%s",
					 $1.text,$2.text);
		   }
                ;

load_insn       :  LOAD_ID reg ',' num '(' ireg ')'
                   {	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s(%s)",
					 $1.text,$2.text,$4.text,$6.text);
		   }
		|  LOAD_ID reg ',' '(' ireg ')'
                   {	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,(%s)",
					 $1.text,$2.text,$5.text);
		   }
                ;

store_insn      :  STORE_ID num '(' ireg ')' ',' reg
                   {	
		     if(pass==2) fprintf(outfp,"\t%s\t%s(%s),%s",
					 $1.text,$2.text,$4.text,$7.text);
		   }
		|  STORE_ID '(' ireg ')' ',' reg
                   {	
		     if(pass==2) fprintf(outfp,"\t%s\t(%s),%s",
					 $1.text,$3.text,$6.text);
		   }
                ;

branch_insn     :  BRANCH_RL_ID ireg ',' IDENT
                   {	Symbol *s;
		     if(pass==2) {
		       if((s=findsymbol($4.text,curfile))&&(s->flags&tLABEL)) {
			 fprintf(outfp,"\t%s\t%s,%s",
				 $1.text,$2.text,outname($4.text));
		       } else {   
			 fprintf(stderr,"%s: error on line %d:\n\t",
				 filename,yylineno);
			 fprintf(stderr,"label \"%s\" doesn't exist\n",
				 $4.text);
			 errors++;
		       }
		     } else if(pass == 1) {
		       if((s = findsymbol($4.text,curfile))) {
			 s->flags |= tREF;
		       } else {
			 s = newsymbol($4.text,curfile);
			 s->flags |= (tREF|tUNK);
		       }
		     }
		   }
                |  BRANCH_LX_ID IDENT
                   {	Symbol *s;
		     if(pass==2) {
		       if((s=findsymbol($2.text,curfile))&&(s->flags&tLABEL)) {
			 fprintf(outfp,"\t%s\t%s",
				 $1.text,outname($2.text));
		       } else {   
			 fprintf(stderr,"%s: error on line %d:\n\t",
				 filename,yylineno);
			 fprintf(stderr,"label \"%s\" doesn't exist\n",
				 $2.text);
			 errors++;
		       }
		     } else if(pass == 1) {
		       if((s = findsymbol($2.text,curfile))) {
			 s->flags |= tREF;
		       } else {
			 s = newsymbol($2.text,curfile);
			 s->flags |= (tREF|tUNK);
		       }
		     }
		   }
                |  SUBCALL_LX_ID IDENT
                   {	Symbol *s;
		     if(pass==2) {
		       if((s=findsymbol($2.text,curfile))&&(s->flags&tLABEL)) {
			 fprintf(outfp,"\t%s\t%s",
				 $1.text,outname($2.text));
		       } else {   
			 fprintf(stderr,"%s: error on line %d:\n\t",
				 filename,yylineno);
			 fprintf(stderr,"label \"%s\" doesn't exist\n",
				 $2.text);
			 errors++;
		       }
		     } else if(pass == 1) {
		       if((s = findsymbol($2.text,curfile))) {
			 s->flags |= tREF;
		       } else {
			 s = newsymbol($2.text,curfile);
			 s->flags |= (tREF|tUNK);
		       }
		     }
		   }
                |  SUBCALL_RX_ID ireg 
                   {	
		     if(pass==2) fprintf(outfp,"\t%s\t%s",$1.text,$2.text);
		   }
                ;

reg             :  ireg { strcpy($$.text,$1.text); }
                |  freg { strcpy($$.text,$1.text); }
		|  sreg { strcpy($$.text,$1.text); }
                ;

ireg            :  IREG { strcpy($$.text,$1.text); }
                ;

freg            :  FREG { strcpy($$.text,$1.text); }
                ;

sreg            :  SREG { strcpy($$.text,$1.text); }
                ;

opt_address     :  num  { $$.ival = $1.ival; strcpy($$.text,$1.text); }
                |	{ $$.ival = -1; $$.text[0]='\0'; }
                ;

strings         :  strings ',' STRING   { push_item($3.text); }
                |  STRING               { push_item($1.text); }
                ;

exprs            :  exprs ',' expr 
                   {
		     push_item($3.text);
		     $$.ival = $1.ival + 1; 
		   }
                |  expr          
                   {
		     push_item($1.text);
		     $$.ival = 1; 
		   }
                ;

num             :  opt_pound '-' INT
                   { $$.ival = -$3.ival;
		     catN($$.text,$1.text,"-",$3.text,NULL);
		   }
                |  opt_pound INT
                   { $$.ival = $2.ival;
		     catN($$.text,$1.text,$2.text,NULL);
		   }
                ;


opt_pound	:  '#' { strcpyp($$.text,"#");}
		|      { $$.text[0]='\0'; }
                ;

expr		:  int_expr
			{ strcpyp($$.text,$1.text);  }
		|  '#' int_expr
			{ catN($$.text,"#",$2.text,NULL);  }
		;

int_expr	:  xor_expr
			{ strcpyp($$.text,$1.text); }
		|  int_expr '|' xor_expr
			{ catN($$.text,$1.text,"|",$3.text,NULL);  }
		;

xor_expr	:  and_expr
			{ strcpyp($$.text,$1.text); }
		|  xor_expr '^' and_expr
			{ catN($$.text,$1.text,"^",$3.text,NULL);  }
		;

and_expr	:  shift_expr
			{ strcpyp($$.text,$1.text); }
		|  and_expr '&' shift_expr
			{ catN($$.text,$1.text,"&",$3.text,NULL);  }
		;

shift_expr	:  add_expr
			{ strcpyp($$.text,$1.text); }
		|  shift_expr SHIFTL add_expr
			{ catN($$.text,$1.text,"<<",$3.text,NULL);  }
		|  shift_expr SHIFTR add_expr
			{ catN($$.text,$1.text,">>",$3.text,NULL);  }
		;

add_expr	:  mult_expr
			{ strcpyp($$.text,$1.text); }
		|  add_expr '+' mult_expr
			{ catN($$.text,$1.text,"+",$3.text,NULL);  }
		|  add_expr '-' mult_expr
			{ catN($$.text,$1.text,"-",$3.text,NULL);  }
		;

mult_expr	:  unary_expr
			{ strcpyp($$.text,$1.text); }
		|  mult_expr '*' unary_expr
			{ catN($$.text,$1.text,"*",$3.text,NULL);  }
		|  mult_expr '/' unary_expr
			{ catN($$.text,$1.text,"/",$3.text,NULL);  }
		|  mult_expr '%' unary_expr
			{ catN($$.text,$1.text,"%",$3.text,NULL);  }
		;

unary_expr	:  primary_expr
			{ strcpyp($$.text,$1.text); }
		|  '+' primary_expr
			{ catN($$.text,"+",$2.text,NULL);  }
		|  '-' primary_expr
			{ catN($$.text,"-",$2.text,NULL);  }
		|  '~' primary_expr
			{ catN($$.text,"~",$2.text,NULL);  }
		;

primary_expr	:  IDENT    { if(pass == 2) {
                                strcpyp($$.text,outname($1.text)); 
		            } else if(pass == 1) {
                              Symbol *s;
		              if((s = findsymbol($1.text,curfile))) {
			        s->flags |= tREF;
		              } else {
			        s = newsymbol($1.text,curfile);
			        s->flags |= (tREF|tUNK);
		              }
			      $$.text[0] = '\0';
		            }
				 }
		|  INT           { strcpyp($$.text,$1.text); }
                |  REAL          { strcpyp($$.text,$1.text); }
		|  '(' expr ')'  { catN($$.text,"(",$2.text,")",NULL); }
		;

%%

#include  "lex.yy.c"

void yyerror(mesg)
char    *mesg;
{       /* Type is either fSYN or fSYM  */
        if ( !strcmp(mesg,"syntax error") )
        {       printf("\n%s: error on line %d: %s\n",filename,
		       yylineno,mesg);
                printf("\tcurrent token = %s\n",yytext);
                exit(-1);
        } else
        {       printf("%s: warning on line %d: %s\n",filename,
		       yylineno,mesg);
        }
}

void err(mesg)
char	*mesg;
{	
    printf("%s: %d: %s\n",filename,yylineno,mesg);
    exit(-1);
}



