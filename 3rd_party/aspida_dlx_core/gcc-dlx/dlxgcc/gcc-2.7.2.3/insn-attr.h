/* Generated automatically by the program `genattr'
from the machine description file `md'.  */

#ifndef PROTO
#if defined (USE_PROTOTYPES) ? USE_PROTOTYPES : defined (__STDC__)
#define PROTO(ARGS) ARGS
#else
#define PROTO(ARGS) ()
#endif
#endif
#define HAVE_ATTR_alternative
#define get_attr_alternative(insn) which_alternative
#define HAVE_ATTR_type
enum attr_type {TYPE_UNKNOWN, TYPE_LOAD, TYPE_STORE, TYPE_MOVE, TYPE_ALU, TYPE_BRANCH, TYPE_JUMP, TYPE_FP, TYPE_MULTI};
extern enum attr_type get_attr_type ();

#define HAVE_ATTR_mode
enum attr_mode {MODE_UNKNOWN, MODE_NONE, MODE_QI, MODE_HI, MODE_SI, MODE_DI, MODE_SF, MODE_DF};
extern enum attr_mode get_attr_mode ();

#define HAVE_ATTR_length
extern int get_attr_length ();
extern void init_lengths ();
extern void shorten_branches PROTO((rtx));
extern int insn_default_length PROTO((rtx));
extern int insn_variable_length_p PROTO((rtx));
extern int insn_current_length PROTO((rtx));

extern int *insn_addresses;
extern int insn_current_address;

#define DELAY_SLOTS
extern int num_delay_slots PROTO((rtx));
extern int eligible_for_delay PROTO((rtx, int, rtx, int));

extern int const_num_delay_slots PROTO((rtx));


#define ATTR_FLAG_forward	0x1
#define ATTR_FLAG_backward	0x2
#define ATTR_FLAG_likely	0x4
#define ATTR_FLAG_very_likely	0x8
#define ATTR_FLAG_unlikely	0x10
#define ATTR_FLAG_very_unlikely	0x20
