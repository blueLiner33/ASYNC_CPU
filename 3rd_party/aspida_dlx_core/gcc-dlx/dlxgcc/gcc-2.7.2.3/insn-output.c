/* Generated automatically by the program `genoutput'
from the machine description file `md'.  */

#include "config.h"
#include "rtl.h"
#include "regs.h"
#include "hard-reg-set.h"
#include "real.h"
#include "insn-config.h"

#include "conditions.h"
#include "insn-flags.h"
#include "insn-attr.h"

#include "insn-codes.h"

#include "recog.h"

#include <stdio.h>
#include "output.h"

static char *
output_8 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_8[] = {
    "add\t%0,%1,%2",
    "addi\t%0,%1,%G2",
    "addui\t%0,%1,%U2",
  };
  return strings_8[which_alternative];
}

static char *
output_9 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_9[] = {
    "sub\t%0,%1,%2",
    "subi\t%0,%1,%G2",
    "subui\t%0,%1,%U2",
  };
  return strings_9[which_alternative];
}

static char *
output_10 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_10[] = {
    "and\t%0,%1,%2",
    "andi\t%0,%1,%U2",
  };
  return strings_10[which_alternative];
}

static char *
output_11 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_11[] = {
    "or\t%0,%1,%2",
    "ori\t%0,%1,%U2",
  };
  return strings_11[which_alternative];
}

static char *
output_12 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_12[] = {
    "xor\t%0,%1,%2",
    "xori\t%0,%1,%U2",
  };
  return strings_12[which_alternative];
}

static char *
output_19 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_19[] = {
    "sll\t%0,%1,%2",
    "slli\t%0,%1,%2",
  };
  return strings_19[which_alternative];
}

static char *
output_20 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_20[] = {
    "sra\t%0,%1,%2",
    "srai\t%0,%1,%2",
  };
  return strings_20[which_alternative];
}

static char *
output_21 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_21[] = {
    "srl\t%0,%1,%2",
    "srli\t%0,%1,%2",
  };
  return strings_21[which_alternative];
}

static char *
output_30 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_30[] = {
    "andi\t%0,%1,0xffff",
    "sh\t%0,%1",
  };
  return strings_30[which_alternative];
}

static char *
output_31 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_31[] = {
    "andi\t%0,%1,0x00ff",
    "sb\t%0,%1",
  };
  return strings_31[which_alternative];
}

static char *
output_32 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_32[] = {
    "andi\t%0,%1,0x00ff",
    "sb\t%0,%1",
  };
  return strings_32[which_alternative];
}

static char *
output_33 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_33[] = {
    "andi\t%0,%1,0x00ff",
    "lbu\t%0,%1",
  };
  return strings_33[which_alternative];
}

static char *
output_34 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_34[] = {
    "andi\t%0,%1,0xffff",
    "lhu\t%0,%1",
  };
  return strings_34[which_alternative];
}

static char *
output_35 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_35[] = {
    "andi\t%0,%1,0x00ff",
    "lbu\t%0,%1",
  };
  return strings_35[which_alternative];
}

static char *
output_36 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_36[] = {
    "slli\t%0,%1,24\n\tsrai\t%0,%0,24",
    "lb\t%0,%1",
  };
  return strings_36[which_alternative];
}

static char *
output_37 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_37[] = {
    "slli\t%0,%1,16\n\tsrai\t%0,%0,16",
    "lh\t%0,%1",
  };
  return strings_37[which_alternative];
}

static char *
output_41 (operands, insn)
     rtx *operands;
     rtx insn;
{

{ 
  switch(which_alternative)
   {
     case 0:
       return "addi\t%0,r0,%G1";
     case 1:
       return "addui\t%0,r0,%U1";
     case 2:
       if(GET_CODE(operands[1]) == CONST_INT)
        {
         return "lhi\t%0,%H1\n\taddui\t%0,%0,%L1";
        }
       else
        {
         return "lhi\t%0,((%1)>>16)&0xffff\n\taddui\t%0,%0,(%1)&0xffff";
        }
     case 3:
        return "lw\t%0,%1";
     case 4:
        return "sw\t%0,%1";
     case 5:
        { int f0,f1;
          f0 = FLOAT_MODE_P(GET_MODE(operands[0]));
          f1 = FLOAT_MODE_P(GET_MODE(operands[1]));
          if(!f0 && !f1) return "add\t%0,r0,%1";
          else if(!f0 && f1) return "movfp2i\t%0,%1";
          else if(f0 && !f1) return "movi2fp\t%0,%1";
          else return "movf\t%0,%1";
        }
   }

}
}

static char *
output_43 (operands, insn)
     rtx *operands;
     rtx insn;
{

{ 
  switch(which_alternative)
   {
     case 0:
        return "addi\t%0,r0,%G1";
     case 1:
        return "lh\t%0,%1";
     case 2:
        return "sh\t%0,%1";
     case 3:
        return "add\t%0,r0,%1";
   }

}
}

static char *
output_45 (operands, insn)
     rtx *operands;
     rtx insn;
{

{ 
  switch(which_alternative)
   {
     case 0:
        return "addi\t%0,r0,(%1)&0xff";
     case 1:
        return "lb\t%0,%1";
     case 2:
        return "sb\t%0,%1";
     case 3:
        return "add\t%0,r0,%1";
   }

}
}

static char *
output_47 (operands, insn)
     rtx *operands;
     rtx insn;
{

{ 
  switch(which_alternative)
   {
     case 0:
        return "lf\t%0,%1";
     case 1:
        return "sf\t%0,%1";
     case 2:
        { int f0,f1;
	  f0 = (REGNO(operands[0]) >= FIRST_FP_REG);
	  f1 = (REGNO(operands[1]) >= FIRST_FP_REG);

          if(!f0 && !f1) return "add\t%0,r0,%1";
          else if(!f0 && f1) return "movfp2i\t%0,%1";
          else if(f0 && !f1) return "movi2fp\t%0,%1";
          else return "movf\t%0,%1";
        }
   }

}
}

static char *
output_49 (operands, insn)
     rtx *operands;
     rtx insn;
{

{ 
  switch(which_alternative)
   {
     case 0:
        return "ld\t%0,%1";
     case 1:
        return "sd\t%0,%1";
     case 2:
        return "movd\t%0,%1";
   }

}
}

static char *
output_52 (operands, insn)
     rtx *operands;
     rtx insn;
{

{
  if (GET_CODE (operands[0]) == REG)
   return "jr\t%0%(";
  else
    return "j\t%0%(";
}
}

static char *
output_92 (operands, insn)
     rtx *operands;
     rtx insn;
{
  static /*const*/ char *const strings_92[] = {
    "s%C1\t%0,%2,%3",
    "s%C1i\t%0,%2,%G3",
  };
  return strings_92[which_alternative];
}

char * const insn_template[] =
  {
    "addf\t%0,%1,%2",
    "addd\t%0,%1,%2",
    "subf\t%0,%1,%2",
    "subd\t%0,%1,%2",
    "multf\t%0,%1,%2",
    "multd\t%0,%1,%2",
    "divf\t%0,%1,%2",
    "divd\t%0,%1,%2",
    0,
    0,
    0,
    0,
    0,
    "sub\t%0,r0,%1",
    "movi2fp\t%2,r0\n\tcvti2f\t%2,%2\n\tsubf\t%0,%2,%1",
    "movi2fp\t%2,r0\n\tcvti2d\t%2,%2\n\tsubd\t%0,%2,%1",
    "xori\t%0,%1,0x00ff",
    "xori\t%0,%1,0xffff",
    "sub\t%0,r0,%1\n\tsubi\t%0,%0,1",
    0,
    0,
    0,
    "addi\tr29,r29,-8\n\
\tsw\t(r29),%1\n\
\tsw\t4(r29),%2\n\
\tjal\t_mult\n\
\tnop\t; delay slot nop\n\
\taddi\tr29,r29,8\n\
\tadd\t%0,r0,r1",
    "addi\tr29,r29,-8\n\
\tsw\t(r29),%1\n\
\tsw\t4(r29),%2\n\
\tjal\t_div\n\
\tnop\t; delay slot nop\n\
\taddi\tr29,r29,8\n\
\tadd\t%0,r0,r1",
    "addi\tr29,r29,-8\n\
\tsw\t(r29),%1\n\
\tsw\t4(r29),%2\n\
\tjal\t_divu\n\
\tnop\t; delay slot nop\n\
\taddi\tr29,r29,8\n\
\tadd\t%0,r0,r1",
    "movi2fp\t%0,%1\n\tcvti2f\t%0,%0",
    "movi2fp\t%0,%1\n\tcvti2d\t%0,%0",
    "cvtf2i\t%2,%1\n\tmovfp2i\t%0,%2\n",
    "cvtd2i\t%2,%1\n\tmovfp2i\t%0,%2\n",
    "cvtd2f\t%0,%1",
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    "slli\t%0,%1,24\n\tsrai\t%0,%0,24\n\tandi\t%0,%0,0xffff",
    "cvtf2d\t%0,%1",
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    "nop",
    "jr\t%0%(",
    0,
    0,
    "jal\t%S0%(",
    "jalr\t%1%(",
    "jalr\t%0%(",
    "jal\t%S0%(",
    "jal\t%S0%(",
    "jal\t%S0%(",
    "jal\t%S0%(",
    "jal\t%S0%(\n",
    "jal\t%S0%(",
    "jr\t%0%(",
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    "beqz\t%0,%1%(",
    "bnez\t%0,%1%(",
    "bfpt\t%1%(",
    "bfpf\t%1%(",
    0,
    "%C1f\t%2,%3",
    "%C1d\t%2,%3",
  };

char *(*const insn_outfun[])() =
  {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    output_8,
    output_9,
    output_10,
    output_11,
    output_12,
    0,
    0,
    0,
    0,
    0,
    0,
    output_19,
    output_20,
    output_21,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    output_30,
    output_31,
    output_32,
    output_33,
    output_34,
    output_35,
    output_36,
    output_37,
    0,
    0,
    0,
    output_41,
    0,
    output_43,
    0,
    output_45,
    0,
    output_47,
    0,
    output_49,
    0,
    0,
    output_52,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    output_92,
    0,
    0,
  };

rtx (*const insn_gen_function[]) () =
  {
    gen_addsf3,
    gen_adddf3,
    gen_subsf3,
    gen_subdf3,
    gen_mulsf3,
    gen_muldf3,
    gen_divsf3,
    gen_divdf3,
    gen_addsi3,
    gen_subsi3,
    gen_andsi3,
    gen_iorsi3,
    gen_xorsi3,
    gen_negsi2,
    gen_negsf2,
    gen_negdf2,
    gen_one_cmplqi2,
    gen_one_cmplhi2,
    gen_one_cmplsi2,
    gen_ashlsi3,
    gen_ashrsi3,
    gen_lshrsi3,
    gen_mulsi3,
    gen_divsi3,
    gen_udivsi3,
    gen_floatsisf2,
    gen_floatsidf2,
    gen_fix_truncsfsi2,
    gen_fix_truncdfsi2,
    gen_truncdfsf2,
    gen_truncsihi2,
    gen_truncsiqi2,
    gen_trunchiqi2,
    gen_zero_extendqihi2,
    gen_zero_extendhisi2,
    gen_zero_extendqisi2,
    gen_extendqisi2,
    gen_extendhisi2,
    gen_extendqihi2,
    gen_extendsfdf2,
    gen_movsi,
    gen_movsi_general,
    gen_movhi,
    gen_movhi_general,
    gen_movqi,
    gen_movqi_general,
    gen_movsf,
    gen_movsf_general,
    gen_movdf,
    gen_movdf_general,
    gen_nop,
    gen_indirect_jump,
    gen_jump,
    gen_call_value,
    gen_call,
    gen_call_value_indirect,
    gen_call_indirect,
    gen_call_val_internal_return_r1,
    gen_call_val_internal_return_r1_halfword,
    gen_call_val_internal_return_r1_quarterword,
    gen_call_val_internal_return_f0_float,
    gen_call_val_internal_return_f0f1,
    gen_call_val_internal_no_return,
    gen_tablejump,
    gen_cmpsi,
    gen_tstsi,
    gen_cmpdf,
    gen_cmpsf,
    gen_beq,
    gen_bne,
    gen_blt,
    gen_bgt,
    gen_ble,
    gen_bge,
    gen_bltu,
    gen_bgtu,
    gen_bleu,
    gen_bgeu,
    gen_seq,
    gen_sne,
    gen_slt,
    gen_sgt,
    gen_sle,
    gen_sge,
    gen_sltu,
    gen_sgtu,
    gen_sleu,
    gen_sgeu,
    gen_int_cond_branch,
    gen_int_cond_branch_rev,
    gen_fp_cond_branch,
    gen_fp_cond_branch_rev,
    gen_set_internal,
    0,
    0,
  };

char *insn_name[] =
  {
    "addsf3",
    "adddf3",
    "subsf3",
    "subdf3",
    "mulsf3",
    "muldf3",
    "divsf3",
    "divdf3",
    "addsi3",
    "subsi3",
    "andsi3",
    "iorsi3",
    "xorsi3",
    "negsi2",
    "negsf2",
    "negdf2",
    "one_cmplqi2",
    "one_cmplhi2",
    "one_cmplsi2",
    "ashlsi3",
    "ashrsi3",
    "lshrsi3",
    "mulsi3",
    "divsi3",
    "udivsi3",
    "floatsisf2",
    "floatsidf2",
    "fix_truncsfsi2",
    "fix_truncdfsi2",
    "truncdfsf2",
    "truncsihi2",
    "truncsiqi2",
    "trunchiqi2",
    "zero_extendqihi2",
    "zero_extendhisi2",
    "zero_extendqisi2",
    "extendqisi2",
    "extendhisi2",
    "extendqihi2",
    "extendsfdf2",
    "movsi",
    "movsi_general",
    "movhi",
    "movhi_general",
    "movqi",
    "movqi_general",
    "movsf",
    "movsf_general",
    "movdf",
    "movdf_general",
    "nop",
    "indirect_jump",
    "jump",
    "call_value",
    "call",
    "call_value_indirect",
    "call_indirect",
    "call_val_internal_return_r1",
    "call_val_internal_return_r1_halfword",
    "call_val_internal_return_r1_quarterword",
    "call_val_internal_return_f0_float",
    "call_val_internal_return_f0f1",
    "call_val_internal_no_return",
    "tablejump",
    "cmpsi",
    "tstsi",
    "cmpdf",
    "cmpsf",
    "beq",
    "bne",
    "blt",
    "bgt",
    "ble",
    "bge",
    "bltu",
    "bgtu",
    "bleu",
    "bgeu",
    "seq",
    "sne",
    "slt",
    "sgt",
    "sle",
    "sge",
    "sltu",
    "sgtu",
    "sleu",
    "sgeu",
    "int_cond_branch",
    "int_cond_branch_rev",
    "fp_cond_branch",
    "fp_cond_branch_rev",
    "set_internal",
    "set_internal+1",
    "set_internal+2",
  };
char **insn_name_ptr = insn_name;

const int insn_n_operands[] =
  {
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    2,
    3,
    3,
    2,
    2,
    2,
    3,
    3,
    3,
    3,
    3,
    3,
    2,
    2,
    3,
    3,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    0,
    1,
    0,
    3,
    2,
    3,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    1,
    2,
    1,
    2,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    4,
    4,
    4,
  };

const int insn_n_dups[] =
  {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  };

char *const insn_operand_constraint[][MAX_RECOG_OPERANDS] =
  {
    { "=f", "%f", "f", },
    { "=f", "%f", "f", },
    { "=f", "f", "f", },
    { "=f", "f", "f", },
    { "=f", "%f", "f", },
    { "=f", "%f", "f", },
    { "=f", "f", "f", },
    { "=f", "f", "f", },
    { "=d,d,d", "%d,d,d", "d,I,L", },
    { "=d,d,d", "d,d,d", "d,I,L", },
    { "=d,d", "%d,d", "d,L", },
    { "=d,d", "%d,d", "d,L", },
    { "=d,d", "%d,d", "d,L", },
    { "=d", "d", },
    { "=f", "f", "=&f", },
    { "=f", "f", "=&f", },
    { "=d", "d", },
    { "=d", "d", },
    { "=d", "d", },
    { "=d,d", "d,d", "d,I", },
    { "=d,d", "d,d", "d,I", },
    { "=d,d", "d,d", "d,I", },
    { "=d", "d", "d", },
    { "=d", "d", "d", },
    { "=d", "d", "d", },
    { "=f", "d", },
    { "=f", "d", },
    { "=d", "+f", "=&f", },
    { "=d", "+f", "=&f", },
    { "=f", "f", },
    { "=d,m", "d,d", },
    { "=d,m", "d,d", },
    { "=d,m", "d,d", },
    { "=d,d", "d,m", },
    { "=d,d", "d,m", },
    { "=d,d", "d,m", },
    { "=d,d", "d,m", },
    { "=d,d", "d,m", },
    { "=d", "d", },
    { "=f", "f", },
    { "", "", },
    { "=d,d,d,d,m,df", "I,L,i,m,d,df", },
    { "", "", },
    { "=d,d,m,d", "i,m,d,d", },
    { "", "", },
    { "=d,d,m,d", "i,m,d,d", },
    { "", "", },
    { "=f,m,df", "m,f,df", },
    { "", "", },
    { "=f,m,f", "m,f,f", },
    { 0 },
    { "d", },
    { 0 },
    { "=df", "", "i", },
    { "", "i", },
    { "=df", "d", "i", },
    { "d", "i", },
    { "", "i", },
    { "", "i", },
    { "", "i", },
    { "", "i", },
    { "", "i", },
    { "", "i", },
    { "d", },
    { "d", "dI", },
    { "d", },
    { "f", "f", },
    { "f", "f", },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { "=d", },
    { "=d", },
    { "=d", },
    { "=d", },
    { "=d", },
    { "=d", },
    { "=d", },
    { "=d", },
    { "=d", },
    { "=d", },
    { "d", },
    { "d", },
    { "z", },
    { "z", },
    { "=d,d", "", "d,d", "d,I", },
    { "=z", "", "f", "f", },
    { "=z", "", "f", "f", },
  };

const enum machine_mode insn_operand_mode[][MAX_RECOG_OPERANDS] =
  {
    { SFmode, SFmode, SFmode, },
    { DFmode, DFmode, DFmode, },
    { SFmode, SFmode, SFmode, },
    { DFmode, DFmode, DFmode, },
    { SFmode, SFmode, SFmode, },
    { DFmode, DFmode, DFmode, },
    { SFmode, SFmode, SFmode, },
    { DFmode, DFmode, DFmode, },
    { SImode, SImode, SImode, },
    { SImode, SImode, SImode, },
    { SImode, SImode, SImode, },
    { SImode, SImode, SImode, },
    { SImode, SImode, SImode, },
    { SImode, SImode, },
    { SFmode, SFmode, SFmode, },
    { DFmode, DFmode, DFmode, },
    { QImode, QImode, },
    { HImode, HImode, },
    { SImode, SImode, },
    { SImode, SImode, SImode, },
    { SImode, SImode, SImode, },
    { SImode, SImode, SImode, },
    { SImode, SImode, SImode, },
    { SImode, SImode, SImode, },
    { SImode, SImode, SImode, },
    { SFmode, SImode, },
    { DFmode, SImode, },
    { SImode, SFmode, SFmode, },
    { SImode, DFmode, DFmode, },
    { SFmode, DFmode, },
    { HImode, SImode, },
    { QImode, SImode, },
    { QImode, HImode, },
    { HImode, QImode, },
    { SImode, HImode, },
    { SImode, QImode, },
    { SImode, QImode, },
    { SImode, HImode, },
    { HImode, QImode, },
    { DFmode, SFmode, },
    { SImode, SImode, },
    { SImode, SImode, },
    { HImode, HImode, },
    { HImode, HImode, },
    { QImode, QImode, },
    { QImode, QImode, },
    { SFmode, SFmode, },
    { SFmode, SFmode, },
    { DFmode, DFmode, },
    { DFmode, DFmode, },
    { VOIDmode },
    { SImode, },
    { VOIDmode },
    { VOIDmode, VOIDmode, VOIDmode, },
    { VOIDmode, VOIDmode, },
    { VOIDmode, VOIDmode, VOIDmode, },
    { VOIDmode, VOIDmode, },
    { VOIDmode, VOIDmode, },
    { VOIDmode, VOIDmode, },
    { VOIDmode, VOIDmode, },
    { VOIDmode, VOIDmode, },
    { VOIDmode, VOIDmode, },
    { VOIDmode, VOIDmode, },
    { SImode, },
    { SImode, SImode, },
    { SImode, },
    { DFmode, DFmode, },
    { SFmode, SFmode, },
    { VOIDmode },
    { VOIDmode },
    { VOIDmode },
    { VOIDmode },
    { VOIDmode },
    { VOIDmode },
    { VOIDmode },
    { VOIDmode },
    { VOIDmode },
    { VOIDmode },
    { SImode, },
    { SImode, },
    { SImode, },
    { SImode, },
    { SImode, },
    { SImode, },
    { SImode, },
    { SImode, },
    { SImode, },
    { SImode, },
    { SImode, },
    { SImode, },
    { CCFPmode, },
    { CCFPmode, },
    { SImode, SImode, SImode, SImode, },
    { CCFPmode, SFmode, SFmode, SFmode, },
    { CCFPmode, DFmode, DFmode, DFmode, },
  };

const char insn_operand_strict_low[][MAX_RECOG_OPERANDS] =
  {
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, 0, },
    { 0, 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0 },
    { 0, },
    { 0 },
    { 0, 0, 0, },
    { 0, 0, },
    { 0, 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, 0, },
    { 0, },
    { 0, 0, },
    { 0, },
    { 0, 0, },
    { 0, 0, },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0, },
    { 0, },
    { 0, },
    { 0, },
    { 0, },
    { 0, },
    { 0, },
    { 0, },
    { 0, },
    { 0, },
    { 0, },
    { 0, },
    { 0, },
    { 0, },
    { 0, 0, 0, 0, },
    { 0, 0, 0, 0, },
    { 0, 0, 0, 0, },
  };

extern int register_operand ();
extern int nonmemory_operand ();
extern int scratch_operand ();
extern int general_operand ();
extern int nonimmediate_operand ();
extern int sym_ref_mem_operand ();
extern int comparison_operator ();
extern int signed_comparison_operator ();

int (*const insn_operand_predicate[][MAX_RECOG_OPERANDS])() =
  {
    { register_operand, register_operand, register_operand, },
    { register_operand, register_operand, register_operand, },
    { register_operand, register_operand, register_operand, },
    { register_operand, register_operand, register_operand, },
    { register_operand, register_operand, register_operand, },
    { register_operand, register_operand, register_operand, },
    { register_operand, register_operand, register_operand, },
    { register_operand, register_operand, register_operand, },
    { register_operand, register_operand, nonmemory_operand, },
    { register_operand, register_operand, nonmemory_operand, },
    { register_operand, register_operand, nonmemory_operand, },
    { register_operand, register_operand, nonmemory_operand, },
    { register_operand, register_operand, nonmemory_operand, },
    { register_operand, register_operand, },
    { register_operand, register_operand, scratch_operand, },
    { register_operand, register_operand, scratch_operand, },
    { register_operand, register_operand, },
    { register_operand, register_operand, },
    { register_operand, register_operand, },
    { register_operand, register_operand, nonmemory_operand, },
    { register_operand, register_operand, nonmemory_operand, },
    { register_operand, register_operand, nonmemory_operand, },
    { register_operand, register_operand, register_operand, },
    { register_operand, register_operand, register_operand, },
    { register_operand, register_operand, register_operand, },
    { register_operand, register_operand, },
    { register_operand, register_operand, },
    { register_operand, register_operand, scratch_operand, },
    { register_operand, register_operand, scratch_operand, },
    { register_operand, register_operand, },
    { general_operand, register_operand, },
    { general_operand, register_operand, },
    { general_operand, register_operand, },
    { register_operand, general_operand, },
    { register_operand, general_operand, },
    { register_operand, general_operand, },
    { register_operand, general_operand, },
    { register_operand, general_operand, },
    { register_operand, register_operand, },
    { register_operand, register_operand, },
    { nonimmediate_operand, general_operand, },
    { general_operand, general_operand, },
    { nonimmediate_operand, general_operand, },
    { general_operand, general_operand, },
    { nonimmediate_operand, general_operand, },
    { general_operand, general_operand, },
    { nonimmediate_operand, general_operand, },
    { general_operand, general_operand, },
    { nonimmediate_operand, general_operand, },
    { general_operand, general_operand, },
    { 0 },
    { register_operand, },
    { 0 },
    { register_operand, sym_ref_mem_operand, 0, },
    { sym_ref_mem_operand, 0, },
    { register_operand, register_operand, 0, },
    { register_operand, 0, },
    { sym_ref_mem_operand, 0, },
    { sym_ref_mem_operand, 0, },
    { sym_ref_mem_operand, 0, },
    { sym_ref_mem_operand, 0, },
    { sym_ref_mem_operand, 0, },
    { sym_ref_mem_operand, 0, },
    { register_operand, },
    { register_operand, nonmemory_operand, },
    { register_operand, },
    { register_operand, register_operand, },
    { register_operand, register_operand, },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { 0 },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, },
    { register_operand, comparison_operator, register_operand, nonmemory_operand, },
    { register_operand, signed_comparison_operator, register_operand, register_operand, },
    { register_operand, signed_comparison_operator, register_operand, register_operand, },
  };

const int insn_n_alternatives[] =
  {
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    3,
    3,
    2,
    2,
    2,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    2,
    2,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    1,
    1,
    0,
    6,
    0,
    4,
    0,
    4,
    0,
    3,
    0,
    3,
    0,
    1,
    0,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    1,
    1,
  };
