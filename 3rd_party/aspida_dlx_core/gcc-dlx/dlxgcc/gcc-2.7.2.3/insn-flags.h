/* Generated automatically by the program `genflags'
from the machine description file `md'.  */

#define HAVE_addsf3 1
#define HAVE_adddf3 1
#define HAVE_subsf3 1
#define HAVE_subdf3 1
#define HAVE_mulsf3 1
#define HAVE_muldf3 1
#define HAVE_divsf3 1
#define HAVE_divdf3 1
#define HAVE_addsi3 1
#define HAVE_subsi3 1
#define HAVE_andsi3 1
#define HAVE_iorsi3 1
#define HAVE_xorsi3 1
#define HAVE_negsi2 1
#define HAVE_negsf2 1
#define HAVE_negdf2 1
#define HAVE_one_cmplqi2 1
#define HAVE_one_cmplhi2 1
#define HAVE_one_cmplsi2 1
#define HAVE_ashlsi3 1
#define HAVE_ashrsi3 1
#define HAVE_lshrsi3 1
#define HAVE_mulsi3 1
#define HAVE_divsi3 1
#define HAVE_udivsi3 1
#define HAVE_floatsisf2 1
#define HAVE_floatsidf2 1
#define HAVE_fix_truncsfsi2 1
#define HAVE_fix_truncdfsi2 1
#define HAVE_truncdfsf2 1
#define HAVE_truncsihi2 1
#define HAVE_truncsiqi2 1
#define HAVE_trunchiqi2 1
#define HAVE_zero_extendqihi2 1
#define HAVE_zero_extendhisi2 1
#define HAVE_zero_extendqisi2 1
#define HAVE_extendqisi2 1
#define HAVE_extendhisi2 1
#define HAVE_extendqihi2 1
#define HAVE_extendsfdf2 1
#define HAVE_movsi 1
#define HAVE_movsi_general 1
#define HAVE_movhi 1
#define HAVE_movhi_general 1
#define HAVE_movqi 1
#define HAVE_movqi_general 1
#define HAVE_movsf 1
#define HAVE_movsf_general 1
#define HAVE_movdf 1
#define HAVE_movdf_general 1
#define HAVE_nop 1
#define HAVE_indirect_jump 1
#define HAVE_jump 1
#define HAVE_call_value 1
#define HAVE_call 1
#define HAVE_call_value_indirect 1
#define HAVE_call_indirect 1
#define HAVE_call_val_internal_return_r1 1
#define HAVE_call_val_internal_return_r1_halfword 1
#define HAVE_call_val_internal_return_r1_quarterword 1
#define HAVE_call_val_internal_return_f0_float 1
#define HAVE_call_val_internal_return_f0f1 1
#define HAVE_call_val_internal_no_return 1
#define HAVE_tablejump 1
#define HAVE_cmpsi 1
#define HAVE_tstsi 1
#define HAVE_cmpdf 1
#define HAVE_cmpsf 1
#define HAVE_beq 1
#define HAVE_bne 1
#define HAVE_blt 1
#define HAVE_bgt 1
#define HAVE_ble 1
#define HAVE_bge 1
#define HAVE_bltu 1
#define HAVE_bgtu 1
#define HAVE_bleu 1
#define HAVE_bgeu 1
#define HAVE_seq 1
#define HAVE_sne 1
#define HAVE_slt 1
#define HAVE_sgt 1
#define HAVE_sle 1
#define HAVE_sge 1
#define HAVE_sltu 1
#define HAVE_sgtu 1
#define HAVE_sleu 1
#define HAVE_sgeu 1
#define HAVE_int_cond_branch 1
#define HAVE_int_cond_branch_rev 1
#define HAVE_fp_cond_branch 1
#define HAVE_fp_cond_branch_rev 1
#define HAVE_set_internal 1

#ifndef NO_MD_PROTOTYPES
extern rtx gen_addsf3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_adddf3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_subsf3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_subdf3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_mulsf3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_muldf3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_divsf3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_divdf3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_addsi3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_subsi3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_andsi3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_iorsi3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_xorsi3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_negsi2                                  PROTO((rtx, rtx));
extern rtx gen_negsf2                                  PROTO((rtx, rtx));
extern rtx gen_negdf2                                  PROTO((rtx, rtx));
extern rtx gen_one_cmplqi2                             PROTO((rtx, rtx));
extern rtx gen_one_cmplhi2                             PROTO((rtx, rtx));
extern rtx gen_one_cmplsi2                             PROTO((rtx, rtx));
extern rtx gen_ashlsi3                                 PROTO((rtx, rtx, rtx));
extern rtx gen_ashrsi3                                 PROTO((rtx, rtx, rtx));
extern rtx gen_lshrsi3                                 PROTO((rtx, rtx, rtx));
extern rtx gen_mulsi3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_divsi3                                  PROTO((rtx, rtx, rtx));
extern rtx gen_udivsi3                                 PROTO((rtx, rtx, rtx));
extern rtx gen_floatsisf2                              PROTO((rtx, rtx));
extern rtx gen_floatsidf2                              PROTO((rtx, rtx));
extern rtx gen_fix_truncsfsi2                          PROTO((rtx, rtx));
extern rtx gen_fix_truncdfsi2                          PROTO((rtx, rtx));
extern rtx gen_truncdfsf2                              PROTO((rtx, rtx));
extern rtx gen_truncsihi2                              PROTO((rtx, rtx));
extern rtx gen_truncsiqi2                              PROTO((rtx, rtx));
extern rtx gen_trunchiqi2                              PROTO((rtx, rtx));
extern rtx gen_zero_extendqihi2                        PROTO((rtx, rtx));
extern rtx gen_zero_extendhisi2                        PROTO((rtx, rtx));
extern rtx gen_zero_extendqisi2                        PROTO((rtx, rtx));
extern rtx gen_extendqisi2                             PROTO((rtx, rtx));
extern rtx gen_extendhisi2                             PROTO((rtx, rtx));
extern rtx gen_extendqihi2                             PROTO((rtx, rtx));
extern rtx gen_extendsfdf2                             PROTO((rtx, rtx));
extern rtx gen_movsi                                   PROTO((rtx, rtx));
extern rtx gen_movsi_general                           PROTO((rtx, rtx));
extern rtx gen_movhi                                   PROTO((rtx, rtx));
extern rtx gen_movhi_general                           PROTO((rtx, rtx));
extern rtx gen_movqi                                   PROTO((rtx, rtx));
extern rtx gen_movqi_general                           PROTO((rtx, rtx));
extern rtx gen_movsf                                   PROTO((rtx, rtx));
extern rtx gen_movsf_general                           PROTO((rtx, rtx));
extern rtx gen_movdf                                   PROTO((rtx, rtx));
extern rtx gen_movdf_general                           PROTO((rtx, rtx));
extern rtx gen_nop                                     PROTO((void));
extern rtx gen_indirect_jump                           PROTO((rtx));
extern rtx gen_jump                                    PROTO((rtx));
extern rtx gen_call_value_indirect                     PROTO((rtx, rtx, rtx));
extern rtx gen_call_indirect                           PROTO((rtx, rtx));
extern rtx gen_call_val_internal_return_r1             PROTO((rtx, rtx));
extern rtx gen_call_val_internal_return_r1_halfword    PROTO((rtx, rtx));
extern rtx gen_call_val_internal_return_r1_quarterword PROTO((rtx, rtx));
extern rtx gen_call_val_internal_return_f0_float       PROTO((rtx, rtx));
extern rtx gen_call_val_internal_return_f0f1           PROTO((rtx, rtx));
extern rtx gen_call_val_internal_no_return             PROTO((rtx, rtx));
extern rtx gen_tablejump                               PROTO((rtx, rtx));
extern rtx gen_cmpsi                                   PROTO((rtx, rtx));
extern rtx gen_tstsi                                   PROTO((rtx));
extern rtx gen_cmpdf                                   PROTO((rtx, rtx));
extern rtx gen_cmpsf                                   PROTO((rtx, rtx));
extern rtx gen_beq                                     PROTO((rtx));
extern rtx gen_bne                                     PROTO((rtx));
extern rtx gen_blt                                     PROTO((rtx));
extern rtx gen_bgt                                     PROTO((rtx));
extern rtx gen_ble                                     PROTO((rtx));
extern rtx gen_bge                                     PROTO((rtx));
extern rtx gen_bltu                                    PROTO((rtx));
extern rtx gen_bgtu                                    PROTO((rtx));
extern rtx gen_bleu                                    PROTO((rtx));
extern rtx gen_bgeu                                    PROTO((rtx));
extern rtx gen_seq                                     PROTO((rtx));
extern rtx gen_sne                                     PROTO((rtx));
extern rtx gen_slt                                     PROTO((rtx));
extern rtx gen_sgt                                     PROTO((rtx));
extern rtx gen_sle                                     PROTO((rtx));
extern rtx gen_sge                                     PROTO((rtx));
extern rtx gen_sltu                                    PROTO((rtx));
extern rtx gen_sgtu                                    PROTO((rtx));
extern rtx gen_sleu                                    PROTO((rtx));
extern rtx gen_sgeu                                    PROTO((rtx));
extern rtx gen_int_cond_branch                         PROTO((rtx, rtx));
extern rtx gen_int_cond_branch_rev                     PROTO((rtx, rtx));
extern rtx gen_fp_cond_branch                          PROTO((rtx, rtx));
extern rtx gen_fp_cond_branch_rev                      PROTO((rtx, rtx));
extern rtx gen_set_internal                            PROTO((rtx, rtx, rtx, rtx));

#ifdef MD_CALL_PROTOTYPES
extern rtx gen_call_value                              PROTO((rtx, rtx, rtx));
extern rtx gen_call                                    PROTO((rtx, rtx));

#else /* !MD_CALL_PROTOTYPES */
extern rtx gen_call_value ();
extern rtx gen_call ();
#endif /* !MD_CALL_PROTOTYPES */

#else  /* NO_MD_PROTOTYPES */
extern rtx gen_addsf3 ();
extern rtx gen_adddf3 ();
extern rtx gen_subsf3 ();
extern rtx gen_subdf3 ();
extern rtx gen_mulsf3 ();
extern rtx gen_muldf3 ();
extern rtx gen_divsf3 ();
extern rtx gen_divdf3 ();
extern rtx gen_addsi3 ();
extern rtx gen_subsi3 ();
extern rtx gen_andsi3 ();
extern rtx gen_iorsi3 ();
extern rtx gen_xorsi3 ();
extern rtx gen_negsi2 ();
extern rtx gen_negsf2 ();
extern rtx gen_negdf2 ();
extern rtx gen_one_cmplqi2 ();
extern rtx gen_one_cmplhi2 ();
extern rtx gen_one_cmplsi2 ();
extern rtx gen_ashlsi3 ();
extern rtx gen_ashrsi3 ();
extern rtx gen_lshrsi3 ();
extern rtx gen_mulsi3 ();
extern rtx gen_divsi3 ();
extern rtx gen_udivsi3 ();
extern rtx gen_floatsisf2 ();
extern rtx gen_floatsidf2 ();
extern rtx gen_fix_truncsfsi2 ();
extern rtx gen_fix_truncdfsi2 ();
extern rtx gen_truncdfsf2 ();
extern rtx gen_truncsihi2 ();
extern rtx gen_truncsiqi2 ();
extern rtx gen_trunchiqi2 ();
extern rtx gen_zero_extendqihi2 ();
extern rtx gen_zero_extendhisi2 ();
extern rtx gen_zero_extendqisi2 ();
extern rtx gen_extendqisi2 ();
extern rtx gen_extendhisi2 ();
extern rtx gen_extendqihi2 ();
extern rtx gen_extendsfdf2 ();
extern rtx gen_movsi ();
extern rtx gen_movsi_general ();
extern rtx gen_movhi ();
extern rtx gen_movhi_general ();
extern rtx gen_movqi ();
extern rtx gen_movqi_general ();
extern rtx gen_movsf ();
extern rtx gen_movsf_general ();
extern rtx gen_movdf ();
extern rtx gen_movdf_general ();
extern rtx gen_nop ();
extern rtx gen_indirect_jump ();
extern rtx gen_jump ();
extern rtx gen_call_value_indirect ();
extern rtx gen_call_indirect ();
extern rtx gen_call_val_internal_return_r1 ();
extern rtx gen_call_val_internal_return_r1_halfword ();
extern rtx gen_call_val_internal_return_r1_quarterword ();
extern rtx gen_call_val_internal_return_f0_float ();
extern rtx gen_call_val_internal_return_f0f1 ();
extern rtx gen_call_val_internal_no_return ();
extern rtx gen_tablejump ();
extern rtx gen_cmpsi ();
extern rtx gen_tstsi ();
extern rtx gen_cmpdf ();
extern rtx gen_cmpsf ();
extern rtx gen_beq ();
extern rtx gen_bne ();
extern rtx gen_blt ();
extern rtx gen_bgt ();
extern rtx gen_ble ();
extern rtx gen_bge ();
extern rtx gen_bltu ();
extern rtx gen_bgtu ();
extern rtx gen_bleu ();
extern rtx gen_bgeu ();
extern rtx gen_seq ();
extern rtx gen_sne ();
extern rtx gen_slt ();
extern rtx gen_sgt ();
extern rtx gen_sle ();
extern rtx gen_sge ();
extern rtx gen_sltu ();
extern rtx gen_sgtu ();
extern rtx gen_sleu ();
extern rtx gen_sgeu ();
extern rtx gen_int_cond_branch ();
extern rtx gen_int_cond_branch_rev ();
extern rtx gen_fp_cond_branch ();
extern rtx gen_fp_cond_branch_rev ();
extern rtx gen_set_internal ();
extern rtx gen_call_value ();
extern rtx gen_call ();
#endif  /* NO_MD_PROTOTYPES */
