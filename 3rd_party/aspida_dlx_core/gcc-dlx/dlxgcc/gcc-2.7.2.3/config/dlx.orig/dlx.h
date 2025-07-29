/*
 *  A DLX Machine Description for GCC 2.x (header file)
 *
 *  Copyright (C) 1994,1995  Aaron Sawdey
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
 *  Email: sawdey@mountains.ee.umn.edu
 *
 *  Snail Mail:
 *
 *  Department of Electrical Engineering
 *  University of Minnesota
 *  4-174 EE/CSci Building
 *  200 Union Street S.E.
 *  Minneapolis, MN 55455
 *
 */

/*
 ***************************************************************************
 *
 * Comparison stuff.
 * Modeled off of the RS6000 description.
 *
 */

extern struct rtx_def *dlx_compare_op0, *dlx_compare_op1;
extern enum machine_mode dlx_compare_mode;

/* so local labels are (fairly) unique. */
extern char *fn_minus_ext();

#define CPP_PREDEFINES "-DDLX -Ddlx -D__dlx__ -D__DLX__"

#define TARGET_VERSION printf(stderr," (DLX microprocessor)");
 
/*
 * Prevent gcc from adding -lgcc
 */
#define LIBGCC_SPEC ""

#define TARGET_SWITCHES \
      { { "traps" , 1 }, \
        { "noargs" , 2 }, \
        { "", 1}}

#define LIB_SPEC "%{!mtraps:-lc}%{mtraps:-ltraps}"

#define BITS_BIG_ENDIAN 0
#define BYTES_BIG_ENDIAN 1
#define WORDS_BIG_ENDIAN 1
#define FLOAT_WORDS_BIG_ENDIAN 1

#define BITS_PER_UNIT 8
#define BITS_PER_WORD 32
#define UNITS_PER_WORD 4
#define POINTER_SIZE 32

#define PARM_BOUNDARY 32
#define STACK_BOUNDARY 64
#define FUNCTION_BOUNDARY 32
#define BIGGEST_ALIGNMENT 64    /* double */
#define BIGGEST_FIELD_ALIGNMENT 64
#define EMPTY_FIELD_BOUNDARY 32
#define STRUCTURE_SIZE_BOUNDARY 8
#define STRICT_ALIGNMENT 1

#define TARGET_FLOAT_FORMAT IEEE_FLOAT_FORMAT

#define INT_TYPE_SIZE 32
#define SHORT_TYPE_SIZE 16
#define LONG_TYPE_SIZE 32
#define LONG_LONG_TYPE_SIZE 32
#define CHAR_TYPE_SIZE 8
#define FLOAT_TYPE_SIZE 32
#define DOUBLE_TYPE_SIZE 64
#define LONG_DOUBLE_TYPE_SIZE 64
/* This way we can do char operations with regular 
   register-register ops and not worry about negative
   chars, so it should be faster. */
#define DEFAULT_SIGNED_CHAR 0

#define MAX_FIXED_MODE_SIZE 32

/* DLX floating point CC */
#define EXTRA_CC_MODES CCFPmode
#define EXTRA_CC_NAMES "CCFP"

#define SELECT_CC_MODE(OP,X,Y) \
  (GET_MODE_CLASS (GET_MODE (X)) == MODE_FLOAT ? CCFPmode : SImode)

#define STORE_FLAG_VALUE 1

#define DEFAULT_PCC_STRUCT_RETURN 0
#define STRUCT_VALUE_REGNUM 1

#define NO_FUNCTION_CSE
#define NO_RECURSIVE_FUNCTION_CSE

#define FUNCTION_MODE QImode
#define Pmode SImode

#define FUNCTION_PROLOGUE(file,size) function_prologue(file,size)
#define FUNCTION_EPILOGUE(file,size) function_epilogue(file,size)

#define EXIT_IGNORE_STACK 0

#define CASE_VECTOR_MODE SImode

/* Define results of standard character escape sequences.  */
#define TARGET_BELL     007
#define TARGET_BS       010
#define TARGET_TAB      011
#define TARGET_NEWLINE  012
#define TARGET_VT       013
#define TARGET_FF       014
#define TARGET_CR       015

#define EASY_DIV_EXPR TRUNC_DIV_EXPR

#define SLOW_BYTE_ACCESS 1

/*
 *
 */
#define TRULY_NOOP_TRUNCATION(OUTPREC, INPREC) 1

/*
 * We can't load any constants as immediates.
 */
#define CONST_DOUBLE_OK_FOR_LETTER_P(VALUE, C) 0

/*
 * Since all the registers are equivalent, 
 * a value can be reloaded in any register of the same
 * class.
 */
#define PREFERRED_RELOAD_CLASS(x,class) class

#define PREDICATE_CODES                                         \
{ "signed_comparison_operator", {EQ, NE, LT, LE, GE, GT} },     \
{ "sym_ref_mem_operand", {MEM} },

/* 
 * It would be silly to try and profile a 
 * simulated machine, would it not?
 */
#define FUNCTION_PROFILER(file,labelno)

#define ASM_OUTPUT_REG_PUSH(stream,regno)       \
{ if(regno <= LAST_INT_REG) fprintf(stream,"\tsw\t-4(r29),r%d\n",regno);  \
  else fprintf(stream,"\tsf\t-4(r29),f%d\n",regno);                       \
  fputs("\taddi\tr29,r29,#-4\n",stream); }

#define ASM_OUTPUT_REG_POP(stream,regno)        \
{ if(regno <= LAST_INT_REG) fprintf(stream,"\tlw\tr%d,-4(r29)\n",regno);  \
  else fprintf(stream,"\tsf\tr%d,-4(r29)\n",regno);                       \
  fputs("\taddi\tr29,r29,#4\n",stream); }

/* memory copy with 32 bit words. */
#define MOVE_MAX 4

/*
 * Small int constants have no cost since they
 * can be used as immediates.
 * Larger int constants and symbols/labels
 * cost 2 instruction (addui/lhi).
 * Doubles cost more, since we have to load the
 * address (addui/lhi) and then load the constant.
 */
#define CONST_COSTS(X, CODE, OUTER_CODE)        \
 case CONST_INT:                                \
  if(SMALL_INT(X)) return 0;                    \
  else return COSTS_N_INSNS(2);                 \
 case CONST:                                    \
 case SYMBOL_REF:                               \
 case LABEL_REF:                                \
  return COSTS_N_INSNS(2);                      \
 case CONST_DOUBLE:                             \
  return COSTS_N_INSNS(8);

#define MEMORY_MOVE_COST(m) ((GET_MODE_SIZE(m) > UNITS_PER_WORD)?8:4)

#define TEXT_SECTION_ASM_OP ".text"
#define DATA_SECTION_ASM_OP ".data"

/* Given a decl node or constant node, choose the section to output it in
   and select that section.  */
/* These are from mips.h, simplified somewhat. */

#define SELECT_RTX_SECTION(MODE,RTX)            \
  data_section()

#define SELECT_SECTION(DECL, RELOC)					\
{                                                                       \
  if(RELOC)                                                             \
    data_section();                                                     \
  else if(TREE_CODE(DECL) == STRING_CST)				\
    data_section();							\
  else if(TREE_CODE(DECL) != VAR_DECL)                                  \
    text_section();                                                     \
  else                                                                  \
    data_section();                                                     \
}


#define ASM_APP_ON ";#APP\n"
#define ASM_APP_OFF ";#NO_APP\n"
#define ASM_IDENTIFY_GCC(file) fputs("; Compiled by GCC\n",file)
#define ASM_COMMENT_START ";;"
#define ASM_FILE_START(stream) asm_file_start(stream)
#define ASM_FILE_END(stream) asm_file_end(stream)
#define ASM_LONG ".word"
#define ASM_SHORT ".half"
#define ASM_OPEN_PAREN "("
#define ASM_CLOSE_PAREN ")"

/* If defined, a C expression to compute the alignment given to a
   constant that is being placed in memory.  CONSTANT is the constant
   and ALIGN is the alignment that the object would ordinarily have.
   The value of this macro is used instead of that alignment to align
   the object.

   If this macro is not defined, then ALIGN is used.

   The typical use of this macro is to increase alignment for string
   constants to be word aligned so that `strcpy' calls that copy
   constants can be done inline.  */
/* Stolen from mips.h */

#define CONSTANT_ALIGNMENT(EXP, ALIGN)                                  \
  ((TREE_CODE (EXP) == STRING_CST  || TREE_CODE (EXP) == CONSTRUCTOR)   \
   && (ALIGN) < BITS_PER_WORD                                           \
        ? BITS_PER_WORD                                                 \
        : (ALIGN))

/* If defined, a C expression to compute the alignment for a static
   variable.  TYPE is the data type, and ALIGN is the alignment that
   the object would ordinarily have.  The value of this macro is used
   instead of that alignment to align the object.

   If this macro is not defined, then ALIGN is used.

   One use of this macro is to increase alignment of medium-size
   data to make it all fit in fewer cache lines.  Another is to
   cause character arrays to be word-aligned so that `strcpy' calls
   that copy constants to character arrays can be done inline.  */
/* Stolen from mips.h */

#undef DATA_ALIGNMENT
#define DATA_ALIGNMENT(TYPE, ALIGN)                                     \
  ((((ALIGN) < BITS_PER_WORD)                                           \
    && (TREE_CODE (TYPE) == ARRAY_TYPE                                  \
        || TREE_CODE (TYPE) == UNION_TYPE                               \
        || TREE_CODE (TYPE) == RECORD_TYPE)) ? BITS_PER_WORD : (ALIGN))

#define ASM_OUTPUT_ALIGN(stream,val) fprintf(stream,"\t.align %d\n",(val))
#define ASM_OUTPUT_SKIP(stream,val)  fprintf(stream,"\t.space %d\n",(val))

#define ASM_OUTPUT_FLOAT(stream,value) \
   { long l;                                 \
      REAL_VALUE_TO_TARGET_SINGLE(value,l); \
      fprintf(stream,"\t.word 0x%08x\t\n;; %26.7e\n",l,value); }
#define ASM_OUTPUT_DOUBLE(stream,value) 			\
   { long l[2];                                 		\
      REAL_VALUE_TO_TARGET_DOUBLE(value,&l[0]); 		\
      fprintf(stream,"\t.word 0x%08x,0x%08x\t\n;; %26.16le\n",	\
	      l[0],l[1],value); }
#define ASM_OUTPUT_LONG_DOUBLE(stream,value) \
   { long l[4];                                 \
      REAL_VALUE_TO_TARGET_DOUBLE(value,&l[0]); \
      fprintf(stream,"\t.word 0x%08x,0x%08x,0x%08x,0x%08x\t\n;; %26.18lle\n", \
	      l[0],l[1],l[2],l[3],value); }

#define ASM_OUTPUT_INT(stream,exp) \
      fprintf(stream,"\t.word "); output_addr_const(stream,exp); \
      putc('\n',stream) 

#define ASM_OUTPUT_SHORT(stream,exp) \
      fprintf(stream,"\t.half "); output_addr_const(stream,exp); \
      putc('\n',stream) 

#define ASM_OUTPUT_CHAR(stream,exp) \
      fprintf(stream,"\t.byte "); output_addr_const(stream,exp); \
      putc('\n',stream) 

#define ASM_OUTPUT_BYTE(stream,val) fprintf(stream,"\t.byte 0x%02x\n",val)
#define ASM_BYTE_OP ".byte"

/*
 * Need to split up .ascii directives to avoid breaking 
 * the linker.
 */
#define ASM_OUTPUT_ASCII(stream, ptr, len)			\
    asm_output_ascii(stream,ptr,len)


#define ASM_OUTPUT_FUNCTION_PREFIX(stream, fnname)		\
  fputs(".proc ",stream); assemble_name(stream,fnname);		\
  fputs("\n",stream);

#define ASM_OUTPUT_COMMON(stream,name,size,rounded)             \
{ data_section();                                               \
  fputs(".global\t",stream); assemble_name(stream,name);        \
  fputs("\n",stream); assemble_name(stream,name);               \
  fprintf(stream,":\n\t.space %d\n",rounded); }

#define ASM_OUTPUT_ALIGNED_COMMON(stream, name, size, alignment) \
{ data_section();						 \
  if((alignment)>8) 						 \
    fprintf(stream,"\t.align %d\n",log_of_two(alignment>>3));    \
  fputs(".global\t",stream); assemble_name(stream,name);         \
  fputs("\n",stream);						 \
  assemble_name(stream,name);                                    \
  fprintf(stream,":\n\t.space %d\n",size); }

#define ASM_OUTPUT_ALIGNED_LOCAL(stream, name, size, alignment)  \
{ data_section();                                                \
  if((alignment)>8)						 \
    fprintf(stream,"\t.align %d\n",log_of_two(alignment>>3));    \
  assemble_name(stream,name);                                    \
  fprintf(stream,":\n\t.space %d\n",size); }

#define ASM_OUTPUT_LABEL(stream, label)                 \
{ assemble_name(stream,label); fputs(":\n",stream); }

#define ASM_GLOBALIZE_LABEL(stream,label)               \
{ fputs(".global ",stream); assemble_name(stream,label); \
  fputs("\n",stream); }

#define ASM_OUTPUT_LABELREF(stream,name)                \
{ fputc('_',stream); fputs(name,stream); }

#define ASM_OUTPUT_INTERNAL_LABEL(stream,prefix,num)    \
  fprintf(stream, "%s%d:\n", prefix, num)

#define ASM_OUTPUT_CASE_LABEL(stream,prefix,num,table)  \
  { data_section(); fprintf(stream,"\t.align 2\n");     \
    ASM_OUTPUT_INTERNAL_LABEL(stream,prefix,num); }

#define ASM_OUTPUT_CASE_END(stream,num,table)           \
  text_section()

#define ASM_OUTPUT_ADDR_VEC_ELT(stream,value)           \
  fprintf(stream,"\t.word L%d\n",value)

#define ASM_FORMAT_PRIVATE_NAME(OUTPUT, NAME, LABELNO)			\
( (OUTPUT) = (char *) alloca (strlen ((NAME)) + 11),			\
  sprintf ((OUTPUT), "%s%d", (NAME), (LABELNO)))

#define ASM_GENERATE_INTERNAL_LABEL(string,prefix,num)  \
  sprintf(string, "*%s%d",prefix, num)

int print_operand();
int print_operand_address();
int print_operand_punct_valid_p();
  
#define PRINT_OPERAND(stream,x,code) print_operand(stream,x,code)
#define PRINT_OPERAND_ADDRESS(stream,x) print_operand_address(stream,x)
#define PRINT_OPERAND_PUNCT_VALID_P(code) print_operand_punct_valid_p(code)

/* Register usage
 *
 * There are 32 int, 32 FP, and one floating point status register
 */

#define FIRST_PSEUDO_REGISTER 65

/*
 * Fixed registers are r0 (==0 always), r29 (stack), r30 (frame),
 * and FP SR.
 */

#define FIRST_INT_REG 0
#define LAST_INT_REG 31
#define FIRST_FP_REG 32
#define LAST_FP_REG 63
#define FP_STATUS_REG 64

#define FIXED_REGISTERS { \
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,     \
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0,     \
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,     \
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,     \
 1 }

/* all registers are callee save. */

#define CALL_USED_REGISTERS { \
 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,     \
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,     \
 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,     \
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,     \
 1 }

#define REGISTER_NAMES                                          \
{ "r0" , "r1" , "r2" , "r3" , "r4" , "r5" , "r6" , "r7",        \
  "r8" , "r9" , "r10", "r11", "r12", "r13", "r14", "r15",       \
  "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",       \
  "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",       \
  "f0" , "f1" , "f2" , "f3" , "f4" , "f5" , "f6" , "f7",        \
  "f8" , "f9" , "f10", "f11", "f12", "f13", "f14", "f15",       \
  "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",       \
  "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",       \
  "FPSR" }
/* ^^^^ should never be output though. */

/* values that can go in particular registers. */
/* doubles will be the only thing that will take 2 registers. */

#define HARD_REGNO_NREGS(regno,mode) \
  ((GET_MODE_SIZE(mode) + UNITS_PER_WORD - 1)/UNITS_PER_WORD)

/*
 * Allocate registers appropriate to data types. doubles 
 * require even/odd pairs of fp registers. For simplicity,
 * I also allocate long long ints to even/odd pairs of int registers.
 */

extern int hard_regno_mode_ok_func();

#define HARD_REGNO_MODE_OK(regno,mode) hard_regno_mode_ok_func(regno,mode)

#define MODES_TIEABLE_P(mode1, mode2)                                   \
  (FLOAT_MODE_P(mode1) && FLOAT_MODE_P(mode2))

enum reg_class
{
  NO_REGS,                      /* no registers in set */
  GR_REGS,                      /* integer registers */
  FP_REGS,                      /* floating point registers */
  ST_REGS,                      /* status registers (fp status) */
  ALL_REGS,                     /* all registers */
  LIM_REG_CLASSES               /* max value + 1 */
};

#define N_REG_CLASSES (int) LIM_REG_CLASSES

#define GENERAL_REGS GR_REGS


#define REG_CLASS_NAMES                                                 \
{                                                                       \
  "NO_REGS",                                                            \
  "GR_REGS",                                                            \
  "FP_REGS",                                                            \
  "ST_REGS",                                                            \
  "ALL_REGS"                                                            \
}

#define REG_CLASS_CONTENTS                                              \
{                                                                       \
  { 0x00000000, 0x00000000, 0x00000000 },       /* no registers */      \
  { 0xffffffff, 0x00000000, 0x00000000 },       /* integer registers */ \
  { 0x00000000, 0xffffffff, 0x00000000 },       /* floating registers*/ \
  { 0x00000000, 0x00000000, 0x00000001 },       /* status registers */  \
  { 0xffffffff, 0xffffffff, 0x00000001 }        /* all registers */     \
}

#define REGNO_REG_CLASS(regno)    \
((regno < FIRST_FP_REG)?(GR_REGS):((regno <= LAST_FP_REG)?(FP_REGS):(ST_REGS)))

#define BASE_REG_CLASS GR_REGS
#define INDEX_REG_CLASS GR_REGS

extern int reg_class_from_letter();

#define REG_CLASS_FROM_LETTER(char) reg_class_from_letter(char)

/* If we use the normal load/store ops in DLX,
   it will always sign-extend sub-word types. */
#define LOAD_EXTEND_OP(mode) SIGN_EXTEND

/*
 * Memory address stuff.
 */
#define MAX_REGS_PER_ADDRESS 1

#define CONSTANT_ADDRESS_P(X) CONSTANT_P(X)

#define REGNO_OK_FOR_BASE_P(REGNO)                                          \
((REGNO) < FIRST_PSEUDO_REGISTER ? ((REGNO) > 0 && (REGNO) <= LAST_INT_REG) \
 : (reg_renumber[REGNO] > 0 && (reg_renumber[REGNO] <= LAST_INT_REG )))

#ifdef REG_OK_STRICT
/* Strict version, used in reload pass. This should not
 * accept pseudo registers.
 */
#define REG_OK_FOR_BASE_P(X) REGNO_OK_FOR_BASE_P(REGNO(X))
#else
/* Accept an int register or a pseudo reg. */
#define REG_OK_FOR_BASE_P(X) (REGNO(X) <= LAST_INT_REG || \
                              REGNO(X) >= FIRST_PSEUDO_REGISTER)
#endif

/*
 * DLX doesn't have any indexed addressing
 * modes, so nothing is ok as an index register.
 */
#define REG_OK_FOR_INDEX_P(X) 0
#define REGNO_OK_FOR_INDEX_P(X) 0

#define LEGITIMATE_ADDRESS_INTEGER_P(X,OFFSET)          \
 (GET_CODE (X) == CONST_INT && SMALL_INT(X))

#define LEGITIMATE_OFFSET_ADDRESS_P(MODE,X)             \
 (GET_CODE (X) == PLUS                                  \
  && GET_CODE (XEXP (X, 0)) == REG                      \
  && REG_OK_FOR_BASE_P (XEXP (X, 0))                    \
  && LEGITIMATE_ADDRESS_INTEGER_P (XEXP (X, 1), 0)      \
  && (((MODE) != DFmode && (MODE) != DImode)            \
      || LEGITIMATE_ADDRESS_INTEGER_P (XEXP (X, 1), 4)))

#define LEGITIMATE_NONOFFSET_ADDRESS_P(MODE,X)          \
             (GET_CODE(X) == REG && REG_OK_FOR_BASE_P(X))
/* 
 * This is simple because DLX only has one addressing mode:
 * register + 16 bit signed offset.
 */
#define GO_IF_LEGITIMATE_ADDRESS(MODE,X,ADDR)           \
  if(LEGITIMATE_OFFSET_ADDRESS_P(MODE,X)) goto ADDR;    \
  if(LEGITIMATE_NONOFFSET_ADDRESS_P(MODE,X)) goto ADDR; 
/*
  if(GET_CODE(X) == SYMBOL_REF) goto ADDR;
*/

/* 
 * We have to force symbol_ref's into registers here
 * because nobody else seems to want to do that!
 */
#define LEGITIMIZE_ADDRESS(X,OLDX,MODE,WIN)
/*
{ if (GET_CODE (x) == SYMBOL_REF)                               \
    (X) = copy_to_reg (X);                                      \
  if (memory_address_p (MODE, X))                               \
    goto WIN; 							\
}
*/

/*
 * DLX addresses do not depend on the machine mode they are
 * being used in.
 */
#define GO_IF_MODE_DEPENDENT_ADDRESS(addr,label)

/* stolen from sparc.h and modified for DLX which 
 * has 16 bit immediates. 
 */
#define SMALL_INT(X) (INTVAL(X) >= -32768 && INTVAL(X) <= 32767)

#define CONST_OK_FOR_LETTER_P(VALUE, C)  \
  ((C) == 'I' ? ((VALUE) >= -32768 && (VALUE) <= 32767)  \
   : (C) == 'J' ? (VALUE) == 0                          \
   : (C) == 'K' ? ((VALUE) & 0xffff) == 0                \
   : (C) == 'L' ? ((VALUE) >= 0 && (VALUE) <= 65535)  \
   : 0)

#define LEGITIMATE_CONSTANT_P(x) (GET_CODE(x) != CONST_DOUBLE)

#define CLASS_UNITS(mode, size)                                         \
  ((GET_MODE_SIZE (mode) + (size) - 1) / (size))

#define CLASS_MAX_NREGS(CLASS, MODE)                                    \
  ((CLASS) == FP_REGS                                                   \
   ? (CLASS_UNITS (MODE, 4))                                        \
   : CLASS_UNITS (MODE, UNITS_PER_WORD))

#define STACK_GROWS_DOWNWARD

#define FRAME_GROWS_DOWNWARD
#define STARTING_FRAME_OFFSET -8

#define STACK_POINTER_OFFSET 0

#define INITIAL_FRAME_POINTER_OFFSET(var) { var=8; }

/* Lifted from mips.h.
 * If defined, a C expression that gives the alignment boundary, in
 * bits, of an argument with the specified mode and type.  If it is
 * not defined,  `PARM_BOUNDARY' is used for all arguments.  
 */

#define FUNCTION_ARG_BOUNDARY(MODE, TYPE)				\
  (((TYPE) != 0)							\
	? ((TYPE_ALIGN(TYPE) <= PARM_BOUNDARY)				\
		? PARM_BOUNDARY						\
		: TYPE_ALIGN(TYPE))					\
	: ((GET_MODE_ALIGNMENT(MODE) <= PARM_BOUNDARY)			\
		? PARM_BOUNDARY						\
		: GET_MODE_ALIGNMENT(MODE)))


#define FIRST_PARM_OFFSET(FNDECL) 0

#define STACK_POINTER_REGNUM 29
#define FRAME_POINTER_REGNUM 30
#define ARG_POINTER_REGNUM 30   /* access args with frame pointer */
#define STATIC_CHAIN_REGNUM 2

#define FRAME_POINTER_REQUIRED 1

#define FUNCTION_ARG(cum,mode,type,named) 0

/* 
 * Return char/short/int in r1
 * return float in f0
 * return double in f0/f1.
 * return anything else in r1.
 */
#define FUNCTION_VALUE(VALTYPE, FUNC)                                   \
((TYPE_MODE(VALTYPE) == DFmode || TYPE_MODE(VALTYPE) == SFmode)?	\
                    gen_rtx(REG,TYPE_MODE(VALTYPE),FIRST_FP_REG)        \
:((TYPE_MODE(VALTYPE)==HImode || TYPE_MODE(VALTYPE) == QImode)?		\
                    gen_rtx(REG, TYPE_MODE(VALTYPE), 1)			\
:gen_rtx(REG,SImode,1)))

#define RETURN_IN_MEMORY(TYPE) (TYPE_MODE (TYPE) == BLKmode)

/* return in r1 or f0. */
/* I'm not quite sure if I'll need any of these routines anyway. */
#define LIBCALL_VALUE(MODE)     \
 (FLOAT_MODE_P(MODE)?gen_rtx(REG,SFmode,FIRST_FP_REG):gen_rtx(REG,SImode,1))

typedef int CUMULATIVE_ARGS;

#define INIT_CUMULATIVE_ARGS(cum,fntype,libname) { cum = 0; }
#define FUNCTION_ARG_ADVANCE(cum,mode,type,named)       \
{ cum += UNITS_PER_WORD*((GET_MODE_SIZE(mode)+UNITS_PER_WORD-1)         \
             /UNITS_PER_WORD) ; }

/*
 * As is usual in C, the caller pops all the arguments.
 */

#define RETURN_POPS_ARGS(FUNDECL, FUNTYPE, STACKSIZE) 0

#define FUNCTION_ARG_PARTIAL_NREGS(cum,mode,type,named) 0

/*
 * All registers are passed on the stack.
 */
#define FUNCTION_ARG_REGNO_P(regno) 0

/*
 * Return is always in r1 or f0.
 */
#define FUNCTION_VALUE_REGNO_P(regno) ((regno) == 1||(regno) == 32)

/*
 * Trampoline stuff, stolen from mips.h.
 * This will need serious work.
 *
 */

/* A C statement to output, on the stream FILE, assembler code for a
   block of data that contains the constant parts of a trampoline. 
   This code should not include a label--the label is taken care of
   automatically.  */

#define TRAMPOLINE_TEMPLATE(STREAM)                                      \
{                                                                        \
}

/* A C expression for the size in bytes of the trampoline, as an
   integer.  */

#define TRAMPOLINE_SIZE (9*4)

/* Alignment required for trampolines, in bits.

   If you don't define this macro, the value of `BIGGEST_ALIGNMENT'
   is used for aligning trampolines.  */

/* #define TRAMPOLINE_ALIGNMENT 32 */

/* A C statement to initialize the variable parts of a trampoline. 
   ADDR is an RTX for the address of the trampoline; FNADDR is an
   RTX for the address of the nested function; STATIC_CHAIN is an
   RTX for the static chain value that should be passed to the
   function when it is called.  */

#define INITIALIZE_TRAMPOLINE(ADDR, FUNC, CHAIN)                            \
{                                                                           \
  rtx addr = ADDR;                                                          \
  emit_move_insn (gen_rtx (MEM, SImode, plus_constant (addr, 28)), FUNC);   \
  emit_move_insn (gen_rtx (MEM, SImode, plus_constant (addr, 32)), CHAIN);  \
                                                                            \
  /* Flush the instruction cache.  */                                       \
  emit_library_call (gen_rtx (SYMBOL_REF, Pmode, "__gcc_flush_cache"), \
                     0, VOIDmode, 1, addr, Pmode);                          \
}

/* Flush the instruction cache.  */

#define TRANSFER_FROM_TRAMPOLINE                                        \
                                                                        \
void                                                                    \
__gcc_flush_cache (addr)                                                \
     char *addr;                                                        \
{                                                                       \
  if (cacheflush (addr, TRAMPOLINE_SIZE, 1) < 0)                        \
    perror ("cacheflush of trampoline code");                           \
}

