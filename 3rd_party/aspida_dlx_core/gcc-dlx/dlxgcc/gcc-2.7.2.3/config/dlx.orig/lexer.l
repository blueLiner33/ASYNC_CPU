%{

/*
 *  DLX "Linker" (lexer)
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

#ifdef FLEX_SCANNER
#define YY_INPUT(buf,result,max_size) \
           { \
                int c = lexin( yyin ); \
                result = c == EOF ? 0 : 1; \
                buf[0] = (char) c; \
           }
#else
#undef input
#define input() (((yytchar=yysptr>yysbuf?U(*--yysptr):lexin(yyin))==10?(yylineno++,yytchar):yytchar)==EOF?0:yytchar)
#endif

/* Implemented Operations */
char *alu_rrr_ops[] = {
    "add",   "addu",   "and",    "mod",   "or",    "seq",
    "sequ",  "sge",    "sgeu",   "sgt",   "sgtu",  "sle",
    "sleu",  "slt",    "sltu",   "sne",   "sneu",  "sll",
    "sra",   "srl",    "sub",    "subu",  "xor",   "mul",
    "divp",  "addd",   "addf",   "subd",  "subf",  "divd",
    "divf",  "multd",  "multf",  "div",   "divu",  "mult",
    "multu",
    NULL
};
char *alu_rrx_ops[] = {
    "movd",   "movf",   "movfp2i", "movi2fp", "negf",   "cvtd2f",
    "cvtd2i", "cvtf2d", "cvtf2i",  "cvti2f",  "cvti2d", "eqd",
    "eqf",    "ged",    "gef",     "gtd",     "gtf",    "led",
    "lef",    "ltd",    "ltf",     "ned",     "nef",
    NULL
};
char *alu_rri_ops[] = {
    "addi",   "addui",  "andi",   "modi",   "ori",    "seqi",
    "sequi",  "sgei",   "sgeui",  "sgti",   "sgtui",  "slei",
    "sleui",  "slti",   "sltui",  "snei",   "sneui",  "slli",
    "srai",   "srli",   "subi",   "subui",  "xori",   "muli",
    "divi",
    NULL
};
char *alu_rix_ops[] = { "lhi", NULL };
char *alu_ixx_ops[]  = { NULL };
char *alu_xxx_ops[]  = { "nop", NULL };
char *branch_rl_ops[] = { "beqz", "bnez", NULL };
char *branch_lx_ops[] = { "bfpf", "bfpt", "j", NULL };
char *subcall_lx_ops[] = { "jal", NULL };
char *subcall_rx_ops[] = { "jr", "jalr", NULL };
char *load_ops[] = { "lw", "lws", "lf", "lfs", "ld", "lds", "lb",
		     "lbs", "lbu", "lh", "lhu", NULL };
char *store_ops[] = { "sw", "sws", "sf", "sfs", "sd", "sds", 
		      "sb", "sbs", "sh", "shs", "fetch", NULL };
char *trap_ixx_ops[]  = { "trap", NULL };

/* Unimplemented Operations */
char *unimplemented_ops[] = {
    "movi2s", "movs2i",
    "rfe",
    NULL
};

%}

W_space	    [ \t]+
Letter      [a-zA-Z]
Digit       [0-9]
HDigit      [0-9a-fA-F]
Integer     ({Digit}+|("0x"|"0X"){HDigit}+)
Plain_real  {Digit}+"."{Digit}+
Exp_real    ({Digit}+|{Plain_real})[Ee][+-]?{Digit}+
Real        {Plain_real}|{Exp_real}

Eol         [\n\r]
Single      [-+*/&|#:,().]
Comment     ";".*
String      \"([^\"]|\\\")*\"

IReg        "r"{Digit}+
FReg        "f"{Digit}+
Ident       ({Letter}|"_")({Letter}|{Digit}|"_")*

Other       .

%%

{W_space}   {	;
	    }

".align"    {   strcpy(yylval.text,yytext);
                return (yylval.token = ASM_ALIGN);
            }

".ascii"    {   strcpy(yylval.text,yytext);
		return (yylval.token = ASM_ASCII);
            }

".asciiz"   {  strcpy(yylval.text,yytext);
		return (yylval.token = ASM_ASCIIZ);
            }

".byte"     {   strcpy(yylval.text,yytext);
		return (yylval.token = ASM_BYTE);
            }

".data"     {   strcpy(yylval.text,yytext);
		return (yylval.token = ASM_DATA);
            }

".double"   {  strcpy(yylval.text,yytext);
		return (yylval.token = ASM_DOUBLE);
            }

".float"    {   strcpy(yylval.text,yytext);
		return (yylval.token = ASM_FLOAT);
            }

".global"   {   strcpy(yylval.text,yytext);
		return (yylval.token = ASM_GLOBAL);
            }

".space"    {   strcpy(yylval.text,yytext);
		return (yylval.token = ASM_SPACE);
            }

".proc"	    {   strcpy(yylval.text,yytext);
		return (yylval.token = ASM_BEGINFUNC);
            }

".endproc"  {   strcpy(yylval.text,yytext);
		return (yylval.token = ASM_ENDFUNC);
            }

".text"     {   strcpy(yylval.text,yytext);
		return (yylval.token = ASM_TEXT);
            }

".half"     {   strcpy(yylval.text,yytext);
		return (yylval.token = ASM_HALF);
            }

".word"     {   strcpy(yylval.text,yytext);
		return (yylval.token = ASM_WORD);
            }

{IReg}      {   strcpy(yylval.text,yytext);
                yylval.ival = atoi(&yytext[1]);
		return (yylval.token = IREG);
            }

{FReg}      {   strcpy(yylval.text,yytext);
                yylval.ival = atoi(&yytext[1]);
		return (yylval.token = FREG);
            }

{Real}      {   strcpy(yylval.text,yytext);
                yylval.fval = (float) atof(yytext);
                yylval.dval = (double) atof(yytext);
		return (yylval.token = REAL);
            }

{Integer}   {   strcpy(yylval.text,yytext);
                yylval.ival = strtol(yytext,NULL,0);
		return (yylval.token = INT);
            }

{Ident}     {   int token;
                strcpy(yylval.text,yytext);
		token = get_ident_type();
                return (yylval.token = token);
            }

{String}    {	strcpy(yylval.text,yytext);
		return (yylval.token = STRING);
	    }

"<<"	    {   strcpy(yylval.text,yytext);
                return (yylval.token = SHIFTL);
            }

">>"	    {   strcpy(yylval.text,yytext);
                return (yylval.token = SHIFTR);
            }

{Single}    {   strcpy(yylval.text,yytext);
                return (yylval.token = yytext[0]);
            }

{Eol}       {   return CR;
            }

{Comment}   {	strcpy(yylval.text,yytext);
		return (yylval.token=COMMENT);
	    }

{Other}     {	printf("error: bad input <%s>\n",yytext);
		exit(0);
            }

%%

#define IDHASHSIZE 1318

static struct idhash_s {
	struct idhash_s *next;
	char *name;
	int type;
} *idhash[IDHASHSIZE];

static int idhash_init=0;

static int idcoll=0;

static void idhashinsert(char *name, int type)
{

  struct idhash_s *si,*sn;

  long h;

  h = hash(name)%IDHASHSIZE;
  si = idhash[h];
  sn = (struct idhash_s *)cmalloc(sizeof(struct idhash_s),"idhashinsert");
  sn->name = name;
  sn->type = type;

  if(si == NULL)
    {
      idhash[h] = sn;
      sn->next = NULL;	/* sanity */
      return;
    }

  idcoll++;

  sn->next = si;
  idhash[h] = sn;

  return;
}

static void
idhash_setup()
{
  int i;
  idhash_init = 1;

  for(i = 0 ; i < IDHASHSIZE ; i++) idhash[i] = NULL;

  for( i=0; alu_rrr_ops[i]; i++)
    idhashinsert(alu_rrr_ops[i],ALU_RRR_ID);

  for( i=0; alu_rrx_ops[i]; i++)
    idhashinsert(alu_rrx_ops[i],ALU_RRX_ID);

  for( i=0; alu_rri_ops[i]; i++)
    idhashinsert(alu_rri_ops[i],ALU_RRI_ID);

  for( i=0; alu_rix_ops[i]; i++)
    idhashinsert(alu_rix_ops[i],ALU_RIX_ID);

  for( i=0; alu_ixx_ops[i]; i++)
    idhashinsert(alu_ixx_ops[i],ALU_IXX_ID);

  for( i=0; alu_xxx_ops[i]; i++)
    idhashinsert(alu_xxx_ops[i],ALU_XXX_ID);

  for( i=0; branch_lx_ops[i]; i++)
    idhashinsert(branch_lx_ops[i],BRANCH_LX_ID);

  for( i=0; branch_rl_ops[i]; i++)
    idhashinsert(branch_rl_ops[i],BRANCH_RL_ID);
    
  for( i=0; subcall_lx_ops[i]; i++)
    idhashinsert(subcall_lx_ops[i],SUBCALL_LX_ID);

  for( i=0; subcall_rx_ops[i]; i++)
    idhashinsert(subcall_rx_ops[i],SUBCALL_RX_ID);

  for( i=0; load_ops[i]; i++)
    idhashinsert(load_ops[i],LOAD_ID);

  for( i=0; store_ops[i]; i++)
    idhashinsert(store_ops[i],STORE_ID);

  for(i=0; trap_ixx_ops[i] ; i++)
    idhashinsert(trap_ixx_ops[i],TRAP_ID);

  for( i=0; unimplemented_ops[i];i++)
    idhashinsert(unimplemented_ops[i],UNIMPLEMENTED_OP);
	
  /* printf("IDhash: %d collisions.\n",idcoll); */
}


int get_ident_type()
{
  long     h;
  int t;
  struct idhash_s *s;
  
  if(!idhash_init) idhash_setup();
  
  h = hash(yytext)%IDHASHSIZE;

  s = idhash[h];

  while(s && strcmp(s->name,yytext)) s=s->next;

  if(s != NULL) {
    t = s->type;
    if(t == UNIMPLEMENTED_OP) {   
      printf("[line %d] error: %s is an unimplemented operation\n",
	     yylineno,yytext);
      exit(-1);
    }
    /* printf("%s --> %d\n",yytext,t); */
    return t;
  }
  return IDENT;
}


#if 0
void main()
{
   int  token;

	while ( !feof(stdin) )
	{   token = yylex();
            if ( token == tWS )
	        printf(" ");
            else
	        printf("[%s %d]",yytext,token);
	}
}

#endif
