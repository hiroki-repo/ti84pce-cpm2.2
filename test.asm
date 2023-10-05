.org 0100000H
.assume ADL=1
main:
	ld hl,0d40000h
	ld de,0d40001h
	ld bc,153600
	ld a,r
	ld (hl),a
	ldir
	jr main
;lplp:	jr lplp

