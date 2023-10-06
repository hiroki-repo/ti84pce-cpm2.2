.org 0f200H
.assume ADL=0
boot:	 jp biosboot 
wboot:	 jp bioswboot 
const:	 jp biosconst 
conin:	 jp biosconin 
conout:	 jp biosconout 
listd:	 jp bioslist 
punch:	 jp biospunch 
reader:	 jp biosreader 
home:	 jp bioshome 
seldsk:	 jp biosseldsk 
settrk:	 jp biossettrk 
setsec:	 jp biossetsec 
setdma:	 jp biossetdma 
read:	 jp biosread 
write:	 jp bioswrite 
listst:	 jp bioslistst 
sectrn:	 jp biossectrn

;
;	Data tables for disks
;	Four disks, 26 sectors/track, disk size = number of 1024 byte blocks
;	Number of directory entries (32-bytes each) set to 127 per 500 blocks
;	Allocation map bits = number of blocks needed to contain directory entries
;	No translations -- translation maps commented out
;
;	disk Parameter header for disk 00
dpbase:
	.dw	0000h, 0000h
	.dw	0000h, 0000h
	.dw	dirbf, dpblk
	.dw	chk00, all00
;	disk parameter header for disk 01
	.dw	0000h, 0000h
	.dw	0000h, 0000h
	.dw	dirbf, dpblk
	.dw	chk01, all01
;	disk parameter header for disk 02
	.dw	0000h, 0000h
	.dw	0000h, 0000h
	.dw	dirbf, dpblk
	.dw	chk02, all02
;	disk parameter header for disk 03
	.dw	0000h, 0000h
	.dw	0000h, 0000h
	.dw	dirbf, dpblk
	.dw	chk03, all03
;
;	sector translate vector
;Since no translation will comment out
;trans:	db	 1,  7, 13, 19	;sectors  1,  2,  3,  4
;	.db	25,  5, 11, 17	;sectors  5,  6,  7,  6
;	.db	23,  3,  9, 15	;sectors  9, 10, 11, 12
;	.db	21,  2,  8, 14	;sectors 13, 14, 15, 16
;	.db	20, 26,  6, 12	;sectors 17, 18, 19, 20
;	.db	18, 24,  4, 10	;sectors 21, 22, 23, 24
;	.db	16, 22		;sectors 25, 26
;
dpblk:	;disk parameter block for all disks.
	.dw	256		;sectors per track
	.db	4		;block shift factor
	.db	15		;block mask - with block shift, sets block size to 1024
	.db	0		;null mask
	.dw	1023		;disk size-1 = number of blocks in a disk - 1
	.dw	256		;directory max = no. directory entries/disk, arbitrary
	.db	240		;alloc 0 -- need 4 bits (blocks) for 256 directory entries -- 
	.db	0		;alloc 1 -- no. bits = (directory max x 32)/block size	
	.dw	0		;check size -- no checking, so zero
	.dw	1		;track offset -- first track for system

;
;	end of fixed tables
;
cpmstart:
	ld de,0dc00h
	ld (dmatmp4diskemu),de
	ld a,0
	ld (dmatmp4diskemu+2),a
	ld (dmatmp4diskemu+3),a
	ld (dmatmp4diskemu+4),a
	ld (dmatmp4diskemu+5),a
	ld l,1
	ld h,0
	ld b,44
cpmbios_cpmload:
	ld a,l
	ld (dmatmp4diskemu+2),a
	ld a,0
	ld (dmatmp4diskemu+4),a
	call biosread
	inc l
cpmbios_cpmload_dmaaddrset:
	ld a,e
	add a,080h
	ld e,a
	ld a,d
	adc a,0
	ld d,a
	ld (dmatmp4diskemu),de
	djnz cpmbios_cpmload
	ld a,0c3h
	ld hl,wboot
	ld (0000h),a
	ld (0001h),hl
	ld hl,0e406h
	ld (0005h),a
	ld (0006h),hl
	ld de,00080h
	ld (dmatmp4diskemu),de
	ld a,(0004h)
	and a,0fh
	ld (diskno),a
	ld c,a
	ld sp,0080h
	jp 0dc00h
biosboot: 
	;in0 a,(0c3h)
	or a,3
	;out0 (0c3h),a
	ld sp,0080h
	ld a,010010101b
	;ld a,010010100b
	ld (0003h),a
	ld a,0
	ld (0004h),a
	ld hl,hellomes
	call showmes
	jp cpmstart
bioswboot: 
	ld sp,0ffffh
	jp cpmstart

hellomes:.db "62k CP/M ver 2.2",00h
showmes:
	ld c,(hl)
	call biosconout
	inc hl
	ld a,(hl)
	and a
	jr nz,showmes
	ret

biosconst: 
	ld a,(0003h)
	and a,3
	cp a,0
	jr z,const_tty
	cp a,1
	jr z,const_crt
	cp a,2
	jp z,bioslistst
	ld a,0h
	ret
const_tty:
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	;ld bc,121h
	;in a,(c)
	;in0 a,(0c5h)
	;bit 0,a
	;jr nz,const_tty_
	ld a,0
const_tty__:
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ret
const_tty_:
	ld a,0ffh
	jr const_tty__
const_crt:
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	;ld c,0
	;rst.lil 8h
	ld.lil a,(0d19510h)
	bit 1,a
	jr nz,const_tty_
	ld a,0h
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ret
biosconin: 
	ld a,(0003h)
	and a,3
	cp a,0
	jr z,conin_tty
	cp a,1
	jr z,conin_crt
	cp a,2
	jp z,biosreader
	ld a,0h
	ret
conin_tty:
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	;ld bc,121h
conin_tty_:
	;in a,(c)
	;in0 a,(0c5h)
	;bit 0,a
	;jr z,conin_tty_
	;inc c
	;in a,(c)
	;in0 a,(0c0h)
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ret
conin_crt:
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	;ld c,1
	;rst.lil 8h
conin_crt_:
	ld.lil a,(0d19510h)
	bit 1,a
	jr z,conin_crt_
	res 0,a
	ld.lil (0d19510h),a
	ld a,13
	;ld.lil a,(0d19511h)
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ret
biosconout: 
	ld a,(0003h)
	and a,3
	cp a,0
	jr z,conout_tty
	cp a,1
	jr z,conout_crt
	cp a,2
	jp z,bioslist
	ld a,c
	ret
conout_tty:
	ld a,c
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	;ld bc,122h
	;out (c),a
	;out0 (0c0h),a
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ret
conout_crt:
	ld a,c
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	;ld c,2
	;rst.lil 8h
	call.lil 0100000h+(5*1)
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ret
bioslist: 
	ld a,(0003h)
	rrca
	rrca
	rrca
	rrca
	rrca
	rrca
	and a,3
	cp a,0
	jp z,conout_tty
	cp a,1
	jp z,conout_crt
	cp a,2
	jp z,list_lpt
	ld a,c
	ret
list_lpt:
	ld a,c
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	ld c,017h
	rst.lil 8
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ret
biospunch: 
	ld a,(0003h)
	rrca
	rrca
	rrca
	rrca
	and a,3
	cp a,0
	jp z,conout_tty
	cp a,1
	jr z,punch_ptp
	cp a,2
	jp z,punch_up1
	ld a,c
	ret
punch_ptp:
	ld a,c
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	ld c,011h
	rst.lil 8
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ret
punch_up1:
	ld a,c
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	ld c,014h
	rst.lil 8
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ret
biosreader: 
	ld a,(0003h)
	rrca
	rrca
	and a,3
	cp a,0
	jp z,conin_tty
	cp a,1
	jr z,reader_ptr
	cp a,2
	jp z,reader_ur1
	ld a,0
	ret
reader_ptr:
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	ld c,010h
	rst.lil 8
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ret
reader_ur1:
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	ld c,013h
	rst.lil 8
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ret
bioshome: 
	ld a,0
	ld (dmatmp4diskemu+4),a
	ld (dmatmp4diskemu+5),a
	ret
biosseldsk: 
	ld a,c
	cp a,4
	jr nc,biosseldsk_0
	ld (diskno),a
	ld hl,dpbase
	ld b,16
	mlt bc
	add hl,bc
	res 0,e
	ret
biosseldsk_0:
	ld hl,0h
	set 0,e
	ret
biossettrk: 
	ld (dmatmp4diskemu+4),bc
	ret
biossetsec:
	ld (dmatmp4diskemu+2),bc
	ret
biossetdma: 
	ld (dmatmp4diskemu),bc
	ret
biosrwaddrbuffer:
	.dl 0
biosread: 
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	ld a,(diskno)
	and a,a
	jr nz,biosreadwrite_inv
	ld.lil de,110000h
	ld.lil hl,0h
	ld a,(dmatmp4diskemu+2)
	ld l,a
	ld a,(dmatmp4diskemu+4)
	ld h,a
	add.lil hl,hl;x2
	add.lil hl,hl;x4
	add.lil hl,hl;x8
	add.lil hl,hl;x16
	add.lil hl,hl;x32
	add.lil hl,hl;x64
	add.lil hl,hl;x128
	add.lil hl,de
	push.lil hl
	ld de,(dmatmp4diskemu)
	ld.lil hl,0d00000h
	add.lil hl,de
	push.lil hl
	ld bc,128
	pop.lil de
	pop.lil hl
	ldir.lil
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ld a,0
	ret
biosreadwrite_inv:
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ld a,0ffh
	ret
biosrw_backupflashstate:	.db 0
bioswrite: 
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	ld a,(diskno)
	and a,a
	jr nz,biosreadwrite_inv
	ld.lil de,110000h
	ld.lil hl,0h
	ld a,(dmatmp4diskemu+2)
	ld l,a
	ld a,(dmatmp4diskemu+4)
	ld h,a
	add.lil hl,hl;x2
	add.lil hl,hl;x4
	add.lil hl,hl;x8
	add.lil hl,hl;x16
	add.lil hl,hl;x32
	add.lil hl,hl;x64
	add.lil hl,hl;x128
	add.lil hl,de
	push.lil hl
	ld de,(dmatmp4diskemu)
	ld.lil hl,0d00000h
	add.lil hl,de
	push.lil hl
	ld bc,128
	pop.lil hl
	pop.lil de
	ldir.lil
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ld a,0
	ret
bioslistst: 
	ld a,(0003h)
	rrca
	rrca
	rrca
	rrca
	rrca
	rrca
	and a,3
	cp a,0
	jp z,const_tty
	cp a,1
	jp z,const_crt
	cp a,2
	jp z,listst_lpt
	ld a,0
	ret
listst_lpt:
	ld (cpmbios_bcbak),bc
	ld (cpmbios_debak),de
	ld (cpmbios_hlbak),hl
	ld (cpmbios_afbak),a
	ld c,018h
	;rst.lil 8
	ld bc,(cpmbios_bcbak)
	ld de,(cpmbios_debak)
	ld hl,(cpmbios_hlbak)
	ld a,(cpmbios_afbak)
	ret
biossectrn:
	ex de,hl
	add hl,bc
	ret

cpmbios_bcbak:.dw 0
cpmbios_debak:.dw 0
cpmbios_hlbak:.dw 0
cpmbios_afbak:.dw 0
dmatmp4diskemu:.dw 0
	.dw 0
	.dw 0
crtx:
	.db 0
crty:
	.db 0
kbuffer:
	.db 0
;
;	the remainder of the cbios is reserved uninitialized
;	data area, and does not need to be a Part of the
;	system	memory image (the space must be available,
;	however, between"begdat" and"enddat").
;
track:	.fill	2		;two bytes for expansion
sector:	.fill	2		;two bytes for expansion
dmaad:	.fill	2		;direct memory address
diskno:	.fill	1		;disk number 0-15
;
;	scratch ram area for bdos use
begdat:	.equ	$	 	;beginning of data area
dirbf:	.fill	128	 	;scratch directory area
;Allocation scratch areas, size of each must be (DSM/8)+1
all00:	.fill	128	 	;allocation vector 0
all01:	.fill	128	 	;allocation vector 1
all02:	.fill	128	 	;allocation vector 2
all03:	.fill	128	 	;allocation vector 3
;Could probably remove these chk areas, but just made size small
chk00:	.fill	1		;check vector 0
chk01:	.fill	1		;check vector 1
chk02:	.fill	1	 	;check vector 2
chk03:	.fill	1	 	;check vector 3
;
enddat:	.equ	$	 	;end of data area
datsiz:	.equ	$-begdat;	;size of data area
hstbuf: 	.fill 256		;buffer for host disk sector
addrbeepconf:.db 00h
