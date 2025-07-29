; Compiled by GCC
.text
	.align 2
.proc _main
.global _main
_main:
;  Function 'main'; 0 bytes of locals, 0 regs to save.
	sw	-4(r29),r30	; push fp
	add	r30,r0,r29	; fp = sp
	sw	-8(r29),r31	; push ret addr
	subui	r29,r29,8	; alloc local storage
	jal	___main
	nop	; delay slot nop
	lhi	r2,((_c)>>16)&0xffff
	addui	r2,r2,(_c)&0xffff
	lhi	r1,((_a)>>16)&0xffff
	addui	r1,r1,(_a)&0xffff
	lhi	r3,((_b)>>16)&0xffff
	addui	r3,r3,(_b)&0xffff
	lw	r4,(r1)
	lw	r3,(r3)
	addi	r29,r29,-8
	sw	(r29),r4
	sw	4(r29),r3
	jal	_mult
	nop	; delay slot nop
	addi	r29,r29,8
	add	r4,r0,r1
	sw	(r2),r4
	lhi	r2,((_c)>>16)&0xffff
	addui	r2,r2,(_c)&0xffff
	lw	r1,(r2)
	j	L1
	nop	; delay slot nop
L1:
	jal	_exit
	nop
.endproc _main
.data
	.align 2
_a:
	.space 4
	.align 2
_b:
	.space 4
	.align 2
_c:
	.space 4
