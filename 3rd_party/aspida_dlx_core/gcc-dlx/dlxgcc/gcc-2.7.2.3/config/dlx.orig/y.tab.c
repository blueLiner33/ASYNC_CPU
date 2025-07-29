#ifndef lint
static char yysccsid[] = "@(#)yaccpar	1.9 (Berkeley) 02/21/93";
#endif
#define YYBYACC 1
#define YYMAJOR 1
#define YYMINOR 9
#define yyclearin (yychar=(-1))
#define yyerrok (yyerrflag=0)
#define YYRECOVERING (yyerrflag!=0)
#define YYPREFIX "yy"
#line 33 "parser.y"
#include  <stdio.h>
#include  <stdlib.h>
#include  <string.h>
#include  <time.h>
#include  <sys/time.h>
#include  <ctype.h>
#include  <math.h>
#include  <varargs.h>
#include  "globals.h"

int	yylineno;
#line 24 "y.tab.c"
#define IREG 257
#define FREG 258
#define INT 259
#define REAL 260
#define IDENT 261
#define STRING 262
#define SHIFTL 263
#define SHIFTR 264
#define CR 265
#define OTHER 266
#define ALU_RRR_ID 267
#define ALU_RRX_ID 268
#define ALU_RRI_ID 269
#define ALU_RIX_ID 270
#define ALU_IXX_ID 271
#define ALU_XXX_ID 272
#define LOAD_ID 273
#define STORE_ID 274
#define TRAP_ID 275
#define BRANCH_RL_ID 276
#define BRANCH_LX_ID 277
#define SUBCALL_LX_ID 278
#define SUBCALL_RX_ID 279
#define ASM_BEGINFUNC 280
#define ASM_ENDFUNC 281
#define ASM_ALIGN 282
#define ASM_ASCII 283
#define ASM_ASCIIZ 284
#define ASM_BYTE 285
#define ASM_DATA 286
#define ASM_DOUBLE 287
#define ASM_FLOAT 288
#define ASM_GLOBAL 289
#define ASM_SPACE 290
#define ASM_TEXT 291
#define ASM_WORD 292
#define ASM_HALF 293
#define UNIMPLEMENTED_OP 294
#define COMMENT 295
#define YYERRCODE 256
short yylhs[] = {                                        -1,
    0,    0,    1,    1,    1,    1,    1,    3,    3,    2,
    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
    4,    4,    4,    4,    5,    5,    5,    5,    5,   13,
   13,   13,   13,   13,   13,   14,   10,   10,   11,   11,
   12,   12,   12,   12,   15,   15,   17,   18,    7,    7,
    8,    8,    9,    9,    6,    6,   19,   19,   16,   16,
   20,   20,   21,   21,   22,   22,   23,   23,   23,   24,
   24,   24,   25,   25,   25,   25,   26,   26,   26,   26,
   27,   27,   27,   27,
};
short yylen[] = {                                         2,
    2,    1,    3,    4,    3,    3,    2,    1,    0,    2,
    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
    2,    2,    2,    2,    1,    1,    1,    1,    1,    6,
    6,    4,    4,    2,    1,    2,    7,    6,    7,    6,
    4,    2,    2,    2,    1,    1,    1,    1,    1,    0,
    3,    1,    3,    1,    3,    2,    1,    0,    1,    2,
    1,    3,    1,    3,    1,    3,    1,    3,    3,    1,
    3,    3,    1,    3,    3,    3,    1,    2,    2,    2,
    1,    1,    1,    3,
};
short yydefred[] = {                                      0,
    0,    0,    0,    0,    0,    0,   35,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    8,    0,
    0,    2,    0,    0,    0,    0,   25,   26,   27,   28,
   29,   10,   47,   48,    0,   45,   46,    0,    0,    0,
   82,   83,   81,    0,    0,    0,    0,    0,   34,    0,
    0,    0,    0,    0,    0,   73,   77,    0,   57,    0,
    0,    0,   36,    0,   42,   43,   44,   13,   14,   11,
   52,    0,    0,    0,   54,   49,   16,    0,    0,   12,
   24,   15,    0,    0,    0,    1,    0,    7,    0,    0,
    0,    0,    0,    0,   80,   78,   79,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,   56,    0,    0,    0,    0,    0,    3,    5,
    6,    0,   32,    0,   33,   84,    0,    0,    0,    0,
    0,    0,    0,   74,   75,   76,    0,    0,    0,    0,
   55,   41,   51,   53,    4,    0,    0,    0,    0,    0,
    0,   30,   31,   38,    0,   40,    0,   37,   39,
};
short yydgoto[] = {                                      31,
   32,   33,   34,   35,   36,   86,   87,   82,   84,   37,
   38,   39,   40,   41,   45,   85,   46,   47,   72,   60,
   61,   62,   63,   64,   65,   66,   67,
};
short yysindex[] = {                                    -35,
  -27, -220, -220, -220, -220,   56,    0, -220,  -20,   56,
 -234, -228, -221, -234, -213, -195,   47, -167, -167,   56,
   47,   56,   56, -164,   47,   47,   56,   56,    0, -151,
  -35,    0, -181, -139, -181, -181,    0,    0,    0,    0,
    0,    0,    0,    0,   90,    0,    0,   98,  100,  101,
    0,    0,    0,    5,    5,    5,  -39,   56,    0,   25,
   52,  112, -161,  -24,  -15,    0,    0,  107,    0, -234,
  116,  -42,    0,  108,    0,    0,    0,    0,    0,    0,
    0,  113,  113,  114,    0,    0,    0,  114,  114,    0,
    0,    0,  114,  114, -102,    0, -103,    0, -101,  -99,
 -220, -220, -220,   56,    0,    0,    0,   25,  122,  -39,
  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,   58,
  126, -234,    0,  -91,  -90,  -92,   56,  -93,    0,    0,
    0,  130,    0,  131,    0,    0,   52,  112, -161,  -24,
  -24,  -15,  -15,    0,    0,    0, -234,  137,  134,  138,
    0,    0,    0,    0,    0, -220,   56,  139, -234, -220,
  140,    0,    0,    0,  142,    0, -220,    0,    0,
};
short yyrindex[] = {                                    -84,
    0,    0,    0,    0,    0,    0,    0,    0,  -34,    0,
    0,    0,    0,    0,    0,    0,  -34,    0,    0,    0,
   32,    0,    0,    0,  -34,   32,    0,    0,    0,    0,
  -84,    0,  -84,    0,  -84,  -84,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,   37,
   30,   11,   24,   15,  -36,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0, -249, -241, -180,    0,    0,    0, -179, -176,    0,
    0,    0, -175, -171,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,   39,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,  -34,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,   35,   29,   31,   19,
   23,   -2,    6,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,
};
short yygindex[] = {                                      0,
  154,    0,   71,    0,    0,    1,  160,  168,    7,    0,
    0,    0,    0,    0,    9,  209,   14,    0,    0,  132,
   78,   79,   80,   27,   22,   10,   77,
};
#define YYTABLESIZE 366
short yytable[] = {                                      30,
   58,   70,  124,   55,   70,   56,   70,   70,   70,   71,
   58,   48,   49,   50,   69,   17,   68,   80,  115,   70,
  116,  119,   43,   18,   74,   91,  117,   77,   88,   89,
   42,  118,   75,   93,   94,   71,   43,   44,   71,   76,
   71,   71,   71,   72,   58,   17,   72,   78,   72,   72,
   72,   63,   67,   18,   63,   67,   68,   70,   67,   68,
   69,   65,   68,   69,   65,   79,   69,   65,   66,   64,
   61,   66,   64,   61,   66,   62,   58,   59,   62,   60,
   59,   69,   60,  121,   19,   20,   54,   70,   21,   22,
   57,   71,   69,   23,   81,   58,   90,  147,   55,   72,
   56,  113,  114,   97,   63,   99,  100,   95,   67,  132,
  133,  134,   68,   29,   19,   20,   69,   65,   21,   22,
  148,   71,   64,   23,   66,   98,  144,  145,  146,   72,
  105,  106,  107,  101,   63,  150,  142,  143,   67,  140,
  141,  102,   68,  103,  104,  111,   69,   65,  110,  112,
  120,  125,   64,   61,   66,  122,  126,  127,   62,  128,
  158,  129,  136,  130,  162,  131,  149,  151,  166,  153,
  152,  155,  165,  156,  157,  169,  159,  160,  161,  164,
    9,   54,  168,  167,   96,   92,   83,  137,  108,  138,
    0,  139,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,   59,    0,  123,    0,   73,   51,
   52,   53,    0,    0,   58,    1,   70,   70,   70,    0,
    0,    2,    3,    4,    5,    6,    7,    8,    9,   10,
   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
   21,   22,   23,   24,   25,   26,   27,   28,   70,   29,
   71,   71,   71,   51,   52,   53,  109,    0,   72,   72,
   72,    0,    0,    0,    0,   63,    0,   67,   67,   67,
    0,   68,   68,   68,    0,   69,   69,   69,   65,    0,
   58,    0,   71,   64,   61,   66,   50,    0,    0,   62,
   72,   59,    0,   60,    0,   63,    0,    0,    0,   67,
    0,    0,  135,   68,   51,   52,   53,   69,   65,    0,
    0,    0,    0,   64,   61,   66,   50,    0,    0,   62,
    0,   59,    0,   60,    0,  154,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,  163,
};
short yycheck[] = {                                      35,
   40,   38,   45,   43,   41,   45,   43,   44,   45,    9,
   45,    3,    4,    5,   35,  265,    8,   17,   43,   40,
   45,   37,  257,  265,   11,   25,   42,   14,   22,   23,
   58,   47,  261,   27,   28,   38,  257,  258,   41,  261,
   43,   44,   45,   38,   40,  295,   41,  261,   43,   44,
   45,   41,   38,  295,   44,   41,   38,   94,   44,   41,
   38,   38,   44,   41,   41,  261,   44,   44,   38,   41,
   41,   41,   44,   44,   44,   41,   45,   41,   44,   41,
   44,   35,   44,   70,  265,  265,  126,  124,  265,  265,
   35,   94,   35,  265,  262,   40,  261,   40,   43,   94,
   45,  263,  264,   33,   94,   35,   36,  259,   94,  101,
  102,  103,   94,  295,  295,  295,   94,   94,  295,  295,
  120,  124,   94,  295,   94,  265,  117,  118,  119,  124,
   54,   55,   56,   44,  124,  122,  115,  116,  124,  113,
  114,   44,  124,   44,   44,   94,  124,  124,  124,   38,
   44,   44,  124,  124,  124,   40,   44,   44,  124,  262,
  147,  265,   41,  265,  156,  265,   41,  259,  160,  262,
  261,  265,  159,   44,   44,  167,   40,   44,   41,   41,
  265,  126,   41,   44,   31,   26,   19,  110,   57,  111,
   -1,  112,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,    6,   -1,  259,   -1,   10,  259,
  260,  261,   -1,   -1,  259,  261,  263,  264,  265,   -1,
   -1,  267,  268,  269,  270,  271,  272,  273,  274,  275,
  276,  277,  278,  279,  280,  281,  282,  283,  284,  285,
  286,  287,  288,  289,  290,  291,  292,  293,  295,  295,
  263,  264,  265,  259,  260,  261,   58,   -1,  263,  264,
  265,   -1,   -1,   -1,   -1,  265,   -1,  263,  264,  265,
   -1,  263,  264,  265,   -1,  263,  264,  265,  265,   -1,
  259,   -1,  295,  265,  265,  265,  265,   -1,   -1,  265,
  295,  265,   -1,  265,   -1,  295,   -1,   -1,   -1,  295,
   -1,   -1,  104,  295,  259,  260,  261,  295,  295,   -1,
   -1,   -1,   -1,  295,  295,  295,  295,   -1,   -1,  295,
   -1,  295,   -1,  295,   -1,  127,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,  157,
};
#define YYFINAL 31
#ifndef YYDEBUG
#define YYDEBUG 0
#endif
#define YYMAXTOKEN 295
#if YYDEBUG
char *yyname[] = {
"end-of-file",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
"'!'",0,"'#'",0,"'%'","'&'",0,"'('","')'","'*'","'+'","','","'-'",0,"'/'",0,0,0,
0,0,0,0,0,0,0,"':'",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,"'^'",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"'|'",
0,"'~'",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,"IREG","FREG","INT","REAL","IDENT","STRING",
"SHIFTL","SHIFTR","CR","OTHER","ALU_RRR_ID","ALU_RRX_ID","ALU_RRI_ID",
"ALU_RIX_ID","ALU_IXX_ID","ALU_XXX_ID","LOAD_ID","STORE_ID","TRAP_ID",
"BRANCH_RL_ID","BRANCH_LX_ID","SUBCALL_LX_ID","SUBCALL_RX_ID","ASM_BEGINFUNC",
"ASM_ENDFUNC","ASM_ALIGN","ASM_ASCII","ASM_ASCIIZ","ASM_BYTE","ASM_DATA",
"ASM_DOUBLE","ASM_FLOAT","ASM_GLOBAL","ASM_SPACE","ASM_TEXT","ASM_WORD",
"ASM_HALF","UNIMPLEMENTED_OP","COMMENT",
};
char *yyrule[] = {
"$accept : asm_lines",
"asm_lines : asm_lines asm_line",
"asm_lines : asm_line",
"asm_line : label opt_comment CR",
"asm_line : '#' INT STRING CR",
"asm_line : asm_cmd opt_comment CR",
"asm_line : insn opt_comment CR",
"asm_line : opt_comment CR",
"opt_comment : COMMENT",
"opt_comment :",
"label : IDENT ':'",
"asm_cmd : ASM_ALIGN num",
"asm_cmd : ASM_GLOBAL IDENT",
"asm_cmd : ASM_BEGINFUNC IDENT",
"asm_cmd : ASM_ENDFUNC IDENT",
"asm_cmd : ASM_TEXT opt_address",
"asm_cmd : ASM_DATA opt_address",
"asm_cmd : ASM_ASCII strings",
"asm_cmd : ASM_ASCIIZ strings",
"asm_cmd : ASM_BYTE exprs",
"asm_cmd : ASM_DOUBLE exprs",
"asm_cmd : ASM_FLOAT exprs",
"asm_cmd : ASM_WORD exprs",
"asm_cmd : ASM_HALF exprs",
"asm_cmd : ASM_SPACE num",
"insn : load_insn",
"insn : store_insn",
"insn : branch_insn",
"insn : alu_insn",
"insn : trap_insn",
"alu_insn : ALU_RRR_ID reg ',' reg ',' reg",
"alu_insn : ALU_RRI_ID reg ',' reg ',' expr",
"alu_insn : ALU_RRX_ID reg ',' reg",
"alu_insn : ALU_RIX_ID reg ',' expr",
"alu_insn : ALU_IXX_ID expr",
"alu_insn : ALU_XXX_ID",
"trap_insn : TRAP_ID expr",
"load_insn : LOAD_ID reg ',' num '(' ireg ')'",
"load_insn : LOAD_ID reg ',' '(' ireg ')'",
"store_insn : STORE_ID num '(' ireg ')' ',' reg",
"store_insn : STORE_ID '(' ireg ')' ',' reg",
"branch_insn : BRANCH_RL_ID ireg ',' IDENT",
"branch_insn : BRANCH_LX_ID IDENT",
"branch_insn : SUBCALL_LX_ID IDENT",
"branch_insn : SUBCALL_RX_ID ireg",
"reg : ireg",
"reg : freg",
"ireg : IREG",
"freg : FREG",
"opt_address : num",
"opt_address :",
"strings : strings ',' STRING",
"strings : STRING",
"exprs : exprs ',' expr",
"exprs : expr",
"num : opt_pound '-' INT",
"num : opt_pound INT",
"opt_pound : '#'",
"opt_pound :",
"expr : int_expr",
"expr : '#' int_expr",
"int_expr : xor_expr",
"int_expr : int_expr '|' xor_expr",
"xor_expr : and_expr",
"xor_expr : xor_expr '^' and_expr",
"and_expr : shift_expr",
"and_expr : and_expr '&' shift_expr",
"shift_expr : add_expr",
"shift_expr : shift_expr SHIFTL add_expr",
"shift_expr : shift_expr SHIFTR add_expr",
"add_expr : mult_expr",
"add_expr : add_expr '+' mult_expr",
"add_expr : add_expr '-' mult_expr",
"mult_expr : unary_expr",
"mult_expr : mult_expr '*' unary_expr",
"mult_expr : mult_expr '/' unary_expr",
"mult_expr : mult_expr '%' unary_expr",
"unary_expr : primary_expr",
"unary_expr : '+' primary_expr",
"unary_expr : '-' primary_expr",
"unary_expr : '~' primary_expr",
"primary_expr : IDENT",
"primary_expr : INT",
"primary_expr : REAL",
"primary_expr : '(' expr ')'",
};
#endif
#ifndef YYSTYPE
typedef int YYSTYPE;
#endif
#ifdef YYSTACKSIZE
#undef YYMAXDEPTH
#define YYMAXDEPTH YYSTACKSIZE
#else
#ifdef YYMAXDEPTH
#define YYSTACKSIZE YYMAXDEPTH
#else
#define YYSTACKSIZE 500
#define YYMAXDEPTH 500
#endif
#endif
int yydebug;
int yynerrs;
int yyerrflag;
int yychar;
short *yyssp;
YYSTYPE *yyvsp;
YYSTYPE yyval;
YYSTYPE yylval;
short yyss[YYSTACKSIZE];
YYSTYPE yyvs[YYSTACKSIZE];
#define yystacksize YYSTACKSIZE
#line 551 "parser.y"

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



#line 395 "y.tab.c"
#define YYABORT goto yyabort
#define YYREJECT goto yyabort
#define YYACCEPT goto yyaccept
#define YYERROR goto yyerrlab
int
yyparse()
{
    register int yym, yyn, yystate;
#if YYDEBUG
    register char *yys;
    extern char *getenv();

    if (yys = getenv("YYDEBUG"))
    {
        yyn = *yys;
        if (yyn >= '0' && yyn <= '9')
            yydebug = yyn - '0';
    }
#endif

    yynerrs = 0;
    yyerrflag = 0;
    yychar = (-1);

    yyssp = yyss;
    yyvsp = yyvs;
    *yyssp = yystate = 0;

yyloop:
    if (yyn = yydefred[yystate]) goto yyreduce;
    if (yychar < 0)
    {
        if ((yychar = yylex()) < 0) yychar = 0;
#if YYDEBUG
        if (yydebug)
        {
            yys = 0;
            if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
            if (!yys) yys = "illegal-symbol";
            printf("%sdebug: state %d, reading %d (%s)\n",
                    YYPREFIX, yystate, yychar, yys);
        }
#endif
    }
    if ((yyn = yysindex[yystate]) && (yyn += yychar) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yychar)
    {
#if YYDEBUG
        if (yydebug)
            printf("%sdebug: state %d, shifting to state %d\n",
                    YYPREFIX, yystate, yytable[yyn]);
#endif
        if (yyssp >= yyss + yystacksize - 1)
        {
            goto yyoverflow;
        }
        *++yyssp = yystate = yytable[yyn];
        *++yyvsp = yylval;
        yychar = (-1);
        if (yyerrflag > 0)  --yyerrflag;
        goto yyloop;
    }
    if ((yyn = yyrindex[yystate]) && (yyn += yychar) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yychar)
    {
        yyn = yytable[yyn];
        goto yyreduce;
    }
    if (yyerrflag) goto yyinrecovery;
#ifdef lint
    goto yynewerror;
#endif
yynewerror:
    yyerror("syntax error");
#ifdef lint
    goto yyerrlab;
#endif
yyerrlab:
    ++yynerrs;
yyinrecovery:
    if (yyerrflag < 3)
    {
        yyerrflag = 3;
        for (;;)
        {
            if ((yyn = yysindex[*yyssp]) && (yyn += YYERRCODE) >= 0 &&
                    yyn <= YYTABLESIZE && yycheck[yyn] == YYERRCODE)
            {
#if YYDEBUG
                if (yydebug)
                    printf("%sdebug: state %d, error recovery shifting\
 to state %d\n", YYPREFIX, *yyssp, yytable[yyn]);
#endif
                if (yyssp >= yyss + yystacksize - 1)
                {
                    goto yyoverflow;
                }
                *++yyssp = yystate = yytable[yyn];
                *++yyvsp = yylval;
                goto yyloop;
            }
            else
            {
#if YYDEBUG
                if (yydebug)
                    printf("%sdebug: error recovery discarding state %d\n",
                            YYPREFIX, *yyssp);
#endif
                if (yyssp <= yyss) goto yyabort;
                --yyssp;
                --yyvsp;
            }
        }
    }
    else
    {
        if (yychar == 0) goto yyabort;
#if YYDEBUG
        if (yydebug)
        {
            yys = 0;
            if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
            if (!yys) yys = "illegal-symbol";
            printf("%sdebug: state %d, error recovery discards token %d (%s)\n",
                    YYPREFIX, yystate, yychar, yys);
        }
#endif
        yychar = (-1);
        goto yyloop;
    }
yyreduce:
#if YYDEBUG
    if (yydebug)
        printf("%sdebug: state %d, reducing by rule %d (%s)\n",
                YYPREFIX, yystate, yyn, yyrule[yyn]);
#endif
    yym = yylen[yyn];
    yyval = yyvsp[1-yym];
    switch (yyn)
    {
case 3:
#line 72 "parser.y"
{ if(pass==2 && PRINTSYM) putc('\n',outfp); }
break;
case 5:
#line 75 "parser.y"
{ if(pass==2 && PRINTSYM) putc('\n',outfp); }
break;
case 6:
#line 77 "parser.y"
{ 
		     inc_addr(BYTES_PER_INSN); 
		     if(pass==2) putc('\n',outfp); 
		   }
break;
case 7:
#line 82 "parser.y"
{ if(pass==2) putc('\n',outfp); }
break;
case 8:
#line 85 "parser.y"
{ if(pass==2) fputs(yyvsp[0].text,outfp); }
break;
case 10:
#line 90 "parser.y"
{ Symbol *s;
		     if(pass==1) {
		       s=newsymbol(yyvsp[-1].text,curfile);
		       lastsym=s;
		       s->flags |= (tLABEL|tDEF); 
		       s->flags &= ~tUNK;
		       s->addr = get_addr();
		       s->flags |= get_addr_state();
		     } else if(pass==2) {
		       s=findsymbol(yyvsp[-1].text,curfile);
		       lastsym=s;
		       if(PRINTSYM) {
			 fprintf(outfp,"%s:",outname(yyvsp[-1].text));
		       }
		     }
		   }
break;
case 11:
#line 109 "parser.y"
{
		     if(pass==1) align_addr(yyvsp[0].ival);
		     if(pass==2) {
		       fprintf(outfp,"%s %s",yyvsp[-1].text,yyvsp[0].text);
		       if(!(PRINTSYM)) putc('\n',outfp);
		     }
		   }
break;
case 12:
#line 117 "parser.y"
{ Symbol *s;
		     if(pass==1) {
		       s=newsymbol(yyvsp[0].text,curfile);
		       s->flags |= tGLOBAL; 
		       s->flags &= ~tUNK;
		       lastsym=s;
		     } else if(pass==2) {
		       s=findsymbol(yyvsp[0].text,curfile);
		       lastsym=s; 
		       if(PRINTSYM) {
			 fprintf(outfp,"%s %s",yyvsp[-1].text,outname(yyvsp[0].text));
		       }
		     }
		   }
break;
case 13:
#line 132 "parser.y"
{ Symbol *s;
		     if(pass==1) {
		       s=newsymbol(yyvsp[0].text,curfile);
		       s->flags &= ~tUNK;
		       s->flags |= tFUNC; 
		     } else if(pass==2) {
		       fprintf(outfp,"%s %s",yyvsp[-1].text,outname(yyvsp[0].text));
		     }
		   }
break;
case 14:
#line 142 "parser.y"
{ 
		     if(pass==2) fprintf(outfp,"%s %s",yyvsp[-1].text,
					 outname(yyvsp[0].text));
		   }
break;
case 15:
#line 147 "parser.y"
{ lastsym=NULL;
		     if(pass==1) {
		       /* if($2.ival >=0) set_addr($2.ival); */
		     } else if(pass==2) {
		       if(get_addr_state() != tTEXT)
			 fputs(".text",outfp);
		     }
		     set_addr_state(tTEXT);
		   }
break;
case 16:
#line 157 "parser.y"
{ lastsym=NULL;
		     if(pass==1) {
		       /* if($2.ival >=0) set_addr($2.ival); */
		     } else if(pass==2) {
		       if(get_addr_state() != tDATA)
			 fputs(".data",outfp);
		     }
		     set_addr_state(tDATA);
		   }
break;
case 17:
#line 167 "parser.y"
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
			    fprintf(outfp,"%s ",yyvsp[-1].text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
                        }
break;
case 18:
#line 188 "parser.y"
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
			    fprintf(outfp,"%s ",yyvsp[-1].text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
                        }
break;
case 19:
#line 209 "parser.y"
{   
			  if(pass==1) {
			    inc_addr(yyvsp[0].ival*BYTES_PER_BYTE);
			    symsize(yyvsp[0].ival*BYTES_PER_BYTE,1);
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",yyvsp[-1].text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
			}
break;
case 20:
#line 223 "parser.y"
{   
			  if(pass==1) {
			    inc_addr(yyvsp[0].ival*BYTES_PER_DOUBLE);
			    symsize(yyvsp[0].ival*BYTES_PER_DOUBLE,1);
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",yyvsp[-1].text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
			}
break;
case 21:
#line 237 "parser.y"
{   
			  if(pass==1) {
			    inc_addr(yyvsp[0].ival*BYTES_PER_FLOAT);
			    symsize(yyvsp[0].ival*BYTES_PER_FLOAT,1);
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",yyvsp[-1].text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
			}
break;
case 22:
#line 251 "parser.y"
{   
			  if(pass==1) {
			    inc_addr(yyvsp[0].ival*BYTES_PER_WORD);
			    symsize(yyvsp[0].ival*BYTES_PER_WORD,1);
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",yyvsp[-1].text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
			}
break;
case 23:
#line 265 "parser.y"
{   
			  if(pass==1) {
			    inc_addr(yyvsp[0].ival*2);
			    symsize(yyvsp[0].ival*2,1);
			  } else if(pass==2 && PRINTSYM) {
			    fprintf(outfp,"%s ",yyvsp[-1].text);
			    while(!queue_empty()) {
			      fputs(pop_item(),outfp);
			      if(!queue_empty()) fputs(", ",outfp);
			    }
			  }
			  init_queue();
			}
break;
case 24:
#line 279 "parser.y"
{
		     if(pass==1) {
		       symsize(yyvsp[0].ival,0);
		       inc_addr(yyvsp[0].ival);
		     } else if(pass==2 && PRINTSYM) {
		       fprintf(outfp,"%s %s",yyvsp[-1].text,yyvsp[0].text);
		     }
		   }
break;
case 30:
#line 297 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s,%s",
					 yyvsp[-5].text,yyvsp[-4].text,yyvsp[-2].text,yyvsp[0].text);
		   }
break;
case 31:
#line 302 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s,%s",
					 yyvsp[-5].text,yyvsp[-4].text,yyvsp[-2].text,yyvsp[0].text);
		   }
break;
case 32:
#line 307 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s",
					 yyvsp[-3].text,yyvsp[-2].text,yyvsp[0].text);
		   }
break;
case 33:
#line 312 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s",
					 yyvsp[-3].text,yyvsp[-2].text,yyvsp[0].text);
		   }
break;
case 34:
#line 317 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s",
					 yyvsp[-1].text,yyvsp[0].text);
		   }
break;
case 35:
#line 321 "parser.y"
{ if(pass==2) fprintf(outfp,"\t%s",yyvsp[0].text); }
break;
case 36:
#line 325 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s",
					 yyvsp[-1].text,yyvsp[0].text);
		   }
break;
case 37:
#line 332 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s(%s)",
					 yyvsp[-6].text,yyvsp[-5].text,yyvsp[-3].text,yyvsp[-1].text);
		   }
break;
case 38:
#line 337 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,(%s)",
					 yyvsp[-5].text,yyvsp[-4].text,yyvsp[-1].text);
		   }
break;
case 39:
#line 344 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s(%s),%s",
					 yyvsp[-6].text,yyvsp[-5].text,yyvsp[-3].text,yyvsp[0].text);
		   }
break;
case 40:
#line 349 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t(%s),%s",
					 yyvsp[-5].text,yyvsp[-3].text,yyvsp[0].text);
		   }
break;
case 41:
#line 356 "parser.y"
{	Symbol *s;
		     if(pass==2) {
		       if((s=findsymbol(yyvsp[0].text,curfile))&&(s->flags&tLABEL)) {
			 fprintf(outfp,"\t%s\t%s,%s",
				 yyvsp[-3].text,yyvsp[-2].text,outname(yyvsp[0].text));
		       } else {   
			 fprintf(stderr,"%s: error on line %d:\n\t",
				 filename,yylineno);
			 fprintf(stderr,"label \"%s\" doesn't exist\n",
				 yyvsp[0].text);
			 errors++;
		       }
		     } else if(pass == 1) {
		       if((s = findsymbol(yyvsp[0].text,curfile))) {
			 s->flags |= tREF;
		       } else {
			 s = newsymbol(yyvsp[0].text,curfile);
			 s->flags |= (tREF|tUNK);
		       }
		     }
		   }
break;
case 42:
#line 378 "parser.y"
{	Symbol *s;
		     if(pass==2) {
		       if((s=findsymbol(yyvsp[0].text,curfile))&&(s->flags&tLABEL)) {
			 fprintf(outfp,"\t%s\t%s",
				 yyvsp[-1].text,outname(yyvsp[0].text));
		       } else {   
			 fprintf(stderr,"%s: error on line %d:\n\t",
				 filename,yylineno);
			 fprintf(stderr,"label \"%s\" doesn't exist\n",
				 yyvsp[0].text);
			 errors++;
		       }
		     } else if(pass == 1) {
		       if((s = findsymbol(yyvsp[0].text,curfile))) {
			 s->flags |= tREF;
		       } else {
			 s = newsymbol(yyvsp[0].text,curfile);
			 s->flags |= (tREF|tUNK);
		       }
		     }
		   }
break;
case 43:
#line 400 "parser.y"
{	Symbol *s;
		     if(pass==2) {
		       if((s=findsymbol(yyvsp[0].text,curfile))&&(s->flags&tLABEL)) {
			 fprintf(outfp,"\t%s\t%s",
				 yyvsp[-1].text,outname(yyvsp[0].text));
		       } else {   
			 fprintf(stderr,"%s: error on line %d:\n\t",
				 filename,yylineno);
			 fprintf(stderr,"label \"%s\" doesn't exist\n",
				 yyvsp[0].text);
			 errors++;
		       }
		     } else if(pass == 1) {
		       if((s = findsymbol(yyvsp[0].text,curfile))) {
			 s->flags |= tREF;
		       } else {
			 s = newsymbol(yyvsp[0].text,curfile);
			 s->flags |= (tREF|tUNK);
		       }
		     }
		   }
break;
case 44:
#line 422 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s",yyvsp[-1].text,yyvsp[0].text);
		   }
break;
case 45:
#line 427 "parser.y"
{ strcpy(yyval.text,yyvsp[0].text); }
break;
case 46:
#line 428 "parser.y"
{ strcpy(yyval.text,yyvsp[0].text); }
break;
case 47:
#line 431 "parser.y"
{ strcpy(yyval.text,yyvsp[0].text); }
break;
case 48:
#line 434 "parser.y"
{ strcpy(yyval.text,yyvsp[0].text); }
break;
case 49:
#line 437 "parser.y"
{ yyval.ival = yyvsp[0].ival; strcpy(yyval.text,yyvsp[0].text); }
break;
case 50:
#line 438 "parser.y"
{ yyval.ival = -1; yyval.text[0]='\0'; }
break;
case 51:
#line 441 "parser.y"
{ push_item(yyvsp[0].text); }
break;
case 52:
#line 442 "parser.y"
{ push_item(yyvsp[0].text); }
break;
case 53:
#line 446 "parser.y"
{
		     push_item(yyvsp[0].text);
		     yyval.ival = yyvsp[-2].ival + 1; 
		   }
break;
case 54:
#line 451 "parser.y"
{
		     push_item(yyvsp[0].text);
		     yyval.ival = 1; 
		   }
break;
case 55:
#line 458 "parser.y"
{ yyval.ival = -yyvsp[0].ival;
		     catN(yyval.text,yyvsp[-2].text,"-",yyvsp[0].text,NULL);
		   }
break;
case 56:
#line 462 "parser.y"
{ yyval.ival = yyvsp[0].ival;
		     catN(yyval.text,yyvsp[-1].text,yyvsp[0].text,NULL);
		   }
break;
case 57:
#line 468 "parser.y"
{ strcpyp(yyval.text,"#");}
break;
case 58:
#line 469 "parser.y"
{ yyval.text[0]='\0'; }
break;
case 59:
#line 473 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text);  }
break;
case 60:
#line 475 "parser.y"
{ catN(yyval.text,"#",yyvsp[0].text,NULL);  }
break;
case 61:
#line 479 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
break;
case 62:
#line 481 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"|",yyvsp[0].text,NULL);  }
break;
case 63:
#line 485 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
break;
case 64:
#line 487 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"^",yyvsp[0].text,NULL);  }
break;
case 65:
#line 491 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
break;
case 66:
#line 493 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"&",yyvsp[0].text,NULL);  }
break;
case 67:
#line 497 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
break;
case 68:
#line 499 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"<<",yyvsp[0].text,NULL);  }
break;
case 69:
#line 501 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,">>",yyvsp[0].text,NULL);  }
break;
case 70:
#line 505 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
break;
case 71:
#line 507 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"+",yyvsp[0].text,NULL);  }
break;
case 72:
#line 509 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"-",yyvsp[0].text,NULL);  }
break;
case 73:
#line 513 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
break;
case 74:
#line 515 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"*",yyvsp[0].text,NULL);  }
break;
case 75:
#line 517 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"/",yyvsp[0].text,NULL);  }
break;
case 76:
#line 519 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"%",yyvsp[0].text,NULL);  }
break;
case 77:
#line 523 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
break;
case 78:
#line 525 "parser.y"
{ catN(yyval.text,"+",yyvsp[0].text,NULL);  }
break;
case 79:
#line 527 "parser.y"
{ catN(yyval.text,"-",yyvsp[0].text,NULL);  }
break;
case 80:
#line 529 "parser.y"
{ catN(yyval.text,"~",yyvsp[0].text,NULL);  }
break;
case 81:
#line 532 "parser.y"
{ if(pass == 2) {
                                strcpyp(yyval.text,outname(yyvsp[0].text)); 
		            } else if(pass == 1) {
                              Symbol *s;
		              if((s = findsymbol(yyvsp[0].text,curfile))) {
			        s->flags |= tREF;
		              } else {
			        s = newsymbol(yyvsp[0].text,curfile);
			        s->flags |= (tREF|tUNK);
		              }
			      yyval.text[0] = '\0';
		            }
				 }
break;
case 82:
#line 545 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
break;
case 83:
#line 546 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
break;
case 84:
#line 547 "parser.y"
{ catN(yyval.text,"(",yyvsp[-1].text,")",NULL); }
break;
#line 1119 "y.tab.c"
    }
    yyssp -= yym;
    yystate = *yyssp;
    yyvsp -= yym;
    yym = yylhs[yyn];
    if (yystate == 0 && yym == 0)
    {
#if YYDEBUG
        if (yydebug)
            printf("%sdebug: after reduction, shifting from state 0 to\
 state %d\n", YYPREFIX, YYFINAL);
#endif
        yystate = YYFINAL;
        *++yyssp = YYFINAL;
        *++yyvsp = yyval;
        if (yychar < 0)
        {
            if ((yychar = yylex()) < 0) yychar = 0;
#if YYDEBUG
            if (yydebug)
            {
                yys = 0;
                if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
                if (!yys) yys = "illegal-symbol";
                printf("%sdebug: state %d, reading %d (%s)\n",
                        YYPREFIX, YYFINAL, yychar, yys);
            }
#endif
        }
        if (yychar == 0) goto yyaccept;
        goto yyloop;
    }
    if ((yyn = yygindex[yym]) && (yyn += yystate) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yystate)
        yystate = yytable[yyn];
    else
        yystate = yydgoto[yym];
#if YYDEBUG
    if (yydebug)
        printf("%sdebug: after reduction, shifting from state %d \
to state %d\n", YYPREFIX, *yyssp, yystate);
#endif
    if (yyssp >= yyss + yystacksize - 1)
    {
        goto yyoverflow;
    }
    *++yyssp = yystate;
    *++yyvsp = yyval;
    goto yyloop;
yyoverflow:
    yyerror("yacc stack overflow");
yyabort:
    return (1);
yyaccept:
    return (0);
}
