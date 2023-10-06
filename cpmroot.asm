.org 0100000H
.assume ADL=1
	jp.lil init
	jp.lil conout
conout:
	call conout_
	ret.l
conout_:
	;Check the sequential codes
	cp a,8	;Back Space
	jp z,renderx_backspace
	cp a,10	;Line Feed
	jp z,renderx_nextline
	cp a,13	;Carriage Return
	jp z,renderx_zerocols
	;Okey we rend a character.
	jp renderx
keyboardthread:
	;ld sp,0d3f000h
	call RestoreKeyboard
keyboardthread_:
	ld hl,0F50000h
	ld (hl),2      ; Set Single Scan mode
	xor a,a
keyboardthread_scan_wait:
	cp a,(hl)      ; Wait for Idle mode
	jr nz,keyboardthread_scan_wait
	ld hl,0F50010h
	ld de,0d19500h
keyboardthread__:
	ld a,(hl)
	ld (de),a
	and a,a
	jr z,keyboardthread____
	push hl
	ld hl,0d19510h
	set 1,(hl)
	pop hl
keyboardthread____:
	inc de
	inc hl
	inc hl
	ld a,l
	cp a,20
	jr nz,keyboardthread__
	ld hl,0d19510h
	set 0,(hl)
keyboardthread___:
	bit 0,(hl)
	jr nz,keyboardthread___
	res 1,(hl)
	;jr keyboardthread
	jr keyboardthread_
RestoreKeyboard:
	ld hl,0F50000h
	xor a		; Mode 0
	ld (hl),a
	inc l		; 0F50001h
	ld (hl),15	; Wait 15*256 APB cycles before scanning each row
	inc l		; 0F50002h
	xor a
	ld (hl),a
	inc l		; 0F50003h
	ld (hl),15	; Wait 15 APB cycles before each scan
	inc l		; 0F50004h
	ld a,8		; Number of rows to scan
	ld (hl),a
	inc l		; 0F50005h
	ld (hl),a	; Number of columns to scan
	ret
init:
	ld hl,7fffh
	ld (0d19400h+(3*3)),hl
	ld hl,-624;16
	ld (0d19100h+(3*0)),hl
	ld hl,0
	ld (0d19100h+(3*1)),hl
	ld (0d19100h+(3*2)),hl
	xor a,a
	ld (0d19100h+(3*2)+0),a
	ld bc,128
	ld de,0d08000h
	ld hl,0110000h
	ldir
	ld a,0d0h
	ld mb,a
	ld hl,0
	add hl,sp
	ld sp,0d3f000h
	ld de,keyboardthread
	push de
	ld sp,hl
	ld hl,0d3f000h-4
	ld (hl),3
	ld sp,0d40000h
	ld de,0
	ld a,0
	push hl
	push hl
	rst.lil 8h
	pop hl
	pop hl
	call.is 08000h
lplp:	jr lplp

showmes:
	ld a,(hl)
	call renderx
	ld a,(hl)
	inc hl
	and a,a
	jr nz,showmes
	ret

hello:
	.db "Hello, World!",00h

renderx:
	ld (0d19400h+(3*0)),bc
	ld (0d19400h+(3*1)),de
	ld (0d19400h+(3*2)),hl
	ld (0d19100h+(3*1)+1),a
	ld b,8
renderx__:
	ld hl,(0d19100h+(3*0))
	ld de,-16
	add hl,de
	ld de,0280h
	add hl,de
	ld (0d19100h+(3*0)),hl
	ld a,b
	ld (0d19100h+(3*1)),a
	ld a,8
	sub a,b
	ld b,8
	ld c,a
	ld a,(0d19100h+(3*1)+1)
	ld hl,0
	ld l,a
	add hl,hl
	add hl,hl
	add hl,hl
	ld a,c
	and a,7
	or a,l
	ld l,a
	ld de,font
	add hl,de
	ld a,(hl)
renderx_:
	bit 7,a
	jp z,renderx_no
	sla a
	ld (0d19100h+(3*1)+2),a
	ld c,a
	ld hl,0d40000h
	ld de,(0d19100h+(3*0))
	add hl,de
	;ld a,07fh
	ld a,(0d19400h+(3*3)+1)
	ld (hl),a
	inc hl
	;ld a,0ffh
	ld a,(0d19400h+(3*3)+0)
	ld (hl),a
	inc hl
	ld de,02c0000h
	add hl,de
	ld a,c
	ld (0d19100h+(3*0)),hl
	jr renderx_finish
renderx_no:
	sla a
	ld (0d19100h+(3*1)+2),a
	ld hl,0d40000h
	ld de,(0d19100h+(3*0))
	add hl,de
	xor a,a
	ld (hl),a
	inc hl
	ld (hl),a
	inc hl
	ld de,02c0000h
	add hl,de
	ld (0d19100h+(3*0)),hl
renderx_finish:
	dec b
	ld a,(0d19100h+(3*1)+2)
	jp nz,renderx_
	ld a,(0d19100h+(3*1))
	ld b,a
	dec b
	jp nz,renderx__
	ld de,0ffec00h+16
	ld hl,(0d19100h+(3*0))
	add hl,de
	ld (0d19100h+(3*0)),hl
	ld a,(0d19100h+(3*2)+0)
	inc a
	ld (0d19100h+(3*2)+0),a
	cp a,40
	jr z,renderx_finish_
	ld bc,(0d19400h+(3*0))
	ld de,(0d19400h+(3*1))
	ld hl,(0d19400h+(3*2))
	ret
renderx_finish_:
	ld de,1400h-280h
	ld hl,(0d19100h+(3*0))
	add hl,de
	ld (0d19100h+(3*0)),hl
	xor a,a
	ld (0d19100h+(3*2)+0),a
	ld a,(0d19100h+(3*2)+1)
	inc a
	ld (0d19100h+(3*2)+1),a
	cp a,30
	jr z,renderx_scroll
	ld bc,(0d19400h+(3*0))
	ld de,(0d19400h+(3*1))
	ld hl,(0d19400h+(3*2))
	ret
renderx_scroll:
	ld hl,0d40000h+(640*8)
	ld de,0d40000h+0
	ld bc,640*232
	ldir
	ld hl,0d40000h+(640*232)
	ld de,0d40000h+(640*232)+1
	ld bc,640*8
	ld (hl),00h
	ldir
	ld a,29
	ld (0d19100h+(3*2)+1),a
	ld hl,(640*232)-624
	ld (0d19100h+(3*0)),hl
	ld bc,(0d19400h+(3*0))
	ld de,(0d19400h+(3*1))
	ld hl,(0d19400h+(3*2))
	ret
renderx_nextline:
	ld (0d19400h+(3*0)),bc
	ld (0d19400h+(3*1)),de
	ld (0d19400h+(3*2)),hl
	ld de,1400h
	ld hl,(0d19100h+(3*0))
	add hl,de
	ld (0d19100h+(3*0)),hl
	ld a,(0d19100h+(3*2)+1)
	inc a
	ld (0d19100h+(3*2)+1),a
	cp a,30
	jr z,renderx_scroll
	ld bc,(0d19400h+(3*0))
	ld de,(0d19400h+(3*1))
	ld hl,(0d19400h+(3*2))
	ret
renderx_zerocols:
	ld (0d19400h+(3*0)),bc
	ld (0d19400h+(3*1)),de
	ld (0d19400h+(3*2)),hl
	ld a,(0d19100h+(3*2)+0)
	and a,a
	jr z,renderx_zerocols__
	ld b,a
	ld de,-16
	ld hl,(0d19100h+(3*0))
renderx_zerocols_:
	add hl,de
	djnz renderx_zerocols_
	ld (0d19100h+(3*0)),hl
	xor a,a
	ld (0d19100h+(3*2)+0),a
renderx_zerocols__:
	ld bc,(0d19400h+(3*0))
	ld de,(0d19400h+(3*1))
	ld hl,(0d19400h+(3*2))
	ret
renderx_backspace:
	ld (0d19400h+(3*0)),bc
	ld (0d19400h+(3*1)),de
	ld (0d19400h+(3*2)),hl
	ld a,(0d19100h+(3*2)+0)
	dec a
	cp a,0ffh
	jr z,renderx_backspace_
	ld (0d19100h+(3*2)+0),a
	ld de,-16
	ld hl,(0d19100h+(3*0))
	add hl,de
	ld (0d19100h+(3*0)),hl
	ld bc,(0d19400h+(3*0))
	ld de,(0d19400h+(3*1))
	ld hl,(0d19400h+(3*2))
	ret
renderx_backspace_:
	ld a,39
	ld (0d19100h+(3*2)+0),a
	ld de,0ffec00h-16
	ld hl,(0d19100h+(3*0))
	add hl,de
	ld (0d19100h+(3*0)),hl
	ld a,(0d19100h+(3*2)+1)
	dec a
	ld (0d19100h+(3*2)+1),a
	ld bc,(0d19400h+(3*0))
	ld de,(0d19400h+(3*1))
	ld hl,(0d19400h+(3*2))
	ret

font:
.db 000h,000h,000h,000h,000h,000h,000h,000h,070h,040h,070h,01Ah,07Ah,00Eh,00Ah,00Ah
.db 070h,040h,070h,012h,074h,008h,014h,022h,070h,040h,070h,042h,074h,008h,014h,022h
.db 070h,040h,070h,040h,07Eh,004h,004h,004h,0E0h,080h,0E0h,08Ch,0F2h,012h,012h,00Dh
.db 020h,050h,070h,052h,054h,018h,014h,012h,070h,048h,070h,048h,074h,004h,004h,007h
.db 070h,048h,070h,04Fh,074h,007h,001h,007h,050h,050h,070h,050h,05Eh,004h,004h,004h
.db 040h,040h,040h,04Eh,078h,00Ch,008h,008h,050h,050h,070h,050h,051h,01Bh,015h,011h
.db 03Ch,040h,040h,044h,038h,008h,008h,00Fh,038h,040h,040h,03Eh,009h,00Eh,00Ah,009h
.db 070h,040h,070h,010h,07Ch,012h,012h,00Ch,070h,040h,070h,010h,07Eh,004h,004h,00Eh
.db 070h,048h,048h,04Fh,074h,007h,004h,007h,070h,048h,048h,04Ah,076h,002h,002h,007h
.db 070h,048h,048h,04Eh,071h,006h,008h,00Fh,070h,048h,048h,04Fh,071h,007h,001h,00Fh
.db 070h,048h,048h,04Ah,076h,00Ah,01Fh,002h,048h,068h,058h,049h,04Ah,00Ch,00Ah,009h
.db 070h,040h,070h,010h,079h,00Dh,00Bh,009h,070h,040h,070h,04Eh,079h,00Eh,009h,00Eh
.db 038h,040h,040h,038h,009h,00Dh,00Bh,009h,070h,040h,070h,040h,071h,01Bh,015h,011h
.db 070h,040h,070h,01Ch,072h,01Ch,012h,01Ch,070h,040h,070h,040h,07Eh,010h,010h,00Eh
.db 000h,008h,004h,07Eh,004h,008h,000h,000h,000h,010h,020h,07Eh,020h,010h,000h,000h
.db 000h,008h,01Ch,02Ah,008h,008h,008h,000h,000h,008h,008h,008h,02Ah,01Ch,008h,000h
.db 000h,000h,000h,000h,000h,000h,000h,000h,008h,008h,008h,008h,000h,000h,008h,000h
.db 024h,024h,024h,000h,000h,000h,000h,000h,024h,024h,07Eh,024h,07Eh,024h,024h,000h
.db 008h,01Eh,028h,01Ch,00Ah,03Ch,008h,000h,000h,062h,064h,008h,010h,026h,046h,000h
.db 030h,048h,048h,030h,04Ah,044h,03Ah,000h,004h,008h,010h,000h,000h,000h,000h,000h
.db 004h,008h,010h,010h,010h,008h,004h,000h,020h,010h,008h,008h,008h,010h,020h,000h
.db 008h,02Ah,01Ch,03Eh,01Ch,02Ah,008h,000h,000h,008h,008h,03Eh,008h,008h,000h,000h
.db 000h,000h,000h,000h,000h,008h,008h,010h,000h,000h,000h,07Eh,000h,000h,000h,000h
.db 000h,000h,000h,000h,000h,018h,018h,000h,000h,002h,004h,008h,010h,020h,040h,000h
.db 03Ch,042h,046h,05Ah,062h,042h,03Ch,000h,008h,018h,028h,008h,008h,008h,03Eh,000h
.db 03Ch,042h,002h,00Ch,030h,040h,07Eh,000h,03Ch,042h,002h,01Ch,002h,042h,03Ch,000h
.db 004h,00Ch,014h,024h,07Eh,004h,004h,000h,07Eh,040h,078h,004h,002h,044h,038h,000h
.db 01Ch,020h,040h,07Ch,042h,042h,03Ch,000h,07Eh,042h,004h,008h,010h,010h,010h,000h
.db 03Ch,042h,042h,03Ch,042h,042h,03Ch,000h,03Ch,042h,042h,03Eh,002h,004h,038h,000h
.db 000h,000h,008h,000h,000h,008h,000h,000h,000h,000h,008h,000h,000h,008h,008h,010h
.db 00Eh,018h,030h,060h,030h,018h,00Eh,000h,000h,000h,07Eh,000h,07Eh,000h,000h,000h
.db 070h,018h,00Ch,006h,00Ch,018h,070h,000h,03Ch,042h,002h,00Ch,010h,000h,010h,000h
.db 01Ch,022h,04Ah,056h,04Ch,020h,01Eh,000h,018h,024h,042h,07Eh,042h,042h,042h,000h
.db 07Ch,022h,022h,03Ch,022h,022h,07Ch,000h,01Ch,022h,040h,040h,040h,022h,01Ch,000h
.db 078h,024h,022h,022h,022h,024h,078h,000h,07Eh,040h,040h,078h,040h,040h,07Eh,000h
.db 07Eh,040h,040h,078h,040h,040h,040h,000h,01Ch,022h,040h,04Eh,042h,022h,01Ch,000h
.db 042h,042h,042h,07Eh,042h,042h,042h,000h,01Ch,008h,008h,008h,008h,008h,01Ch,000h
.db 00Eh,004h,004h,004h,004h,044h,038h,000h,042h,044h,048h,070h,048h,044h,042h,000h
.db 040h,040h,040h,040h,040h,040h,07Eh,000h,042h,066h,05Ah,05Ah,042h,042h,042h,000h
.db 042h,062h,052h,04Ah,046h,042h,042h,000h,018h,024h,042h,042h,042h,024h,018h,000h
.db 07Ch,042h,042h,07Ch,040h,040h,040h,000h,018h,024h,042h,042h,04Ah,024h,01Ah,000h
.db 07Ch,042h,042h,07Ch,048h,044h,042h,000h,03Ch,042h,040h,03Ch,002h,042h,03Ch,000h
.db 03Eh,008h,008h,008h,008h,008h,008h,000h,042h,042h,042h,042h,042h,042h,03Ch,000h
.db 042h,042h,042h,024h,024h,018h,018h,000h,042h,042h,042h,05Ah,05Ah,066h,042h,000h
.db 042h,042h,024h,018h,024h,042h,042h,000h,022h,022h,022h,01Ch,008h,008h,008h,000h
.db 07Eh,002h,004h,018h,020h,040h,07Eh,000h,03Ch,020h,020h,020h,020h,020h,03Ch,000h
.db 022h,022h,014h,03Eh,008h,03Eh,008h,000h,03Ch,004h,004h,004h,004h,004h,03Ch,000h
.db 008h,014h,022h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,07Eh,000h
.db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,03Ch,004h,03Ch,044h,03Ah,000h
.db 040h,040h,05Ch,062h,042h,062h,05Ch,000h,000h,000h,03Ch,042h,040h,042h,03Ch,000h
.db 002h,002h,03Ah,046h,042h,046h,03Ah,000h,000h,000h,03Ch,042h,07Eh,040h,03Ch,000h
.db 00Ch,012h,010h,07Ch,010h,010h,010h,000h,000h,000h,03Ah,046h,046h,03Ah,002h,03Ch
.db 040h,040h,05Ch,062h,042h,042h,042h,000h,008h,000h,018h,008h,008h,008h,01Ch,000h
.db 004h,000h,00Ch,004h,004h,004h,044h,038h,040h,040h,044h,048h,050h,068h,044h,000h
.db 018h,008h,008h,008h,008h,008h,01Ch,000h,000h,000h,076h,049h,049h,049h,049h,000h
.db 000h,000h,05Ch,062h,042h,042h,042h,000h,000h,000h,03Ch,042h,042h,042h,03Ch,000h
.db 000h,000h,05Ch,062h,062h,05Ch,040h,040h,000h,000h,03Ah,046h,046h,03Ah,002h,002h
.db 000h,000h,05Ch,062h,040h,040h,040h,000h,000h,000h,03Eh,040h,03Ch,002h,07Ch,000h
.db 010h,010h,07Ch,010h,010h,012h,00Ch,000h,000h,000h,042h,042h,042h,046h,03Ah,000h
.db 000h,000h,042h,042h,042h,024h,018h,000h,000h,000h,041h,049h,049h,049h,036h,000h
.db 000h,000h,042h,024h,018h,024h,042h,000h,000h,000h,042h,042h,046h,03Ah,002h,03Ch
.db 000h,000h,07Eh,004h,018h,020h,07Eh,000h,00Eh,010h,010h,020h,010h,010h,00Eh,000h
.db 008h,008h,000h,000h,000h,008h,008h,000h,070h,008h,008h,004h,008h,008h,070h,000h
.db 030h,049h,006h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
.db 000h,000h,000h,000h,000h,000h,000h,0FFh,000h,000h,000h,000h,000h,000h,0FFh,0FFh
.db 000h,000h,000h,000h,000h,0FFh,0FFh,0FFh,000h,000h,000h,000h,0FFh,0FFh,0FFh,0FFh
.db 000h,000h,000h,0FFh,0FFh,0FFh,0FFh,0FFh,000h,000h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
.db 000h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
.db 080h,080h,080h,080h,080h,080h,080h,080h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h
.db 0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0E0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h,0F0h
.db 0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh
.db 0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,008h,008h,008h,008h,0FFh,008h,008h,008h
.db 008h,008h,008h,008h,0FFh,000h,000h,000h,000h,000h,000h,000h,0FFh,008h,008h,008h
.db 008h,008h,008h,008h,0F8h,008h,008h,008h,008h,008h,008h,008h,00Fh,008h,008h,008h
.db 0FFh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0FFh,000h,000h,000h
.db 008h,008h,008h,008h,008h,008h,008h,008h,001h,001h,001h,001h,001h,001h,001h,001h
.db 000h,000h,000h,000h,00Fh,008h,008h,008h,000h,000h,000h,000h,0F8h,008h,008h,008h
.db 008h,008h,008h,008h,00Fh,000h,000h,000h,008h,008h,008h,008h,0F8h,000h,000h,000h
.db 000h,000h,000h,000h,003h,004h,008h,008h,000h,000h,000h,000h,0E0h,010h,008h,008h
.db 008h,008h,008h,004h,003h,000h,000h,000h,008h,008h,008h,010h,0E0h,000h,000h,000h
.db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,038h,028h,038h,000h
.db 01Ch,010h,010h,010h,000h,000h,000h,000h,000h,000h,000h,008h,008h,008h,038h,000h
.db 000h,000h,000h,000h,020h,010h,008h,000h,000h,000h,000h,018h,018h,000h,000h,000h
.db 000h,07Eh,002h,07Eh,002h,004h,038h,000h,000h,000h,03Eh,002h,00Ch,008h,010h,000h
.db 000h,000h,004h,008h,018h,028h,008h,000h,000h,000h,008h,03Eh,022h,002h,00Ch,000h
.db 000h,000h,000h,03Eh,008h,008h,03Eh,000h,000h,000h,004h,03Eh,00Ch,014h,024h,000h
.db 000h,000h,010h,03Eh,012h,014h,010h,000h,000h,000h,000h,01Ch,004h,004h,03Eh,000h
.db 000h,000h,03Ch,004h,03Ch,004h,03Ch,000h,000h,000h,000h,02Ah,02Ah,002h,00Ch,000h
.db 000h,000h,000h,03Eh,000h,000h,000h,000h,07Eh,002h,002h,014h,018h,010h,020h,000h
.db 002h,004h,008h,018h,028h,048h,008h,000h,008h,07Eh,042h,042h,002h,004h,038h,000h
.db 000h,03Eh,008h,008h,008h,008h,03Eh,000h,008h,07Eh,008h,018h,028h,048h,008h,000h
.db 010h,07Eh,012h,012h,012h,012h,024h,000h,008h,03Eh,008h,03Eh,008h,008h,008h,000h
.db 01Eh,022h,042h,004h,008h,010h,060h,000h,020h,03Eh,048h,008h,008h,008h,010h,000h
.db 000h,07Eh,002h,002h,002h,002h,07Eh,000h,024h,07Eh,024h,024h,004h,008h,010h,000h
.db 000h,070h,000h,072h,002h,004h,078h,000h,07Eh,002h,004h,008h,018h,024h,042h,000h
.db 020h,07Eh,022h,024h,020h,020h,01Eh,000h,042h,042h,022h,002h,004h,008h,030h,000h
.db 01Eh,022h,062h,014h,008h,010h,060h,000h,004h,038h,008h,07Eh,008h,008h,070h,000h
.db 000h,052h,052h,052h,004h,008h,070h,000h,03Ch,000h,07Eh,008h,008h,010h,020h,000h
.db 010h,010h,010h,018h,014h,010h,010h,000h,008h,008h,07Eh,008h,008h,010h,020h,000h
.db 000h,03Ch,000h,000h,000h,000h,07Eh,000h,000h,03Eh,002h,014h,008h,014h,020h,000h
.db 008h,03Eh,004h,008h,01Ch,02Ah,008h,000h,002h,002h,002h,004h,008h,010h,020h,000h
.db 010h,008h,004h,042h,042h,042h,042h,000h,040h,040h,07Eh,040h,040h,040h,03Eh,000h
.db 000h,07Eh,002h,002h,004h,008h,030h,000h,000h,010h,028h,044h,002h,002h,000h,000h
.db 008h,03Eh,008h,008h,02Ah,02Ah,008h,000h,07Eh,002h,002h,004h,028h,010h,008h,000h
.db 000h,03Ch,000h,03Ch,000h,07Ch,002h,000h,004h,008h,010h,020h,048h,07Ch,002h,000h
.db 000h,002h,002h,014h,008h,014h,060h,000h,000h,07Eh,010h,07Eh,010h,010h,01Eh,000h
.db 020h,020h,07Eh,022h,024h,020h,020h,000h,000h,038h,008h,008h,008h,008h,07Eh,000h
.db 07Eh,002h,002h,07Eh,002h,002h,07Eh,000h,03Ch,000h,07Eh,002h,004h,008h,010h,000h
.db 042h,042h,042h,042h,002h,004h,018h,000h,028h,028h,028h,02Ah,02Ah,02Ch,048h,000h
.db 020h,020h,020h,022h,024h,028h,030h,000h,000h,07Eh,042h,042h,042h,042h,07Eh,000h
.db 000h,07Eh,042h,042h,002h,004h,018h,000h,000h,070h,002h,002h,004h,008h,070h,000h
.db 010h,048h,020h,000h,000h,000h,000h,000h,070h,050h,070h,000h,000h,000h,000h,000h
.db 000h,000h,0FFh,000h,000h,0FFh,000h,000h,008h,008h,00Fh,008h,008h,00Fh,008h,008h
.db 008h,008h,0FFh,008h,008h,0FFh,008h,008h,008h,008h,0F8h,008h,008h,0F8h,008h,008h
.db 001h,003h,007h,00Fh,01Fh,03Fh,07Fh,0FFh,080h,0C0h,0E0h,0F0h,0F8h,0FCh,0FEh,0FFh
.db 0FFh,07Fh,03Fh,01Fh,00Fh,007h,003h,001h,0FFh,0FEh,0FCh,0F8h,0F0h,0E0h,0C0h,080h
.db 008h,01Ch,03Eh,07Fh,07Fh,01Ch,03Eh,000h,036h,07Fh,07Fh,07Fh,03Eh,01Ch,008h,000h
.db 008h,01Ch,03Eh,07Fh,03Eh,01Ch,008h,000h,01Ch,01Ch,07Fh,07Fh,06Bh,008h,03Eh,000h
.db 000h,03Ch,07Eh,07Eh,07Eh,07Eh,03Ch,000h,000h,03Ch,042h,042h,042h,042h,03Ch,000h
.db 001h,002h,004h,008h,010h,020h,040h,080h,080h,040h,020h,010h,008h,004h,002h,001h
.db 081h,042h,024h,018h,018h,024h,042h,081h,07Fh,049h,049h,07Fh,041h,041h,041h,000h
.db 040h,07Eh,048h,03Ch,028h,07Eh,008h,000h,03Fh,021h,03Fh,021h,03Fh,021h,041h,000h
.db 07Fh,041h,041h,07Fh,041h,041h,07Fh,000h,004h,0EEh,0A4h,0EFh,0A2h,0EFh,00Ah,002h
.db 000h,018h,024h,042h,03Ch,014h,024h,000h,03Ah,012h,07Fh,017h,03Bh,052h,014h,000h
.db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
.db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
.db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
.db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
