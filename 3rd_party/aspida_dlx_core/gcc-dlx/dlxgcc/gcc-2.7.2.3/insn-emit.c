/* Generated automatically by the program `genemit'
from the machine description file `md'.  */

#include "config.h"
#include "rtl.h"
#include "expr.h"
#include "real.h"
#include "output.h"
#include "insn-config.h"

#include "insn-flags.h"

#include "insn-codes.h"

extern char *insn_operand_constraint[][MAX_RECOG_OPERANDS];

extern rtx recog_operand[];
#define operands emit_operand

#define FAIL goto _fail

#define DONE goto _done

rtx
gen_addsf3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (PLUS, SFmode,
	operand1,
	operand2));
}

rtx
gen_adddf3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (PLUS, DFmode,
	operand1,
	operand2));
}

rtx
gen_subsf3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (MINUS, SFmode,
	operand1,
	operand2));
}

rtx
gen_subdf3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (MINUS, DFmode,
	operand1,
	operand2));
}

rtx
gen_mulsf3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (MULT, SFmode,
	operand1,
	operand2));
}

rtx
gen_muldf3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (MULT, DFmode,
	operand1,
	operand2));
}

rtx
gen_divsf3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (DIV, SFmode,
	operand1,
	operand2));
}

rtx
gen_divdf3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (DIV, DFmode,
	operand1,
	operand2));
}

rtx
gen_addsi3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (PLUS, SImode,
	operand1,
	operand2));
}

rtx
gen_subsi3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (MINUS, SImode,
	operand1,
	operand2));
}

rtx
gen_andsi3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (AND, SImode,
	operand1,
	operand2));
}

rtx
gen_iorsi3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (IOR, SImode,
	operand1,
	operand2));
}

rtx
gen_xorsi3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (XOR, SImode,
	operand1,
	operand2));
}

rtx
gen_negsi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (NEG, SImode,
	operand1));
}

rtx
gen_negsf2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode, gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (NEG, SFmode,
	operand1)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (SCRATCH, SFmode, 0))));
}

rtx
gen_negdf2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode, gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (NEG, DFmode,
	operand1)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (SCRATCH, DFmode, 0))));
}

rtx
gen_one_cmplqi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (NOT, QImode,
	operand1));
}

rtx
gen_one_cmplhi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (NOT, HImode,
	operand1));
}

rtx
gen_one_cmplsi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (NOT, SImode,
	operand1));
}

rtx
gen_ashlsi3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (ASHIFT, SImode,
	operand1,
	operand2));
}

rtx
gen_ashrsi3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (ASHIFTRT, SImode,
	operand1,
	operand2));
}

rtx
gen_lshrsi3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (LSHIFTRT, SImode,
	operand1,
	operand2));
}

rtx
gen_mulsi3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (PARALLEL, VOIDmode, gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (MULT, SImode,
	operand1,
	operand2)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	1))));
}

rtx
gen_divsi3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (PARALLEL, VOIDmode, gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (DIV, SImode,
	operand1,
	operand2)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	1))));
}

rtx
gen_udivsi3 (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (PARALLEL, VOIDmode, gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (UDIV, SImode,
	operand1,
	operand2)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SFmode,
	1))));
}

rtx
gen_floatsisf2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (FLOAT, SFmode,
	operand1));
}

rtx
gen_floatsidf2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (FLOAT, DFmode,
	operand1));
}

rtx
gen_fix_truncsfsi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode, gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (FIX, SImode,
	operand1)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (SCRATCH, SFmode, 0))));
}

rtx
gen_fix_truncdfsi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode, gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (FIX, SImode,
	operand1)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (SCRATCH, DFmode, 0))));
}

rtx
gen_truncdfsf2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (FLOAT_TRUNCATE, SFmode,
	operand1));
}

rtx
gen_truncsihi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (TRUNCATE, HImode,
	operand1));
}

rtx
gen_truncsiqi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (TRUNCATE, QImode,
	operand1));
}

rtx
gen_trunchiqi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (TRUNCATE, QImode,
	operand1));
}

rtx
gen_zero_extendqihi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (ZERO_EXTEND, HImode,
	operand1));
}

rtx
gen_zero_extendhisi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (ZERO_EXTEND, SImode,
	operand1));
}

rtx
gen_zero_extendqisi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (ZERO_EXTEND, SImode,
	operand1));
}

rtx
gen_extendqisi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (SIGN_EXTEND, SImode,
	operand1));
}

rtx
gen_extendhisi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (SIGN_EXTEND, SImode,
	operand1));
}

rtx
gen_extendqihi2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (SIGN_EXTEND, HImode,
	operand1));
}

rtx
gen_extendsfdf2 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (FLOAT_EXTEND, DFmode,
	operand1));
}

rtx
gen_movsi (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  rtx operands[2];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
  operands[1] = operand1;

{
  if ((reload_in_progress | reload_completed) == 0
      && !register_operand (operands[0], SImode)
      && !register_operand (operands[1], SImode))
    {
      rtx temp = force_reg (SImode, operands[1]);
      temp = emit_move_insn (operands[0], temp);
      DONE;
    }
}
  operand0 = operands[0];
  operand1 = operands[1];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	operand1));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_movsi_general (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	operand1);
}

rtx
gen_movhi (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  rtx operands[2];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
  operands[1] = operand1;

{
  if ((reload_in_progress | reload_completed) == 0
      && !register_operand (operands[0], HImode)
      && !register_operand (operands[1], HImode))
    {
      rtx temp = force_reg (HImode, operands[1]);
      temp = emit_move_insn (operands[0], temp);
      DONE;
    }
}
  operand0 = operands[0];
  operand1 = operands[1];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	operand1));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_movhi_general (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	operand1);
}

rtx
gen_movqi (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  rtx operands[2];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
  operands[1] = operand1;

{
  if ((reload_in_progress | reload_completed) == 0
      && !register_operand (operands[0], QImode)
      && !register_operand (operands[1], QImode))
    {
      rtx temp = force_reg (QImode, operands[1]);
      temp = emit_move_insn (operands[0], temp);
      DONE;
    }
}
  operand0 = operands[0];
  operand1 = operands[1];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	operand1));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_movqi_general (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	operand1);
}

rtx
gen_movsf (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  rtx operands[2];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
  operands[1] = operand1;

{
  if ((reload_in_progress | reload_completed) == 0
      && !register_operand (operands[0], SFmode)
      && !register_operand (operands[1], SFmode))
    {
      rtx temp = force_reg (SFmode, operands[1]);
      temp = emit_move_insn (operands[0], temp);
      DONE;
    }
}
  operand0 = operands[0];
  operand1 = operands[1];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	operand1));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_movsf_general (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	operand1);
}

rtx
gen_movdf (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  rtx operands[2];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
  operands[1] = operand1;

{
  if ((reload_in_progress | reload_completed) == 0
      && !register_operand (operands[0], DFmode)
      && !register_operand (operands[1], DFmode))
    {
      rtx temp = force_reg (DFmode, operands[1]);
      temp = emit_move_insn (operands[0], temp);
      DONE;
    }
}
  operand0 = operands[0];
  operand1 = operands[1];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	operand1));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_movdf_general (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	operand1);
}

rtx
gen_nop ()
{
  return const0_rtx;
}

rtx
gen_indirect_jump (operand0)
     rtx operand0;
{
  return gen_rtx (SET, VOIDmode,
	pc_rtx,
	operand0);
}

rtx
gen_jump (operand0)
     rtx operand0;
{
  return gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (LABEL_REF, VOIDmode,
	operand0));
}

rtx
gen_call_value (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  rtx operands[3];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
  operands[1] = operand1;
  operands[2] = operand2;
{ gen_call_value_1(operands); DONE; }
  operand0 = operands[0];
  operand1 = operands[1];
  operand2 = operands[2];
  emit_call_insn (gen_rtx (PARALLEL, VOIDmode,
	gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (CALL, VOIDmode,
	operand1,
	operand2)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	31)))));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_call (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode,
	gen_rtvec (2,
		gen_rtx (CALL, VOIDmode,
	operand0,
	operand1),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	31))));
}

rtx
gen_call_value_indirect (operand0, operand1, operand2)
     rtx operand0;
     rtx operand1;
     rtx operand2;
{
  return gen_rtx (PARALLEL, VOIDmode,
	gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (CALL, VOIDmode,
	gen_rtx (MEM, QImode,
	operand1),
	operand2)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	31))));
}

rtx
gen_call_indirect (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode,
	gen_rtvec (2,
		gen_rtx (CALL, VOIDmode,
	gen_rtx (MEM, QImode,
	operand0),
	operand1),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	31))));
}

rtx
gen_call_val_internal_return_r1 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode,
	gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	gen_rtx (REG, SImode,
	1),
	gen_rtx (CALL, VOIDmode,
	operand0,
	operand1)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	31))));
}

rtx
gen_call_val_internal_return_r1_halfword (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode,
	gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	gen_rtx (REG, HImode,
	1),
	gen_rtx (CALL, VOIDmode,
	operand0,
	operand1)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	31))));
}

rtx
gen_call_val_internal_return_r1_quarterword (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode,
	gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	gen_rtx (REG, QImode,
	1),
	gen_rtx (CALL, VOIDmode,
	operand0,
	operand1)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	31))));
}

rtx
gen_call_val_internal_return_f0_float (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode,
	gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	gen_rtx (REG, SFmode,
	32),
	gen_rtx (CALL, VOIDmode,
	operand0,
	operand1)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	31))));
}

rtx
gen_call_val_internal_return_f0f1 (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode,
	gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	gen_rtx (REG, DFmode,
	32),
	gen_rtx (CALL, VOIDmode,
	operand0,
	operand1)),
		gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	31))));
}

rtx
gen_call_val_internal_no_return (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (CALL, VOIDmode,
	operand0,
	operand1);
}

rtx
gen_tablejump (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (PARALLEL, VOIDmode, gen_rtvec (2,
		gen_rtx (SET, VOIDmode,
	pc_rtx,
	operand0),
		gen_rtx (USE, VOIDmode,
	gen_rtx (LABEL_REF, VOIDmode,
	operand1))));
}

rtx
gen_cmpsi (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  rtx operands[2];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
  operands[1] = operand1;

{
      dlx_compare_op0 = operands[0];
      dlx_compare_op1 = operands[1];
      dlx_compare_mode = SImode;
      DONE;
}
  operand0 = operands[0];
  operand1 = operands[1];
  emit_insn (gen_rtx (SET, VOIDmode,
	cc0_rtx,
	gen_rtx (COMPARE, CCmode,
	operand0,
	operand1)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_tstsi (operand0)
     rtx operand0;
{
  rtx operands[1];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;

{
      dlx_compare_op0 = operands[0];
      dlx_compare_op1 = const0_rtx;
      dlx_compare_mode = SImode;
      DONE;
}
  operand0 = operands[0];
  emit_insn (gen_rtx (SET, VOIDmode,
	cc0_rtx,
	operand0));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_cmpdf (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  rtx operands[2];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
  operands[1] = operand1;

{
      dlx_compare_op0 = operands[0];
      dlx_compare_op1 = operands[1];
      dlx_compare_mode = DFmode;
      DONE;
}
  operand0 = operands[0];
  operand1 = operands[1];
  emit_insn (gen_rtx (SET, VOIDmode,
	cc0_rtx,
	gen_rtx (COMPARE, CCFPmode,
	operand0,
	operand1)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_cmpsf (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  rtx operands[2];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
  operands[1] = operand1;

{
      dlx_compare_op0 = operands[0];
      dlx_compare_op1 = operands[1];
      dlx_compare_mode = SFmode;
      DONE;
}
  operand0 = operands[0];
  operand1 = operands[1];
  emit_insn (gen_rtx (SET, VOIDmode,
	cc0_rtx,
	gen_rtx (COMPARE, CCFPmode,
	operand0,
	operand1)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_beq (operand0)
     rtx operand0;
{
  rtx operands[1];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
{ gen_conditional_branch(operands, EQ); DONE; }
  operand0 = operands[0];
  emit_jump_insn (gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (EQ, VOIDmode,
	cc0_rtx,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand0),
	pc_rtx)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_bne (operand0)
     rtx operand0;
{
  rtx operands[1];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
{ gen_conditional_branch(operands, NE); DONE; }
  operand0 = operands[0];
  emit_jump_insn (gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (NE, VOIDmode,
	cc0_rtx,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand0),
	pc_rtx)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_blt (operand0)
     rtx operand0;
{
  rtx operands[1];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
{ gen_conditional_branch(operands, LT); DONE; }
  operand0 = operands[0];
  emit_jump_insn (gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (LT, VOIDmode,
	cc0_rtx,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand0),
	pc_rtx)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_bgt (operand0)
     rtx operand0;
{
  rtx operands[1];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
{ gen_conditional_branch(operands, GT); DONE; }
  operand0 = operands[0];
  emit_jump_insn (gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (GT, VOIDmode,
	cc0_rtx,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand0),
	pc_rtx)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_ble (operand0)
     rtx operand0;
{
  rtx operands[1];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
{ gen_conditional_branch(operands, LE); DONE; }
  operand0 = operands[0];
  emit_jump_insn (gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (LE, VOIDmode,
	cc0_rtx,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand0),
	pc_rtx)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_bge (operand0)
     rtx operand0;
{
  rtx operands[1];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
{ gen_conditional_branch(operands, GE); DONE; }
  operand0 = operands[0];
  emit_jump_insn (gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (GE, VOIDmode,
	cc0_rtx,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand0),
	pc_rtx)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_bltu (operand0)
     rtx operand0;
{
  rtx operands[1];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
{ gen_conditional_branch(operands, LTU); DONE; }
  operand0 = operands[0];
  emit_jump_insn (gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (LTU, VOIDmode,
	cc0_rtx,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand0),
	pc_rtx)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_bgtu (operand0)
     rtx operand0;
{
  rtx operands[1];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
{ gen_conditional_branch(operands, GTU); DONE; }
  operand0 = operands[0];
  emit_jump_insn (gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (GTU, VOIDmode,
	cc0_rtx,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand0),
	pc_rtx)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_bleu (operand0)
     rtx operand0;
{
  rtx operands[1];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
{ gen_conditional_branch(operands, LEU); DONE; }
  operand0 = operands[0];
  emit_jump_insn (gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (LEU, VOIDmode,
	cc0_rtx,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand0),
	pc_rtx)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_bgeu (operand0)
     rtx operand0;
{
  rtx operands[1];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
{ gen_conditional_branch(operands, GEU); DONE; }
  operand0 = operands[0];
  emit_jump_insn (gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (GEU, VOIDmode,
	cc0_rtx,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand0),
	pc_rtx)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_seq (operand0)
     rtx operand0;
{
  rtx operand1;
  rtx operand2;
  rtx operands[3];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
 if(dlx_compare_mode != SImode) FAIL;
    operands[1] = dlx_compare_op0;
    operands[2] = dlx_compare_op1;
  
  operand0 = operands[0];
  operand1 = operands[1];
  operand2 = operands[2];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (EQ, SImode,
	operand1,
	operand2)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_sne (operand0)
     rtx operand0;
{
  rtx operand1;
  rtx operand2;
  rtx operands[3];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
 if(dlx_compare_mode != SImode) FAIL;
    operands[1] = dlx_compare_op0;
    operands[2] = dlx_compare_op1;
  
  operand0 = operands[0];
  operand1 = operands[1];
  operand2 = operands[2];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (NE, SImode,
	operand1,
	operand2)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_slt (operand0)
     rtx operand0;
{
  rtx operand1;
  rtx operand2;
  rtx operands[3];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
 if(dlx_compare_mode != SImode) FAIL;
    operands[1] = dlx_compare_op0;
    operands[2] = dlx_compare_op1;
  
  operand0 = operands[0];
  operand1 = operands[1];
  operand2 = operands[2];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (LT, SImode,
	operand1,
	operand2)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_sgt (operand0)
     rtx operand0;
{
  rtx operand1;
  rtx operand2;
  rtx operands[3];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
 if(dlx_compare_mode != SImode) FAIL;
    operands[1] = dlx_compare_op0;
    operands[2] = dlx_compare_op1;
  
  operand0 = operands[0];
  operand1 = operands[1];
  operand2 = operands[2];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (GT, SImode,
	operand1,
	operand2)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_sle (operand0)
     rtx operand0;
{
  rtx operand1;
  rtx operand2;
  rtx operands[3];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
 if(dlx_compare_mode != SImode) FAIL;
    operands[1] = dlx_compare_op0;
    operands[2] = dlx_compare_op1;
  
  operand0 = operands[0];
  operand1 = operands[1];
  operand2 = operands[2];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (LE, SImode,
	operand1,
	operand2)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_sge (operand0)
     rtx operand0;
{
  rtx operand1;
  rtx operand2;
  rtx operands[3];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
 if(dlx_compare_mode != SImode) FAIL;
    operands[1] = dlx_compare_op0;
    operands[2] = dlx_compare_op1;
  
  operand0 = operands[0];
  operand1 = operands[1];
  operand2 = operands[2];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (GE, SImode,
	operand1,
	operand2)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_sltu (operand0)
     rtx operand0;
{
  rtx operand1;
  rtx operand2;
  rtx operands[3];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
 if(dlx_compare_mode != SImode) FAIL;
    operands[1] = dlx_compare_op0;
    operands[2] = dlx_compare_op1;
  
  operand0 = operands[0];
  operand1 = operands[1];
  operand2 = operands[2];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (LTU, SImode,
	operand1,
	operand2)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_sgtu (operand0)
     rtx operand0;
{
  rtx operand1;
  rtx operand2;
  rtx operands[3];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
 if(dlx_compare_mode != SImode) FAIL;
    operands[1] = dlx_compare_op0;
    operands[2] = dlx_compare_op1;
  
  operand0 = operands[0];
  operand1 = operands[1];
  operand2 = operands[2];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (GTU, SImode,
	operand1,
	operand2)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_sleu (operand0)
     rtx operand0;
{
  rtx operand1;
  rtx operand2;
  rtx operands[3];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
 if(dlx_compare_mode != SImode) FAIL;
    operands[1] = dlx_compare_op0;
    operands[2] = dlx_compare_op1;
  
  operand0 = operands[0];
  operand1 = operands[1];
  operand2 = operands[2];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (LEU, SImode,
	operand1,
	operand2)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_sgeu (operand0)
     rtx operand0;
{
  rtx operand1;
  rtx operand2;
  rtx operands[3];
  rtx _val = 0;
  start_sequence ();
  operands[0] = operand0;
 if(dlx_compare_mode != SImode) FAIL;
    operands[1] = dlx_compare_op0;
    operands[2] = dlx_compare_op1;
  
  operand0 = operands[0];
  operand1 = operands[1];
  operand2 = operands[2];
  emit_insn (gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (GEU, SImode,
	operand1,
	operand2)));
 _done:
  _val = gen_sequence ();
 _fail:
  end_sequence ();
  return _val;
}

rtx
gen_int_cond_branch (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (EQ, SImode,
	const0_rtx,
	operand0),
	gen_rtx (LABEL_REF, VOIDmode,
	operand1),
	pc_rtx));
}

rtx
gen_int_cond_branch_rev (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (NE, SImode,
	const0_rtx,
	operand0),
	gen_rtx (LABEL_REF, VOIDmode,
	operand1),
	pc_rtx));
}

rtx
gen_fp_cond_branch (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (NE, CCFPmode,
	operand0,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand1),
	pc_rtx));
}

rtx
gen_fp_cond_branch_rev (operand0, operand1)
     rtx operand0;
     rtx operand1;
{
  return gen_rtx (SET, VOIDmode,
	pc_rtx,
	gen_rtx (IF_THEN_ELSE, VOIDmode,
	gen_rtx (EQ, CCFPmode,
	operand0,
	const0_rtx),
	gen_rtx (LABEL_REF, VOIDmode,
	operand1),
	pc_rtx));
}

rtx
gen_set_internal (operand0, operand1, operand2, operand3)
     rtx operand0;
     rtx operand1;
     rtx operand2;
     rtx operand3;
{
  return gen_rtx (SET, VOIDmode,
	operand0,
	gen_rtx (GET_CODE (operand1), SImode,
		operand2,
		operand3));
}



void
add_clobbers (pattern, insn_code_number)
     rtx pattern;
     int insn_code_number;
{
  int i;

  switch (insn_code_number)
    {
    case 24:
      XVECEXP (pattern, 0, 1) = gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SFmode,
	1));
      break;

    case 23:
    case 22:
      XVECEXP (pattern, 0, 1) = gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (REG, SImode,
	1));
      break;

    case 28:
    case 15:
      XVECEXP (pattern, 0, 1) = gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (SCRATCH, DFmode, 0));
      break;

    case 27:
    case 14:
      XVECEXP (pattern, 0, 1) = gen_rtx (CLOBBER, VOIDmode,
	gen_rtx (SCRATCH, SFmode, 0));
      break;

    default:
      abort ();
    }
}

void
init_mov_optab ()
{
#ifdef HAVE_movccfp
  if (HAVE_movccfp)
    mov_optab->handlers[(int) CCFPmode].insn_code = CODE_FOR_movccfp;
#endif
}
