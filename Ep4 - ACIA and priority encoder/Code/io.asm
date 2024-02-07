; ****************************************************************************************
; * Subroutines			IN			OUT			Description
; * --------------------------------------------------------------------------------------
; * Cls					.			.			Clear the screen
; * Com1Init			.			.			Initialize COM1 (USB)
; * Com1Rx										* (Com1RxWain)
; *   Com1RxWait		.			A			Read a character from COM1 (waiting)
; *   Com1RxNoWait		.			A,Carry		Read a character from COM1 (non-waiting)
; * Com1Tx				A			.			Sends a character to COM1
; * DelChar				B			.			Delete an amount of characters
; * GetStrByte			X			A,X,Cary	Get a byte from string
; * GetStrNibble		X			A,X,Cary	Get a nibble from string
; * GetStrWord			X			D,X,Cary	Get a word from string
; * InByte				.			A			Converts ASCII hex to a binary byte
; * InChar				.			A			* (Com1RxWait)
; * InCharNW			.			A,Carry		* (Com1RxNoWait)
; * InStr				B,X			B,X,Carry	Input string (size in B, string pointed in X)
; * InWord				.			D			Converts ASCII hex to a binary word
; * OutChar				A			.			* (Com1Tx)
; * OutByte										* (OutByteLZ)
; *   OutByteLZ			A			.			Print a byte to screen (with leading zero)
; *   OutByteNLZ		A			.			Print a byte to screen (no leading zero)
; * OutCRLF				.			.			Print a carriage return and a line feed
; * OutNibble									* (OutNibbleLSB)
; *   OutNibbleLSB		A			.			Print a nibble (LSB of A)
; *   OutNibbleMSB		A			.			Print a nibble (MSB of A)
; * OutStr										* (OutStrLZ)
; *   OutStrLZ			X			X			Print a string pointed by X (with leadig zeros)
; *   OutStrNLZ			X			X			Print a string pointed by X (no leading zeros)
; * OutWord										* (OutWordLZ)
; *   OutWordLZ			D			.			Print a word from binary data (with leading zeros)
; *   OutWordNLZ		D			.			Print a word from binary data (no leading zeros)

; ****************************************************************************************

; I/O addresses
; -------------
Com1_Data		= $FF68			; Data register
Com1_Status		= $FF69			; Read: Status Register, Write: Programmed Reset
Com1_Command	= $FF6A			; Command Register
Com1_Control	= $FF6B			; Control Register

;   ____   _       
;  / ___| | |  ___ 
; | |     | | / __|
; | |___  | | \__ \
;  \____| |_| |___/
;
;
; Clear terminal screen and set cursor to home position (upper-left)
; ==================================================================
; Uses VT compatible ANSI codes 

	PRAGMA cc

Cls:
	; Clear Screen using ANSI/VT100 terminal control escape sequences
	pshs	D
	lda		#ESC				; Control sequence introducer
	jsr		OutChar				;
	lda		#'['				;
	jsr		OutChar				;
	lda		#'2'				; Entire screen
	jsr		OutChar				;
	lda		#'J'				; Clear screen
	jsr		OutChar				;
	; Home the cursor
	lda		#ESC				; Control sequence introducer
	jsr		OutChar
	lda		#'['
	jsr		OutChar
	lda		#'1'
	jsr		OutChar
	lda		#';'
	jsr		OutChar
	lda		#'1'
	jsr		OutChar
	lda		#'H'
	jsr		OutChar
	puls	D,PC

;   ____                       _   ___           _   _   
;  / ___|   ___    _ __ ___   / | |_ _|  _ __   (_) | |_ 
; | |      / _ \  | '_ ` _ \  | |  | |  | '_ \  | | | __|
; | |___  | (_) | | | | | | | | |  | |  | | | | | | | |_ 
;  \____|  \___/  |_| |_| |_| |_| |___| |_| |_| |_|  \__|
;
;
; Serial port 1 initialization
; ============================

	PRAGMA cc

Com1Init:
	pshs	A
	lda		#$00				; Perform a software reset
	sta		Com1_Status
	lda 	#%00010000			; 1 stop bit, 8 data bits, 115200 baud
;	lda 	#%00011111			; 1 stop bit, 8 data bits, 19200 baud
	sta 	Com1_Control
	lda 	#%00001011			; No parity, no echo, RTS low, DTR low
	sta 	Com1_Command
	puls	A,PC

;   ____                       _   ____
;  / ___|   ___    _ __ ___   / | |  _ \  __  __
; | |      / _ \  | '_ ` _ \  | | | |_) | \ \/ /
; | |___  | (_) | | | | | | | | | |  _ <   >  <
;  \____|  \___/  |_| |_| |_| |_| |_| \_\ /_/\_\
;
;
; Serial port 1 receive character (waiting)
; =========================================
; Status bit 3 goes HIGH when the ACIA transfers data from the Receiver Shift
; Register to the Receiver Data Register and goes LOW when the processor reads the
; Receiver Data Register.
;
; Output:	A = Character received

	PRAGMA cc

InChar:
Com1RxWait:
	lda		Com1_Status			; Load the ACIA's status in to the accumulator
	anda	#%00001000			; Check if there's data in the buffer
	beq		Com1RxWait			; Loop untill buffer is empty
	lda		Com1_Data			; Load character from the data register
	rts

; Serial port 1 receive character (non-waiting)
; =============================================
; Output:	Carry bit clear = no character received.
;			Carry bit set = character received in A.

	PRAGMA cc

InCharNW:
Com1RxNoWait:
	andcc	#$FE				; Clear Carry to indicate no character is present
	lda		Com1_Status			; Load ACIA1 status register
	anda	#%00001000			; Is there a character in the buffer?
	beq		Com1RxNoWaitEnd		; If not then end subroutine, with cleared carry
	lda		Com1_Data			; Read character from ACIA buffer
	orcc	#$01				; Set carry flag to indicate a character is available
Com1RxNoWaitEnd:
	rts

;   ____                       _   _____        
;  / ___|   ___    _ __ ___   / | |_   _| __  __
; | |      / _ \  | '_ ` _ \  | |   | |   \ \/ /
; | |___  | (_) | | | | | | | | |   | |    >  < 
;  \____|  \___/  |_| |_| |_| |_|   |_|   /_/\_\
;
;
; Serial port 1 transmit character
; ================================
; Write a character to Rockwell ACIA1. If using a WDC 65C51, use a delay instead of
; checking the transmit buffer flag (Known and documented Transmit bug in W65C51N).
;
; Status bit 4 goes HIGH when the ACIA transfers data from the Transmitter Data
; Register to the Transmitter Shift Register, and goes LOW when the processor writes
; new data onto the Transmitter Data Register.
;
; Input:	A = Character to transmit

	PRAGMA cc

OutChar:
Com1Tx:
	pshs	A					; Save the character for later use
Com1TxNotReady:
	lda		Com1_Status			; Load the status register
	anda	#%00010000			; Is the transmit buffer full?
	beq		Com1TxNotReady		; Yes, then check until it's empty
	puls	A					; Restore the character
	sta		Com1_Data			; Send out the character
	rts

;  ____           _    ____   _                    
; |  _ \    ___  | |  / ___| | |__     __ _   _ __ 
; | | | |  / _ \ | | | |     | '_ \   / _` | | '__|
; | |_| | |  __/ | | | |___  | | | | | (_| | | |   
; |____/   \___| |_|  \____| |_| |_|  \__,_| |_|   
;
; Delete a number of characters
; =============================
; Input:	B = Number of characters to delete

	PRAGMA cc

DelChar:
	pshs	D
	lda		#BS					; Load the backspace character
DelCharLoop:
	jsr		OutChar				; Print the backspace character
	lda		#' '				; Load the space character
	jsr		OutChar				; Print it the space character
	lda		#BS					; Load the backspace character
	jsr		OutChar				; Print it the backspace character
	decb						; Decrement the character count
	bne		DelCharLoop			; If not zero, then loop to delete another character
	puls	D,PC

;   ____          _     ____    _            ____            _          
;  / ___|   ___  | |_  / ___|  | |_   _ __  | __ )   _   _  | |_    ___ 
; | |  _   / _ \ | __| \___ \  | __| | '__| |  _ \  | | | | | __|  / _ \
; | |_| | |  __/ | |_   ___) | | |_  | |    | |_) | | |_| | | |_  |  __/
;  \____|  \___|  \__| |____/   \__| |_|    |____/   \__, |  \__|  \___|
;                                                    |___/
;
; Read a byte from string in X, and converts to binary
; ====================================================
; Input:	X = String pointer
; Output:	A = Binary byte
;			X = Points to next character in string
;			Carry Clear = hex digit is not valid
;			Carry Set = hex digit is valid in A

GetStrByte:
	pshs	B
	pshsw
	pshs	X					; Save position
	clrb						; Clear byte counter
	clrf						; Clear byte storage
GetStrByteCount:
	lda		,X+					; Load a character
	beq		GetStrByteParse		; If it's the end of the string, parse byte
	cmpa	#' '				; Is it a space delimiter
	beq		GetStrByteParse		; Yes, then parse byte
	incb						; Increment byte counter
	bra		GetStrByteCount		; Loop till delimiter found
GetStrByteParse:
	puls	X					; Restore position
	cmpb	#0					; Is the counter = 0
	beq		GetStrByteError		; Yes, then set error flag
	cmpb	#1					; Is it 1 character long
	bne		GetStrByteParse2	; No, then check if it's 2
	jsr		GetStrNibble		; Get a nibble
	bcc		GetStrByteError		; If it's not a valid hex digit, then set error flag
	bra		GetStrByteGood		; Exit indicating that it's a valid hex digit
GetStrByteParse2:
	cmpb	#2					; Is it 2 character long
	bne		GetStrByteParseMore	; No, then check if it's 3
	jsr		GetStrNibble		; Get a nibble
	bcc		GetStrByteError		; If it's not a valid hex digit, then set error flag
	asla						; Push nibble to MSB
	asla						;
	asla						;
	asla						;
	tfr		A,B					; Store byte in LSB of W
	jsr		GetStrNibble		; Get a nibble
	bcc		GetStrByteError		; If it's not a valid hex digit, then set error flag
	orr		B,A					; Merge both nibbles as a byte
	bra		GetStrByteGood		; Exit indicating that it's a valid hex digit
GetStrByteParseMore:
	lda		CmdErrorPtr			; Load error pointer
	adda	#3					; Add 3 to it
	sta		CmdErrorPtr			; Store it back
	bra		GetStrByteError		; Set error flag
GetStrByteGood:
	orcc	#%00000001			; Set Carry: Indicates the byte is ok
	bra		GetStrByteEnd
GetStrByteError:
	andcc	#%11111110			; Clear Carry: Indicates there an error
GetStrByteEnd:
	pulsw
	puls	B,PC

GetStrByteFixed:
	pshs	B
	jsr		GetStrNibble		; Get a nibble
	bcc		GetStrByteFixedErr	; If it's not a valid hex digit, then set error flag
	asla						; Push nibble to MSB
	asla						;
	asla						;
	asla						;
	tfr		A,B					; Store byte in B
	jsr		GetStrNibble		; Get a nibble
	bcc		GetStrByteFixedErr	; If it's not a valid hex digit, then set error flag
	orr		B,A					; Merge both nibbles as a byte
	orcc	#%00000001			; Set Carry: Indicates the nibble is ok
	bra		GetStrByteFixedEnd	;
GetStrByteFixedErr:
	andcc	#%11111110			; Clear Carry: Indicates there an error
GetStrByteFixedEnd:
	puls	B,PC

;   ____          _     ____    _            _   _   _   _       _       _        
;  / ___|   ___  | |_  / ___|  | |_   _ __  | \ | | (_) | |__   | |__   | |   ___ 
; | |  _   / _ \ | __| \___ \  | __| | '__| |  \| | | | | '_ \  | '_ \  | |  / _ \
; | |_| | |  __/ | |_   ___) | | |_  | |    | |\  | | | | |_) | | |_) | | | |  __/
;  \____|  \___|  \__| |____/   \__| |_|    |_| \_| |_| |_.__/  |_.__/  |_|  \___|
;
;
; Read a nibble from string in X, and converts to binary
; ======================================================
; Input:	X = String pointer
; Output:	A = Binary nibble in LSB
;			X = Points to next character in string
;			Carry Clear = hex digit is not valid
;			Carry Set = hex digit is valid in A

GetStrNibble:
	lda		,X					; Get a character from string
	beq		GetStrNibbleError	; Is it the end of the string? Yes, then error
	jsr		UpperCase			; No, then convert to uppercase
	; Is it a valid hex character?
	cmpa	#'0'				; Filter anything bellow the ASCII 0
	blt		GetStrNibbleError	; Is it less than '0'? Yes, then error
	cmpa	#'F'				; Filter anything above the ASCII F
	bgt		GetStrNibbleError	; Is it greater than 'F'? Yes, then error
	cmpa	#'9'				; Filter anything above ASCII '9'
	ble		GetStrNibbleGood	; Is it less or equal to '9'? Yes, then ok
	cmpa	#'A'				; Filter anything below ASCII 'A'
	bge		GetStrNibbleGood	; Is it greater then or equal to 'A'? Yes, then ok
GetStrNibbleError:
	andcc	#$FE				; Clear carry to indicate error
	bra		GetStrNibbleEnd
GetStrNibbleGood:
	jsr		AscToBinNibble
	orcc	#$01				; Set carry to indicate valid number in A
GetStrNibbleEnd:
	leax	1,X					; Increment string pointer
	inc		CmdErrorPtr			; Advance error pointer
	rts
	
;   ____          _     ____    _           __        __                     _ 
;  / ___|   ___  | |_  / ___|  | |_   _ __  \ \      / /   ___    _ __    __| |
; | |  _   / _ \ | __| \___ \  | __| | '__|  \ \ /\ / /   / _ \  | '__|  / _` |
; | |_| | |  __/ | |_   ___) | | |_  | |      \ V  V /   | (_) | | |    | (_| |
;  \____|  \___|  \__| |____/   \__| |_|       \_/\_/     \___/  |_|     \__,_|
;
;
; Read a word from string in X, and converts to binary
; ======================================================
; Input:	X = String pointer
; Output:	D = Binary word
;			X = Points to next character in string
;			Carry Clear = hex digit is not valid
;			Carry Set = hex digit is valid in D

GetStrWord:
	pshsw
	pshs	X					; Save position
	clrb						; Clear word counter
	clrw						; Clear word storage
GetStrWordCount:
	lda		,X+					; Load a character
	beq		GetStrWordParse		; If it's the end of the string, parse word
	cmpa	#' '				; Is it a space delimiter
	beq		GetStrWordParse		; Yes, then parse word
	incb						; Increment byte counter
	bra		GetStrWordCount		; Loop till delimiter found
GetStrWordParse:
	puls	X					; Restore position
	cmpb	#0					; Is the counter = 0
	beq		GetStrWordError		; Yes, then set error flag
	cmpb	#1					; Is it 1 character long
	bne		GetStrWordParse2	; No, then check if it's 2
	jsr		GetStrNibble		; Get a nibble
	bcc		GetStrWordError		; If it's not a valid hex digit, then set error flag
	tfr		A,F					; Store nibble in LSB of W
	bra		GetStrWordGood		; Exit indicating that it's a valid hex digit
GetStrWordParse2:
	cmpb	#2					; Is it 2 character long
	bne		GetStrWordParse3	; No, then check if it's 3
	jsr		GetStrByteFixed		; Get a byte
	bcc		GetStrWordError		; If it's not a valid hex digit, then set error flag
	tfr		A,F					; Store byte in LSB of W
	bra		GetStrWordGood		; Exit indicating that it's a valid hex digit
GetStrWordParse3:
	cmpb	#3					; Is it 3 character long
	bne		GetStrWordParse4	; No, then check if it's 4
	jsr		GetStrNibble		; Get a nibble
	bcc		GetStrWordError		; If it's not a valid hex digit, then set error flag
	tfr		A,E					; Store nibble in MSB of W
	jsr		GetStrByteFixed		; Get a byte
	bcc		GetStrWordError		; If it's not a valid hex digit, then set error flag
	tfr		A,F					; Store byte in LSB of W
	bra		GetStrWordGood		; Exit indicating that it's a valid hex digit
GetStrWordParse4:
	cmpb	#4					; Is it 4 character long
	bne		GetStrWordParseMore	; No, then check if it's longer
	jsr		GetStrByteFixed		; Get a byte
	bcc		GetStrWordError		; If it's not a valid hex digit, then set error flag
	tfr		A,E					; Store byte in MSB of W
	jsr		GetStrByteFixed		; Get a byte
	bcc		GetStrWordError		; If it's not a valid hex digit, then set error flag
	tfr		A,F					; Store byte in LSB of W
	bra		GetStrWordGood		; Exit indicating that it's a valid hex digit
GetStrWordParseMore:
	lda		CmdErrorPtr			; Load error pointer
	adda	#5					; Add 5 to it
	sta		CmdErrorPtr			; Store it back
	bra		GetStrWordError		; Set error flag
GetStrWordGood:
	tfr		W,D
	orcc	#%00000001			; Set Carry: Indicates the word is ok
	bra		GetStrWordEnd
GetStrWordError:
	andcc	#%11111110			; Clear Carry: Indicates there an error
GetStrWordEnd:
	pulsw
	rts

;  ___           ____            _          
; |_ _|  _ __   | __ )   _   _  | |_    ___ 
;  | |  | '_ \  |  _ \  | | | | | __|  / _ \
;  | |  | | | | | |_) | | |_| | | |_  |  __/
; |___| |_| |_| |____/   \__, |  \__|  \___|
;                        |___/              
;
; Read a hexadecimal byte
; =======================
; Output:	A = Binary number converted from two ASCII characters read from stdin

	PRAGMA cc

InByte:
	pshs	B,CC
	jsr		InChar				; Read first character in A
	tfr		A,B					; Save is in B temporarily
	jsr		InChar				; Read second character in A
	exg		A,B					; Swap both registers to put them in order
	jsr		AscToBinByte		; Convert 2 ASCII characters in D to a binary in A
	puls	B,CC,PC

;  ___           ____    _
; |_ _|  _ __   / ___|  | |_   _ __
;  | |  | '_ \  \___ \  | __| | '__|
;  | |  | | | |  ___) | | |_  | |
; |___| |_| |_| |____/   \__| |_|
;
;
; Read string from from input device
; ==================================
; Reg used:	E = current number of bytes counter
;			F = contains the original max number of bytes to read
;			Y = contains the original string pointer start
; Input:	B = max number of characters to read
;			X = Pointer to string (ex: InStrBuffer has a 256 bytes buffer)
; Output:	B = Actual number of characters read
;			X = Pointer to start of string, null terminated
;				Carry bit clear = no string recorded
;				Carry bit set = string in InStrBuffer

	PRAGMA cc

InStr:
	pshs	A,X,Y
	pshsw
	tfr		X,Y					; Stores the starting address of the string
	tfr		B,F					; Stores the original size of string to grab
	clre						; Clear the current byte count
InStrReadChar:
	jsr		InChar				; Wait for a character
	;jsr		UpperCase	; *** TEMPORARY
	cmpa	#CR					; Is it the Carriage Return key?
	beq		InStrPrintCR		; Yes, then end string read
	cmpa 	#BS					; Is it the Backspace key?
	beq		InStrBackspace		; Yes, then delete previous character
	cmpa	#ESC				; Has the ESC key been pressed?
	beq		InStrEscape			; Yes, then quit reading string and empty buffer
	bmi		InStrReadChar		; Don't accept ASCII character above 127?
	cmpr	B,E					; Has it reached the number of characters imposed by input?
	bne		InStrStoreChar		; If the max number of characters has not been reached, store it
InStrBackspace:
	cmpr	X,Y					; Is it the first character in the string?
	beq 	InStrReadChar		; No characters present, so get a new character
	leax	-1,X				; Decrement string index
	dece						; Decrement the current byte counter
	dec		CmdErrorPtr			; Decrement the error pointer
	pshs	B					; Saves B
	ldb		#1					; number of characters to delete
	jsr		DelChar				; Delete a character
	puls	B					; Restores B
	bra 	InStrReadChar		; Go read next character
InStrEscape:
	cmpe	#0					; Is there a character in the buffer?
	beq		InStrReadChar		; No, then read a character
	pshs	B					; Else, erase everyting
	tfr		E,B					; Amount of bytes to delete
	jsr		DelChar				; Delete the whole line
	puls	B
	tfr		Y,X					; Restores string pointer position
	clre						; Clear the byte count
	lda		PromptSize
	sta		CmdErrorPtr			; Reset the error pointer position
	bra		InStrReadChar		; Restart by reading the first character
InStrStoreChar:
	jsr 	OutChar				; Print character on terminal
	sta		,X+					; Add to the text buffer
	ince						; Increment byte count
	bra 	InStrReadChar		; No? Read another character
InStrPrintCR:
	jsr		OutCRLF				; Print carriage return
	clr		,X					; Add a null termination to the input buffer string
	tfr		E,B					; Saves actual bytes entered
	cmpe	#0					; Are there any characters in the buffer?
	beq		InStrClearCarry		; No characters, so go clear the carry flag
	orcc	#%00000001			; Set Carry: Indicates there is data in buffer
	bra		InStrEnd
InStrClearCarry:
	andcc	#%11111110			; Clear Carry: Indicates there is no data in buffer
InStrEnd:
	pulsw
	puls	A,X,Y,PC

;  ___          __        __                     _ 
; |_ _|  _ __   \ \      / /  ___    _ __    __| |
;  | |  | '_ \   \ \ /\ / /  / _ \  | '__|  / _` |
;  | |  | | | |   \ V  V /  | (_) | | |    | (_| |
; |___| |_| |_|    \_/\_/    \___/  |_|     \__,_|
;
;
; Read a hexadecimal word
; =======================
; Output:	D = Binary number converted from two ASCII characters read from stdin
; 
	PRAGMA cc

InWord:
	pshs	CC
	pshsw
	jsr		InChar
	tfr		A,F
	jsr		InChar
	tfr		A,B
	jsr		InChar
	tfr		A,E
	jsr		InChar
	exg		A,F
	jsr		AscToBinWord
	pulsw
	puls	CC,PC
	
;   ___            _     ____            _          
;  / _ \   _   _  | |_  | __ )   _   _  | |_    ___ 
; | | | | | | | | | __| |  _ \  | | | | | __|  / _ \
; | |_| | | |_| | | |_  | |_) | | |_| | | |_  |  __/
;  \___/   \__,_|  \__| |____/   \__, |  \__|  \___|
;                                |___/
;
; Print a byte as 2 ASCII characters
; ==================================
; Input:	A = Byte to output

	PRAGMA cc

OutByte:
OutByteLZ:
	pshs	A,B,CC
	jsr		BinToAscByte		; In A = binary byte, Out D = ASCII characters
	jsr		OutChar				; Print MSB in A
	tfr		B,A					; Transfer LSB in A
	jsr		OutChar				; Print LSB that is now in A
	puls	A,B,CC,PC

; Print a byte as 2 ASCII characters, without a leading zero
; ==========================================================
; Input:	A = Byte to output

	PRAGMA cc

OutByteNLZ:
	pshs	A,B,CC
	jsr		BinToAscByte		; In A = binary byte, Out D = ASCII characters
	cmpa	#'0'				; Is the MSB a ASCII '0'?
	beq		OutByteDigit1NLZ	; If it is, then skip printing the first digit
	jsr		OutChar				; Print MSB in A
OutByteDigit1NLZ:	
	tfr		B,A					; Transfer LSB in A
	jsr		OutChar				; Print LSB that is now in A
	puls	A,B,CC,PC

;   ___            _      ____   ____    _       _____ 
;  / _ \   _   _  | |_   / ___| |  _ \  | |     |  ___|
; | | | | | | | | | __| | |     | |_) | | |     | |_   
; | |_| | | |_| | | |_  | |___  |  _ <  | |___  |  _|  
;  \___/   \__,_|  \__|  \____| |_| \_\ |_____| |_|    
;
; Print a carriage return and linefeed
; ====================================

	PRAGMA cc

OutCRLF:
	pshs	A,CC
	lda		#CR
	jsr		OutChar
	lda		#LF
	jsr		OutChar
	puls	A,CC,PC

;   ___            _     _   _   _   _       _       _        
;  / _ \   _   _  | |_  | \ | | (_) | |__   | |__   | |   ___ 
; | | | | | | | | | __| |  \| | | | | '_ \  | '_ \  | |  / _ \
; | |_| | | |_| | | |_  | |\  | | | | |_) | | |_) | | | |  __/
;  \___/   \__,_|  \__| |_| \_| |_| |_.__/  |_.__/  |_|  \___|
;
; Print LSB nibble as an ASCII character
; ====================================
; Input:	A = Nibble to output

	PRAGMA cc

OutNibble:
OutNibbleLSB:
	pshs	A,CC
	jsr		BinToAscNibble		; Print LSB nibble
	jsr		OutChar
	puls	A,CC,PC

; Print LSB nibble as an ASCII character
; ====================================
; Input:	A = Nibble to output

	PRAGMA cc

OutNibbleMSB:
	pshs	A,CC
	lsra						; Shift the upper nibble to the lower nibble,
	lsra						;   all the while clearing the upper nibble with 0
	lsra						;
	lsra						;
	jsr		BinToAscNibble		; Print MSB nibble
	jsr		OutChar
	puls	A,CC,PC

;   ___            _     ____    _
;  / _ \   _   _  | |_  / ___|  | |_   _ __
; | | | | | | | | | __| \___ \  | __| | '__|
; | |_| | | |_| | | |_   ___) | | |_  | |
;  \___/   \__,_|  \__| |____/   \__| |_|
;
; Print a string to the screen
; ============================
; Input:    X = Address of string to print
; Output:	X = Address of next string (if any)

	PRAGMA cc

OutStr:
OutStrLZ:
	pshs	A,CC
OutStrLoop:
	lda		,X+					; Read character pointed by X, then increments X
	beq		OutStrEnd			; End routine if end of string (null) has been reached
	cmpa	#EOD				; Is second terminator detected?
	beq		OutStrEnd			; End routine if end of string (EOD) has been reached
	lbsr	OutChar				; Print character
	bra		OutStrLoop			; Loop to get the next character
OutStrEnd:
	puls	A,CC,PC

; Print a string to the screen without leading zeros
; ==================================================
; Input:    X = Address of string to print
; Output:	X = Address of next string (if any)

	PRAGMA cc

OutStrNLZ:
	pshs	A,B,CC
	clrb						; Clear B register as a leading zero flag 
OutStrNLZLoop:
	lda		,X+					; Read character pointed by X, then increments X
	cmpa	#EOD				; Is second (End of Data) terminator detected?
	beq		OutStrNLZEnd		; End routine if end of string (EOD) has been reached
	cmpa	#'0'				; Is it a zero?
	bne		OutStrNLZPrintChar	; No then go print the character
	cmpa	#0					; Yes, but is it a leading zero (as opposed to embedded zeros)
	beq		OutStrNLZLoop		; Yes, it's a leading zero, not an embedded one
OutStrNLZPrintChar:
	tfr		A,B					; Store non-zero as flag to no longer look for leading zeros
	jsr		OutChar				; Print character
	bra		OutStrNLZLoop		; Loop to get the next character
OutStrNLZEnd:
	puls	A,B,CC,PC

;   ___            _    __        __                     _ 
;  / _ \   _   _  | |_  \ \      / /   ___    _ __    __| |
; | | | | | | | | | __|  \ \ /\ / /   / _ \  | '__|  / _` |
; | |_| | | |_| | | |_    \ V  V /   | (_) | | |    | (_| |
;  \___/   \__,_|  \__|    \_/\_/     \___/  |_|     \__,_|
;
; Print a word as 4 ASCII characters
; ==================================
; Input:	D = Word to output

	PRAGMA cc

OutWord:
	pshs	A,B,CC
	pshsw
	jsr		BinToAscWord		; In D = binary word, Out Q = ASCII characters
	jsr		OutChar				; Print 4th digit
	tfr		B,A					; Transfer 3rd digit in A
	jsr		OutChar				; Print 3rd digit
	tfr		E,A					; Transfer 2nd digit in A
	jsr		OutChar				; Print 2nd digit
	tfr		F,A					; Transfer 1st digit in A
	jsr		OutChar				; Print 1st digit
	pulsw
	puls	A,B,CC,PC

; Print a word as 4 ASCII characters, without leading zeros
; =========================================================
; Input:	D = Byte to output

	PRAGMA cc

OutWordNLZ:
	pshs	A,B,X
	pshsw
	ldx		#0					; Clear leading zero flag
	jsr		BinToAscWord		; In D = binary word, Out Q = ASCII characters
	cmpa	#'0'				; Is it ASCII zero?
	beq		OutWordNLZ2			; If not zero, then print 1st character
	leax	1,X					; Place non zero value to indicate no more leading zeros
	jsr		OutChar				; Print 1th digit
OutWordNLZ2:
	tfr		B,A					; Transfer 3rd digit in A
	cmpa	#'0'				; Is it ASCII zero
	bne		OutWordNLZp2		; It's not zero
	cmpx	#0					; Check leading zero flag
	beq		OutWordNLZ3			; Still a leading zero, skip to next character
OutWordNLZp2:
	leax	1,X					; Place non zero value to indicate no more leading zeros
	jsr		OutChar				; Print 2rd digit
OutWordNLZ3:
	tfr		E,A					; Transfer 2nd digit in A
	cmpa	#'0'				; Is it ASCII zero
	bne		OutWordNLZp3		; It's not zero
	cmpx	#0					; Check leading zero flag
	beq		OutWordNLZ4			; Still a leading zero, skip to next character
OutWordNLZp3:
	leax	1,X					; Place non zero value to indicate no more leading zeros
	jsr		OutChar				; Print 3nd digit
OutWordNLZ4:
	tfr		F,A					; Transfer 1st digit in A
	jsr		OutChar				; Print 4st digit
	pulsw
	puls	A,B,X,PC
