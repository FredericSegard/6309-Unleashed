; ****************************************************************************************
; * Convert subroutines
; * -------------------
; *
; * BinToAscii: 
; *		BinToAscii4		Convert a nibble to ASCII
; * 	BinToAscii8		Convert a byte to ASCII
; * 	BinToAscii16	Convert a word to ASCII
; ****************************************************************************************

;  ____    _           _____              _                   _   _ 
; | __ )  (_)  _ __   |_   _|   ___      / \     ___    ___  (_) (_)
; |  _ \  | | | '_ \    | |    / _ \    / _ \   / __|  / __| | | | |
; | |_) | | | | | | |   | |   | (_) |  / ___ \  \__ \ | (__  | | | |
; |____/  |_| |_| |_|   |_|    \___/  /_/   \_\ |___/  \___| |_| |_|
;
; 4-bit nibble binary to ASCII conversion.
; Converts a LSB nibble of binary data to a byte of ASCII hexadecimal number.
;
; Input:	A = binary data ($00-$0F), MSB is ignored
; Output:	A = Ascii alphanumeric character ('0'-'9', 'A'-'F')

BinToAscii4:
	anda	#$0F				; Clear the MSB
	cmpa	#9					; See if it's numeric (0-9)
	bgt		BinToAscii4Alpha	; No, then it's alpha
	adda	#'0'				; Else,convert $0 to $9 to ASCII '0' to '9'
	rts
BinToAscii4Alpha:				; If we fall through, carry is set unlike direct entry at nib2num
	adda	#'A'-10				; Convert $A to $F to ASCII 'A' to 'F'
	rts

; 8-bit binary number to Ascii conversion.
; Converts a byte of binary data to two bytes of ASCII hexadecimal numbers.
;
; Input:	A = binary data
; Output:	D = Ascii alphanumeric characters

BinToAscii8:
	pshs	A					; Save A
	jsr		BinToAscii4			; Convert LSB to alphanumeric
	tfr		A,B					; Transfer LSB character to B
	puls	A					; Restore A
	lsra						; Shift the upper nibble to the lower nibble,
	lsra						;   all the while clearing the upper nibble with 0
	lsra						;
	lsra						;
	jsr		BinToAscii4			; Convert MSB to alphanumeric, returns it in A 
	rts							; Returns D (A=MSB, B=LSB)

; 16-bit binary to Binary Coded Decimal conversion.
; Converts a word of binary data to two words of BCD data.
;
; Input:	D = binary data
; Output:	Q = Binary coded Decimal

BinToAscii16:
	tfr		D,X					; Save
	rts


