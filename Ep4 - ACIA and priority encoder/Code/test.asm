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

EOD				EQU		0

	PRAGMA cd					; Detailed cycle count
	PRAGMA ct					; Cycle count running subtotal
	
	ORG $1000

Start:
	ldd		Data1
	jsr		[BinToBcd]
	jsr		[OutWord]
	exg		W,D
	jsr		[OutWord]
	jsr		[OutCRLF]

	ldd		Data2
	jsr		[BinToBcd]
	jsr		[OutWord]
	exg		W,D
	jsr		[OutWord]
	jsr		[OutCRLF]

	bra		PrgEnd

Data1:		.dw		1024
Data2:		.dw		64256

PrgEnd:
	
	
	END
