

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
.text
	.align	2
.proc	_mult
.global _mult
_mult:				; initial operations
	sw	-4(r29),r30	; save frame pointer
	add	r30,r29,r0	; new fp = sp
	subui	r29,r29,#28	; allocate space for saving registers  in the stack
	sw	0(r29),r2	; save r2
	sw	4(r29),r3	; save r3
	sw	8(r29),r5	; save r5
	sw	12(r29),r6	; save r6
	sw	16(r29),r7	; save r7
	sw	16(r29),r8	; save r7				;
	lw	r5,0(r30)	; load multiplicand from the stack
	lw	r6,4(r30)	; load multiplier from the stack
	add	r8,r0,r0	; Clear r8
	sgt	r3,r0,r5	; test dividend  r3 = 0 if positive)
	beqz	r3,m0_pos1
	nop
	addi	r8,r8,#1	; sets flag
	sub	r5,r0,r5	; changes sign to the multiplicand
m0_pos1:
	sgt	r3,r0,r6	; test divisor
	beqz	r3,m0_pos2
	nop			; delay slot
	subi	r8,r8,#1	; sets flag 
	sub	r6,r0,r6	; changes sign to the multiplier
m0_pos2:			; flag = 0 if dividend and divisor are both pos or neg				;
	addi	r1,r0,#32   	; set counter r1 to 32
	addi	r2,r0,#1	; create mask on LSB with r2
	add	r7,r0,r0
m0_loop:
	add	r3,r0,r6	; moves r6 into r3
	and	r3,r3,r2	; r3 has the value of the LSB of r6
	beqz	r3,m0_noadd	; bit is 0
	nop
	add	r7,r7,r5	; bit is 1 - addition
m0_noadd:
	srli	r6,r6,#1	; shift right the multiplier to test next bit
	slli	r5,r5,#1	; shift left the multiplicand to multiply by 2
	subi	r1,r1,#1	; decrement the counter
	bnez	r1,m0_loop
	nop
	beqz	r8,m0_endmul	; test for sign of the result
	nop
	sub	r7,r0,r7
m0_endmul:	
	add	r1,r0,r7	; put result into r1
	lw	r7,16(r29)	; restore r7
	lw	r6,12(r29)	; restore r6
	lw	r5,8(r29)	; restore r5
	lw	r3,4(r29)	; restore r3
	lw	r2,0(r29)	; restore r2
	add	r29,r30,r0	; restore stack pointer
	lw	r30,-4(r29)	; restore old frame pointer
	jr	r31		; return from subroutine
	nop
