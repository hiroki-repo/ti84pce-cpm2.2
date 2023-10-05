; CP/M v2.2 Copyright 1979 (c) by Digital Research
; Ported to the EZ80F92 platform by
; Jean-Michel Howland
; Christopher D. Farrar

                ;CPU     = EZ80F92

                .ASSUME ADL=0
#define equ .equ
#define EQU .equ
#define end .end
#define END .end
#macro __org(value)
.ASSUME ADL=0
#if (value)>ccp
#if (value)>$
.fill (value)-$
#endif
#endif
.org value
#endmacro
#define org __org(
#define ORG org
#define db .db
#define DB .db
#define dw .dw
#define DW .dw
#define dl .dl
#define DL .dl
#define ds .fill
#define DS .fill
#macro _asciz(value)
.db value
.db 0
#endmacro
#define asciz _asciz(
#define ASCIZ asciz
#define ascii .db
#define ASCII .db
#define mod %
#define MOD %

                #INCLUDE "eZ80-CPM-MDEF.inc"                     ; CP/M memory defines.

                ORG     ccp                                     ; start addr of cpm binary blob

; Start of CP/M code.

		#INCLUDE	"eZ80-CPM-CCP.inc"			; CP/M Console Command Processor code.
		#INCLUDE	"eZ80-CPM-BDOS.inc"			; CP/M Basic Disk Operating System code.
		#INCLUDE	"eZ80-CPM-BIOS.inc"			; CP/M Basic Input/Output System code.

; End of CP/M code.

		END
