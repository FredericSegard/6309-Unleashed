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

	PRAGMA cd					; Detailed cycle count
	PRAGMA ct					; Cycle count running subtotal
	
	ORG $1000

Start:
	ldd		#$1234
	ldw		#$5678
	ldx		#$AAAA
	ldy		#$BBBB
	jsr		[OutNibble]
	jsr		[OutCRLF]
	jsr		[OutByte]
	jsr		[OutCRLF]
	jsr		[OutWord]
	jsr		[OutCRLF]
	nop
	nop
	nop
	nop
	
	END
