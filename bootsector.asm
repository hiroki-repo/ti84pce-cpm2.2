.org 08000H
.assume ADL=0
lplp:
	ld.lil bc,1024*8
	ld.lil de,0d0dc00h
	ld.lil hl,0110080h
	ldir.lil
	jp 0f200h
