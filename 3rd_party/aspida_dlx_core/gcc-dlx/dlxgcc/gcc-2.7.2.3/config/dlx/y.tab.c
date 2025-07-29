/* A Bison parser, made from parser.y
   by GNU bison 1.35.  */

#define YYBISON 1  /* Identify Bison output.  */

# define	IREG	257
# define	FREG	258
# define	SREG	259
# define	INT	260
# define	REAL	261
# define	IDENT	262
# define	STRING	263
# define	SHIFTL	264
# define	SHIFTR	265
# define	CR	266
# define	OTHER	267
# define	ALU_RRR_ID	268
# define	ALU_RRX_ID	269
# define	ALU_RRI_ID	270
# define	ALU_RIX_ID	271
# define	ALU_IXX_ID	272
# define	ALU_XXX_ID	273
# define	LOAD_ID	274
# define	STORE_ID	275
# define	TRAP_ID	276
# define	BRANCH_RL_ID	277
# define	BRANCH_LX_ID	278
# define	SUBCALL_LX_ID	279
# define	SUBCALL_RX_ID	280
# define	ASM_BEGINFUNC	281
# define	ASM_ENDFUNC	282
# define	ASM_ALIGN	283
# define	ASM_ASCII	284
# define	ASM_ASCIIZ	285
# define	ASM_BYTE	286
# define	ASM_DATA	287
# define	ASM_DOUBLE	288
# define	ASM_FLOAT	289
# define	ASM_GLOBAL	290
# define	ASM_SPACE	291
# define	ASM_TEXT	292
# define	ASM_WORD	293
# define	ASM_HALF	294
# define	UNIMPLEMENTED_OP	295
# define	COMMENT	296

#line 32 "parser.y"

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

#ifndef YYSTYPE
# define YYSTYPE int
# define YYSTYPE_IS_TRIVIAL 1
#endif
#ifndef YYDEBUG
# define YYDEBUG 0
#endif



#define	YYFINAL		173
#define	YYFLAG		-32768
#define	YYNTBASE	58

/* YYTRANSLATE(YYLEX) -- Bison token number corresponding to YYLEX. */
#define YYTRANSLATE(x) ((unsigned)(x) <= 296 ? yytranslate[x] : 87)

/* YYTRANSLATE[YYLEX] -- Bison token number corresponding to YYLEX. */
static const char yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    43,     2,    53,     2,    47,    50,     2,
      56,    57,    45,    48,    55,    49,     2,    46,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    54,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,    51,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,    52,     2,    44,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     3,     4,     5,
       6,     7,     8,     9,    10,    11,    12,    13,    14,    15,
      16,    17,    18,    19,    20,    21,    22,    23,    24,    25,
      26,    27,    28,    29,    30,    31,    32,    33,    34,    35,
      36,    37,    38,    39,    40,    41,    42
};

#if YYDEBUG
static const short yyprhs[] =
{
       0,     0,     3,     5,     9,    14,    18,    22,    25,    27,
      28,    31,    34,    37,    40,    43,    46,    49,    52,    55,
      58,    61,    64,    67,    70,    73,    75,    77,    79,    81,
      83,    90,    97,   102,   107,   110,   112,   115,   123,   130,
     138,   145,   150,   153,   156,   159,   161,   163,   165,   167,
     169,   171,   173,   174,   178,   180,   184,   186,   190,   193,
     195,   196,   198,   201,   203,   207,   209,   213,   215,   219,
     221,   225,   229,   231,   235,   239,   241,   245,   249,   253,
     255,   258,   261,   264,   266,   268,   270
};
static const short yyrhs[] =
{
      58,    59,     0,    59,     0,    61,    60,    12,     0,    53,
       6,     9,    12,     0,    62,    60,    12,     0,    63,    60,
      12,     0,    60,    12,     0,    42,     0,     0,     8,    54,
       0,    29,    76,     0,    36,     8,     0,    27,     8,     0,
      28,     8,     0,    38,    73,     0,    33,    73,     0,    30,
      74,     0,    31,    74,     0,    32,    75,     0,    34,    75,
       0,    35,    75,     0,    39,    75,     0,    40,    75,     0,
      37,    76,     0,    66,     0,    67,     0,    68,     0,    64,
       0,    65,     0,    14,    69,    55,    69,    55,    69,     0,
      16,    69,    55,    69,    55,    78,     0,    15,    69,    55,
      69,     0,    17,    69,    55,    78,     0,    18,    78,     0,
      19,     0,    22,    78,     0,    20,    69,    55,    76,    56,
      70,    57,     0,    20,    69,    55,    56,    70,    57,     0,
      21,    76,    56,    70,    57,    55,    69,     0,    21,    56,
      70,    57,    55,    69,     0,    23,    70,    55,     8,     0,
      24,     8,     0,    25,     8,     0,    26,    70,     0,    70,
       0,    71,     0,    72,     0,     3,     0,     4,     0,     5,
       0,    76,     0,     0,    74,    55,     9,     0,     9,     0,
      75,    55,    78,     0,    78,     0,    77,    49,     6,     0,
      77,     6,     0,    53,     0,     0,    79,     0,    53,    79,
       0,    80,     0,    79,    52,    80,     0,    81,     0,    80,
      51,    81,     0,    82,     0,    81,    50,    82,     0,    83,
       0,    82,    10,    83,     0,    82,    11,    83,     0,    84,
       0,    83,    48,    84,     0,    83,    49,    84,     0,    85,
       0,    84,    45,    85,     0,    84,    46,    85,     0,    84,
      47,    85,     0,    86,     0,    48,    86,     0,    49,    86,
       0,    44,    86,     0,     8,     0,     6,     0,     7,     0,
      56,    78,    57,     0
};

#endif

#if YYDEBUG
/* YYRLINE[YYN] -- source line where rule number YYN was defined. */
static const short yyrline[] =
{
       0,    69,    70,    73,    75,    76,    78,    83,    87,    88,
      91,   110,   118,   133,   143,   148,   158,   168,   189,   210,
     224,   238,   252,   266,   280,   291,   292,   293,   294,   295,
     298,   303,   308,   313,   318,   323,   326,   333,   338,   345,
     350,   357,   379,   401,   423,   429,   430,   431,   434,   437,
     440,   443,   444,   447,   448,   451,   456,   463,   467,   474,
     475,   478,   480,   484,   486,   490,   492,   496,   498,   502,
     504,   506,   510,   512,   514,   518,   520,   522,   524,   528,
     530,   532,   534,   538,   551,   552,   553
};
#endif


#if (YYDEBUG) || defined YYERROR_VERBOSE

/* YYTNAME[TOKEN_NUM] -- String name of the token TOKEN_NUM. */
static const char *const yytname[] =
{
  "$", "error", "$undefined.", "IREG", "FREG", "SREG", "INT", "REAL", 
  "IDENT", "STRING", "SHIFTL", "SHIFTR", "CR", "OTHER", "ALU_RRR_ID", 
  "ALU_RRX_ID", "ALU_RRI_ID", "ALU_RIX_ID", "ALU_IXX_ID", "ALU_XXX_ID", 
  "LOAD_ID", "STORE_ID", "TRAP_ID", "BRANCH_RL_ID", "BRANCH_LX_ID", 
  "SUBCALL_LX_ID", "SUBCALL_RX_ID", "ASM_BEGINFUNC", "ASM_ENDFUNC", 
  "ASM_ALIGN", "ASM_ASCII", "ASM_ASCIIZ", "ASM_BYTE", "ASM_DATA", 
  "ASM_DOUBLE", "ASM_FLOAT", "ASM_GLOBAL", "ASM_SPACE", "ASM_TEXT", 
  "ASM_WORD", "ASM_HALF", "UNIMPLEMENTED_OP", "COMMENT", "'!'", "'~'", 
  "'*'", "'/'", "'%'", "'+'", "'-'", "'&'", "'^'", "'|'", "'#'", "':'", 
  "','", "'('", "')'", "asm_lines", "asm_line", "opt_comment", "label", 
  "asm_cmd", "insn", "alu_insn", "trap_insn", "load_insn", "store_insn", 
  "branch_insn", "reg", "ireg", "freg", "sreg", "opt_address", "strings", 
  "exprs", "num", "opt_pound", "expr", "int_expr", "xor_expr", "and_expr", 
  "shift_expr", "add_expr", "mult_expr", "unary_expr", "primary_expr", 0
};
#endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives. */
static const short yyr1[] =
{
       0,    58,    58,    59,    59,    59,    59,    59,    60,    60,
      61,    62,    62,    62,    62,    62,    62,    62,    62,    62,
      62,    62,    62,    62,    62,    63,    63,    63,    63,    63,
      64,    64,    64,    64,    64,    64,    65,    66,    66,    67,
      67,    68,    68,    68,    68,    69,    69,    69,    70,    71,
      72,    73,    73,    74,    74,    75,    75,    76,    76,    77,
      77,    78,    78,    79,    79,    80,    80,    81,    81,    82,
      82,    82,    83,    83,    83,    84,    84,    84,    84,    85,
      85,    85,    85,    86,    86,    86,    86
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN. */
static const short yyr2[] =
{
       0,     2,     1,     3,     4,     3,     3,     2,     1,     0,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     1,     1,     1,     1,     1,
       6,     6,     4,     4,     2,     1,     2,     7,     6,     7,
       6,     4,     2,     2,     2,     1,     1,     1,     1,     1,
       1,     1,     0,     3,     1,     3,     1,     3,     2,     1,
       0,     1,     2,     1,     3,     1,     3,     1,     3,     1,
       3,     3,     1,     3,     3,     1,     3,     3,     3,     1,
       2,     2,     2,     1,     1,     1,     3
};

/* YYDEFACT[S] -- default rule to reduce with in state S when YYTABLE
   doesn't specify something else to do.  Zero means the default is an
   error. */
static const short yydefact[] =
{
       9,     0,     0,     0,     0,     0,     0,    35,     0,    60,
       0,     0,     0,     0,     0,     0,     0,    60,     0,     0,
       0,    52,     0,     0,     0,    60,    52,     0,     0,     8,
       0,     9,     2,     0,     9,     9,     9,    28,    29,    25,
      26,    27,    10,    48,    49,    50,     0,    45,    46,    47,
       0,     0,     0,    84,    85,    83,     0,     0,     0,     0,
       0,    34,    61,    63,    65,    67,    69,    72,    75,    79,
       0,    59,     0,     0,     0,    36,     0,    42,    43,    44,
      13,    14,    11,    54,    17,    18,    19,    56,    16,    51,
      20,    21,    12,    24,    15,    22,    23,     0,     1,     7,
       0,     0,     0,     0,     0,     0,     0,    82,    80,    81,
      62,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,    60,     0,     0,    58,     0,     0,     0,     0,
       0,     3,     5,     6,     0,    32,     0,    33,    86,    64,
      66,    68,    70,    71,    73,    74,    76,    77,    78,     0,
       0,     0,     0,    57,    41,    53,    55,     4,     0,     0,
       0,     0,     0,     0,    30,    31,    38,     0,    40,     0,
      37,    39,     0,     0
};

static const short yydefgoto[] =
{
      31,    32,    33,    34,    35,    36,    37,    38,    39,    40,
      41,    46,    47,    48,    49,    88,    84,    86,    89,    74,
      87,    62,    63,    64,    65,    66,    67,    68,    69
};

static const short yypact[] =
{
     153,   -47,    57,    57,    57,    57,    61,-32768,    57,    20,
      61,     8,    58,    67,     8,    86,    87,    43,    88,    88,
      61,     4,    61,    61,    90,    43,     4,    61,    61,-32768,
      93,    12,-32768,    91,    65,    65,    65,-32768,-32768,-32768,
  -32768,-32768,-32768,-32768,-32768,-32768,    51,-32768,-32768,-32768,
      56,    60,    63,-32768,-32768,-32768,     7,     7,     7,    64,
      61,-32768,    69,    68,    73,    11,    42,    33,-32768,-32768,
      70,-32768,     8,    72,    10,-32768,    71,-32768,-32768,-32768,
  -32768,-32768,-32768,-32768,    74,    74,    75,-32768,-32768,-32768,
      75,    75,-32768,-32768,-32768,    75,    75,   115,-32768,-32768,
     119,   120,   121,    57,    57,    57,    61,-32768,-32768,-32768,
      69,    77,    64,    64,    64,    64,    64,    64,    64,    64,
      64,    64,    21,    78,     8,-32768,   130,   129,   131,    61,
     126,-32768,-32768,-32768,    84,-32768,    89,-32768,-32768,    68,
      73,    11,    42,    42,    33,    33,-32768,-32768,-32768,     8,
      92,    94,    85,-32768,-32768,-32768,-32768,-32768,    57,    61,
      95,     8,    57,    96,-32768,-32768,-32768,    97,-32768,    57,
  -32768,-32768,   143,-32768
};

static const short yypgoto[] =
{
  -32768,   114,    47,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
  -32768,    -3,    -8,-32768,-32768,   124,   127,    -4,     0,-32768,
      -2,    99,    35,    49,    46,   -60,   -25,   -35,    31
};


#define	YYLAST		206


static const short yytable[] =
{
      50,    51,    52,    76,    61,    70,    79,    42,    75,    73,
     -60,    43,   172,    53,    54,    55,   125,    82,    90,    91,
       1,   115,   116,    95,    96,    93,     2,     3,     4,     5,
       6,     7,     8,     9,    10,    11,    12,    13,    14,    15,
      16,    17,    18,    19,    20,    21,    22,    23,    24,    25,
      26,    27,    28,   -60,    29,   142,   143,    71,   111,   126,
      43,    44,    45,    60,   123,    30,    77,    53,    54,    55,
      53,    54,    55,    71,    71,    78,    72,   149,   119,   120,
     121,   100,   101,   102,   146,   147,   148,   107,   108,   109,
     117,   118,   144,   145,    80,    81,    71,    83,    92,    97,
     134,   135,   136,    99,   137,    56,   103,    29,    56,    57,
      58,   104,    57,    58,    59,   105,   152,    60,   106,   113,
      60,   112,   150,   114,   130,   122,   127,   156,   124,   128,
     129,   131,   132,   133,   138,   151,   153,   154,   157,   158,
     155,   160,   163,   173,   159,    98,    85,   139,   161,   162,
      94,   169,   166,   167,   170,   164,     0,   165,   110,   168,
     141,     1,   140,     0,     0,     0,   171,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,     0,    29,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    30
};

static const short yycheck[] =
{
       3,     4,     5,    11,     6,     8,    14,    54,    10,     9,
       6,     3,     0,     6,     7,     8,     6,    17,    22,    23,
       8,    10,    11,    27,    28,    25,    14,    15,    16,    17,
      18,    19,    20,    21,    22,    23,    24,    25,    26,    27,
      28,    29,    30,    31,    32,    33,    34,    35,    36,    37,
      38,    39,    40,    49,    42,   115,   116,    53,    60,    49,
       3,     4,     5,    56,    72,    53,     8,     6,     7,     8,
       6,     7,     8,    53,    53,     8,    56,    56,    45,    46,
      47,    34,    35,    36,   119,   120,   121,    56,    57,    58,
      48,    49,   117,   118,     8,     8,    53,     9,     8,     6,
     103,   104,   105,    12,   106,    44,    55,    42,    44,    48,
      49,    55,    48,    49,    53,    55,   124,    56,    55,    51,
      56,    52,   122,    50,     9,    55,    55,   129,    56,    55,
      55,    12,    12,    12,    57,    57,     6,     8,    12,    55,
       9,   149,    57,     0,    55,    31,    19,   112,    56,    55,
      26,    55,    57,   161,    57,   158,    -1,   159,    59,   162,
     114,     8,   113,    -1,    -1,    -1,   169,    14,    15,    16,
      17,    18,    19,    20,    21,    22,    23,    24,    25,    26,
      27,    28,    29,    30,    31,    32,    33,    34,    35,    36,
      37,    38,    39,    40,    -1,    42,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    53
};
/* -*-C-*-  Note some compilers choke on comments on `#line' lines.  */
#line 3 "/usr/share/bison/bison.simple"

/* Skeleton output parser for bison,

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002 Free Software
   Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

/* This is the parser code that is written into each bison parser when
   the %semantic_parser declaration is not specified in the grammar.
   It was written by Richard Stallman by simplifying the hairy parser
   used when %semantic_parser is specified.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

#if ! defined (yyoverflow) || defined (YYERROR_VERBOSE)

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# if YYSTACK_USE_ALLOCA
#  define YYSTACK_ALLOC alloca
# else
#  ifndef YYSTACK_USE_ALLOCA
#   if defined (alloca) || defined (_ALLOCA_H)
#    define YYSTACK_ALLOC alloca
#   else
#    ifdef __GNUC__
#     define YYSTACK_ALLOC __builtin_alloca
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning. */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
# else
#  if defined (__STDC__) || defined (__cplusplus)
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   define YYSIZE_T size_t
#  endif
#  define YYSTACK_ALLOC malloc
#  define YYSTACK_FREE free
# endif
#endif /* ! defined (yyoverflow) || defined (YYERROR_VERBOSE) */


#if (! defined (yyoverflow) \
     && (! defined (__cplusplus) \
	 || (YYLTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  short yyss;
  YYSTYPE yyvs;
# if YYLSP_NEEDED
  YYLTYPE yyls;
# endif
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAX (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# if YYLSP_NEEDED
#  define YYSTACK_BYTES(N) \
     ((N) * (sizeof (short) + sizeof (YYSTYPE) + sizeof (YYLTYPE))	\
      + 2 * YYSTACK_GAP_MAX)
# else
#  define YYSTACK_BYTES(N) \
     ((N) * (sizeof (short) + sizeof (YYSTYPE))				\
      + YYSTACK_GAP_MAX)
# endif

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  register YYSIZE_T yyi;		\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (0)
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAX;	\
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (0)

#endif


#if ! defined (YYSIZE_T) && defined (__SIZE_TYPE__)
# define YYSIZE_T __SIZE_TYPE__
#endif
#if ! defined (YYSIZE_T) && defined (size_t)
# define YYSIZE_T size_t
#endif
#if ! defined (YYSIZE_T)
# if defined (__STDC__) || defined (__cplusplus)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# endif
#endif
#if ! defined (YYSIZE_T)
# define YYSIZE_T unsigned int
#endif

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		-2
#define YYEOF		0
#define YYACCEPT	goto yyacceptlab
#define YYABORT 	goto yyabortlab
#define YYERROR		goto yyerrlab1
/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */
#define YYFAIL		goto yyerrlab
#define YYRECOVERING()  (!!yyerrstatus)
#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yychar1 = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { 								\
      yyerror ("syntax error: cannot back up");			\
      YYERROR;							\
    }								\
while (0)

#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Compute the default location (before the actions
   are run).

   When YYLLOC_DEFAULT is run, CURRENT is set the location of the
   first token.  By default, to implement support for ranges, extend
   its range to the last symbol.  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)       	\
   Current.last_line   = Rhs[N].last_line;	\
   Current.last_column = Rhs[N].last_column;
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#if YYPURE
# if YYLSP_NEEDED
#  ifdef YYLEX_PARAM
#   define YYLEX		yylex (&yylval, &yylloc, YYLEX_PARAM)
#  else
#   define YYLEX		yylex (&yylval, &yylloc)
#  endif
# else /* !YYLSP_NEEDED */
#  ifdef YYLEX_PARAM
#   define YYLEX		yylex (&yylval, YYLEX_PARAM)
#  else
#   define YYLEX		yylex (&yylval)
#  endif
# endif /* !YYLSP_NEEDED */
#else /* !YYPURE */
# define YYLEX			yylex ()
#endif /* !YYPURE */


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (0)
/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
#endif /* !YYDEBUG */

/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   SIZE_MAX < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#if YYMAXDEPTH == 0
# undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif

#ifdef YYERROR_VERBOSE

# ifndef yystrlen
#  if defined (__GLIBC__) && defined (_STRING_H)
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
#   if defined (__STDC__) || defined (__cplusplus)
yystrlen (const char *yystr)
#   else
yystrlen (yystr)
     const char *yystr;
#   endif
{
  register const char *yys = yystr;

  while (*yys++ != '\0')
    continue;

  return yys - yystr - 1;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined (__GLIBC__) && defined (_STRING_H) && defined (_GNU_SOURCE)
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
#   if defined (__STDC__) || defined (__cplusplus)
yystpcpy (char *yydest, const char *yysrc)
#   else
yystpcpy (yydest, yysrc)
     char *yydest;
     const char *yysrc;
#   endif
{
  register char *yyd = yydest;
  register const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif
#endif

#line 315 "/usr/share/bison/bison.simple"


/* The user can define YYPARSE_PARAM as the name of an argument to be passed
   into yyparse.  The argument should have type void *.
   It should actually point to an object.
   Grammar actions can access the variable by casting it
   to the proper pointer type.  */

#ifdef YYPARSE_PARAM
# if defined (__STDC__) || defined (__cplusplus)
#  define YYPARSE_PARAM_ARG void *YYPARSE_PARAM
#  define YYPARSE_PARAM_DECL
# else
#  define YYPARSE_PARAM_ARG YYPARSE_PARAM
#  define YYPARSE_PARAM_DECL void *YYPARSE_PARAM;
# endif
#else /* !YYPARSE_PARAM */
# define YYPARSE_PARAM_ARG
# define YYPARSE_PARAM_DECL
#endif /* !YYPARSE_PARAM */

/* Prevent warning if -Wstrict-prototypes.  */
#ifdef __GNUC__
# ifdef YYPARSE_PARAM
int yyparse (void *);
# else
int yyparse (void);
# endif
#endif

/* YY_DECL_VARIABLES -- depending whether we use a pure parser,
   variables are global, or local to YYPARSE.  */

#define YY_DECL_NON_LSP_VARIABLES			\
/* The lookahead symbol.  */				\
int yychar;						\
							\
/* The semantic value of the lookahead symbol. */	\
YYSTYPE yylval;						\
							\
/* Number of parse errors so far.  */			\
int yynerrs;

#if YYLSP_NEEDED
# define YY_DECL_VARIABLES			\
YY_DECL_NON_LSP_VARIABLES			\
						\
/* Location data for the lookahead symbol.  */	\
YYLTYPE yylloc;
#else
# define YY_DECL_VARIABLES			\
YY_DECL_NON_LSP_VARIABLES
#endif


/* If nonreentrant, generate the variables here. */

#if !YYPURE
YY_DECL_VARIABLES
#endif  /* !YYPURE */

int
yyparse (YYPARSE_PARAM_ARG)
     YYPARSE_PARAM_DECL
{
  /* If reentrant, generate the variables here. */
#if YYPURE
  YY_DECL_VARIABLES
#endif  /* !YYPURE */

  register int yystate;
  register int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Lookahead token as an internal (translated) token number.  */
  int yychar1 = 0;

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack. */
  short	yyssa[YYINITDEPTH];
  short *yyss = yyssa;
  register short *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  register YYSTYPE *yyvsp;

#if YYLSP_NEEDED
  /* The location stack.  */
  YYLTYPE yylsa[YYINITDEPTH];
  YYLTYPE *yyls = yylsa;
  YYLTYPE *yylsp;
#endif

#if YYLSP_NEEDED
# define YYPOPSTACK   (yyvsp--, yyssp--, yylsp--)
#else
# define YYPOPSTACK   (yyvsp--, yyssp--)
#endif

  YYSIZE_T yystacksize = YYINITDEPTH;


  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
#if YYLSP_NEEDED
  YYLTYPE yyloc;
#endif

  /* When reducing, the number of symbols on the RHS of the reduced
     rule. */
  int yylen;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;
#if YYLSP_NEEDED
  yylsp = yyls;
#endif
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed. so pushing a state here evens the stacks.
     */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyssp >= yyss + yystacksize - 1)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack. Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	short *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  */
# if YYLSP_NEEDED
	YYLTYPE *yyls1 = yyls;
	/* This used to be a conditional around just the two extra args,
	   but that might be undefined if yyoverflow is a macro.  */
	yyoverflow ("parser stack overflow",
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yyls1, yysize * sizeof (*yylsp),
		    &yystacksize);
	yyls = yyls1;
# else
	yyoverflow ("parser stack overflow",
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);
# endif
	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyoverflowlab;
# else
      /* Extend the stack our own way.  */
      if (yystacksize >= YYMAXDEPTH)
	goto yyoverflowlab;
      yystacksize *= 2;
      if (yystacksize > YYMAXDEPTH)
	yystacksize = YYMAXDEPTH;

      {
	short *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyoverflowlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);
# if YYLSP_NEEDED
	YYSTACK_RELOCATE (yyls);
# endif
# undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
#if YYLSP_NEEDED
      yylsp = yyls + yysize - 1;
#endif

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyssp >= yyss + yystacksize - 1)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* yychar is either YYEMPTY or YYEOF
     or a valid token in external form.  */

  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  /* Convert token to internal form (in yychar1) for indexing tables with */

  if (yychar <= 0)		/* This means end of input. */
    {
      yychar1 = 0;
      yychar = YYEOF;		/* Don't call YYLEX any more */

      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yychar1 = YYTRANSLATE (yychar);

#if YYDEBUG
     /* We have to keep this `#if YYDEBUG', since we use variables
	which are defined only if `YYDEBUG' is set.  */
      if (yydebug)
	{
	  YYFPRINTF (stderr, "Next token is %d (%s",
		     yychar, yytname[yychar1]);
	  /* Give the individual parser a way to print the precise
	     meaning of a token, for further debugging info.  */
# ifdef YYPRINT
	  YYPRINT (stderr, yychar, yylval);
# endif
	  YYFPRINTF (stderr, ")\n");
	}
#endif
    }

  yyn += yychar1;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != yychar1)
    goto yydefault;

  yyn = yytable[yyn];

  /* yyn is what to do for this token type in this state.
     Negative => reduce, -yyn is rule number.
     Positive => shift, yyn is new state.
       New state is final state => don't bother to shift,
       just return success.
     0, or most negative number => error.  */

  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrlab;

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */
  YYDPRINTF ((stderr, "Shifting token %d (%s), ",
	      yychar, yytname[yychar1]));

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;
#if YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  yystate = yyn;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to the semantic value of
     the lookahead token.  This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

#if YYLSP_NEEDED
  /* Similarly for the default location.  Let the user run additional
     commands if for instance locations are ranges.  */
  yyloc = yylsp[1-yylen];
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
#endif

#if YYDEBUG
  /* We have to keep this `#if YYDEBUG', since we use variables which
     are defined only if `YYDEBUG' is set.  */
  if (yydebug)
    {
      int yyi;

      YYFPRINTF (stderr, "Reducing via rule %d (line %d), ",
		 yyn, yyrline[yyn]);

      /* Print the symbols being reduced, and their result.  */
      for (yyi = yyprhs[yyn]; yyrhs[yyi] > 0; yyi++)
	YYFPRINTF (stderr, "%s ", yytname[yyrhs[yyi]]);
      YYFPRINTF (stderr, " -> %s\n", yytname[yyr1[yyn]]);
    }
#endif

  switch (yyn) {

case 3:
#line 74 "parser.y"
{ if(pass==2 && PRINTSYM) putc('\n',outfp); }
    break;
case 5:
#line 77 "parser.y"
{ if(pass==2 && PRINTSYM) putc('\n',outfp); }
    break;
case 6:
#line 79 "parser.y"
{ 
		     inc_addr(BYTES_PER_INSN); 
		     if(pass==2) putc('\n',outfp); 
		   }
    break;
case 7:
#line 84 "parser.y"
{ if(pass==2) putc('\n',outfp); }
    break;
case 8:
#line 87 "parser.y"
{ if(pass==2) fputs(yyvsp[0].text,outfp); }
    break;
case 10:
#line 92 "parser.y"
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
#line 111 "parser.y"
{
		     if(pass==1) align_addr(yyvsp[0].ival);
		     if(pass==2) {
		       fprintf(outfp,"%s %s",yyvsp[-1].text,yyvsp[0].text);
		       if(!(PRINTSYM)) putc('\n',outfp);
		     }
		   }
    break;
case 12:
#line 119 "parser.y"
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
#line 134 "parser.y"
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
#line 144 "parser.y"
{ 
		     if(pass==2) fprintf(outfp,"%s %s",yyvsp[-1].text,
					 outname(yyvsp[0].text));
		   }
    break;
case 15:
#line 149 "parser.y"
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
#line 159 "parser.y"
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
#line 169 "parser.y"
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
#line 190 "parser.y"
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
#line 211 "parser.y"
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
#line 225 "parser.y"
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
#line 239 "parser.y"
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
#line 253 "parser.y"
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
#line 267 "parser.y"
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
#line 281 "parser.y"
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
#line 299 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s,%s",
					 yyvsp[-5].text,yyvsp[-4].text,yyvsp[-2].text,yyvsp[0].text);
		   }
    break;
case 31:
#line 304 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s,%s",
					 yyvsp[-5].text,yyvsp[-4].text,yyvsp[-2].text,yyvsp[0].text);
		   }
    break;
case 32:
#line 309 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s",
					 yyvsp[-3].text,yyvsp[-2].text,yyvsp[0].text);
		   }
    break;
case 33:
#line 314 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s",
					 yyvsp[-3].text,yyvsp[-2].text,yyvsp[0].text);
		   }
    break;
case 34:
#line 319 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s",
					 yyvsp[-1].text,yyvsp[0].text);
		   }
    break;
case 35:
#line 323 "parser.y"
{ if(pass==2) fprintf(outfp,"\t%s",yyvsp[0].text); }
    break;
case 36:
#line 327 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s",
					 yyvsp[-1].text,yyvsp[0].text);
		   }
    break;
case 37:
#line 334 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,%s(%s)",
					 yyvsp[-6].text,yyvsp[-5].text,yyvsp[-3].text,yyvsp[-1].text);
		   }
    break;
case 38:
#line 339 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s,(%s)",
					 yyvsp[-5].text,yyvsp[-4].text,yyvsp[-1].text);
		   }
    break;
case 39:
#line 346 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s(%s),%s",
					 yyvsp[-6].text,yyvsp[-5].text,yyvsp[-3].text,yyvsp[0].text);
		   }
    break;
case 40:
#line 351 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t(%s),%s",
					 yyvsp[-5].text,yyvsp[-3].text,yyvsp[0].text);
		   }
    break;
case 41:
#line 358 "parser.y"
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
#line 380 "parser.y"
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
#line 402 "parser.y"
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
#line 424 "parser.y"
{	
		     if(pass==2) fprintf(outfp,"\t%s\t%s",yyvsp[-1].text,yyvsp[0].text);
		   }
    break;
case 45:
#line 429 "parser.y"
{ strcpy(yyval.text,yyvsp[0].text); }
    break;
case 46:
#line 430 "parser.y"
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
{ strcpy(yyval.text,yyvsp[0].text); }
    break;
case 50:
#line 440 "parser.y"
{ strcpy(yyval.text,yyvsp[0].text); }
    break;
case 51:
#line 443 "parser.y"
{ yyval.ival = yyvsp[0].ival; strcpy(yyval.text,yyvsp[0].text); }
    break;
case 52:
#line 444 "parser.y"
{ yyval.ival = -1; yyval.text[0]='\0'; }
    break;
case 53:
#line 447 "parser.y"
{ push_item(yyvsp[0].text); }
    break;
case 54:
#line 448 "parser.y"
{ push_item(yyvsp[0].text); }
    break;
case 55:
#line 452 "parser.y"
{
		     push_item(yyvsp[0].text);
		     yyval.ival = yyvsp[-2].ival + 1; 
		   }
    break;
case 56:
#line 457 "parser.y"
{
		     push_item(yyvsp[0].text);
		     yyval.ival = 1; 
		   }
    break;
case 57:
#line 464 "parser.y"
{ yyval.ival = -yyvsp[0].ival;
		     catN(yyval.text,yyvsp[-2].text,"-",yyvsp[0].text,NULL);
		   }
    break;
case 58:
#line 468 "parser.y"
{ yyval.ival = yyvsp[0].ival;
		     catN(yyval.text,yyvsp[-1].text,yyvsp[0].text,NULL);
		   }
    break;
case 59:
#line 474 "parser.y"
{ strcpyp(yyval.text,"#");}
    break;
case 60:
#line 475 "parser.y"
{ yyval.text[0]='\0'; }
    break;
case 61:
#line 479 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text);  }
    break;
case 62:
#line 481 "parser.y"
{ catN(yyval.text,"#",yyvsp[0].text,NULL);  }
    break;
case 63:
#line 485 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
    break;
case 64:
#line 487 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"|",yyvsp[0].text,NULL);  }
    break;
case 65:
#line 491 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
    break;
case 66:
#line 493 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"^",yyvsp[0].text,NULL);  }
    break;
case 67:
#line 497 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
    break;
case 68:
#line 499 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"&",yyvsp[0].text,NULL);  }
    break;
case 69:
#line 503 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
    break;
case 70:
#line 505 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"<<",yyvsp[0].text,NULL);  }
    break;
case 71:
#line 507 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,">>",yyvsp[0].text,NULL);  }
    break;
case 72:
#line 511 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
    break;
case 73:
#line 513 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"+",yyvsp[0].text,NULL);  }
    break;
case 74:
#line 515 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"-",yyvsp[0].text,NULL);  }
    break;
case 75:
#line 519 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
    break;
case 76:
#line 521 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"*",yyvsp[0].text,NULL);  }
    break;
case 77:
#line 523 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"/",yyvsp[0].text,NULL);  }
    break;
case 78:
#line 525 "parser.y"
{ catN(yyval.text,yyvsp[-2].text,"%",yyvsp[0].text,NULL);  }
    break;
case 79:
#line 529 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
    break;
case 80:
#line 531 "parser.y"
{ catN(yyval.text,"+",yyvsp[0].text,NULL);  }
    break;
case 81:
#line 533 "parser.y"
{ catN(yyval.text,"-",yyvsp[0].text,NULL);  }
    break;
case 82:
#line 535 "parser.y"
{ catN(yyval.text,"~",yyvsp[0].text,NULL);  }
    break;
case 83:
#line 538 "parser.y"
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
case 84:
#line 551 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
    break;
case 85:
#line 552 "parser.y"
{ strcpyp(yyval.text,yyvsp[0].text); }
    break;
case 86:
#line 553 "parser.y"
{ catN(yyval.text,"(",yyvsp[-1].text,")",NULL); }
    break;
}

#line 705 "/usr/share/bison/bison.simple"


  yyvsp -= yylen;
  yyssp -= yylen;
#if YYLSP_NEEDED
  yylsp -= yylen;
#endif

#if YYDEBUG
  if (yydebug)
    {
      short *yyssp1 = yyss - 1;
      YYFPRINTF (stderr, "state stack now");
      while (yyssp1 != yyssp)
	YYFPRINTF (stderr, " %d", *++yyssp1);
      YYFPRINTF (stderr, "\n");
    }
#endif

  *++yyvsp = yyval;
#if YYLSP_NEEDED
  *++yylsp = yyloc;
#endif

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTBASE] + *yyssp;
  if (yystate >= 0 && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTBASE];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;

#ifdef YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (yyn > YYFLAG && yyn < YYLAST)
	{
	  YYSIZE_T yysize = 0;
	  char *yymsg;
	  int yyx, yycount;

	  yycount = 0;
	  /* Start YYX at -YYN if negative to avoid negative indexes in
	     YYCHECK.  */
	  for (yyx = yyn < 0 ? -yyn : 0;
	       yyx < (int) (sizeof (yytname) / sizeof (char *)); yyx++)
	    if (yycheck[yyx + yyn] == yyx)
	      yysize += yystrlen (yytname[yyx]) + 15, yycount++;
	  yysize += yystrlen ("parse error, unexpected ") + 1;
	  yysize += yystrlen (yytname[YYTRANSLATE (yychar)]);
	  yymsg = (char *) YYSTACK_ALLOC (yysize);
	  if (yymsg != 0)
	    {
	      char *yyp = yystpcpy (yymsg, "parse error, unexpected ");
	      yyp = yystpcpy (yyp, yytname[YYTRANSLATE (yychar)]);

	      if (yycount < 5)
		{
		  yycount = 0;
		  for (yyx = yyn < 0 ? -yyn : 0;
		       yyx < (int) (sizeof (yytname) / sizeof (char *));
		       yyx++)
		    if (yycheck[yyx + yyn] == yyx)
		      {
			const char *yyq = ! yycount ? ", expecting " : " or ";
			yyp = yystpcpy (yyp, yyq);
			yyp = yystpcpy (yyp, yytname[yyx]);
			yycount++;
		      }
		}
	      yyerror (yymsg);
	      YYSTACK_FREE (yymsg);
	    }
	  else
	    yyerror ("parse error; also virtual memory exhausted");
	}
      else
#endif /* defined (YYERROR_VERBOSE) */
	yyerror ("parse error");
    }
  goto yyerrlab1;


/*--------------------------------------------------.
| yyerrlab1 -- error raised explicitly by an action |
`--------------------------------------------------*/
yyerrlab1:
  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      /* return failure if at end of input */
      if (yychar == YYEOF)
	YYABORT;
      YYDPRINTF ((stderr, "Discarding token %d (%s).\n",
		  yychar, yytname[yychar1]));
      yychar = YYEMPTY;
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */

  yyerrstatus = 3;		/* Each real token shifted decrements this */

  goto yyerrhandle;


/*-------------------------------------------------------------------.
| yyerrdefault -- current state does not do anything special for the |
| error token.                                                       |
`-------------------------------------------------------------------*/
yyerrdefault:
#if 0
  /* This is wrong; only states that explicitly want error tokens
     should shift them.  */

  /* If its default is to accept any token, ok.  Otherwise pop it.  */
  yyn = yydefact[yystate];
  if (yyn)
    goto yydefault;
#endif


/*---------------------------------------------------------------.
| yyerrpop -- pop the current state because it cannot handle the |
| error token                                                    |
`---------------------------------------------------------------*/
yyerrpop:
  if (yyssp == yyss)
    YYABORT;
  yyvsp--;
  yystate = *--yyssp;
#if YYLSP_NEEDED
  yylsp--;
#endif

#if YYDEBUG
  if (yydebug)
    {
      short *yyssp1 = yyss - 1;
      YYFPRINTF (stderr, "Error: state stack now");
      while (yyssp1 != yyssp)
	YYFPRINTF (stderr, " %d", *++yyssp1);
      YYFPRINTF (stderr, "\n");
    }
#endif

/*--------------.
| yyerrhandle.  |
`--------------*/
yyerrhandle:
  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yyerrdefault;

  yyn += YYTERROR;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != YYTERROR)
    goto yyerrdefault;

  yyn = yytable[yyn];
  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrpop;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrpop;

  if (yyn == YYFINAL)
    YYACCEPT;

  YYDPRINTF ((stderr, "Shifting error token, "));

  *++yyvsp = yylval;
#if YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

/*---------------------------------------------.
| yyoverflowab -- parser overflow comes here.  |
`---------------------------------------------*/
yyoverflowlab:
  yyerror ("parser stack overflow");
  yyresult = 2;
  /* Fall through.  */

yyreturn:
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
  return yyresult;
}
#line 556 "parser.y"


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



