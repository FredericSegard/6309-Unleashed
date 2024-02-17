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

	PRAGMA		CD						; Detailed cycle count
	PRAGMA		CT						; Cycle count running subtotal
	
	ORG 	$1000

Start:
	jmp		PrgEnd

PrgEnd:	
	
	END
