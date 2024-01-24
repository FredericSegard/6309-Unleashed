; ****************************************************************************************
; * I/O subroutines
; * ---------------
; * Cls			Clear the screen using ANSI/VT100 terminal control escape sequences
; * Com1Init	Initialize COM1 (USB)
; * InChar		Read a character, waiting			(Com1RxWait)
; * InCharNW	Read a character, non-waiting		(Com1RxNoWait)
; * InStr		Read a string
; * OutChar		Print a character					(Com1Tx)
; * OutNibble	Print a nibble
; * OutStr		Print a string
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
; Clear terminal screen and set cursor to home position (upper-left)
; ==================================================================

Cls:
	pshs	A
	; ERASE SCREEN
	lda		#ESC				; Control sequence introducer
	jsr		OutChar				;
	lda		#'['				;
	jsr		OutChar				;
	lda		#'2'				; Entire screen
	jsr		OutChar				;
	lda		#'J'				; Clear screen
	jsr		OutChar				;
	; CURSOR HOME
	lda		#ESC				; Control sequence introducer
	jsr		OutChar				;
	lda		#'['				;
	jsr		OutChar				;
	lda		#'1'				; Position cursor on first column
	jsr		OutChar				;
	lda		#';'				;
	jsr		OutChar				;
	lda		#'1'				; Position cursor on first column
	jsr		OutChar				;
	lda		#'H'				; Return to home position 1:1
	jsr		OutChar				;
	puls	A,PC

;   ____                       _   ___           _   _   
;  / ___|   ___    _ __ ___   / | |_ _|  _ __   (_) | |_ 
; | |      / _ \  | '_ ` _ \  | |  | |  | '_ \  | | | __|
; | |___  | (_) | | | | | | | | |  | |  | | | | | | | |_ 
;  \____|  \___/  |_| |_| |_| |_| |___| |_| |_| |_|  \__|
;
; Serial port 1 initialization
; ============================

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
; Serial port 1 receive character (waiting)
; =========================================
; Status bit 3 goes HIGH when the ACIA transfers data from the Receiver Shift
; Register to the Receiver Data Register and goes LOW when the processor reads the
; Receiver Data Register.
;
; Output:	A = Character received

InChar:							; *** InChar ***
Com1RxWait:						; --------------
	lda		Com1_Status			; Load the ACIA's status in to the accumulator
	anda	#%00001000			; Check if there's data in the buffer
	beq		Com1RxWait			; Loop untill buffer is empty
	lda		Com1_Data			; Load character from the data register
	rts

; Serial port 1 receive character (non-waiting)
; =============================================
; Output:	Carry bit clear = no character received.
;			Carry bit set = character received in A.

InCharNW:						; *** InCharNW ***
Com1RxNoWait:					; ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
	andcc	#%11111110			; Clear Carry to indicate no character is present
	lda		Com1_Status			; Load ACIA1 status register
	anda	#%00001000			; Is there a character in the buffer?
	beq		Com1RxNoWaitEnd		; If not then end subroutine, with cleared carry
	lda		Com1_Data			; Read character from ACIA buffer
	orcc	#%00000001			; Set carry flag to indicate a character is available
Com1RxNoWaitEnd:
	rts

;   ____                       _   _____        
;  / ___|   ___    _ __ ___   / | |_   _| __  __
; | |      / _ \  | '_ ` _ \  | |   | |   \ \/ /
; | |___  | (_) | | | | | | | | |   | |    >  < 
;  \____|  \___/  |_| |_| |_| |_|   |_|   /_/\_\
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
; Output:	A = Transmitted character

OutChar:						; *** OutChar ***
Com1Tx:							; ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
	pshs	A					; Save the character for later use
Com1TxNotReady:
	lda		Com1_Status			; Load the status register
	anda	#%00010000			; Is the transmit buffer full?
	beq		Com1TxNotReady		; Yes, then check until it's empty
	puls	A					; Restore the character
	sta		Com1_Data			; Send out the character
	rts

;  ___           ____    _
; |_ _|  _ __   / ___|  | |_   _ __
;  | |  | '_ \  \___ \  | __| | '__|
;  | |  | | | |  ___) | | |_  | |
; |___| |_| |_| |____/   \__| |_|
;
; Read string from from input device
; ==================================
; Input:	X = max number of characters
; Output:	InStrBuffer, null terminated
;				Carry bit clear = no string recorded
;				Carry bit set = string in InStrBuffer

InStr:
	pshs	A,X
	stx		TempWord			; Store number of bytes to read in TempWord
	ldx		#0					; Set string index to 0
InStrReadChar:
	jsr		InChar				; Wait for a character
	cmpa	#CR					; Is it the Carriage Return key?
	beq		InStrPrintCR		; Yes, then end string read
	cmpa 	#BS					; Is it the Backspace key?
	beq		InStrBackspace		; Yes, then delete previous character
	cmpa	#ESC				; Has the ESC key been pressed?
	beq		InStrEscape			; Yes, then quit reading string and empty buffer
	bmi		InStrReadChar		; Don't accept ASCII character above 127?
	cmpx	TempWord			; Has it reached the number of characters imposed by input?
	bne		InStrStoreChar		; Get next character, but if above 127 characters, auto escape
InStrBackspace:
	cmpx	#0					; Is it the first character in the string?
	beq 	InStrReadChar		; No characters present, go get a new character
	leax	-1,X				; Decrement text index
	lda 	#BS					; Go back one character,
	jsr 	OutChar				;   on the terminal
	lda 	#' '				; Go overwite previous character,
	jsr 	OutChar				;   on the terminal
	lda 	#BS					; Go back one character again,
	jsr 	OutChar				;   on the terminal
	bra 	InStrReadChar		; Go read next character
InStrEscape:
	ldx		#0					; Set index to 0 (Start of InStrBuffer)
	bra		InStrPrintCR		; Exit routine 
InStrStoreChar:
	jsr 	OutChar				; Print character on terminal
	sta		InStrBuffer,X		; Add to the text buffer
	leax	1,X					; Increment character counter
	bra 	InStrReadChar		; No? Read another character
InStrPrintCR:
	jsr		OutCRLF				; Print carriage return
	lda		#NULL				; Add a null,
	sta		InStrBuffer,X		;   to the input buffer string
	cmpx	#0
	beq		InStrClearCarry		
	orcc	#%00000001			; Set Carry: Indicates there is data in buffer
	bra		InStrEnd
InStrClearCarry:
	andcc	#%11111110			; Clear Carry: Indicates there is no data in buffer
InStrEnd:
	puls	A,X,PC

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

OutByte:
	pshs	D
	jsr		BinToAscii8			; In A = binary byte, Out D = ASCII characters
	jsr		OutChar				; Print MSB
	tfr		B,A					; Transfer LSB in A
	jsr		OutChar				; Print LSB
	puls	D,PC

;   ___            _      ____   ____    _       _____ 
;  / _ \   _   _  | |_   / ___| |  _ \  | |     |  ___|
; | | | | | | | | | __| | |     | |_) | | |     | |_   
; | |_| | | |_| | | |_  | |___  |  _ <  | |___  |  _|  
;  \___/   \__,_|  \__|  \____| |_| \_\ |_____| |_|    
;
; Print a carriage return and linefeed
; ====================================

OutCRLF:
	pshs	A
	lda		#CR
	jsr		OutChar
	lda		#LF
	jsr		OutChar
	puls	A,PC

;   ___            _     _   _   _   _       _       _        
;  / _ \   _   _  | |_  | \ | | (_) | |__   | |__   | |   ___ 
; | | | | | | | | | __| |  \| | | | | '_ \  | '_ \  | |  / _ \
; | |_| | | |_| | | |_  | |\  | | | | |_) | | |_) | | | |  __/
;  \___/   \__,_|  \__| |_| \_| |_| |_.__/  |_.__/  |_|  \___|
;
; Print a nibble as an ASCII character
; ====================================
; Input:	A = Nibble to output

OutNibble:
	pshs	A
	jsr		BinToAscii4
	jsr		OutChar
	puls	A,PC

;   ___            _     ____    _
;  / _ \   _   _  | |_  / ___|  | |_   _ __
; | | | | | | | | | __| \___ \  | __| | '__|
; | |_| | | |_| | | |_   ___) | | |_  | |
;  \___/   \__,_|  \__| |____/   \__| |_|
;
; Print a string to the screen
; ============================
; Input:    X = Pass address of string to print


OutStr:
	pshs	A,X
OutStrLoop:
	lda		,X+					; Read character pointed by X, then increments X
	beq		OutStrEnd			; End routine if end of string (null) has been reached
	jsr		OutChar				; Print character
	bra		OutStrLoop			; Get the next character
OutStrEnd:
	puls	A,X,PC
