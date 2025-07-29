/* Generated automatically by the program `genattrtab'
from the machine description file `md'.  */

#include "config.h"
#include "rtl.h"
#include "insn-config.h"
#include "recog.h"
#include "regs.h"
#include "real.h"
#include "output.h"
#include "insn-attr.h"

#define operands recog_operand

int
insn_current_length (insn)
     rtx insn;
{
  switch (recog_memoized (insn))
    {
    case -1:
      if (GET_CODE (PATTERN (insn)) != ASM_INPUT
          && asm_noperands (PATTERN (insn)) < 0)
        fatal_insn_not_found (insn);
    default:
      return 0;

    }
}

int
insn_variable_length_p (insn)
     rtx insn;
{
  switch (recog_memoized (insn))
    {
    case -1:
      if (GET_CODE (PATTERN (insn)) != ASM_INPUT
          && asm_noperands (PATTERN (insn)) < 0)
        fatal_insn_not_found (insn);
    default:
      return 0;

    }
}

int
insn_default_length (insn)
     rtx insn;
{
  switch (recog_memoized (insn))
    {
    case 41:
      insn_extract (insn);
      if (! constrain_operands (INSN_CODE (insn), reload_completed))
        fatal_insn_not_found (insn);
      if ((which_alternative == 0) || (which_alternative == 1))
        {
	  return 1;
        }
      else if (which_alternative == 2)
        {
	  return 2;
        }
      else if ((which_alternative == 3) || (which_alternative == 4))
        {
	  return 1;
        }
      else
        {
	  return 1;
        }

    case 38:
    case 15:
    case 14:
      return 3;

    case 37:
    case 36:
      insn_extract (insn);
      if (! constrain_operands (INSN_CODE (insn), reload_completed))
        fatal_insn_not_found (insn);
      if (which_alternative == 0)
        {
	  return 2;
        }
      else
        {
	  return 1;
        }

    case 30:
    case 28:
    case 27:
    case 26:
    case 25:
    case 18:
      return 2;

    case 24:
    case 23:
    case 22:
      return 7;

    case -1:
      if (GET_CODE (PATTERN (insn)) != ASM_INPUT
          && asm_noperands (PATTERN (insn)) < 0)
        fatal_insn_not_found (insn);
    default:
      return 1;

    }
}

int
num_delay_slots (insn)
     rtx insn;
{
  switch (recog_memoized (insn))
    {
    case 91:
    case 90:
    case 89:
    case 88:
    case 63:
    case 62:
    case 61:
    case 60:
    case 59:
    case 58:
    case 57:
    case 56:
    case 55:
    case 54:
    case 52:
    case 51:
      return 1;

    case -1:
      if (GET_CODE (PATTERN (insn)) != ASM_INPUT
          && asm_noperands (PATTERN (insn)) < 0)
        fatal_insn_not_found (insn);
    default:
      return 0;

    }
}

enum attr_mode
get_attr_mode (insn)
     rtx insn;
{
  switch (recog_memoized (insn))
    {
    case 1:
    case 3:
    case 5:
    case 7:
    case 15:
    case 26:
    case 28:
    case 39:
    case 49:
    case 94:
      return MODE_DF;

    case 0:
    case 2:
    case 4:
    case 6:
    case 14:
    case 25:
    case 27:
    case 29:
    case 47:
    case 90:
    case 91:
    case 93:
      return MODE_SF;

    case 30:
    case 33:
    case 38:
    case 43:
      return MODE_HI;

    case 31:
    case 32:
    case 45:
      return MODE_QI;

    case 50:
    case 51:
    case 52:
    case 54:
    case 55:
    case 56:
    case 57:
    case 58:
    case 59:
    case 60:
    case 61:
    case 62:
    case 63:
      return MODE_NONE;

    case -1:
      if (GET_CODE (PATTERN (insn)) != ASM_INPUT
          && asm_noperands (PATTERN (insn)) < 0)
        fatal_insn_not_found (insn);
      return MODE_UNKNOWN;

    default:
      return MODE_SI;

    }
}

enum attr_type
get_attr_type (insn)
     rtx insn;
{
  switch (recog_memoized (insn))
    {
    case 41:
      insn_extract (insn);
      if (! constrain_operands (INSN_CODE (insn), reload_completed))
        fatal_insn_not_found (insn);
      if ((which_alternative == 0) || ((which_alternative == 1) || (which_alternative == 2)))
        {
	  return TYPE_MOVE;
        }
      else if (which_alternative == 3)
        {
	  return TYPE_LOAD;
        }
      else if (which_alternative == 4)
        {
	  return TYPE_STORE;
        }
      else
        {
	  return TYPE_MOVE;
        }

    case 30:
    case 31:
    case 32:
      insn_extract (insn);
      if (! constrain_operands (INSN_CODE (insn), reload_completed))
        fatal_insn_not_found (insn);
      if (which_alternative == 0)
        {
	  return TYPE_ALU;
        }
      else
        {
	  return TYPE_STORE;
        }

    case 33:
    case 34:
    case 35:
    case 36:
    case 37:
      insn_extract (insn);
      if (! constrain_operands (INSN_CODE (insn), reload_completed))
        fatal_insn_not_found (insn);
      if (which_alternative == 0)
        {
	  return TYPE_ALU;
        }
      else
        {
	  return TYPE_LOAD;
        }

    case 43:
    case 45:
      insn_extract (insn);
      if (! constrain_operands (INSN_CODE (insn), reload_completed))
        fatal_insn_not_found (insn);
      if (which_alternative == 0)
        {
	  return TYPE_MOVE;
        }
      else if (which_alternative == 1)
        {
	  return TYPE_LOAD;
        }
      else if (which_alternative == 2)
        {
	  return TYPE_STORE;
        }
      else
        {
	  return TYPE_MOVE;
        }

    case 47:
    case 49:
      insn_extract (insn);
      if (! constrain_operands (INSN_CODE (insn), reload_completed))
        fatal_insn_not_found (insn);
      if (which_alternative == 0)
        {
	  return TYPE_LOAD;
        }
      else if (which_alternative == 1)
        {
	  return TYPE_STORE;
        }
      else
        {
	  return TYPE_MOVE;
        }

    case 51:
    case 52:
    case 54:
    case 55:
    case 56:
    case 57:
    case 58:
    case 59:
    case 60:
    case 61:
    case 62:
    case 63:
      return TYPE_JUMP;

    case 88:
    case 89:
    case 90:
    case 91:
      return TYPE_BRANCH;

    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 19:
    case 20:
    case 21:
    case 38:
    case 50:
    case 92:
      return TYPE_ALU;

    case -1:
      if (GET_CODE (PATTERN (insn)) != ASM_INPUT
          && asm_noperands (PATTERN (insn)) < 0)
        fatal_insn_not_found (insn);
      return TYPE_UNKNOWN;

    default:
      return TYPE_FP;

    }
}

int
eligible_for_delay (delay_insn, slot, candidate_insn, flags)
     rtx delay_insn;
     int slot;
     rtx candidate_insn;
     int flags;
{
  rtx insn;

  if (slot >= 1)
    abort ();

  insn = candidate_insn;
  switch (recog_memoized (insn))
    {
    case -1:
      if (GET_CODE (PATTERN (insn)) != ASM_INPUT
          && asm_noperands (PATTERN (insn)) < 0)
        fatal_insn_not_found (insn);
    default:
      return 0;

    }
}

int
const_num_delay_slots (insn)
     rtx insn;
{
  switch (recog_memoized (insn))
    {
    default:
      return 1;
    }
}
