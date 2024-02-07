; ****************************************************************************************
; * Subroutines				IN			OUT			Description
; * --------------------------------------------------------------------------------------
; * AscToBin:
; * 	AscToBinNibble		A			A			Convert 1 ASCII digit to a nibble
; *		AscToBinByte		D			A			Convert 2 ASCII digits to a byte
; *		AscToBinWord		Q			D			Convert 4 ASCII digits to a word
; * BinToAsc: 
; *		BinToAscNibble		A			A			Convert a nibble to 1 ASCII digit
; * 	BinToAscByte		A			D			Convert a byte to 2 ASCII digits
; * 	BinToAscWord		D			Q			Convert a word to 4 ASCII digits
; * BinToBcd:				D			Q			Convert a word to BCD
; *	UpperCase:				A			A			Convert lower case to upper case
; ****************************************************************************************

;     _                   _____           ____    _         
;    / \     ___    ___  |_   _|   ___   | __ )  (_)  _ __  
;   / _ \   / __|  / __|   | |    / _ \  |  _ \  | | | '_ \ 
;  / ___ \  \__ \ | (__    | |   | (_) | | |_) | | | | | | |
; /_/   \_\ |___/  \___|   |_|    \___/  |____/  |_| |_| |_|
;
; Convert ASCII hexadecimal number to binary nibble
; =================================================
; Input:	A = Single hexadecimal number
; Output:	A = Binary nibble in LSB

	PRAGMA cc

AscToBinNibble:
	pshs	CC
	jsr		UpperCase			; Convert Hexadecimal characters to upper case
	cmpa	#'9'				; See if it's 0-9 or 'A'-'F'
	bgt		AscToBinNibbleAlpha	; If it's greater than, it's A to F
	suba	#$30				; 
	bra		AscToBinNibbleEnd	; End
AscToBinNibbleAlpha:			; If we fall through, carry is set unlike direct entry at nib2num
	suba	#$37				; 
AscToBinNibbleEnd
	anda	#$0F				; Mask off MSB
	puls	CC,PC

; Convert two ASCII hexadecimal characters
; ========================================
; Input:	D = 2 hex characters to convert
; Output:	A = Binary number
; Clobbers: B

	PRAGMA cc

AscToBinByte:
	pshs	CC
	jsr		AscToBinNibble		; Convert A to 0..F numeric
	asla						; Shift value to MSB
	asla						;
	asla						;
	asla				  		; This is the upper nibble
	anda	#$F0				; Clear LSB
	exg		A,B					; 
	jsr		AscToBinNibble		; Convert to 0..F numeric
	orr		B,A					; Merge MSB (TEMP) and LSB (A)
	clrb
	puls	CC,PC

; Convert four ASCII hexadecimal characters
; ========================================
; Input:	Q = 4 hex characters to convert
; Output:	D = Binary number
; Clobbers: W

	PRAGMA cc

AscToBinWord:
	pshs	CC
	jsr		AscToBinByte		; Convert Ascii byte in D to binary in A
	exg		D,W					; Get LSB of quad, while transfering the result from A to E
	jsr		AscToBinByte		; Convert Ascii byte in D to binary in A
	tfr		A,B					; Place LSB from A to B
	tfr		E,A					; Place MSB from E to A
	clrw
	puls	CC,PC

;  ____    _           _____              _
; | __ )  (_)  _ __   |_   _|   ___      / \     ___    ___
; |  _ \  | | | '_ \    | |    / _ \    / _ \   / __|  / __|
; | |_) | | | | | | |   | |   | (_) |  / ___ \  \__ \ | (__ 
; |____/  |_| |_| |_|   |_|    \___/  /_/   \_\ |___/  \___|
;
; Binary to ASCII conversion (Nibble, Byte, Word, Quad)
; =====================================================

; Convert a 4-bit nibble binary number to a byte of ASCII hexadecimal number
; --------------------------------------------------------------------------
; Input:	A = binary data (LSB of A: $00-$0F), MSB is ignored
; Output:	A = Single alphanumeric character ('0'-'9', 'A'-'F')

	PRAGMA cc

BinToAscNibble:
	pshs	CC
	anda	#$0F				; Clear the MSB
	cmpa	#9					; See if it's numeric (0-9)
	bgt		BinToAscNibbleAlpha	; No, then it's alpha
	adda	#'0'				; Else,convert $0 to $9 to ASCII '0' to '9'
	bra		BinToAscNibbleEnd	; Exit
BinToAscNibbleAlpha:
	adda	#'A'-10				; Convert $A to $F to ASCII 'A' to 'F'
BinToAscNibbleEnd:
	puls	CC,PC
	
; Convert an 8-bit binary number to two bytes of ASCII hexadecimal numbers
; ------------------------------------------------------------------------
; Input:	A = 8-bit binary data (byte)
; Output:	D = Dual ASCII characters (MSB in A, LSB in B)

	PRAGMA cc

BinToAscByte:
	pshs	CC
	pshsw
	tfr		A,E					; Save A
	lsra						; Shift the lower nibble
	lsra						;   to upper nibble,
	lsra						;	all the while zeroing
	lsra						;	the upper nibble
	jsr		BinToAscNibble		; Convert nibble to alphanumeric: In = A, Out = A
	pshs	A					; Store 1st hexadecimal ASCII number
	tfr		E,A					; Restore nibble from E
	jsr		BinToAscNibble		; Convert nibble to alphanumeric: In = A, Out = A 
	tfr		A,B					; Transfer to LSB of D
	puls	A					; Transfer to MSB of D
	pulsw
	puls	CC,PC

; Convert a 16-bit binary number to four bytes of ASCII hexadecimal numbers
; -------------------------------------------------------------------------
; Input:	D = 16-bit binary data (word)
; Output:	Q = ASCII characters in A,B,E,F

	PRAGMA cc

BinToAscWord:
	pshs	D
	jsr		BinToAscByte		; Convert MSB in A to ASCII in D
	tfr		D,W					; Save MSB result in W
	puls	D					; Recover original content
	tfr		B,A					; Put B in A
	jsr		BinToAscByte		; Convert LSB in A (B) to ASCII in D
	exg		D,W					; Invert D and W
	rts

;  ____    _           _____           ____               _ 
; | __ )  (_)  _ __   |_   _|   ___   | __ )    ___    __| |
; |  _ \  | | | '_ \    | |    / _ \  |  _ \   / __|  / _` |
; | |_) | | | | | | |   | |   | (_) | | |_) | | (__  | (_| |
; |____/  |_| |_| |_|   |_|    \___/  |____/   \___|  \__,_|
;
; Binary to binary coded decimal (BCD)
; ====================================

; Convert a 16-bit word binary number to up to five BCD numbers
; -------------------------------------------------------------
; Input:	D = 16-bit binary data (To be coded: 24 bit)
; Output:	Q = 32-bit BCD data

	PRAGMA cc

BinToBcd:
	pshs	CC
	clr		TempQ1				; Clear Q's High MSB byte
	clrw						; Clear Q's MSB
	; Calculate 10,000's digit
	exg		W,D					; Q = DW
	divq	#10000				; Divide Q by 10,000: Quotient in W, Remainder in D
	stw		TempQ2				; Save 10,000's digit to variable
	; Calculate 1,000's digit
	tfr		D,W					; Transfer Remainder to LSB
	clrd						; Clear MSB
	divq	#1000				; Divide Q by 1,000: Quotient in W, Remainder in D
	exg		D,W					; Exchange registers: Quotien is now in D, and remainder in W
	lsld						; Move 1,000's digit to high nibble
	lsld						;	Had to exchange D <-> W
	lsld						;	in order for lsld to work
	lsld						;
	stb		TempQ3				; Save 1,000's digit for later or'ing with the 100's
	; Calculate 100's digit
	tfr		W,D					; Transfer remainder to D
	divd	#100				; Divide D by 100: Quotient in B, Remainder in A
	pshs	A					; Save for 10's and 1's 
	lda		TempQ3				; Load quotien from the 1000's
	orr		B,A					; Merge 1000's and 100's digits together
	sta		TempQ3				; Save result to variable
	; Calculate the 10's and 1's digit
	puls	B					; Place remainder in LSB of D
	clra						; Clear MSB of D
	divd	#10					; Divide D by 10: Quotient in B, Remainder in A
	lslb						; Move 10's digit to high nibble
	lslb						;
	lslb						;
	lslb						;
	orr		B,A					; Merge 10's and 1's digits together
	sta		TempQ4				; Save result to Variable
	ldq		TempQuad			; Load Quad result
	puls	CC,PC

;  _   _                                  ____                      
; | | | |  _ __    _ __     ___   _ __   / ___|   __ _   ___    ___ 
; | | | | | '_ \  | '_ \   / _ \ | '__| | |      / _` | / __|  / _ \
; | |_| | | |_) | | |_) | |  __/ | |    | |___  | (_| | \__ \ |  __/
;  \___/  | .__/  | .__/   \___| |_|     \____|  \__,_| |___/  \___|
;         |_|     |_|                                               
;
; Convert character in A to uppercase
; ===================================
; Input:	A = anycase
; Output:	A = UPPERCASE

	PRAGMA cc

UpperCase:
	pshs	CC
	cmpa	#'a'				; Is value less the 'a'?
	blt		UpperCaseEnd		; Then end subroutine
	cmpa	#'z'				; Is value higher then 'z'?
	bgt		UpperCaseEnd		; Then end subroutine
	suba	#$20				; Substract $20 from the ASCII for upper case
UpperCaseEnd:
	puls	CC,PC
	