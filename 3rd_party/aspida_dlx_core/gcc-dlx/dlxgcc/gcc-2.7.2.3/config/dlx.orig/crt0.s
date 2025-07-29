;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
.proc _close
.global _close
_close:		
	trap	#0x214
	jr	r31
	nop
.endproc _close
;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
.proc _exit
.global _exit
_exit:		
	trap	#0x300
	jr	r31
	nop
.endproc _exit
.text
.proc _lseek
.global _lseek
_lseek:		
	trap	#0x212
	jr	r31
	nop
.endproc _lseek
;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
.proc _open
.global _open
_open:		
	trap	#0x213
	jr	r31
	nop
.endproc _open
;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
.proc _printf
.global _printf
_printf:		
	trap	#0x201
	jr	r31
	nop
.endproc _printf
;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
.proc _random
.global _random
_random:		
	trap	#0x220
	jr	r31
	nop
.endproc _random
;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
.proc _read
.global _read
_read:		
	trap	#0x210
	jr	r31
	nop
.endproc _read
;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
.proc _srandom
.global _srandom
_srandom:		
	trap	#0x221
	jr	r31
	nop
.endproc _srandom
;
; Stub functions for DLX traps.
;
; Aaron Sawdey 1996; released to the Public Domain.
;
.text
.proc _write
.global _write
_write:		
	trap	#0x211
	jr	r31
	nop
.endproc _write

; for the benefit of gcc.
.proc ___main
.global ___main
___main:
	jr	r31
	nop
.endproc ___main
