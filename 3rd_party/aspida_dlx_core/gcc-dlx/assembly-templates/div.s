;--------------------------------------------------------------------------
;
; DIV --- DIV --- DIV --- DIV --- DIV --- DIV
;
; Signed division 32 bit x 32 bit -> 32 bit
;
; This version takes the two operands from the stack (dividend and divisor in
; the order) and returns in r1 the result according to the standard C call
; c = div(a,b);
; register r29 is assumed to be the stack pointer
; all other used registers are saved into the stack and restored 
; In case of a division by 0 no exception will be generated and a result
; corresponding to the maximum value of a 32 bit number (0x7fffffff) will
; be returned
;
; For internal debugging purposes this is the internal use of the registers
;  r5 dividend
;  r6 divisor
;  r7 quotient
;  r5 remainder at the end of the algorithm	
;  r1 used as movable mask		
;  r3 used as test register
;  r2 used as MSB positive mask
;  r29 Stack pointer
;  r30 Frame Pointer
;  r31 Return address
;
; F.Gregoretti January 2004
;
.text
	.align	2
.proc	_div
.global _div
_div:				; initial operations
	sw	-4(r29),r30	; save frame pointer
	add	r30,r29,r0	; new fp = sp
	subui	r29,r29,#24	; allocate space for saving registers  in the stack
	sw	0(r29),r2	; save r2
	sw	4(r29),r3	; save r3
	sw	8(r29),r5	; save r5
	sw	12(r29),r6	; save r6
	sw	16(r29),r7	; save r7
	lw	r5,0(r30)	; load dividend from the stack
	lw	r6,4(r30)	; load divisor from the stack
				; Start division algorithm
	beqz	r6,d0_ovfl	; test division by 0
	nop			; delay slot
	addi	r1,r0,#1   	; set movable mask to 1
	slli	r2,r1,#31	; create mask for MSB in r2
				; test signs of dividend and divisor
				; using r3 and r7 as scratch and r8 for storing the sign
	add	r8,r0,r0	; Clear r8
	sgt	r3,r0,r5	; test dividend  r3 = 0 if positive)
	beqz	r3,d0_pos1
	nop
	addi	r8,r8,#1	; sets flag
	sub	r5,r0,r5	; changes sign to the dividend
d0_pos1:
	sgt	r3,r0,r6	; test divisor
	beqz	r3,d0_pos2
	nop			; delay slot
	subi	r8,r8,#1	; sets flag 
	sub	r6,r0,r6	; changes sign to the divisor
d0_pos2:			; flag = 0 if dividend and divisor are both pos or neg
	add	r7,r0,r0	; clear quotient (may be unuseful ?)
				; possono essere utilizzati vari delay slot 
				; modifica 1.1.2004 for unsigned mult
	subu	r3,r5,r6	; r3 <0 if dividend < divisor
	slt	r3,r3,r0	; set r3 if dividend < divisor
	beqz	r3,d0_loop0	; if not continue the algorithm
	nop			; delay slot (check if necessary)
	add	r7,r0,r0	; if yes clear quotient and
;	add	r8,r0,r5	, set remainder = dividend inutile 6.1.2004
	j	d0_enddiv
	nop			; delay slot (check if necessary)
d0_loop0:
	and	r3,r5,r2	; Controlla se MSB del divisore = 1
	bnez	r3,d0_endl2	; per evitare che con lo shift esca
	nop			; delay slot
d0_loop1:				; 1st phase align dividend and divisor
	slli	r6,r6,#1	; shift left r6 (divisor x 2)
	slli	r1,r1,#1	; shift left r1
	subu	r3,r5,r6	; r3 <0 if dividend < divisor
	slt	r3,r3,r0	; set r3 if dividend < divisor
	bnez	r3,d0_endlop1	; if yes stop shifting - correzione 30.12.03
	nop			; delay slot
	and 	r3,r1,r2	; test for maximum shift (MSB of r1=1)
	beqz	r3,d0_loop1	; Se la condizione si verifica significa
				; che il divisore 
				; e in tal caso non si shifta di nuovo a dx
	nop			; delay slot
	j	d0_endl2		; 
	nop			; delay slot
d0_endlop1:
	srli	r6,r6,#1
	srli	r1,r1,#1 	
d0_endl2:			; dividendo e divisore allineati
	subu	r5,r5,r6	; dividend - shifted divisor 
	or	r7,r7,r1	; set the correct bit in the quotient
d0_endlop3:
	srli	r6,r6,#1
	srli	r1,r1,#1 	;
	beqz	r1,d0_endd1
	nop
	subu	r3,r5,r6	; r3 <0 if dividend < divisor
	slt	r3,r3,r0	; set r3 if dividend < divisor
	bnez	r3,d0_endlop3
	nop
	j	d0_endl2
	nop
d0_endd1:			; if r8 neq 0 change sign quotient and rem.
	beqz	r8,d0_enddiv
	nop
	sub	r7,r0,r7
	sub	r6,r0,r6
	j	d0_enddiv
	nop
d0_ovfl:			; set quotient and remainder to 0x7fffffff
	subui	r7,r0,#1
	srli	r7,r7,#1
	add	r6,r7,r0
d0_enddiv:	
	add	r1,r7,r0	; put quotient in r1
	lw	r7,16(r29)	; restore r7
	lw	r6,12(r29)	; restore r6
	lw	r5,8(r29)	; restore r5
	lw	r3,4(r29)	; restore r3
	lw	r2,0(r29)	; restore r2
	add	r29,r30,r0	; restore stack pointer
	lw	r30,-4(r29)	; restore old frame pointer
	jr	r31		; return from subroutine
	nop
