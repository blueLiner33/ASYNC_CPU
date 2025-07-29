/* Generated automatically by the program `genrecog'
from the machine description file `md'.  */

#include "config.h"
#include "rtl.h"
#include "insn-config.h"
#include "recog.h"
#include "real.h"
#include "output.h"
#include "flags.h"


/* `recog' contains a decision tree
   that recognizes whether the rtx X0 is a valid instruction.

   recog returns -1 if the rtx is not valid.
   If the rtx is valid, recog returns a nonnegative number
   which is the insn code number for the pattern that matched.
   This is the same as the order in the machine description of
   the entry that matched.  This number can be used as an index into
   entry that matched.  This number can be used as an index into various
   insn_* tables, such as insn_templates, insn_outfun, and insn_n_operands
   (found in insn-output.c).

   The third argument to recog is an optional pointer to an int.
   If present, recog will accept a pattern if it matches except for
   missing CLOBBER expressions at the end.  In that case, the value
   pointed to by the optional pointer will be set to the number of
   CLOBBERs that need to be added (it should be initialized to zero by
   the caller).  If it is set nonzero, the caller should allocate a
   PARALLEL of the appropriate size, copy the initial entries, and call
   add_clobbers (found in insn-emit.c) to fill in the CLOBBERs.*/

rtx recog_operand[MAX_RECOG_OPERANDS];

rtx *recog_operand_loc[MAX_RECOG_OPERANDS];

rtx *recog_dup_loc[MAX_DUP_OPERANDS];

char recog_dup_num[MAX_DUP_OPERANDS];

#define operands recog_operand

int
recog_1 (x0, insn, pnum_clobbers)
     register rtx x0;
     rtx insn;
     int *pnum_clobbers;
{
  register rtx *ro = &recog_operand[0];
  register rtx x1, x2, x3, x4;
  int tem;

  x1 = XEXP (x0, 0);
  switch (GET_MODE (x1))
    {
    case SFmode:
      if (register_operand (x1, SFmode))
	{
	  ro[0] = x1;
	  goto L2;
	}
    L241:
      if (general_operand (x1, SFmode))
	{
	  ro[0] = x1;
	  goto L242;
	}
      break;
    case DFmode:
      if (register_operand (x1, DFmode))
	{
	  ro[0] = x1;
	  goto L7;
	}
    L244:
      if (general_operand (x1, DFmode))
	{
	  ro[0] = x1;
	  goto L245;
	}
      break;
    case SImode:
      if (register_operand (x1, SImode))
	{
	  ro[0] = x1;
	  goto L42;
	}
    L232:
      if (general_operand (x1, SImode))
	{
	  ro[0] = x1;
	  goto L233;
	}
      break;
    case QImode:
      if (register_operand (x1, QImode))
	{
	  ro[0] = x1;
	  goto L93;
	}
    L196:
      if (general_operand (x1, QImode))
	{
	  ro[0] = x1;
	  goto L197;
	}
      break;
    case HImode:
      if (register_operand (x1, HImode))
	{
	  ro[0] = x1;
	  goto L97;
	}
    L192:
      if (general_operand (x1, HImode))
	{
	  ro[0] = x1;
	  goto L193;
	}
    }
  if (GET_CODE (x1) == PC && 1)
    goto L249;
  L273:
  if (register_operand (x1, VOIDmode))
    {
      ro[0] = x1;
      goto L274;
    }
  L298:
  switch (GET_MODE (x1))
    {
    case SImode:
      switch (GET_CODE (x1))
	{
	case REG:
	  if (XINT (x1, 0) == 1 && 1)
	    goto L299;
	}
      break;
    case HImode:
      switch (GET_CODE (x1))
	{
	case REG:
	  if (XINT (x1, 0) == 1 && 1)
	    goto L312;
	}
      break;
    case QImode:
      switch (GET_CODE (x1))
	{
	case REG:
	  if (XINT (x1, 0) == 1 && 1)
	    goto L325;
	}
      break;
    case SFmode:
      switch (GET_CODE (x1))
	{
	case REG:
	  if (XINT (x1, 0) == 32 && 1)
	    goto L338;
	}
      break;
    case DFmode:
      if (GET_CODE (x1) == REG && XINT (x1, 0) == 32 && 1)
	goto L351;
      break;
    case CCFPmode:
      if (register_operand (x1, CCFPmode))
	{
	  ro[0] = x1;
	  goto L407;
	}
    }
  goto ret0;

  L2:
  x1 = XEXP (x0, 1);
  if (GET_MODE (x1) != SFmode)
    {
      x1 = XEXP (x0, 0);
      goto L241;
    }
  switch (GET_CODE (x1))
    {
    case PLUS:
      goto L3;
    case MINUS:
      goto L13;
    case MULT:
      goto L23;
    case DIV:
      goto L33;
    case NEG:
      goto L79;
    case FLOAT:
      goto L160;
    case FLOAT_TRUNCATE:
      goto L190;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L3:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SFmode))
    {
      ro[1] = x2;
      goto L4;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L4:
  x2 = XEXP (x1, 1);
  if (register_operand (x2, SFmode))
    {
      ro[2] = x2;
      return 0;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L13:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SFmode))
    {
      ro[1] = x2;
      goto L14;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L14:
  x2 = XEXP (x1, 1);
  if (register_operand (x2, SFmode))
    {
      ro[2] = x2;
      return 2;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L23:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SFmode))
    {
      ro[1] = x2;
      goto L24;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L24:
  x2 = XEXP (x1, 1);
  if (register_operand (x2, SFmode))
    {
      ro[2] = x2;
      return 4;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L33:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SFmode))
    {
      ro[1] = x2;
      goto L34;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L34:
  x2 = XEXP (x1, 1);
  if (register_operand (x2, SFmode))
    {
      ro[2] = x2;
      return 6;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L79:
  x2 = XEXP (x1, 0);
  if (pnum_clobbers != 0 && register_operand (x2, SFmode))
    {
      ro[1] = x2;
      *pnum_clobbers = 1;
      return 14;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L160:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      return 25;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L190:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, DFmode))
    {
      ro[1] = x2;
      return 29;
    }
  x1 = XEXP (x0, 0);
  goto L241;

  L242:
  x1 = XEXP (x0, 1);
  if (general_operand (x1, SFmode))
    {
      ro[1] = x1;
      return 47;
    }
  x1 = XEXP (x0, 0);
  goto L273;

  L7:
  x1 = XEXP (x0, 1);
  if (GET_MODE (x1) != DFmode)
    {
      x1 = XEXP (x0, 0);
      goto L244;
    }
  switch (GET_CODE (x1))
    {
    case PLUS:
      goto L8;
    case MINUS:
      goto L18;
    case MULT:
      goto L28;
    case DIV:
      goto L38;
    case NEG:
      goto L90;
    case FLOAT:
      goto L164;
    case FLOAT_EXTEND:
      goto L230;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L8:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, DFmode))
    {
      ro[1] = x2;
      goto L9;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L9:
  x2 = XEXP (x1, 1);
  if (register_operand (x2, DFmode))
    {
      ro[2] = x2;
      return 1;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L18:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, DFmode))
    {
      ro[1] = x2;
      goto L19;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L19:
  x2 = XEXP (x1, 1);
  if (register_operand (x2, DFmode))
    {
      ro[2] = x2;
      return 3;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L28:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, DFmode))
    {
      ro[1] = x2;
      goto L29;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L29:
  x2 = XEXP (x1, 1);
  if (register_operand (x2, DFmode))
    {
      ro[2] = x2;
      return 5;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L38:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, DFmode))
    {
      ro[1] = x2;
      goto L39;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L39:
  x2 = XEXP (x1, 1);
  if (register_operand (x2, DFmode))
    {
      ro[2] = x2;
      return 7;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L90:
  x2 = XEXP (x1, 0);
  if (pnum_clobbers != 0 && register_operand (x2, DFmode))
    {
      ro[1] = x2;
      *pnum_clobbers = 1;
      return 15;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L164:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      return 26;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L230:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SFmode))
    {
      ro[1] = x2;
      return 39;
    }
  x1 = XEXP (x0, 0);
  goto L244;

  L245:
  x1 = XEXP (x0, 1);
  if (general_operand (x1, DFmode))
    {
      ro[1] = x1;
      return 49;
    }
  x1 = XEXP (x0, 0);
  goto L273;

  L42:
  x1 = XEXP (x0, 1);
  if (GET_MODE (x1) != SImode)
    {
      x1 = XEXP (x0, 0);
      goto L232;
    }
  switch (GET_CODE (x1))
    {
    case PLUS:
      goto L43;
    case MINUS:
      goto L48;
    case AND:
      goto L53;
    case IOR:
      goto L58;
    case XOR:
      goto L63;
    case NEG:
      goto L68;
    case NOT:
      goto L102;
    case ASHIFT:
      goto L106;
    case ASHIFTRT:
      goto L111;
    case LSHIFTRT:
      goto L116;
    case MULT:
      goto L129;
    case DIV:
      goto L142;
    case UDIV:
      goto L155;
    case FIX:
      goto L175;
    case ZERO_EXTEND:
      goto L210;
    case SIGN_EXTEND:
      goto L218;
    case EQ:
    case NE:
    case LE:
    case LT:
    case GE:
    case GT:
    case LEU:
    case LTU:
    case GEU:
    case GTU:
      if (comparison_operator (x1, SImode))
	{
	  ro[1] = x1;
	  goto L403;
	}
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L43:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      goto L44;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L44:
  x2 = XEXP (x1, 1);
  if (nonmemory_operand (x2, SImode))
    {
      ro[2] = x2;
      return 8;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L48:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      goto L49;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L49:
  x2 = XEXP (x1, 1);
  if (nonmemory_operand (x2, SImode))
    {
      ro[2] = x2;
      return 9;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L53:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      goto L54;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L54:
  x2 = XEXP (x1, 1);
  if (nonmemory_operand (x2, SImode))
    {
      ro[2] = x2;
      return 10;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L58:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      goto L59;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L59:
  x2 = XEXP (x1, 1);
  if (nonmemory_operand (x2, SImode))
    {
      ro[2] = x2;
      return 11;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L63:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      goto L64;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L64:
  x2 = XEXP (x1, 1);
  if (nonmemory_operand (x2, SImode))
    {
      ro[2] = x2;
      return 12;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L68:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      return 13;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L102:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      return 18;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L106:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      goto L107;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L107:
  x2 = XEXP (x1, 1);
  if (nonmemory_operand (x2, SImode))
    {
      ro[2] = x2;
      return 19;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L111:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      goto L112;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L112:
  x2 = XEXP (x1, 1);
  if (nonmemory_operand (x2, SImode))
    {
      ro[2] = x2;
      return 20;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L116:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      goto L117;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L117:
  x2 = XEXP (x1, 1);
  if (nonmemory_operand (x2, SImode))
    {
      ro[2] = x2;
      return 21;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L129:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      goto L130;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L130:
  x2 = XEXP (x1, 1);
  if (pnum_clobbers != 0 && register_operand (x2, SImode))
    {
      ro[2] = x2;
      *pnum_clobbers = 1;
      return 22;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L142:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      goto L143;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L143:
  x2 = XEXP (x1, 1);
  if (pnum_clobbers != 0 && register_operand (x2, SImode))
    {
      ro[2] = x2;
      *pnum_clobbers = 1;
      return 23;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L155:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      goto L156;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L156:
  x2 = XEXP (x1, 1);
  if (pnum_clobbers != 0 && register_operand (x2, SImode))
    {
      ro[2] = x2;
      *pnum_clobbers = 1;
      return 24;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L175:
  x2 = XEXP (x1, 0);
  switch (GET_MODE (x2))
    {
    case SFmode:
      if (pnum_clobbers != 0 && register_operand (x2, SFmode))
	{
	  ro[1] = x2;
	  *pnum_clobbers = 1;
	  return 27;
	}
      break;
    case DFmode:
      if (pnum_clobbers != 0 && register_operand (x2, DFmode))
	{
	  ro[1] = x2;
	  *pnum_clobbers = 1;
	  return 28;
	}
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L210:
  x2 = XEXP (x1, 0);
  switch (GET_MODE (x2))
    {
    case HImode:
      if (general_operand (x2, HImode))
	{
	  ro[1] = x2;
	  return 34;
	}
      break;
    case QImode:
      if (general_operand (x2, QImode))
	{
	  ro[1] = x2;
	  return 35;
	}
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L218:
  x2 = XEXP (x1, 0);
  switch (GET_MODE (x2))
    {
    case QImode:
      if (general_operand (x2, QImode))
	{
	  ro[1] = x2;
	  return 36;
	}
      break;
    case HImode:
      if (general_operand (x2, HImode))
	{
	  ro[1] = x2;
	  return 37;
	}
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L403:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[2] = x2;
      goto L404;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L404:
  x2 = XEXP (x1, 1);
  if (nonmemory_operand (x2, SImode))
    {
      ro[3] = x2;
      return 92;
    }
  x1 = XEXP (x0, 0);
  goto L232;

  L233:
  x1 = XEXP (x0, 1);
  if (general_operand (x1, SImode))
    {
      ro[1] = x1;
      return 41;
    }
  x1 = XEXP (x0, 0);
  goto L273;

  L93:
  x1 = XEXP (x0, 1);
  if (GET_MODE (x1) == QImode && GET_CODE (x1) == NOT && 1)
    goto L94;
  x1 = XEXP (x0, 0);
  goto L196;

  L94:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, QImode))
    {
      ro[1] = x2;
      return 16;
    }
  x1 = XEXP (x0, 0);
  goto L196;

  L197:
  x1 = XEXP (x0, 1);
  if (GET_MODE (x1) == QImode && GET_CODE (x1) == TRUNCATE && 1)
    goto L198;
  if (general_operand (x1, QImode))
    {
      ro[1] = x1;
      return 45;
    }
  x1 = XEXP (x0, 0);
  goto L273;

  L198:
  x2 = XEXP (x1, 0);
  switch (GET_MODE (x2))
    {
    case SImode:
      if (register_operand (x2, SImode))
	{
	  ro[1] = x2;
	  return 31;
	}
      break;
    case HImode:
      if (register_operand (x2, HImode))
	{
	  ro[1] = x2;
	  return 32;
	}
    }
  x1 = XEXP (x0, 0);
  goto L273;

  L97:
  x1 = XEXP (x0, 1);
  if (GET_MODE (x1) != HImode)
    {
      x1 = XEXP (x0, 0);
      goto L192;
    }
  switch (GET_CODE (x1))
    {
    case NOT:
      goto L98;
    case ZERO_EXTEND:
      goto L206;
    case SIGN_EXTEND:
      goto L226;
    }
  x1 = XEXP (x0, 0);
  goto L192;

  L98:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, HImode))
    {
      ro[1] = x2;
      return 17;
    }
  x1 = XEXP (x0, 0);
  goto L192;

  L206:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == QImode && general_operand (x2, QImode))
    {
      ro[1] = x2;
      return 33;
    }
  x1 = XEXP (x0, 0);
  goto L192;

  L226:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, QImode))
    {
      ro[1] = x2;
      return 38;
    }
  x1 = XEXP (x0, 0);
  goto L192;

  L193:
  x1 = XEXP (x0, 1);
  if (GET_MODE (x1) == HImode && GET_CODE (x1) == TRUNCATE && 1)
    goto L194;
  if (general_operand (x1, HImode))
    {
      ro[1] = x1;
      return 43;
    }
  x1 = XEXP (x0, 0);
  goto L273;

  L194:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SImode))
    {
      ro[1] = x2;
      return 30;
    }
  x1 = XEXP (x0, 0);
  goto L273;

  L249:
  x1 = XEXP (x0, 1);
  if (register_operand (x1, SImode))
    {
      ro[0] = x1;
      return 51;
    }
  switch (GET_CODE (x1))
    {
    case LABEL_REF:
      goto L253;
    case IF_THEN_ELSE:
      goto L367;
    }
  goto ret0;

  L253:
  x2 = XEXP (x1, 0);
  ro[0] = x2;
  return 52;

  L367:
  x2 = XEXP (x1, 0);
  switch (GET_MODE (x2))
    {
    case SImode:
      switch (GET_CODE (x2))
	{
	case EQ:
	  goto L368;
	case NE:
	  goto L377;
	}
      break;
    case CCFPmode:
      switch (GET_CODE (x2))
	{
	case NE:
	  goto L386;
	case EQ:
	  goto L395;
	}
    }
  goto ret0;

  L368:
  x3 = XEXP (x2, 0);
  if (GET_CODE (x3) == CONST_INT && XWINT (x3, 0) == 0 && 1)
    goto L369;
  goto ret0;

  L369:
  x3 = XEXP (x2, 1);
  if (register_operand (x3, SImode))
    {
      ro[0] = x3;
      goto L370;
    }
  goto ret0;

  L370:
  x2 = XEXP (x1, 1);
  if (GET_CODE (x2) == LABEL_REF && 1)
    goto L371;
  goto ret0;

  L371:
  x3 = XEXP (x2, 0);
  ro[1] = x3;
  goto L372;

  L372:
  x2 = XEXP (x1, 2);
  if (GET_CODE (x2) == PC && 1)
    return 88;
  goto ret0;

  L377:
  x3 = XEXP (x2, 0);
  if (GET_CODE (x3) == CONST_INT && XWINT (x3, 0) == 0 && 1)
    goto L378;
  goto ret0;

  L378:
  x3 = XEXP (x2, 1);
  if (register_operand (x3, SImode))
    {
      ro[0] = x3;
      goto L379;
    }
  goto ret0;

  L379:
  x2 = XEXP (x1, 1);
  if (GET_CODE (x2) == LABEL_REF && 1)
    goto L380;
  goto ret0;

  L380:
  x3 = XEXP (x2, 0);
  ro[1] = x3;
  goto L381;

  L381:
  x2 = XEXP (x1, 2);
  if (GET_CODE (x2) == PC && 1)
    return 89;
  goto ret0;

  L386:
  x3 = XEXP (x2, 0);
  if (register_operand (x3, CCFPmode))
    {
      ro[0] = x3;
      goto L387;
    }
  goto ret0;

  L387:
  x3 = XEXP (x2, 1);
  if (GET_CODE (x3) == CONST_INT && XWINT (x3, 0) == 0 && 1)
    goto L388;
  goto ret0;

  L388:
  x2 = XEXP (x1, 1);
  if (GET_CODE (x2) == LABEL_REF && 1)
    goto L389;
  goto ret0;

  L389:
  x3 = XEXP (x2, 0);
  ro[1] = x3;
  goto L390;

  L390:
  x2 = XEXP (x1, 2);
  if (GET_CODE (x2) == PC && 1)
    return 90;
  goto ret0;

  L395:
  x3 = XEXP (x2, 0);
  if (register_operand (x3, CCFPmode))
    {
      ro[0] = x3;
      goto L396;
    }
  goto ret0;

  L396:
  x3 = XEXP (x2, 1);
  if (GET_CODE (x3) == CONST_INT && XWINT (x3, 0) == 0 && 1)
    goto L397;
  goto ret0;

  L397:
  x2 = XEXP (x1, 1);
  if (GET_CODE (x2) == LABEL_REF && 1)
    goto L398;
  goto ret0;

  L398:
  x3 = XEXP (x2, 0);
  ro[1] = x3;
  goto L399;

  L399:
  x2 = XEXP (x1, 2);
  if (GET_CODE (x2) == PC && 1)
    return 91;
  goto ret0;

  L274:
  x1 = XEXP (x0, 1);
  if (GET_CODE (x1) == CALL && 1)
    goto L275;
  x1 = XEXP (x0, 0);
  goto L298;

  L275:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == QImode && GET_CODE (x2) == MEM && 1)
    goto L276;
  x1 = XEXP (x0, 0);
  goto L298;

  L276:
  x3 = XEXP (x2, 0);
  if (register_operand (x3, VOIDmode))
    {
      ro[1] = x3;
      goto L277;
    }
  x1 = XEXP (x0, 0);
  goto L298;

  L277:
  x2 = XEXP (x1, 1);
  if (pnum_clobbers != 0 && 1)
    {
      ro[2] = x2;
      *pnum_clobbers = 1;
      return 55;
    }
  x1 = XEXP (x0, 0);
  goto L298;

  L299:
  x1 = XEXP (x0, 1);
  if (GET_CODE (x1) == CALL && 1)
    goto L300;
  goto ret0;

  L300:
  x2 = XEXP (x1, 0);
  if (GET_CODE (x2) == MEM && sym_ref_mem_operand (x2, VOIDmode))
    {
      ro[0] = x2;
      goto L301;
    }
  goto ret0;

  L301:
  x2 = XEXP (x1, 1);
  if (pnum_clobbers != 0 && 1)
    {
      ro[1] = x2;
      *pnum_clobbers = 1;
      return 57;
    }
  goto ret0;

  L312:
  x1 = XEXP (x0, 1);
  if (GET_CODE (x1) == CALL && 1)
    goto L313;
  goto ret0;

  L313:
  x2 = XEXP (x1, 0);
  if (GET_CODE (x2) == MEM && sym_ref_mem_operand (x2, VOIDmode))
    {
      ro[0] = x2;
      goto L314;
    }
  goto ret0;

  L314:
  x2 = XEXP (x1, 1);
  if (pnum_clobbers != 0 && 1)
    {
      ro[1] = x2;
      *pnum_clobbers = 1;
      return 58;
    }
  goto ret0;

  L325:
  x1 = XEXP (x0, 1);
  if (GET_CODE (x1) == CALL && 1)
    goto L326;
  goto ret0;

  L326:
  x2 = XEXP (x1, 0);
  if (GET_CODE (x2) == MEM && sym_ref_mem_operand (x2, VOIDmode))
    {
      ro[0] = x2;
      goto L327;
    }
  goto ret0;

  L327:
  x2 = XEXP (x1, 1);
  if (pnum_clobbers != 0 && 1)
    {
      ro[1] = x2;
      *pnum_clobbers = 1;
      return 59;
    }
  goto ret0;

  L338:
  x1 = XEXP (x0, 1);
  if (GET_CODE (x1) == CALL && 1)
    goto L339;
  goto ret0;

  L339:
  x2 = XEXP (x1, 0);
  if (GET_CODE (x2) == MEM && sym_ref_mem_operand (x2, VOIDmode))
    {
      ro[0] = x2;
      goto L340;
    }
  goto ret0;

  L340:
  x2 = XEXP (x1, 1);
  if (pnum_clobbers != 0 && 1)
    {
      ro[1] = x2;
      *pnum_clobbers = 1;
      return 60;
    }
  goto ret0;

  L351:
  x1 = XEXP (x0, 1);
  if (GET_CODE (x1) == CALL && 1)
    goto L352;
  goto ret0;

  L352:
  x2 = XEXP (x1, 0);
  if (GET_CODE (x2) == MEM && sym_ref_mem_operand (x2, VOIDmode))
    {
      ro[0] = x2;
      goto L353;
    }
  goto ret0;

  L353:
  x2 = XEXP (x1, 1);
  if (pnum_clobbers != 0 && 1)
    {
      ro[1] = x2;
      *pnum_clobbers = 1;
      return 61;
    }
  goto ret0;

  L407:
  x1 = XEXP (x0, 1);
  switch (GET_MODE (x1))
    {
    case SFmode:
      if (signed_comparison_operator (x1, SFmode))
	{
	  ro[1] = x1;
	  goto L408;
	}
      break;
    case DFmode:
      if (signed_comparison_operator (x1, DFmode))
	{
	  ro[1] = x1;
	  goto L413;
	}
    }
  goto ret0;

  L408:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, SFmode))
    {
      ro[2] = x2;
      goto L409;
    }
  goto ret0;

  L409:
  x2 = XEXP (x1, 1);
  if (register_operand (x2, SFmode))
    {
      ro[3] = x2;
      return 93;
    }
  goto ret0;

  L413:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, DFmode))
    {
      ro[2] = x2;
      goto L414;
    }
  goto ret0;

  L414:
  x2 = XEXP (x1, 1);
  if (register_operand (x2, DFmode))
    {
      ro[3] = x2;
      return 94;
    }
  goto ret0;
 ret0: return -1;
}

int
recog_2 (x0, insn, pnum_clobbers)
     register rtx x0;
     rtx insn;
     int *pnum_clobbers;
{
  register rtx *ro = &recog_operand[0];
  register rtx x1, x2, x3, x4;
  int tem;

  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  switch (GET_MODE (x2))
    {
    case SFmode:
      if (register_operand (x2, SFmode))
	{
	  ro[0] = x2;
	  goto L72;
	}
      break;
    case DFmode:
      if (register_operand (x2, DFmode))
	{
	  ro[0] = x2;
	  goto L83;
	}
      break;
    case SImode:
      if (register_operand (x2, SImode))
	{
	  ro[0] = x2;
	  goto L121;
	}
    }
  if (GET_CODE (x2) == PC && 1)
    goto L360;
  L265:
  if (register_operand (x2, VOIDmode))
    {
      ro[0] = x2;
      goto L266;
    }
  L291:
  if (GET_CODE (x2) != REG)
    goto ret0;
  switch (GET_MODE (x2))
    {
    case SImode:
      if (XINT (x2, 0) == 1 && 1)
	goto L292;
      break;
    case HImode:
      if (XINT (x2, 0) == 1 && 1)
	goto L305;
      break;
    case QImode:
      if (XINT (x2, 0) == 1 && 1)
	goto L318;
      break;
    case SFmode:
      if (XINT (x2, 0) == 32 && 1)
	goto L331;
      break;
    case DFmode:
      if (XINT (x2, 0) == 32 && 1)
	goto L344;
    }
  goto ret0;

  L72:
  x2 = XEXP (x1, 1);
  if (GET_MODE (x2) == SFmode && GET_CODE (x2) == NEG && 1)
    goto L73;
  x2 = XEXP (x1, 0);
  goto L265;

  L73:
  x3 = XEXP (x2, 0);
  if (register_operand (x3, SFmode))
    {
      ro[1] = x3;
      goto L74;
    }
  x2 = XEXP (x1, 0);
  goto L265;

  L74:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L75;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L75:
  x2 = XEXP (x1, 0);
  if (scratch_operand (x2, SFmode))
    {
      ro[2] = x2;
      return 14;
    }
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L83:
  x2 = XEXP (x1, 1);
  if (GET_MODE (x2) == DFmode && GET_CODE (x2) == NEG && 1)
    goto L84;
  x2 = XEXP (x1, 0);
  goto L265;

  L84:
  x3 = XEXP (x2, 0);
  if (register_operand (x3, DFmode))
    {
      ro[1] = x3;
      goto L85;
    }
  x2 = XEXP (x1, 0);
  goto L265;

  L85:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L86;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L86:
  x2 = XEXP (x1, 0);
  if (scratch_operand (x2, DFmode))
    {
      ro[2] = x2;
      return 15;
    }
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L121:
  x2 = XEXP (x1, 1);
  if (GET_MODE (x2) != SImode)
    {
      x2 = XEXP (x1, 0);
      goto L265;
    }
  switch (GET_CODE (x2))
    {
    case MULT:
      goto L122;
    case DIV:
      goto L135;
    case UDIV:
      goto L148;
    case FIX:
      goto L169;
    }
  x2 = XEXP (x1, 0);
  goto L265;

  L122:
  x3 = XEXP (x2, 0);
  if (register_operand (x3, SImode))
    {
      ro[1] = x3;
      goto L123;
    }
  x2 = XEXP (x1, 0);
  goto L265;

  L123:
  x3 = XEXP (x2, 1);
  if (register_operand (x3, SImode))
    {
      ro[2] = x3;
      goto L124;
    }
  x2 = XEXP (x1, 0);
  goto L265;

  L124:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L125;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L125:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == SImode && GET_CODE (x2) == REG && XINT (x2, 0) == 1 && 1)
    return 22;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L135:
  x3 = XEXP (x2, 0);
  if (register_operand (x3, SImode))
    {
      ro[1] = x3;
      goto L136;
    }
  x2 = XEXP (x1, 0);
  goto L265;

  L136:
  x3 = XEXP (x2, 1);
  if (register_operand (x3, SImode))
    {
      ro[2] = x3;
      goto L137;
    }
  x2 = XEXP (x1, 0);
  goto L265;

  L137:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L138;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L138:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == SImode && GET_CODE (x2) == REG && XINT (x2, 0) == 1 && 1)
    return 23;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L148:
  x3 = XEXP (x2, 0);
  if (register_operand (x3, SImode))
    {
      ro[1] = x3;
      goto L149;
    }
  x2 = XEXP (x1, 0);
  goto L265;

  L149:
  x3 = XEXP (x2, 1);
  if (register_operand (x3, SImode))
    {
      ro[2] = x3;
      goto L150;
    }
  x2 = XEXP (x1, 0);
  goto L265;

  L150:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L151;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L151:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == SFmode && GET_CODE (x2) == REG && XINT (x2, 0) == 1 && 1)
    return 24;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L169:
  x3 = XEXP (x2, 0);
  switch (GET_MODE (x3))
    {
    case SFmode:
      if (register_operand (x3, SFmode))
	{
	  ro[1] = x3;
	  goto L170;
	}
      break;
    case DFmode:
      if (register_operand (x3, DFmode))
	{
	  ro[1] = x3;
	  goto L181;
	}
    }
  x2 = XEXP (x1, 0);
  goto L265;

  L170:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L171;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L171:
  x2 = XEXP (x1, 0);
  if (scratch_operand (x2, SFmode))
    {
      ro[2] = x2;
      return 27;
    }
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L181:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L182;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L182:
  x2 = XEXP (x1, 0);
  if (scratch_operand (x2, DFmode))
    {
      ro[2] = x2;
      return 28;
    }
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L265;

  L360:
  x2 = XEXP (x1, 1);
  if (register_operand (x2, SImode))
    {
      ro[0] = x2;
      goto L361;
    }
  goto ret0;

  L361:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == USE && 1)
    goto L362;
  goto ret0;

  L362:
  x2 = XEXP (x1, 0);
  if (GET_CODE (x2) == LABEL_REF && 1)
    goto L363;
  goto ret0;

  L363:
  x3 = XEXP (x2, 0);
  ro[1] = x3;
  return 63;

  L266:
  x2 = XEXP (x1, 1);
  if (GET_CODE (x2) == CALL && 1)
    goto L267;
  x2 = XEXP (x1, 0);
  goto L291;

  L267:
  x3 = XEXP (x2, 0);
  if (GET_MODE (x3) == QImode && GET_CODE (x3) == MEM && 1)
    goto L268;
  x2 = XEXP (x1, 0);
  goto L291;

  L268:
  x4 = XEXP (x3, 0);
  if (register_operand (x4, VOIDmode))
    {
      ro[1] = x4;
      goto L269;
    }
  x2 = XEXP (x1, 0);
  goto L291;

  L269:
  x3 = XEXP (x2, 1);
  ro[2] = x3;
  goto L270;

  L270:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L271;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L291;

  L271:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == SImode && GET_CODE (x2) == REG && XINT (x2, 0) == 31 && 1)
    return 55;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L291;

  L292:
  x2 = XEXP (x1, 1);
  if (GET_CODE (x2) == CALL && 1)
    goto L293;
  goto ret0;

  L293:
  x3 = XEXP (x2, 0);
  if (GET_CODE (x3) == MEM && sym_ref_mem_operand (x3, VOIDmode))
    {
      ro[0] = x3;
      goto L294;
    }
  goto ret0;

  L294:
  x3 = XEXP (x2, 1);
  ro[1] = x3;
  goto L295;

  L295:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L296;
  goto ret0;

  L296:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == SImode && GET_CODE (x2) == REG && XINT (x2, 0) == 31 && 1)
    return 57;
  goto ret0;

  L305:
  x2 = XEXP (x1, 1);
  if (GET_CODE (x2) == CALL && 1)
    goto L306;
  goto ret0;

  L306:
  x3 = XEXP (x2, 0);
  if (GET_CODE (x3) == MEM && sym_ref_mem_operand (x3, VOIDmode))
    {
      ro[0] = x3;
      goto L307;
    }
  goto ret0;

  L307:
  x3 = XEXP (x2, 1);
  ro[1] = x3;
  goto L308;

  L308:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L309;
  goto ret0;

  L309:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == SImode && GET_CODE (x2) == REG && XINT (x2, 0) == 31 && 1)
    return 58;
  goto ret0;

  L318:
  x2 = XEXP (x1, 1);
  if (GET_CODE (x2) == CALL && 1)
    goto L319;
  goto ret0;

  L319:
  x3 = XEXP (x2, 0);
  if (GET_CODE (x3) == MEM && sym_ref_mem_operand (x3, VOIDmode))
    {
      ro[0] = x3;
      goto L320;
    }
  goto ret0;

  L320:
  x3 = XEXP (x2, 1);
  ro[1] = x3;
  goto L321;

  L321:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L322;
  goto ret0;

  L322:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == SImode && GET_CODE (x2) == REG && XINT (x2, 0) == 31 && 1)
    return 59;
  goto ret0;

  L331:
  x2 = XEXP (x1, 1);
  if (GET_CODE (x2) == CALL && 1)
    goto L332;
  goto ret0;

  L332:
  x3 = XEXP (x2, 0);
  if (GET_CODE (x3) == MEM && sym_ref_mem_operand (x3, VOIDmode))
    {
      ro[0] = x3;
      goto L333;
    }
  goto ret0;

  L333:
  x3 = XEXP (x2, 1);
  ro[1] = x3;
  goto L334;

  L334:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L335;
  goto ret0;

  L335:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == SImode && GET_CODE (x2) == REG && XINT (x2, 0) == 31 && 1)
    return 60;
  goto ret0;

  L344:
  x2 = XEXP (x1, 1);
  if (GET_CODE (x2) == CALL && 1)
    goto L345;
  goto ret0;

  L345:
  x3 = XEXP (x2, 0);
  if (GET_CODE (x3) == MEM && sym_ref_mem_operand (x3, VOIDmode))
    {
      ro[0] = x3;
      goto L346;
    }
  goto ret0;

  L346:
  x3 = XEXP (x2, 1);
  ro[1] = x3;
  goto L347;

  L347:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L348;
  goto ret0;

  L348:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == SImode && GET_CODE (x2) == REG && XINT (x2, 0) == 31 && 1)
    return 61;
  goto ret0;
 ret0: return -1;
}

int
recog (x0, insn, pnum_clobbers)
     register rtx x0;
     rtx insn;
     int *pnum_clobbers;
{
  register rtx *ro = &recog_operand[0];
  register rtx x1, x2, x3, x4;
  int tem;

  L0:
  switch (GET_CODE (x0))
    {
    case SET:
      goto L1;
    case PARALLEL:
      if (XVECLEN (x0, 0) == 2 && 1)
	goto L70;
      break;
    case CONST_INT:
      if (XWINT (x0, 0) == 0 && 1)
	return 50;
      break;
    case CALL:
      goto L261;
    }
  goto ret0;
 L1:
  return recog_1 (x0, insn, pnum_clobbers);

  L70:
  x1 = XVECEXP (x0, 0, 0);
  switch (GET_CODE (x1))
    {
    case SET:
      goto L71;
    case CALL:
      goto L256;
    }
  goto ret0;
 L71:
  return recog_2 (x0, insn, pnum_clobbers);

  L256:
  x2 = XEXP (x1, 0);
  if (GET_CODE (x2) != MEM)
    goto ret0;
  if (sym_ref_mem_operand (x2, VOIDmode))
    {
      ro[0] = x2;
      goto L257;
    }
  L280:
  if (GET_MODE (x2) == QImode && 1)
    goto L281;
  goto ret0;

  L257:
  x2 = XEXP (x1, 1);
  ro[1] = x2;
  goto L258;

  L258:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L259;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L280;

  L259:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == SImode && GET_CODE (x2) == REG && XINT (x2, 0) == 31 && 1)
    return 54;
  x1 = XVECEXP (x0, 0, 0);
  x2 = XEXP (x1, 0);
  goto L280;

  L281:
  x3 = XEXP (x2, 0);
  if (register_operand (x3, VOIDmode))
    {
      ro[0] = x3;
      goto L282;
    }
  goto ret0;

  L282:
  x2 = XEXP (x1, 1);
  ro[1] = x2;
  goto L283;

  L283:
  x1 = XVECEXP (x0, 0, 1);
  if (GET_CODE (x1) == CLOBBER && 1)
    goto L284;
  goto ret0;

  L284:
  x2 = XEXP (x1, 0);
  if (GET_MODE (x2) == SImode && GET_CODE (x2) == REG && XINT (x2, 0) == 31 && 1)
    return 56;
  goto ret0;

  L261:
  x1 = XEXP (x0, 0);
  if (GET_CODE (x1) != MEM)
    goto ret0;
  if (sym_ref_mem_operand (x1, VOIDmode))
    {
      ro[0] = x1;
      goto L262;
    }
  L286:
  if (GET_CODE (x1) != MEM)
    goto ret0;
  if (GET_MODE (x1) == QImode && 1)
    goto L287;
  L355:
  if (sym_ref_mem_operand (x1, VOIDmode))
    {
      ro[0] = x1;
      goto L356;
    }
  goto ret0;

  L262:
  x1 = XEXP (x0, 1);
  if (pnum_clobbers != 0 && 1)
    {
      ro[1] = x1;
      *pnum_clobbers = 1;
      return 54;
    }
  x1 = XEXP (x0, 0);
  goto L286;

  L287:
  x2 = XEXP (x1, 0);
  if (register_operand (x2, VOIDmode))
    {
      ro[0] = x2;
      goto L288;
    }
  goto L355;

  L288:
  x1 = XEXP (x0, 1);
  if (pnum_clobbers != 0 && 1)
    {
      ro[1] = x1;
      *pnum_clobbers = 1;
      return 56;
    }
  x1 = XEXP (x0, 0);
  goto L355;

  L356:
  x1 = XEXP (x0, 1);
  ro[1] = x1;
  return 62;
 ret0: return -1;
}

rtx
split_insns (x0, insn)
     register rtx x0;
     rtx insn;
{
  register rtx *ro = &recog_operand[0];
  register rtx x1, x2, x3, x4;
  rtx tem;

  goto ret0;
 ret0: return 0;
}

