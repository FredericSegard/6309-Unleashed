Cls				EQU		$FD00
DelChar			EQU		$FD02
GetStrByte		EQU		$FD04
GetStrNibble	EQU		$FD06
GetStrWord		EQU		$FD08
InByte			EQU		$FD0A
InChar			EQU		$FD0C
InCharNW		EQU		$FD0E
InStr			EQU		$FD10
InWord			EQU		$FD12
OutChar			EQU		$FD14
OutByte			EQU		$FD16
OutCRLF			EQU		$FD18
OutNibble		EQU		$FD1A
OutStr			EQU		$FD1C
OutWord			EQU		$FD1E
AscToBinNibble	EQU		$FD20
AscToBinByte	EQU		$FD22
AscToBinWord	EQU		$FD24
BinToAscNibble	EQU		$FD26
BinToAscByte	EQU		$FD28
BinToAscWord	EQU		$FD2A
BinToBcd		EQU		$FD2C
UpperCase		EQU		$FD2E
OutBcd			EQU		$FD30

NULL			EQU		$00				; End delimiter
BS				EQU		$08				; Backspace
TAB				EQU		$09				; Horizontal Tab
CR				EQU		$0D				; Carriage return
LF				EQU		$0A				; Line feed
ESC				EQU		$1B				; Escape
SPACE			EQU		$20				; Space
EOD				EQU		$FF				; End of data, used by some routines

RomStart		EQU		$E000

	PRAGMA 	CD					; Detailed cycle count
	PRAGMA 	CT					; Cycle count running subtotal
	
	ORG 	$1000

Start:
	nop
	jsr		Diagnostics
	jmp		PrgEnd

Diagnostics:
	ldx		#DiagMessage
	jsr		[OutStr]
DiagBase:
	ldx		#DiagTestingMsg
	jsr		[OutStr]
	ldx		#$2000				; Start address pointer
	ldy		#RomStart			; End address pointer
	clrf						; Clear error flag
DiagBaseLoop:
	jsr		DiagTest			; Test RAM cell with different patterns
	leax	1,X					; Increment address pointer
	cmpr	X,Y
	bne		DiagBaseLoop
	tstw
	beq		DiagBaseOK
	ldx		#DiagFailMsg
	jsr		[OutStr]			; Print fail message
	tfr		W,D					; Copy the error count over to D
	jsr		[BinToBcd]			; Convert the number of errors in D to decimal
	jsr		[OutBcd]			; Print the number
	jsr		[OutStr]			; Continue the fail message
	bra		DiagBaseEnd
DiagBaseOK:
	ldx		#DiagPassMsg
	jsr		[OutStr]
DiagBaseEnd:
	rts

; Diagnostic subroutines
; ----------------------

DiagTest:
	; Read a byte and save it for later
	lda		,X
	pshs	A
	; Test pattern $00
	ldb		#$00
	jsr		DiagCellPattern
	; Test pattern $55
	ldb		#$55
	jsr		DiagCellPattern
	; Test pattern $AA
	ldb		#$AA
	jsr		DiagCellPattern
	; Test pattern $FF
	ldb		#$FF
	jsr		DiagCellPattern
	; Restore original data in cell
	puls	A
	sta		,X
	rts

DiagCellPattern:
	; B = Test pattern
	; X = Current cell pointer
	stb		,X					; Store test pattern in memory
	lda		,X					; Read back memory
	cmpr	A,B					; Does the memory cell match the pattern after read back
	beq		DiagCellEnd			; If it's the same, test with pattern AA
	incw						; Increment error count
	; *** Print cell error
DiagCellEnd:
	rts

DiagMessage:
	.str	"Diagnostics"
	.db		CR,LF,NULL
DiagTestingMsg:
	.str	"  Testing Base RAM: "
	.db		NULL
DiagPassMsg:
	.str	"Pass"
	.db		CR,LF,NULL
DiagFailMsg:
	.str	"Fail, "
	.db		NULL
	.str	" errors"
	.db		CR,LF,NULL

PrgEnd:	
	
	END
