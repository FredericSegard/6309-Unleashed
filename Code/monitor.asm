; ****************************************************************************************
; * Subroutines			IN			OUT			Description
; * --------------------------------------------------------------------------------------
; * CmdErrors			.			.			
; *   ErrPointer								Print the error location
; *   ErrInvalidAddress
; *   ErrInvalidByte
; *   ErrInvalidCommand
; *   ErrInvalidParameter
; *   ErrNoParameter
; *   ErrSyntaxError
; * CmdHelp  			.			.			List of monitor commands
; * CmdParse			X			.			Parse the command string
; * CmdPrompt			.			X			Print the command prompt
; * Dump				X			.			Dumps the contents of memory
; * LoadIntelHex		.			.			Intel Hex loader
; * MemoryMap			.			.			Print memory and I/O map
; * Peek				X			.			Read a byte from a memory location
; * Poke				X			.			Write a byte at a memory location
; * PrintRegisters		.			.			Print the contents of the registers
; * PushRegisters		.			.			Push the contents of the registers to RAM
; * PullRegisters		.			.			Pull the contents of the registers from RAM
; * Run					X			.			Execute code at specified or CurrAddr
; * SetAddress			X			.			Sets the current address for commands
; * SetBank				X			.			Sets the current bank
; * SkipSpaces			X			X			Skip spaces in the command line
; ****************************************************************************************

;   ____                   _   _____                                    
;  / ___|  _ __ ___     __| | | ____|  _ __   _ __    ___    _ __   ___ 
; | |     | '_ ` _ \   / _` | |  _|   | '__| | '__|  / _ \  | '__| / __|
; | |___  | | | | | | | (_| | | |___  | |    | |    | (_) | | |    \__ \
;  \____| |_| |_| |_|  \__,_| |_____| |_|    |_|     \___/  |_|    |___/
;
; Various error messages pertaining to command line
; =================================================

; Error pointer of where the error occured on the command line
; ------------------------------------------------------------
ErrPointer:
	pshs	A,B,CC
	ldb		CmdErrorPtr			; Get relative error pointer position
	addb	#PromptSize			; Add command prompt lenght offset
ErrorPointerLoop:
	lda		#' '				; Move cursor one space
	jsr		OutChar				;
	decb						; Decrement position counter
	bne		ErrorPointerLoop	; Has it reached the error position
	lda		#'^'				; Print the position pointer
	jsr		OutChar				;
	jsr		OutCRLF				;
	puls	A,B,CC,PC

; Invalid address error message
; -----------------------------
ErrInvalidAddress:
	pshs	X,CC
	jsr		ErrPointer			; Print ^ error pointer
	ldx		#ErrInvalidAddrMsg	; Print error message
	jsr		OutStr				;
	puls	X,CC,PC

; Invalid byte error message
; --------------------------
ErrInvalidByte:
	pshs	X,CC
	jsr		ErrPointer			; Print ^ error pointer
	ldx		#ErrInvalidByteMsg	; Print error message
	jsr		OutStr				;
	puls	X,CC,PC

; Invalid command error message
; -----------------------------
ErrInvalidCommand:
	pshs	X,CC
	jsr		ErrPointer			; Print ^ error pointer
	ldx		#ErrInvalidCmdMsg	; Print error message
	jsr		OutStr				;
	puls	X,CC,PC

; Invalid parameter error message
; -------------------------------
ErrInvalidParameter:
	pshs	X,CC
	jsr		ErrPointer			; Print ^ error pointer
	ldx		#ErrInvalidParamMsg	; Print error message
	jsr		OutStr				;
	puls	X,CC,PC

; No parameter error message
; --------------------------
ErrNoParameter:
	pshs	X,CC
	jsr		ErrPointer			; Print ^ error pointer
	ldx		#ErrNoParameterMsg	; Print error message
	jsr		OutStr				;
	puls	X,CC,PC
	
; Syntax error message
; --------------------
ErrSyntaxError:
	pshs	X,CC
	jsr		ErrPointer			; Print ^ error pointer
	ldx		#ErrSyntaxErrorMsg	; Print error message
	jsr		OutStr				;
	puls	X,CC,PC

;   ____                   _   _   _          _         
;  / ___|  _ __ ___     __| | | | | |   ___  | |  _ __  
; | |     | '_ ` _ \   / _` | | |_| |  / _ \ | | | '_ \ 
; | |___  | | | | | | | (_| | |  _  | |  __/ | | | |_) |
;  \____| |_| |_| |_|  \__,_| |_| |_|  \___| |_| | .__/ 
;                                                |_|
; Monitor help screen
; ===================

CmdHelp:
	ldx		#CmdHelpMsg
	jsr		OutStr
	rts
	
;   ____                   _   ____                              
;  / ___|  _ __ ___     __| | |  _ \    __ _   _ __   ___    ___ 
; | |     | '_ ` _ \   / _` | | |_) |  / _` | | '__| / __|  / _ \
; | |___  | | | | | | | (_| | |  __/  | (_| | | |    \__ \ |  __/
;  \____| |_| |_| |_|  \__,_| |_|      \__,_| |_|    |___/  \___|
;
; Command parser for the monitor
; ==============================
; Input:	X = Command Prompt String

	PRAGMA cc

CmdParse:
	pshs	A,B,Y,CC
	jsr		SkipSpaces			; Skip leading spaces
	stx		TempWord			; Store string pointer for command list cycling
	lda		,X					; Load first character from command string to see if it's empty
	beq		CmdParseEnd			; Is it the end of the string? Yes, then end
	ldy		#CmdList			; Load command list table location in Y
CmdParseChar:
	lda		,X+					; Load first character from command prompt string
	jsr		UpperCase			; Convert character to upper case (command list is in upper case)
	ldb		,Y+					; Load a character from the command list
	bmi		CmdParseValid		; Command code end delimiter? Execute command
	cmpr	A,B					; Compare command string to command list character
	bne		CmdParseSkip		; Skip command list entry and point to next command
	inc		CmdErrorPtr			; Increment command line error pointer
	bra		CmdParseChar		; Go and compare the next character
CmdParseSkip:
	ldx		TempWord			; Restore command prompt pointer to starting position
	clr		CmdErrorPtr			; Restore command prompt error pointer
CmdParseSkipLoop:
	ldb		,Y+					; Read next character
	bpl		CmdParseSkipLoop	; Loop until command list end delimiter is found
	leay	2,Y					; Jump over command address
	ldb		,Y					; Is it the end of the command list
	beq		CmdParseNone		; Yes it is, print error and exit
	bra		CmdParseChar		; Repeat process until command found
CmdParseValid:
	; Check for characters after valid command
	cmpa	#' '				; Check for a parameter separator (space)
	beq		CmdParseExecute		; Yes, then execute command
	cmpa	#$00				; Check for an end of line in string (null)
	bne		CmdParseNone		; If it's something else, the command invalid, else execute
CmdParseExecute:
	dec		CmdErrorPtr			; Shift pointer -1 for arguments
	ldd		,Y					; Load address of command from table
	std		,--U				; Save address to user stack
	leax	-1,X				; Backup pointer 1 position, because of the auto advance above
	puls	A,B,Y,CC			; Restore registers
	jmp		[,U++]				; Execute command
CmdParseNone:
	jsr		ErrInvalidCommand	;
CmdParseEnd:
	puls	A,B,Y,CC,PC

;   ____                   _   ____                                       _   
;  / ___|  _ __ ___     __| | |  _ \   _ __    ___    _ __ ___    _ __   | |_ 
; | |     | '_ ` _ \   / _` | | |_) | | '__|  / _ \  | '_ ` _ \  | '_ \  | __|
; | |___  | | | | | | | (_| | |  __/  | |    | (_) | | | | | | | | |_) | | |_ 
;  \____| |_| |_| |_|  \__,_| |_|     |_|     \___/  |_| |_| |_| | .__/   \__|
;                                                                |_|
; Prints the command prompt: BB:AAAA> where BB is bank number and AAAA is address
; -------------------------------------------------------------------------------

	PRAGMA cc

CmdPrompt:
	pshs	D
	lda		CurrBank			;
	jsr		OutByte				; Print current bank (not yet implemented)
	lda		#':'				;
	jsr		OutChar				; Print separator
	ldd		CurrAddress			;
	jsr		OutWord				; Print current address
	lda		#'>'				;
	jsr		OutChar				; Print prompt greater than symbol
	lda		#' '				;
	jsr		OutChar				; Print space
	clr		CmdErrorPtr			; Reset command error pointer
	puls	D,PC


;  ____    _                                         _     _              
; |  _ \  (_)   __ _    __ _   _ __     ___    ___  | |_  (_)   ___   ___ 
; | | | | | |  / _` |  / _` | | '_ \   / _ \  / __| | __| | |  / __| / __|
; | |_| | | | | (_| | | (_| | | | | | | (_) | \__ \ | |_  | | | (__  \__ \
; |____/  |_|  \__,_|  \__, | |_| |_|  \___/  |___/  \__| |_|  \___| |___/
;                      |___/                                              
;
; Diagnose RAM and some peripherals
; =================================

Diagnostics:
	ldx		#DiagMessage
	jsr		OutStr
DiagBase:
	ldx		#DiagTestingMsg
	jsr		OutStr
	ldx		#$0000				; Start address pointer
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
	jsr		OutStr				; Print fail message
	tfr		W,D					; Copy the error count over to D
	jsr		BinToBcd			; Convert the number of errors in D to decimal
	jsr		OutBcd				; Print the number
	jsr		OutStr				; Continue the fail message
	bra		DiagBaseEnd
DiagBaseOK:
	ldx		#DiagPassMsg
	jsr		OutStr
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
	
;  ____                              
; |  _ \   _   _   _ __ ___    _ __  
; | | | | | | | | | '_ ` _ \  | '_ \ 
; | |_| | | |_| | | | | | | | | |_) |
; |____/   \__,_| |_| |_| |_| | .__/ 
;                             |_|    
;
; Memory dump
; ===========

Dump:
	jsr		SkipSpaces			; Remove leading white spaces
	lda		,X					; Read a character from string
	beq		DumpDisplay			; If empty, assume Current Address, and display
	jsr		GetStrWord			; Read address from string
	bcc		DumpInvalidAddress	; Invalid Address if Carry is clear
	std		CurrAddress			; Save inputed address in Current Address
DumpDisplay:
	ldx		CurrAddress			; Retrieve Current Address
	tfr		X,Y
	lde		#ScrVertRes-4		; Number of lines to print
DumpAddr:
	tfr		X,D					; Put Current address in D
	jsr		OutWord				;
	lda		#':'				; Print address separator
	jsr		OutChar				;
	lda		#' '				; Print space separator
	jsr		OutChar				;
	ldb		#BytePerLine		; Get the number of bytes to print per line
DumpByte:
	lda		,X+					; Print byte from Current Address
	jsr		OutByte				;
	lda		#' '				; Print space separator
	jsr		OutChar				;
	decb						; Decrement byte counter
	bne		DumpByte			; If not finished, loop and output next byte
	lda		#'|'				; Print space separator
	jsr		OutChar				;
	lda		#' '				; Print space separator
	jsr		OutChar				;
	ldb		#BytePerLine		; Get the number of bytes to print per line
DumpChar:
	lda		,Y+					; Print character from Current Address
	cmpa	#' '				; Compare character to space character
	blt		DumpCharDot			; If lower, then print dot
	tsta						; Is the characther in the extended ASCII range
	bmi		DumpCharDot			; If it is, the print dot
	bra		DumpCharPrint		; Else, print character
DumpCharDot:
	lda		#'.'				; Replace character to dot
DumpCharPrint:
	jsr		OutChar				; Output actual or replaced character
	decb						; Decrement byte counter
	bne		DumpChar			; If not finished, loop and output next character
	jsr		OutCRLF				; Change line
	dece						; Decrement the lines to print
	bne		DumpAddr
	stx		CurrAddress			; Store new Current Address in memory
	bra		DumpEnd
DumpInvalidAddress:
	jsr		ErrInvalidAddress	; Display address error
DumpEnd:
	rts
	
;  _                           _   ___           _            _   _   _               
; | |       ___     __ _    __| | |_ _|  _ __   | |_    ___  | | | | | |   ___  __  __
; | |      / _ \   / _` |  / _` |  | |  | '_ \  | __|  / _ \ | | | |_| |  / _ \ \ \/ /
; | |___  | (_) | | (_| | | (_| |  | |  | | | | | |_  |  __/ | | |  _  | |  __/  >  < 
; |_____|  \___/   \__,_|  \__,_| |___| |_| |_|  \__|  \___| |_| |_| |_|  \___| /_/\_\
;
; Load Intel Hex file to memory
; =============================
; Regs:		D = Various data manipulation
;			E = Checksum accumulator
;			F = Flags: Bit 0 = Origin start address flag, Bit 7 = Download fail flag
;			X = Destination address to copy the record bytes to
;			Y = Byte count in current record
; Vars:		TempWord

LoadIntelHex:
	pshs	A,B,X,Y,CC
	pshsw
	clrw						; Clear the flags and checksum accumulator
	ldx		#LoadStartMsg		; Print message that loading will commence
	jsr		OutStr				; 
LoadRecord:
	jsr		InChar				; Read a character
	cmpa	#ESC				; Is it the ESC key?
	bne		LoadStart			; No, check for record marker
	ldx		#LoadUserAbortErr	; Print message that transfer is aborted
	jsr		OutStr				; 
	lbra	LoadEnd				; Exit
LoadStart:
	cmpa	#':'				; Start of record marker
	bne		LoadRecord			; Not found (also bypasses any CR and LF)
	clre						; Clear checksum accumulator
	; Read the record length
	jsr		InByte				; Get record length
	tfr		A,B					; Transfer value to LSB of D
	clra						; Clear MSB of D
	tfr		D,Y					; Transfer byte count D to Y
	tfr		B,E					; Copy first value to checksum accumulator
	; Read the destination address
	jsr		InWord				; Read the address
	stx		TempWord			; Save last address pointed by X, as last record is $0000
	tfr		D,X					; Save the address to the X register
	; Add checksum of both bytes
	addr	A,E					; Add MSB of address to checksum accumulator
	addr	B,E					; Add LSB of address to checksum accumulator
	;Set origin address flag and store address in CurrAddress
	tstf						; Test the flags register
	bmi		LoadRecordType		; If it's not the first line of code read record type
	stx 	CurrAddress			; Save start address
	stx		RegPC				; Save the user PC 
	ldf		#$80				; Sets the origin flag
LoadRecordType:
	jsr		InByte				; Get the record type
	; Add checksum
	addr	A,E					; Add record type to the checksum accumulator
	; Which record type is it?
	cmpa	#0					; Is it the Data record type?
	beq		LoadData			; Get Data
	cmpa	#1					; Is it the End of File record type?
	beq		LoadEOF				; Load last line
	ldx		#LoadRecordErr		; 
	jsr		OutStr				; Print Unknown Record Type message
	jsr		OutByte				; Print the actual record number
	jsr		OutCRLF				; Change line
	lbra	LoadEnd
LoadData:
	; Get record type 00 (Data)
	jsr		InByte				; Read data
	sta		,X+					; Save data to RAM
	; Add checksum
	addr	A,E					; Add byte data to checksum accumulator
	leay	-1,Y				; Decrement byte counter
	cmpy	#0
	bne		LoadData
LoadChecksum:
	; Process accumulated checksum
	come						; Complement F
	ince						; adding one to get a 2's complement
	; Get record checksum
	jsr		InByte				; Read checksum
	cmpr	A,E					; Do the checksums match
	bne		LoadFailure			; If inconsistent, display message
	lda		#'.'				; Character indicating line is ok
	jsr		OutChar				; Print the period character
	lbra	LoadRecord			; Fetch next record
LoadFailure:
	; Indicate record failed checksum
	ldf		#$81				; Sets the checksum failure flag
	lda		#'x'				; Load the failed checksum character
	jsr		OutChar				; Print it
	lbra	LoadRecord			; Get next record
LoadEOF:
	; Process accumulated checksum
	come						; Complement E
	ince						; adding one to get a 2's complement
	; Get end record (01) checksum
	jsr		InByte				; Get the checksum byte
	cmpr	A,E					; Do the checksums match
	beq		LoadCheckFlag		; If it's the same then verify download fail flag
	ldf		#$81				; Sets the checksum failure flag
	lda		#'X'				; Load the failed checksum character
	jsr		OutChar				; Print it Exit routine
LoadCheckFlag:
	cmpf	#$80				; Was there any checksum errors?
	beq		LoadSuccess			; If no errors, then print success
	jsr		OutCRLF				; Change line
	ldx		#LoadFailedErr		; Print download failed
	jsr		OutStr				;
	bra		LoadEnd				;
LoadSuccess:
	ldx		TempWord			; Restore last position of X
	ldd		#$36FF				; Save opcode "pshu CC,A,B,DP,X,Y,S,PC"
	std		,X++				; Store it at the end of code
	ldd		#$103A				; Save opcode "pshuw"
	std		,X++				; Store it at the end of code
	lda		#$39				; Save opcode "rts"
	sta		,X					; Store it at the end of code to return to prompt
	jsr		OutCRLF				; Change line
	ldx		#LoadSuccessMsg		; Print success message
	jsr		OutStr
LoadEnd:
	pulsw
	puls	A,B,X,Y,CC,PC

;  __  __                                             __  __                 
; |  \/  |   ___   _ __ ___     ___    _ __   _   _  |  \/  |   __ _   _ __  
; | |\/| |  / _ \ | '_ ` _ \   / _ \  | '__| | | | | | |\/| |  / _` | | '_ \ 
; | |  | | |  __/ | | | | | | | (_) | | |    | |_| | | |  | | | (_| | | |_) |
; |_|  |_|  \___| |_| |_| |_|  \___/  |_|     \__, | |_|  |_|  \__,_| | .__/ 
;                                             |___/                   |_|
;
; Prints the memory and I/O map of the system
; ===========================================

MemoryMap:
	pshs	A,B
	ldx		#MemoryMapMsg
	jsr		OutStr				; Print up to end of RAM
	ldd		#RomStart-1
	jsr		OutWord				; Print RAM end
	jsr		OutStr				; Print up to begining of ROM
	incd
	jsr		OutWord				; Print ROM start
	jsr		OutStr				; Print till the end of mapping
	puls	A,B,PC

;  ____                  _    
; |  _ \    ___    ___  | | __
; | |_) |  / _ \  / _ \ | |/ /
; |  __/  |  __/ |  __/ |   < 
; |_|      \___|  \___| |_|\_\
;
;
; Read a byte from a specific or current address
; ==============================================

Peek:
	jsr		SkipSpaces
	lda		,X
	beq		PeekDisplay
	jsr		GetStrWord
	bcc		PeekInvalidAddr
	std		CurrAddress
PeekDisplay:
	ldd		CurrAddress
	jsr		OutWord
	lda		#'='
	jsr		OutChar
	lda		[CurrAddress]
	jsr		OutByte
	jsr		OutCRLF
	bra		PeekEnd
PeekInvalidAddr:
	jsr		ErrInvalidAddress
PeekEnd:
	rts

;  ____            _           
; |  _ \    ___   | | __   ___ 
; | |_) |  / _ \  | |/ /  / _ \
; |  __/  | (_) | |   <  |  __/
; |_|      \___/  |_|\_\  \___|
;
;
; Writes a byte at a specific address
; ===================================

Poke:
	jsr		SkipSpaces			; Remove excessive leading spaces
	lda		,X					; Load character
	beq		PokeNoParameters	; If no parameters, print no parameter error
	jsr		GetStrWord			; Get an address
	bcc		PokeInvalidAddress	; If error in address, print invalid address error
	std		CurrAddress			; Save address
	jsr		SkipSpaces			; Remove unecessary spaces
	jsr		GetStrByte			; Get byte
	bcc		PokeInvalidByte		; If error in byte, print invalid byte error
	sta		[CurrAddress]		; Poke value at address
	ldd		CurrAddress			; Print address
	jsr		OutWord				;
	lda		#'='				; Print a colon
	jsr		OutChar				;
	lda		[CurrAddress]		; Load A from Current Address
	jsr		OutByte				; Print byte value
	jsr		OutCRLF				; New line
	bra		PokeEnd
PokeInvalidByte:
	jsr		ErrInvalidByte		; Print invalid byte
	bra		PokeEnd
PokeInvalidAddress:
	jsr		ErrInvalidAddress	; Print invalid address error
	bra		PokeEnd
PokeNoParameters:
	jsr		ErrNoParameter		; Print no parameter error
PokeEnd:
	rts

;  ____           _           _     ____                   _         _                       
; |  _ \   _ __  (_)  _ __   | |_  |  _ \    ___    __ _  (_)  ___  | |_    ___   _ __   ___ 
; | |_) | | '__| | | | '_ \  | __| | |_) |  / _ \  / _` | | | / __| | __|  / _ \ | '__| / __|
; |  __/  | |    | | | | | | | |_  |  _ <  |  __/ | (_| | | | \__ \ | |_  |  __/ | |    \__ \
; |_|     |_|    |_| |_| |_|  \__| |_| \_\  \___|  \__, | |_| |___/  \__|  \___| |_|    |___/
;                                                  |___/                                     
;
; Print Registers
; ===============
PrintRegisters:
	; Print Register A
	lda		#'A'
	jsr		OutChar
	lda		#':'
	jsr 	OutChar
	lda		RegA
	jsr		OutByte
	lda		#' '
	jsr		OutChar
	; Print Register B
	lda		#'B'
	jsr		OutChar
	lda		#':'
	jsr 	OutChar
	lda		RegB
	jsr		OutByte
	lda		#' '
	jsr		OutChar
	; Print Register E
	lda		#'E'
	jsr		OutChar
	lda		#':'
	jsr 	OutChar
	lda		RegE
	jsr		OutByte
	lda		#' '
	jsr		OutChar
	; Print Register F
	lda		#'F'
	jsr		OutChar
	lda		#':'
	jsr 	OutChar
	lda		RegF
	jsr		OutByte
	lda		#' '
	jsr		OutChar
	; Print Register X
	lda		#'X'
	jsr		OutChar
	lda		#':'
	jsr 	OutChar
	ldd		RegX
	jsr		OutWord
	lda		#' '
	jsr		OutChar
	; Print Register Y
	lda		#'Y'
	jsr		OutChar
	lda		#':'
	jsr 	OutChar
	ldd		RegY
	jsr		OutWord
	lda		#' '
	jsr		OutChar
	; Print Register U
	lda		#'U'
	jsr		OutChar
	lda		#':'
	jsr 	OutChar
	ldd		RegU
	jsr		OutWord
	lda		#' '
	jsr		OutChar
	; Print Register S
	lda		#'S'
	jsr		OutChar
	lda		#':'
	jsr 	OutChar
	ldd		RegS
	jsr		OutWord
	lda		#' '
	jsr		OutChar
	; Print Register CC
	lda		#'C'
	jsr		OutChar
	jsr		OutChar
	lda		#':'
	jsr 	OutChar
	lda		RegCC
	jsr		OutByte
	lda		#' '
	jsr		OutChar
	; Print Register DP
	lda		#'D'
	jsr		OutChar
	lda		#'P'
	jsr		OutChar
	lda		#':'
	jsr 	OutChar
	lda		RegDP
	jsr		OutByte
	lda		#' '
	jsr		OutChar
	; Print Program Counter
	lda		#'P'
	jsr		OutChar
	lda		#'C'
	jsr		OutChar
	lda		#':'
	jsr 	OutChar
	ldd		RegPC
	jsr		OutWord
	jsr		OutCRLF
	rts

;  ____                  _       ____                   _         _                       
; |  _ \   _   _   ___  | |__   |  _ \    ___    __ _  (_)  ___  | |_    ___   _ __   ___ 
; | |_) | | | | | / __| | '_ \  | |_) |  / _ \  / _` | | | / __| | __|  / _ \ | '__| / __|
; |  __/  | |_| | \__ \ | | | | |  _ <  |  __/ | (_| | | | \__ \ | |_  |  __/ | |    \__ \
; |_|      \__,_| |___/ |_| |_| |_| \_\  \___|  \__, | |_| |___/  \__|  \___| |_|    |___/
;                                               |___/                                     
;
; Push Registers
; ==============
; Input:	User Stack contains register content after a return from run

PushRegisters:	
	; Recover register values from last run command
	puluw
	pulu	CC,A,B,DP,X,Y,S		; Restore all, except PC
	; Save registers in variables
	pshs	CC					; Store CC so it's not altered
	sta		RegA				; Save the A register
	puls	A					; Restore CC so it can be saved
	sta		RegCC				; Save the condition code register
	stb		RegB				; Save the B register
	ste		RegE				; Save the E register
	stf		RegF				; Save the F register
	stx		RegX				; Save the X register
	sty		RegY				; Save the Y register
	sts		RegS				; Save the systemp stack
	pulu	D					; Restore PC in D
	subd	#$0002				; Substract 2 from program counter to account for the pshu instruction
	std		RegPC				; Save the program counter that was in D
	stu		RegU				; Save the user stack
	rts

;  ____            _   _   ____                   _         _                       
; |  _ \   _   _  | | | | |  _ \    ___    __ _  (_)  ___  | |_    ___   _ __   ___ 
; | |_) | | | | | | | | | | |_) |  / _ \  / _` | | | / __| | __|  / _ \ | '__| / __|
; |  __/  | |_| | | | | | |  _ <  |  __/ | (_| | | | \__ \ | |_  |  __/ | |    \__ \
; |_|      \__,_| |_| |_| |_| \_\  \___|  \__, | |_| |___/  \__|  \___| |_|    |___/
;                                         |___/                                     
;
; Pull Registers
; --------------
PullRegisters:	
	lda		RegCC				; Load CC register
	pshs	A					; Store it so it can be restored
	lda		RegA				; Load the A register
	ldb		RegB				; Load the B register
	lde		RegE				; Load the E register
	ldf		RegF				; Load the F register
	ldx		RegX				; Load the X register
	ldy		RegY				; Load the Y register
	ldu		RegU				; Load the user stack
	puls	CC,PC

;  ____                  
; |  _ \   _   _   _ __  
; | |_) | | | | | | '_ \ 
; |  _ <  | |_| | | | | |
; |_| \_\  \__,_| |_| |_|
;
; Execute code at address specified, or CurrAddress
; -------------------------------------------------
; Input:	X = Command line string

Run:
	jsr		SkipSpaces			; Removes possible leading spaces
	lda		,X					; Read character from command line
	beq		RunValidate			; Use current address
RunGetAddress:
	jsr		GetStrWord			; Get address from the input buffer
	bcc		RunError			; Invalid address, then print error
	std		CurrAddress			; Save address to memory
RunValidate:
	lda		[CurrAddress]		; Load byte at specified address
	beq		RunEnd				; If it's zero, then don't try to execute code
RunExecute:
	inc		RunFlag				; Make run flag non zero
	jsr		PullRegisters		; Restore registers from previous command
	jmp		[CurrAddress]		; Execute code at specified address
RunError:
	jsr		ErrInvalidAddress	; If there's an error in the address, print it
RunEnd:
	rts

;  ____           _        _          _       _                           
; / ___|    ___  | |_     / \      __| |   __| |  _ __    ___   ___   ___ 
; \___ \   / _ \ | __|   / _ \    / _` |  / _` | | '__|  / _ \ / __| / __|
;  ___) | |  __/ | |_   / ___ \  | (_| | | (_| | | |    |  __/ \__ \ \__ \
; |____/   \___|  \__| /_/   \_\  \__,_|  \__,_| |_|     \___| |___/ |___/
;
; Sets the current address
; ========================
; Input:	X = Command line string

SetAddress:
	pshs	A,B,CC
	jsr		SkipSpaces			; Remove leading spaces
	lda		,X					; Load first character
	beq		SetAddressDefault	; Is it the end of the string?
	jsr		GetStrWord			; Get address from the input buffer
	bcc		SetAddressError		; Error in address
	std		CurrAddress			; Save the address
	bra		SetAddressEnd
SetAddressError:
	jsr		ErrInvalidAddress	; Display address error
	bra		SetAddressEnd
SetAddressDefault:
	ldd		#$0000
	std		CurrAddress			; Set default address to $0000
SetAddressEnd:
	puls	A,B,CC,PC

;  ____           _     ____                    _    
; / ___|    ___  | |_  | __ )    __ _   _ __   | | __
; \___ \   / _ \ | __| |  _ \   / _` | | '_ \  | |/ /
;  ___) | |  __/ | |_  | |_) | | (_| | | | | | |   < 
; |____/   \___|  \__| |____/   \__,_| |_| |_| |_|\_\
;
; Sets the current bank
; =====================
; Input:	X = Command line string

SetBank:
	pshs	A,CC
	jsr		SkipSpaces			; Remove leading spaces
	lda		,X					; Load first character
	beq		SetBankDefault		; Is it the end of the string?
	jsr		GetStrByte			; Get bank from the input buffer
	bcc		SetBankError		; Error in byte
	sta		CurrBank			; Save the bank
	bra		SetBankEnd
SetBankError:
	jsr		ErrInvalidByte		; Display byte error
	bra		SetBankEnd
SetBankDefault:
	clr		CurrBank			; Set default bank to $00
SetBankEnd:
	puls	A,CC,PC

;  ____    _      _           ____                                      
; / ___|  | | __ (_)  _ __   / ___|   _ __     __ _    ___    ___   ___ 
; \___ \  | |/ / | | | '_ \  \___ \  | '_ \   / _` |  / __|  / _ \ / __|
;  ___) | |   <  | | | |_) |  ___) | | |_) | | (_| | | (__  |  __/ \__ \
; |____/  |_|\_\ |_| | .__/  |____/  | .__/   \__,_|  \___|  \___| |___/
;                    |_|             |_|
;
; Skip leading spaces in string and positions pointer to first non-space character
; ================================================================================
; Input:	X = Starting position of string pointer
; Output:	X = New position of pointer

	PRAGMA cc

SkipSpaces:
	pshs	A,CC
SkipSpacesLoop:
	lda		,X					; Load character from string
	beq		SkipSpacesEnd		; Is it the end of the string? Yes, then exit
	cmpa	#' '				; Is it a space?
	bne		SkipSpacesEnd		; Not a space? Then end subroutine
	leax	1,X					; Increment index for next character
	inc		CmdErrorPtr			; Increment error pointer to next potential error location
	bra		SkipSpacesLoop		; Go and read another character
SkipSpacesEnd:
	puls	A,CC,PC
