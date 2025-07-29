; Memory read/write test NUMBER 0
; 
; 1st phase
;  - Sets registers r5,r6 and r7 to oxffffffff
;  - Initializes the data memory
,  - Reads 3 different memory cells aligned at the word boundary respectively in r5 as word, in r6 as half word
;    and in r7 as byte
;  - Writes back into the memory the contents of r5,r6,r7 as words
;  - Writes back into the memory the contents of r5,r6,r7 as half words (each twice at two
;    consecutive half word aligned addresses
;  - Writes back into the memory the contents of r5,r6,r7 as bytes (each 4 times at 4 consecutive
;    byte addresses
;
; 2nd phase
; Reads 2 different memory cells aligned at the HALF WORD boundary respectively in r5 as word and in r6
; as byte
; Reads 
.text	0x000
init:
	j	start
	nop
.text	0x100	
start:
	add r1,r0,r0    ;  clear R1
	add r2,r0,r0     ; clear R2
	add r3,r0,r0	; clear R3
	add r4,r0,r0	; clear R4
	add r5,r0,r0    ; clear R5
	subi r5,r5,#1	; sets r5 to 0xffffffff
	add r6,r5,r0    ; sets r6 to 0xffffffff 
	add r7,r5,r0    ; sets r7 to 0xffffffff
	add r8,r0,r0    ; clear R8
	add r9,r0,r0    ; clear R9
	add r10,r0,r0	; clear R10
	add r11,r0,r0	; clear R11
	add r12,r0,r0	; clear R12
	add r13,r0,r0	; clear R13
	add r14,r0,r0	; clear R14
	add r15,r0,r0	; clear R15
	add r16,r0,r0	; clear R16
	;
	; PHASE 0 - STORE in memory the original register content
	;
	sw tstdst(r0),r5
	sw tstdst+4(r0),r6
	sw tstdst+8(r0),r7
	sw tstdst+12(r0),r8
	;
	; Initializes the data memory
	;
	lhi	r1,#0x55ff
	addui	r1,r1,#0xaa11
	sw	src1(r2),r1
	lhi	r1,#0x3377
	addui	r1,r1,#0xff55
	sw	src1+4(r2),r1
	lhi	r1,#0x44aa
	addui	r1,r1,#0x0710
	sw	src1+8(r2),r1
	lhi	r1,#0x0000
	addui	r1,r1,#0x0002
	sw	src1+12(r2),r1
	;
	lhi	r1,#0x1122
	addui	r1,r1,#0x3344
	sw	src2(r2),r1
	lhi	r1,#0x5566
	addui	r1,r1,#0x7788
	sw	src2+4(r2),r1
	lhi	r1,#0x99aa
	addui	r1,r1,#0xbbcc
	sw	src2+8(r2),r1
	lhi	r1,#0xddee
	addui	r1,r1,#0xf00a
	sw	src2+12(r2),r1
	add r1,r0,r0    ;  clear R1
	;
	; PHASE 1 - READ Data aligned to the word
	;
	lw  r5,src1(r2)	; read a word aligned to word 
	addi	r2,r2,4	; inc. pointer
	lh  r6,src1(r2)	; read half word aligned to word
	addi	r2,r2,4	; inc. pointer
	lb  r7,src1(r2)	; read byte aligned to word
			;
	sw dst1(r1),r5	; Writes back the content of registers r5,r6,r7 as words
	addui	r1,r1,4	; pointer increment
	sw dst1(r1),r6
	addui	r1,r1,4
	sw dst1(r1),r7
	addui	r1,r1,4
	; writes back (twice) the content of the registers as half words
	sh dst1(r1),r5
	addui	r1,r1,2	; increments the pointer
	sh dst1(r1),r5
	addui	r1,r1,2	; increments the pointer
	sh dst1(r1),r6	
	addui	r1,r1,2	; increments the pointer
	sh dst1(r1),r6	
	addui	r1,r1,2	; increments the pointer
	sh dst1(r1),r7	
	addui	r1,r1,2	; increments the pointer
	sh dst1(r1),r7
	addui	r1,r1,2	; increments the pointer
	;
	; Writes back (4 times) the content of the registers as bytes
	;
	sb  dst1(r1),r5
	addui	r1,r1,1	; increments the pointer
	sb  dst1(r1),r5
	addui	r1,r1,1	; increments the pointer
	sb  dst1(r1),r5
	addui	r1,r1,1	; increments the pointer
	sb  dst1(r1),r5
	addui	r1,r1,1	; increments the pointer
	sb  dst1(r1),r6
	addui	r1,r1,1	; increments the pointer
	sb  dst1(r1),r6
	addui	r1,r1,1	; increments the pointer
	sb  dst1(r1),r6
	addui	r1,r1,1	; increments the pointer
	sb  dst1(r1),r6
	addui	r1,r1,1	; increments the pointer
	;
	; PHASE 2 - READ Data aligned to the half word
	;
	add r8,r0,r0    ; clear R8		; Re-initialization
	add r1,r0,r0	; clear r0
	subi r8,r8,#1	; sets r8 to 0xffffffff
	add r9,r8,r0    ; sets r9 to 0xffffffff 
	add r10,r8,r0   ; sets r10 to 0xffffffff
	addi r2,r0,#2	; set r2 to 2
	addi r3,r0,#3	; set r3 to 3
	;	
	lh  r8,src2(r2)	; lettura memoria a mezza parola allinata a mezza parola
	lb  r9,src2(r2) ; lettura memoria a byte allineato a mezza parola
	lb  r10,src2(r3); lettura memoria a byte allineato a byte (ind. dispari)
			;
	sw dst2(r1),r5	; Writes back  registers r8,r9,r10 as words
	addui	r1,r1,4	; pointer increment
	sw dst2(r1),r6
	addui	r1,r1,4
	sw dst2(r1),r7
	addui	r1,r1,4			;
;	
	j  end
	nop
			;
end:
	trap 0x400    	; end
	nop
	nop
			;
.data	0x300
src1:
	.word 	0x55ffaa11,0x3377ff55,0x44aa0710,2
src2:
	.word	0x11223344,0x55667788,0x99aabbcc,0xddeef00a
tstdst:
	.word	0,0,0,0			; target memory for initial values
dst1:
 	.word	0,0,0,0,0,0,0,0  	; target memory #1
 	.word	0,0,0,0,0,0,0,0
dst2:
	.word	0,0,0,0,0,0,0,0		; target memory #2
dst3:	.word	0,0,0,0

