/*
 *  A DLX Machine Description for GCC 2.x (Support Routines)
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

#include "config.h"             /* really xm-dlx.h */
#include "rtl.h"
#include "regs.h"
#include "flags.h"
#include "tree.h"
#include "hard-reg-set.h"

extern int target_flags;

#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define REG_NEEDS_SAVE(i) (regs_ever_live[i] && !(call_used_regs[i])&&i!=1)

char *
get_function_name()
{
  char *kind = "function";
  if (current_function_decl != 0
      && TREE_CODE (TREE_TYPE (current_function_decl)) == METHOD_TYPE)
    kind = "method";
  
  if (current_function_decl == NULL)
    {
      return "top level";
    }
  else
    {
      char *name = (*decl_printable_name) (current_function_decl, &kind);
      return name;
    }
}

/* from mips.c */
/* Abort after printing out a specific insn.  */

void
abort_with_insn (insn, reason)
     rtx insn;
     char *reason;
{
  error (reason);
  debug_rtx (insn);
  abort ();
}

void
oops_message(str)
     char *str;
{
  fputs(str,stderr);
}

/*
 * for holding comparison operands.
 */
rtx dlx_compare_op0, dlx_compare_op1;
enum machine_mode dlx_compare_mode;


int hard_regno_mode_ok_func(regno,mode)
     int regno,mode;
{
  /* modes that require multiple registers we choose to 
     always put in an even/odd pair. This is required on
     the FP side but not on the integer. We do it there anyway
     just to make things easier.
   */
  if(GET_MODE_SIZE(mode) > UNITS_PER_WORD &&
     (regno&1 != 0)) return 0;

  /* int mode, int register */
  if(INTEGRAL_MODE_P(mode) && 
     regno >= FIRST_INT_REG && regno <= LAST_INT_REG) return 1;

  /* float mode and float register */
  if(FLOAT_MODE_P(mode) &&
     regno >= FIRST_FP_REG && regno <= LAST_FP_REG) return 1;

  /* allow float values in int regs. */
/*  if(mode == SFmode && regno <= LAST_INT_REG) return 1; */

  return 0;
}


int reg_class_from_letter(chr)
     int chr;
{
  switch(chr)
    {
    case 'd':
      return GR_REGS;
    case 'f':
      return FP_REGS;
    case 'z':
      return ST_REGS;
    default:
      return NO_REGS;
    }
}

int
print_operand(stream,x,letter)
     FILE *stream;
     rtx x;
     int letter;
{
  int code;

  if(PRINT_OPERAND_PUNCT_VALID_P(letter))
    {
      switch(letter)
        {
        case '%':
          putc('%',stream);
          break;
        case '(':
          /* no instructions have been found to fill the slot,
             or we are not optimizing. */
          if(dbr_sequence_length() == 0)
            {
              if(!optimize)
                fputs("\n\tnop\t; delay slot nop",stream);
              else
                fputs("\n\tnop\t; not filled.", stream);
            }
          else
            {
              fputs("\n\t\t;; filled delay slot:",stream);
            }
          break;
        }
      return;
    }
  if(!x)
    {
      error("PRINT_OPERAND x==NULL");
      return;
    }
  code = GET_CODE(x);

  if(letter == 'C')
    { /* conditional */
      switch(code)
        {
        case EQ:        fputs("eq",stream); break;
        case NE:        fputs("ne",stream); break;
        case GT:        fputs("gt",stream); break;
        case GE:        fputs("ge",stream); break;
        case LT:        fputs("lt",stream); break;
        case LE:        fputs("le",stream); break;
        case GTU:       fputs("gtu",stream); break;
        case GEU:       fputs("geu",stream); break;
        case LTU:       fputs("ltu",stream); break;
        case LEU:       fputs("leu",stream); break;

        default:
          abort_with_insn (x, "PRINT_OPERAND, illegal insn for %%C");
        }
    }
  else if(letter == 'N')
    { /* reverse conditional */
      switch(code)
        {
        case EQ:        fputs("ne",stream); break;
        case NE:        fputs("eq",stream); break;
        case GT:        fputs("le",stream); break;
        case GE:        fputs("lt",stream); break;
        case LT:        fputs("ge",stream); break;
        case LE:        fputs("gt",stream); break;
        case GTU:       fputs("leu",stream); break;
        case GEU:       fputs("ltu",stream); break;
        case LTU:       fputs("geu",stream); break;
        case LEU:       fputs("gtu",stream); break;

        default:
          abort_with_insn (x, "PRINT_OPERAND, illegal insn for %%N");
        }
    }
  else if(letter == 'H') /* print upper 16 bits. */
    { 
      int iv = ((unsigned)(INTVAL(x))>>16)&0xffff;
      if(iv > 0x7fff) iv |= ((-1) ^ 0xffff);
      fprintf(stream,"%d",iv);
    }
  else if(letter == 'L') /* print lower 16 bits. */
    { 
      int iv = INTVAL(x)&0xffff;
      /* if(iv > 0x7fff) iv |= ((-1) ^ 0xffff); */
      fprintf(stream,"%d",iv);
    }
  else if(letter == 'S') /* print SYMBOL_REF */
    {
      assemble_name(stream,XSTR(XEXP(x,0),0));
    }
  else if(code == REG)
    {
      int regnum = REGNO(x);
      if(regnum != FP_STATUS_REG)       /* don't print this one. */
        fputs(reg_names[regnum],stream);
    }
  else if(letter == 'U') /* Unsigned int */
    {
      unsigned int iv = (unsigned)(INTVAL(x));
      iv &= 0xffff;
      fprintf(stream,"%d",iv);
    }
  else if(letter == 'G') /* siGned int */
    {
      int iv = INTVAL(x);
      fprintf(stream,"%d",iv);
    }
  else if(code == CONST_INT)
    {
      fprintf(stream,"0x%x",(INTVAL(x))&0xffff);
    }
  else if(code == MEM)
    {
      rtx adr = XEXP(x, 0);
      code = GET_CODE(adr);
      switch(code)
        {
        case REG:
          fprintf(stream,"(%s)",reg_names[REGNO(adr)]);
          break;
        case PLUS:
          { rtx reg,offs;
            reg = XEXP(adr,0);
            offs = XEXP(adr,1);
            if(GET_CODE(reg) != REG)
              {
                reg = XEXP(adr,1);
                offs = XEXP(adr,0);
              }
            if(GET_CODE(reg) != REG || GET_CODE(offs) != CONST_INT)
              {
                abort_with_insn (x, "PRINT_OPERAND, Can't figure out adr.");
              }
            fprintf(stream,"%d(%s)",INTVAL(offs),reg_names[REGNO(reg)]);
            break;
          }
        case CONST_INT:
          fprintf(stream,"%d(r0)",INTVAL(adr));
          break;
                
        default:
          output_address(stream,x);
          break;
        }
    }
  else
    {
      output_addr_const(stream,x);
    }
}

int
print_operand_address(stream,x)
     FILE *stream;
     rtx x;
{
  if (!x)
    {
      error("PRINT_OPERAND_ADDRESS, null pointer");
    }
  else
    {
      switch(GET_CODE(x))
        {
        case SYMBOL_REF:
          fputs(XSTR(x,0),stream);
          break;
        default:
          abort_with_insn(x,"PRINT_OPERAND_ADDRESS, illegal insn #1");
          break;
        }
    }
      
}

int
print_operand_punct_valid_p(code)
     int code;
{
  switch(code)
    {
    case '(':   /* idea taken from sparc; output nop for %( if
                   not optimizing or the slot is not filled. */
    case '%': 
      return 1;
    }
  return 0;
}

int
sym_ref_mem_operand(op, mode)
     register rtx op;
     enum machine_mode mode;
{
  if(GET_CODE(op) == MEM)
    {
      rtx t1 = XEXP(op, 0);
      if(GET_CODE(t1) == SYMBOL_REF)
        {
          return 1;
        }
    }
  return 0;
}
     
int
signed_comparison_operator (op, mode)
    register rtx op;
    enum machine_mode mode;
{
  if(mode == VOIDmode || GET_MODE (op) == mode)
    {
      switch(GET_CODE(op))
        {
        case EQ:
        case NE:
        case LT:
        case LE:
        case GE:
        case GT:
          return 1;
        }
    }
  return 0;
}

int
gen_call_value_1(operands)
     rtx operands[];
{
  rtx result = operands[0];
  rtx func = operands[1];
  rtx stacksize = operands[2];
  int mode = GET_MODE(result);

  switch(mode)
    {
/*
 [(set (reg:SI 1)
                  (call (match_operand 0 "sym_ref_mem_operand" "")
                        (match_operand 1 "" "i")))]
*/
/*
    HImode:
    QImode:
      printf("Subreg in gcv1.\n");
      emit_call_insn(gen_rtx(SET,mode,
			     gen_rtx(SUBREG,mode,result),
			     gen_rtx(CALL,VOIDmode,func,stacksize)));
      break;
*/

    default:
      emit_call_insn(gen_rtx(PARALLEL,VOIDmode,
		       gen_rtvec(2,
				 gen_rtx(SET,mode,result,
					 gen_rtx(CALL,VOIDmode,func,
						 stacksize)),
				 gen_rtx(CLOBBER,VOIDmode,
					 gen_rtx(REG,SImode,31)))));
      break;

    }

  return 0;
}
/*
 * operands[0] will be the branch target.
 * test will be the comparison type.
 * dlx_compare_mode is SImode, SFmode, or DFmode
 * dlx_compare_op0 and dlx_compare_op1 are the things to be 
 *  compared.
 *
 * This routine has to generate a compare and a branch rtx.
 *
 */
int
gen_conditional_branch(operands, test)
     rtx operands[];
     enum rtx_code test;
{
  rtx target = operands[0];
  rtx cres;
  rtx tmp;

  switch(dlx_compare_mode)
    {
    case SFmode:
    case DFmode:
      /* floating point branch:
         Generate XXf or XXd instruction RTL,
         then generate bfpt/bfpf RTL. */
      /* We need the fp condition code register for this;
         so we just generate the RTL for the hard register.
         I tried using gen_reg_rtx(CCFPmode) but I got an 
         error (something having to do with an illegal spilled
         register). It should work fine this way anyway; there's
         no point in worrying about allocating the FP status reg
         since there is only one. */

      cres = gen_rtx(REG,CCFPmode,FP_STATUS_REG);

      /* Ensure both operands of the compare are in registers. */
      if(GET_CODE(dlx_compare_op0) != REG)
        dlx_compare_op0 = force_reg(dlx_compare_mode,dlx_compare_op0);

      if(GET_CODE(dlx_compare_op1) != REG)
        dlx_compare_op1 = force_reg(dlx_compare_mode,dlx_compare_op1);

      /* generate the compare */
      emit_insn(gen_rtx(SET,CCFPmode,cres,
                       gen_rtx(test,dlx_compare_mode,
                               dlx_compare_op0,dlx_compare_op1)));

      /* generate the branch. */
      emit_jump_insn(gen_rtx(SET,VOIDmode,pc_rtx,
                             gen_rtx(IF_THEN_ELSE,VOIDmode,
                                     gen_rtx(NE,CCFPmode,cres,const0_rtx),
                                     gen_rtx(LABEL_REF,VOIDmode,operands[0]),
                                     pc_rtx)));
      break;
    case SImode:
      /* generate a sXX instruction. */
      /* RTX is:
  (set (match_operand:SI 0 "register_operand" "=d,d")
         (eq:SI (match_operand:SI 1 "register_operand" "d,d")
                (match_operand:SI 2 "nonmemory_operand" "d,I")))
       */
      /* ok, we need a pseudo register to store the 
         comparison result in: */
      cres = gen_reg_rtx(SImode);

      /* check if operand 1 is an integer that is too big;
         move it into a register if it is. */
      if(GET_CODE(dlx_compare_op1) == CONST_INT)
        {
          int c = INTVAL(dlx_compare_op1);
          if(c+0x10000 > 0x20000)
            {
              dlx_compare_op1 = force_reg(SImode, dlx_compare_op1);
            }
        }

      /* emit the set instruction. */
      tmp = gen_rtx( SET, SImode, cres, 
                         gen_rtx(test, SImode, 
                                 dlx_compare_op0, dlx_compare_op1));
      emit_insn( tmp);
  
/*
  [(set (pc) (if_then_else (eq:SI (const_int 0)
                                  (match_operand:SI 0 "register_operand"))
                           (label_ref (match_operand 1 "" "")) (pc)))]
*/
      /* emit the branch instruction. */
      tmp = gen_rtx(SET, VOIDmode, 
                              pc_rtx, 
                              gen_rtx(IF_THEN_ELSE, VOIDmode,
                                      gen_rtx(NE, SImode, const0_rtx,
                                              cres),
                                      gen_rtx(LABEL_REF,VOIDmode,operands[0]), 
                                      pc_rtx));
      emit_jump_insn( tmp);
      break;
    }

}

/*
 * Set up stack and frame pointers, and prepare
 * for function entry.
 *
 * Stack map:
 *
 * incoming args
 *                      <--------------------------- new frame pointer
 * saved frame pointer          4 bytes
 * saved return addr            4 bytes
 *
 * local variables:             size rounded up to a multiple of 4.
 *
 * save caller regs area        (4*n_regs_to_save)
 * 
 *
 */

/*
 * Used for internal labels.
 * Characters not in [a-zA-Z0-9] are mapped to "_".
 */
static char fn_minus_ext_buf[200];

char *
fn_minus_ext()
{
  char *x;
  if(main_input_filename == NULL) return "";
  strcpy(fn_minus_ext_buf,main_input_filename);
  x = strrchr(fn_minus_ext_buf,'.');
  if(x != NULL) *x = '\0';

  for(x = fn_minus_ext_buf ; *x ; x++) {
    if(!isalnum(*x)) *x = '_';
  }
  return fn_minus_ext_buf;
}

asm_output_ascii(FILE *stream, unsigned char *ptr, int len)
{ 
  int i,p;
  unsigned int c;
  fputs("\t.ascii \"",stream);
  i = 0;
  p = 0;
  do 
    { 
      c = ptr[i++];
      if(c < 0x80 && isprint(c)) {
	switch(c) {
	case '\"': fputs("\\\"",stream); p+=2; break;
	case '\'': fputs("\\\'",stream); p+=2; break;
	case '\\': fputs("\\\\",stream); p+=2; break;

	default:
	  fputc(c,stream); p++;
	}
      } else {
	switch(c) {
	case '\a': fputs("\\a",stream); p+=2; break;
	case '\b': fputs("\\b",stream); p+=2; break;
	case '\f': fputs("\\f",stream); p+=2; break;
	case '\n': fputs("\\n",stream); p+=2; break;
	case '\r': fputs("\\r",stream); p+=2; break;
	case '\t': fputs("\\t",stream); p+=2; break;
	case '\v': fputs("\\v",stream); p+=2; break;
	default:
	  fprintf(stream,"\\%03o",c); 
	  p+=4; 
	  break;
	}
      }
      if(p >= 70 && i < len) {
	fputs("\"\n\t.ascii \"",stream);
	p = 0;
      }
    } while(i < len); 
  fputs("\"\n",stream);
}

function_prologue (file, size)
     FILE *file;
     int size;
{
  int reg_so;
  int local_space;
  int i;
  int stkoff;
  int n_regs_to_save;
  char *name = get_function_name();
  int is_main = 0;

  if(!strcmp("main",name)) is_main = 1;

  stkoff = 0;
  n_regs_to_save = 0;

  if(!is_main) {
    for(i = 0; i < FIRST_FP_REG ; i++)
      if(REG_NEEDS_SAVE(i)) {
	stkoff += 4;
	n_regs_to_save++;
      }
    
    for(i = FIRST_FP_REG ; i <= LAST_FP_REG ; i++) {
      if((i&1)==0 && REG_NEEDS_SAVE(i) && REG_NEEDS_SAVE(i+1)) {
	stkoff = (stkoff+7)&(~7);
	stkoff += 8;
	i++;
	n_regs_to_save+=2;
      } else if(REG_NEEDS_SAVE(i)) {
	stkoff += 4;
	n_regs_to_save++;
      }
    }
    stkoff = (stkoff+7)&(~7);
  }

  local_space = size + 8 + stkoff;

  fprintf(file,";  Function '%s'; %d bytes of locals, %d regs to save.\n",
          name,size,n_regs_to_save);

  /* 
   * Treat main specially as it needs to be a DLX entry point.
   * This means we need to set the initial stack pointer, and 
   * that we need to do an exit instead of a return at the end.
   *
   * If -mnoargs was specified, then load r29 with memSize-8,
   * otherwise assume that it is set correctly on entry to main.
   */

  if(is_main && (target_flags & 2))
    {
      fputs("\tlhi\tr29,(((memSize-8)>>16)&0xffff)\n",file);
      fputs("\taddui\tr29,r29,((memSize-8)&0xffff)\n",file);
    }
  
  fputs("\tsw\t-4(r29),r30\t; push fp\n",file);
  fputs("\tadd\tr30,r0,r29\t; fp = sp\n",file);
  fputs("\tsw\t-8(r29),r31\t; push ret addr\n",file);
  if(local_space < 0xffff)
    fprintf(file,"\tsubui\tr29,r29,%d\t; alloc local storage\n",
            local_space);
  else
    {
      unsigned int iv = (local_space>>16)&0xffff;

      /* We can get away with clobbering r1 because it will
         have the return value put into it anyway, I think. */
      fprintf(file,"\tlhi\tr1,%d\t; alloc local storage = %d\n",
              iv,local_space);
      fprintf(file,"\taddui\tr1,r1,0x%04x\n",local_space&0xffff);
      fputs("\tsubu\tr29,r29,r1\n",file);
    }

  reg_so = 0;   /* start just above the sp. */
  if(!is_main)
    {
      for(i = 0 ; i < FIRST_FP_REG ; i++)
        {
          if(REG_NEEDS_SAVE(i))
            {
              fprintf(file,"\tsw\t%d(r29),%s\n",reg_so,reg_names[i]);
              reg_so += 4;
            }
        }
      for(i = FIRST_FP_REG ; i <= LAST_FP_REG ; i++)
        {
          /* use sd whenever possible: */
          if((i&1) == 0 && REG_NEEDS_SAVE(i) && REG_NEEDS_SAVE(i+1))
            {
	      reg_so = (reg_so+7)&(~7);
              fprintf(file,"\tsd\t%d(r29),%s\n",reg_so,reg_names[i]);
              reg_so += 8;
              i++;
              continue;
            }
          else if(REG_NEEDS_SAVE(i))
            {
              fprintf(file,"\tsf\t%d(r29),%s\n",reg_so,reg_names[i]);
              reg_so += 4;
            }
        }
    }

}

int
log_of_two(int x)
{
  int y;

  x >>= 1;
  for(y=0; x; x>>=1, y++);

  return y;
}

function_epilogue (file, size)
     FILE *file;
     int size;
{
  int i;
  int reg_so;
  char *name = get_function_name();
  int is_main = 0;

  if(!strcmp("main",name)) is_main = 1;

  reg_so = 0;   /* start just above the sp. */
  if(!is_main)
    {
      for(i = 0 ; i < FIRST_FP_REG ; i++)
        {
          if(REG_NEEDS_SAVE(i))
            {
              fprintf(file,"\tlw\t%s,%d(r29)\n",reg_names[i],reg_so);
              reg_so += 4;
            }
        }
      for(i = FIRST_FP_REG ; i <= LAST_FP_REG ; i++)
        {
          /* use sd whenever possible: */
          if((i&1) == 0 && REG_NEEDS_SAVE(i) && REG_NEEDS_SAVE(i+1))
            {
	      reg_so = (reg_so+7)&(~7);
              fprintf(file,"\tld\t%s,%d(r29)\n",reg_names[i],reg_so);
              reg_so += 8;
              i++;
              continue;
            }
          else if(REG_NEEDS_SAVE(i))
            {
              fprintf(file,"\tlf\t%s,%d(r29)\n",reg_names[i],reg_so);
              reg_so += 4;
            }
        }
      
      /*
       * Restore the return address, the stack pointer, and
       * the frame pointer. The frame pointer load can go in
       * the jump delay slot.
       */
      fputs("\tlw\tr31,-8(r30)\n",file);
      fputs("\tadd\tr29,r0,r30\n",file);
      fputs("\tlw\tr30,-4(r30)\n",file);
      fputs("\tjr\tr31\n",file);
      fputs("\tnop\n", file);
    }
  else
    {
      fputs("\tjal\t_exit\n",file);
      fputs("\tnop\n",file);
    }
  fprintf(file,".endproc _%s\n",name);
}


asm_file_start(file)
     FILE *file;
{
#ifdef NO_LOADER 
  fputs(".data 0x100\n.text 0x8000\n",file);
#endif
}

struct traptab_s {
  char *name;
  int num;
} traptab[] = {
  { "_exit",   0 },
  { "_open",   1 },
  { "_close",  2 },
  { "_read",   3 },
  { "_write",  4 },
  { "_printf", 5 },
  { "_sqrt",   29 },
  { NULL,      0 }};

asm_file_end(file)
     FILE *file;
{
  int i;

#ifdef NO_LOADER
  text_section();

  i = 0;
  while(traptab[i].name != NULL)
    {
      output_trap_def(file,traptab[i].name,traptab[i].num);
      i++;
    }
#endif
}

output_trap_def(file,name,num)
     FILE *file;
     char *name;
     int num;
{
  fprintf(file,".global %s\n%s:\t",name,name);
  fprintf(file,"\ttrap\t%d\n",num);
  fputs("\tjr\tr31\n",file);
  fputs("\tnop\n\n",file);
}
