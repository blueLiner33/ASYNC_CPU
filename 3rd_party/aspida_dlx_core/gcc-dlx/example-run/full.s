; Linked by DLX-LD.
; MemSize 20480
; Data size: 12
; Text size: 328
; Stack size: 8192
.text 0x0000
.data 0x1000
;;; Ethan L. Miller, 1999.  Released to the public domain
;;;
;;; Most of the traps are called in files from libtraps.

.text
.align 2
.proc _exit
.global _exit
_exit:
	trap	0x300
	jr	r31
	nop
.endproc _exit

; for the benefit of gcc.
.proc ___main
.global ___main
___main:
	jr	r31
	nop
.endproc ___main


;---------------------------------------------------------------------------------------
;
; MULT --- MULT --- MULT --- MULT --- MULT --- MULT
;
; Signed 32 x 32 -> 32 bit Multiply routine
; 
; This version takes the two operands from the stack (dividend and divisor in the
; order) and returns in r1 the result according to the standard C call
; c = mult(a,b);
; register r29 is assumed to be the stack pointer
; all other used registers are saved into the stack and restored on the return
;
; For internal debugging purposes this is the internal use of the registers
;  r5 multiplicand
;  r6 multiplier
;  r7 result
;  r1 counter
;  r2 mask
;  r3 scratch
;		
;  r29 Stack pointer
;  r30 Frame Pointer
;  r31 Return address
;
; F.Gregoretti January 7th 2004
; 

.align 2
.proc _mult
.global _mult
_mult:; initial operations
	sw	-4(r29),r30; save frame pointer
	add	r30,r29,r0; new fp = sp
	subui	r29,r29,#28; allocate space for saving registers  in the stack
	sw	0(r29),r2; save r2
	sw	4(r29),r3; save r3
	sw	8(r29),r5; save r5
	sw	12(r29),r6; save r6
	sw	16(r29),r7; save r7
	sw	16(r29),r8; save r7				;
	lw	r5,0(r30); load multiplicand from the stack
	lw	r6,4(r30); load multiplier from the stack
	add	r8,r0,r0; Clear r8
	sgt	r3,r0,r5; test dividend  r3 = 0 if positive)
	beqz	r3,m0_pos1_LF1
	nop
	addi	r8,r8,#1; sets flag
	sub	r5,r0,r5; changes sign to the multiplicand
m0_pos1_LF1:
	sgt	r3,r0,r6; test divisor
	beqz	r3,m0_pos2_LF1
	nop; delay slot
	subi	r8,r8,#1; sets flag 
	sub	r6,r0,r6; changes sign to the multiplier
m0_pos2_LF1:; flag = 0 if dividend and divisor are both pos or neg				;
	addi	r1,r0,#32; set counter r1 to 32
	addi	r2,r0,#1; create mask on LSB with r2
	add	r7,r0,r0
m0_loop_LF1:
	add	r3,r0,r6; moves r6 into r3
	and	r3,r3,r2; r3 has the value of the LSB of r6
	beqz	r3,m0_noadd_LF1; bit is 0
	nop
	add	r7,r7,r5; bit is 1 - addition
m0_noadd_LF1:
	srli	r6,r6,#1; shift right the multiplier to test next bit
	slli	r5,r5,#1; shift left the multiplicand to multiply by 2
	subi	r1,r1,#1; decrement the counter
	bnez	r1,m0_loop_LF1
	nop
	beqz	r8,m0_endmul_LF1; test for sign of the result
	nop
	sub	r7,r0,r7
m0_endmul_LF1:
	add	r1,r0,r7; put result into r1
	lw	r7,16(r29); restore r7
	lw	r6,12(r29); restore r6
	lw	r5,8(r29); restore r5
	lw	r3,4(r29); restore r3
	lw	r2,0(r29); restore r2
	add	r29,r30,r0; restore stack pointer
	lw	r30,-4(r29); restore old frame pointer
	jr	r31; return from subroutine
	nop
; Compiled by GCC

.align 2
.proc _main
.global _main
_main:
;  Function 'main'; 0 bytes of locals, 0 regs to save.
	sw	-4(r29),r30; push fp
	add	r30,r0,r29; fp = sp
	sw	-8(r29),r31; push ret addr
	subui	r29,r29,8; alloc local storage
	jal	___main
	nop; delay slot nop
	lhi	r2,((_c_LF2)>>16)&0xffff
	addui	r2,r2,(_c_LF2)&0xffff
	lhi	r1,((_a_LF2)>>16)&0xffff
	addui	r1,r1,(_a_LF2)&0xffff
	lhi	r3,((_b_LF2)>>16)&0xffff
	addui	r3,r3,(_b_LF2)&0xffff
	lw	r4,(r1)
	lw	r3,(r3)
	addi	r29,r29,-8
	sw	(r29),r4
	sw	4(r29),r3
	jal	_mult
	nop; delay slot nop
	addi	r29,r29,8
	add	r4,r0,r1
	sw	(r2),r4
	lhi	r2,((_c_LF2)>>16)&0xffff
	addui	r2,r2,(_c_LF2)&0xffff
	lw	r1,(r2)
	j	L1_LF2
	nop; delay slot nop
L1_LF2:
	jal	_exit
	nop
.endproc _main
.data
.align 2
_a_LF2:
.space 4
.align 2
_b_LF2:
.space 4
.align 2
_c_LF2:
.space 4
.text
.global _etext
_etext:
.align 3
.data
.global _edata
_edata:
