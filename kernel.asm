.org 00000H
.assume ADL=0
	di
	rsmix
	jp.lil initkernel
	di
	nop
	jp.lil syscall
	.fill (038H-$)
	di
	nop
	jp.lil interrupthandler
	.fill (066h-$)
	ld.lil hl,(execaddr4initprg+3)
	jp.lil (hl)
	.fill (0100h-$)
.assume ADL=1
execaddr4initprg:
	.dl lplp
	.dl nmihandler
initkernel:
	ld sp,0d40000h
	ld hl,0182Bh
	ld (0f80000h),hl
	ld hl,02000Bh
	ld (0f80004h),hl
	ld hl,010Ch
	ld (0f80008h),hl
	ld hl,02h
	ld (0f8000Ch),hl
	ld hl,021h
	ld (0f80010h),hl
	ld.sis bc,0d018h
;wakeup
	;ld a,11h
	;call spicommunticate_
;turn on the display
	;ld a,29h
	;call spicommunticate_

	ld a,00h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,03h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,07h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,01h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,02h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,06h
	out (bc),a
	ld a,04h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,00h
	out (bc),a
	ld a,05h
	out (bc),a
	ld a,01h
	out (bc),a

	in0 a,(0dh)
	set 3,a
	out0 (0dh),a

	in0 a,(05h)
	set 4,a
	out0 (05h),a

	ld hl,0A0338h
	ld (0e30000h),hl
	ld a,01Fh
	ld (0e30003h),a
	ld hl,02093Fh
	ld (0e30004h),hl
	ld a,04h
	ld (0e30007h),a
	ld hl,0EF7802h
	ld (0e30008h),hl
	ld a,0h
	ld (0e3000bh),a
	ld hl,0h
	ld (0e3000ch),hl
	ld a,0h
	ld (0e3000fh),a
	ld hl,0D40000h
	ld (0e30010h),hl
	ld a,0h
	ld (0e30013h),a
	ld hl,0h
	ld (0e30014h),hl
	ld a,0h
	ld (0e30017h),a
	ld hl,092dh
;1000100101101b
	ld (0e30018h),hl
	ld a,0h
	ld (0e3001bh),a
	ld a,(0f00004h)
	set 4,a
	ld (0f00004h),a
	ld a,0
	ld (0f60024h),a
	stmix
	ld a,0d0h
	ld mb,a
	xor a,a
	set 0,a
	ld (context4ct+(3*10)),a
	xor a,a
	ld (contextcount),a
	im 1
	ld hl,(execaddr4initprg)
	ei
	
	jp (hl)
lplp:	jr lplp
spicommunticate_:
	or a,a
	jr spicommunticate
	scf
spicommunticate:
	ld.sis bc,0d018h
	rla
	rla
	rla
	out (bc),a
	rla
	rla
	rla
	out (bc),a
	rla
	rla
	rla
	out (bc),a
	xor a,a
	ld.sis bc,0d008h
	out (bc),a
	ret
syscall:
	cp a,0
	jp z,syscall_add_tsk
	cp a,1
	jp z,syscall_ter_tsk
	cp a,2
	jp z,syscall_get_tskid
	cp a,3
	jp z,syscall_flashaccess
	cp a,4
	jp z,syscall_add_tsk_new
	ld hl,-1
	ei
	ret.l
context4ct:	.equ 0d10000h
context:	.equ 0d10100h
contextcount:	.equ 0d18100h
; add_tsk -- void add_tsk(void* newstack);
syscall_add_tsk:
	di
	ld (contextcount+(3*2)),ix
	ld ix,0
	add ix,sp
	ld hl,(ix+((3*1)+(4)))
	ld (contextcount+(3*1)),hl
	call backupthecurrentcontext
	ld a,(contextcount)
syscall_add_tsk_:
	inc a
	ld e,128
	ld d,a
	ld (contextcount),a
	mlt de
	ld hl,context+(3*10)
	add hl,de
	ld a,(hl)
	bit 0,a
	ld a,(contextcount)
	jr nz,syscall_add_tsk_
	set 0,a
	ld (hl),a
	ld sp,(contextcount+(3*1))
	ld (context4ct+(3*8)),sp
	ld ix,(contextcount+(3*2))
	jp nextcontextload
; ter_tsk -- UINT24 ter_tsk(UINT8 taskid);
syscall_ter_tsk:
	di
	ld (contextcount+(3*2)),ix
	ld ix,0
	add ix,sp
	ld hl,(ix+((3*1)+(4)))
	ld (contextcount+(3*1)),hl
	ld a,l
syscall_ter_tsk_:
	ld e,128
	ld d,a
	mlt de
	ld hl,context+(3*10)
	add hl,de
	ld a,(hl)
	bit 0,a
	jr z,syscall_ter_tsk_err
	res 0,a
	res 1,a
	ld (hl),a
	ld hl,0
	ld ix,(contextcount+(3*2))
	ei
	ret.l
syscall_ter_tsk_err:
	ld hl,-1
	ld ix,(contextcount+(3*2))
	ei
	ret.l

; get_tskid -- UINT8 get_tskid(void);
syscall_get_tskid:
	ld hl,0
	ld a,(contextcount)
	ld l,a
	ei
	ret.l

;flashaccess -- used from assembly
syscall_flashaccess:
	di
	in0 a,(06h)
	ld (context4ct+(3*10)+1),a
	set 2,a
	out0 (06h),a
	ld a,0ffh

	di
	jr syscall_flashaccess_
syscall_flashaccess_:
	di
	di
	rsmix
	im 1
	out0 (028h),a
	in0 a,(028h)
	bit 2,a
	stmix

	ldir
	ld a,(context4ct+(3*10)+1)
	out0 (06h),a
	ld hl,0
	ei
	ret.l

; add_tsk_new -- void add_tsk_new(void* newstack,bool pagingenable);
syscall_add_tsk_new:
	di
	ld (contextcount+(3*2)),ix
	ld ix,0
	add ix,sp
	ld hl,(ix+((3*1)+(4)))
	ld (contextcount+(3*1)),hl
	ld hl,(ix+((3*2)+(4)))
	ld (contextcount+(3*3)),hl
	call backupthecurrentcontext
	ld a,(contextcount)
syscall_add_tsk_new_:
	inc a
	ld e,128
	ld d,a
	ld (contextcount),a
	mlt de
	ld hl,context+(3*10)
	add hl,de
	ld a,(hl)
	bit 0,a
	ld a,(contextcount)
	jr nz,syscall_add_tsk_new_
	set 0,a
	ld (hl),a
	ld sp,(contextcount+(3*1))
	ld (context4ct+(3*8)),sp
	ld hl,(contextcount+(3*3))
	bit 0,l
	jr nz,syscall_add_tsk_new__
	ld a,(context4ct+(3*10))
	or a,1
	ld (context4ct+(3*10)),a
	ld ix,(contextcount+(3*2))
	jp nextcontextload
syscall_add_tsk_new__:
	ld a,(context4ct+(3*10))
	or a,3
	ld (context4ct+(3*10)),a
	ld ix,(contextcount+(3*2))
	jp nextcontextload

backupthecurrentcontext:
	ld.lil (context4ct+(3*0)),bc
	ld.lil (context4ct+(3*1)),de
	ld.lil (context4ct+(3*2)),hl
	push af
	pop hl
	ld.lil (context4ct+(3*3)),hl
	ex af,af'
	exx
	ld.lil (context4ct+(3*4)),bc
	ld.lil (context4ct+(3*5)),de
	ld.lil (context4ct+(3*6)),hl
	push af
	pop hl
	ld.lil (context4ct+(3*7)),hl
	ex af,af'
	exx
	ld.lil (context4ct+(3*8)),sp
	ld hl,0
	add.sis hl,sp
	ld.lil (context4ct+(3*9)),hl
	ld a,mb
	ld.lil (context4ct+((3*9)+2)),a
	ld.lil a,(context4ct+(3*10))
	bit 1,a
	jp nz,cs_pagein_bc
;backup current context
backupcontext_bc:
	ld bc,128
	ld e,128
	ld a,(contextcount)
	ld d,a
	inc a
	ld (contextcount),a
	mlt de
	ld hl,context
	add hl,de
	ex de,hl
	ld hl,context4ct
	ldir
	ex de,hl
	ret

interrupthandler:
	di
	ld.lil (context4ct+(3*0)),bc
	ld.lil (context4ct+(3*1)),de
	ld.lil (context4ct+(3*2)),hl
	push af
	pop hl
	ld.lil (context4ct+(3*3)),hl
	ex af,af'
	exx
	ld.lil (context4ct+(3*4)),bc
	ld.lil (context4ct+(3*5)),de
	ld.lil (context4ct+(3*6)),hl
	push af
	pop hl
	ld.lil (context4ct+(3*7)),hl
	ex af,af'
	exx
	ld.lil (context4ct+(3*8)),sp
	ld hl,0
	add.sis hl,sp
	ld.lil (context4ct+(3*9)),hl
	ld a,mb
	ld.lil (context4ct+((3*9)+2)),a
	ld.lil a,(context4ct+(3*10))
	bit 1,a
	jp nz,cs_pagein
;backup current context
backupcontext:
	ld bc,128
	ld e,128
	ld a,(contextcount)
	ld d,a
	inc a
	ld (contextcount),a
	mlt de
	ld hl,context
	add hl,de
	ex de,hl
	ld hl,context4ct
	ldir
	ex de,hl
	ld a,(contextcount)
;read next context
contextloop:
	ld hl,0
	ld (context4ct+(3*10)),hl
	ld (contextcount),a
	ld bc,128
	ld e,128
	ld a,(contextcount)
	ld d,a
	mlt de
	ld hl,context
	add hl,de
	ld de,context4ct
	ldir
	ld a,(context4ct+(3*10))
	ld b,a
	ld a,(contextcount)
	inc a
	bit 0,b
	jr z,contextloop
;restore context
nextcontextload:
	bit 1,b
	jp nz,cs_pageout
nextcontextload_:
	ld.lil a,(context4ct+((3*9)+2))
	ld mb,a
	ld.lil sp,(context4ct+(3*8))
	ld.lil hl,(context4ct+(3*9))
	ld.sis sp,hl

	ld.lil hl,(context4ct+(3*3))
	push hl
	pop af
	ld.lil bc,(context4ct+(3*0))
	ld.lil de,(context4ct+(3*1))
	ld.lil hl,(context4ct+(3*2))
	ex af,af'
	exx
	ld.lil hl,(context4ct+(3*7))
	push hl
	pop af
	ld.lil bc,(context4ct+(3*4))
	ld.lil de,(context4ct+(3*5))
	ld.lil hl,(context4ct+(3*6))
	ex af,af'
	exx
	ei
	reti.l
cs_pageout:
	in0 a,(06h)
	ld (context4ct+(3*10)+1),a
	set 2,a
	out0 (06h),a
	ld hl,cs_pageout_
	jp unlockthememory
cs_pageout_:
	ld hl,(context4ct+(3*11))
	ld de,0d00000h
	ld bc,65536
	ldir
	ld a,(context4ct+(3*10)+1)
	out0 (06h),a
	jp nextcontextload_
cs_pagein:
	in0 a,(06h)
	ld (context4ct+(3*10)+1),a
	set 2,a
	out0 (06h),a
	ld hl,cs_pagein_
	jp unlockthememory
cs_pagein_:
	ld hl,0d00000h
	ld de,(context4ct+(3*11))
	ld bc,65536
	ldir
	ld a,(context4ct+(3*10)+1)
	out0 (06h),a
	jp backupcontext

cs_pagein_bc:
	in0 a,(06h)
	ld (context4ct+(3*10)+1),a
	set 2,a
	out0 (06h),a
	ld hl,cs_pagein_bc_
	jp unlockthememory
cs_pagein_bc_:
	ld hl,0d00000h
	ld de,(context4ct+(3*11))
	ld bc,65536
	ldir
	ld a,(context4ct+(3*10)+1)
	out0 (06h),a
	jp backupcontext_bc


unlockthememory:
	ld a,0ffh

	di
	jr unlockthememory_
unlockthememory_:
	di
	di
	rsmix
	im 1
	out0 (028h),a
	in0 a,(028h)
	bit 2,a
	stmix
	jp (hl)
nmihandler:
	di
	ei
	reti.l
