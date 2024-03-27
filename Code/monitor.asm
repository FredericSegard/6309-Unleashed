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
; * MemSize				.			.			Print the available memory of system
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
; Clobbers:	D,Y

	PRAGMA cc

CmdParse:
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
	jmp		[,U++]				; Execute command
CmdParseNone:
	jsr		ErrInvalidCommand	;
CmdParseEnd:
	rts

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
; Regs:	A,B,E,F,X,Y

	PRAGMA cc
	
Diagnostics:
	ldx		#DiagMessage		; Diagnostics message pointer
	jsr		OutStr				; Print message
	lda		$FFA0				; Load current block value from bank 0
	pshs	A					; Save value
	lda		$FF90				; Load INIT0 (MMU enable state)
	pshs	A					; Save value
	lda		$FF91				; Load INIT1 (Task number)
	pshs	A					; Save value
	jsr		MmuOn				; Enable MMU
	jsr		MmuTaskSet0			; Switch to Task 0
	ldy		#$1FFF				; Block size (8K)
	; Test first 512KB chip
	lda		#$00				; Block start
	pshu	A
	lde		#$40				; Block End
	lda		#'1'				; Chip number
	jsr		Diag512
	; Test second 512KB chip
	lda		#$40				; Block start
	pshu	A
	lde		#$80				; Block End
	lda		#'2'				; Chip number
	jsr		Diag512
	; Test third 512KB chip
	lda		#$80				; Block start
	pshu	A
	lde		#$C0				; Block End
	lda		#'3'				; Chip number
	jsr		Diag512
	; Test fourth 512KB chip
	lda		#$C0				; Block start
	pshu	A
	lde		#$00				; Block End
	lda		#'4'				; Chip number
	jsr		Diag512
DiagEnd:
	puls	A
	sta		$FF91				; Restore task number to inital value
	puls	A
	sta		$FF90				; Restore MMU state to initial value
	puls	A
	sta		$FFA0				; Restore bank0 block number to inital value
	rts

; Diagnostic subroutines
; ----------------------

; Test a complete 512KB chip
Diag512:
	clrf						; Clear error flag
	ldx		#DiagTestingMsg		; Testing chip message pointer
	jsr		OutStr				; Print message
	jsr		OutChar
	lda		#':'
	jsr		OutChar
	lda		#' '
	jsr		OutChar
	pulu	A					; Load start block number
Diag512Loop:
	sta		$FFA0				; Store it to bank 0 of task 0
	jsr		MemSizeValidate		; Check if there is valid memory at that location
	bcc		DiagSkip			; Skip test if no memory is present
	jsr		OutByte				; Display block number
	jsr		DiagBlock			; Test the block
	inca						; Next block
	cmpa	#$07				; Skip ROM area
	bne		Diag512Continue		; It not ROM, then continue
	inca						; Proceed to next block
Diag512Continue:
	ldb		#2					; Number of bytes to erase on screen
	jsr		DelChar				; Delete block number
	cmpr	A,E					; Has all the blocks been tested?
	bne		Diag512Loop			; Loop until finished
DiagPassFail:
	tstf						; Check error flag
	beq		DiagPass			; If no errors found then print "Pass"
DiagFail:
	ldx		#DiagFailMsg		; Fail message pointer
	jsr		OutStr				; Print fail message
	rts
DiagPass:
	ldx		#DiagPassMsg		; Pass message pointer
	jsr		OutStr				; Print Pass message
	rts
DiagSkip:
	ldx		#DiagSkipMsg		; Pass message pointer
	jsr		OutStr				; Print Pass message
	rts


; Test bank 0
DiagBlock:
	ldx		#$0000				; Start address pointer
DiagBlockLoop:
	jsr		DiagTest			; Test RAM cell with different patterns
	leax	1,X					; Increment address pointer
	cmpr	X,Y					; Has the end of the block been reached?
	bne		DiagBlockLoop		; No, then loop
	rts

; Test a cell with 2 distinct patterns
DiagTest:
	; Read a byte and save it for later
	pshs	A
	lda		,X
	pshs	A
	; Test pattern $55
	ldb		#$55
	jsr		DiagCellPattern
	; Test pattern $AA
	ldb		#$AA
	jsr		DiagCellPattern
	; Restore original data in cell
	puls	A
	sta		,X
	puls	A,PC

; Test and compare a cell, and flag error if any
DiagCellPattern:
	; B = Test pattern
	; X = Current cell pointer
	stb		,X					; Store test pattern in memory
	lda		,X					; Read back memory
	cmpr	A,B					; Does the memory cell match the pattern after read back
	beq		DiagCellEnd			; If it's the same, test with next pattern
	ldf		#$01				; Makes sure F is non-zero
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

	PRAGMA cc
	
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
	lde		#16					; Number of lines to print
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

;  ___           _     _____                _   
; |_ _|  _ __   | |_  |_   _|   ___   ___  | |_ 
;  | |  | '_ \  | __|   | |    / _ \ / __| | __|
;  | |  | | | | | |_    | |   |  __/ \__ \ | |_ 
; |___| |_| |_|  \__|   |_|    \___| |___/  \__|
;
; Testing Priority Interrupt Encoder
; ==================================

	PRAGMA cc

IntTest:
	ldb		#$2					; Number of bytes to erase
IntTestLoop:
	jsr		InCharNW			; Read characther (non-waiting)
	cmpa	#ESC				; Is it the ESCape key?
	beq		IntTestEnd			; Yes, then end the routine
	lda		IntVector			; Read the interrupt vector
	lsra						; Shift it right
	jsr		OutByte				; Print value of interrupt
	jsr		Delay				; Let it stay still for a while
	jsr		DelChar				; Delete the byte on screen
	bra		IntTestLoop			; Loop until ESC
IntTestEnd:
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

	PRAGMA cc
	
LoadIntelHex:
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
	rts

;  __  __                                             __  __                 
; |  \/  |   ___   _ __ ___     ___    _ __   _   _  |  \/  |   __ _   _ __  
; | |\/| |  / _ \ | '_ ` _ \   / _ \  | '__| | | | | | |\/| |  / _` | | '_ \ 
; | |  | | |  __/ | | | | | | | (_) | | |    | |_| | | |  | | | (_| | | |_) |
; |_|  |_|  \___| |_| |_| |_|  \___/  |_|     \__, | |_|  |_|  \__,_| | .__/ 
;                                             |___/                   |_|
;
; Prints the memory and I/O map of the system
; ===========================================

	PRAGMA cc
	
MemoryMap:
	ldx		#MemoryMapMsg
	jsr		OutStr				; Print up to end of RAM
	ldd		#RomStart-1
	jsr		OutWord				; Print up to ROM start -1
	jsr		OutStr				; Print up to begining of ROM
	incd
	jsr		OutWord				; Print ROM start
	lda		#'-'
	jsr		OutChar
	lda		#'$'
	jsr		OutChar
	ldd		#VarStart
	jsr		OutWord
	jsr		OutStr				; Print till end:
	rts

;  __  __                      _____                 
; |  \/  |   ___   _ __ ___   |_   _|   __ _    __ _ 
; | |\/| |  / _ \ | '_ ` _ \    | |    / _` |  / _` |
; | |  | | |  __/ | | | | | |   | |   | (_| | | (_| |
; |_|  |_|  \___| |_| |_| |_|   |_|    \__,_|  \__, |
;                                              |___/ 
;
; Tags memory by writing block number into 8K banks
; =================================================
; Regs:	A,B,W,X,Y
; Note: Future version will detect RAM amount

MemTag:
	jsr		MmuOn
	lda		#$3F				; Start at upper memory
	ldb		#$02				; Number of characters to erase
MemTagLoop:
	sta		$FFA0				; Store block number in bank 0
	jsr		OutByte				; Output current block
	ldx		#$FFA0				; Source address containing value
	ldy		#$0000				; Destination address
	ldw		#$2000				; Number of bytes to copy
	tfm		X,Y+				; Transfer data and increment destination pointer
	jsr		DelChar				; Delete the previously writen byte
	cmpa	#$00				; Has it reached 0?
	beq		MemTagEnd			; Yes, then end
	deca						; Decrement A
	cmpa	#$07				; Is it block 07, where ROM data is?
	bne		MemTagLoop			; No, then copy next block
	deca						; Decrement A to skip block 07
	bra		MemTagLoop			; Loop to copy next block
MemTagEnd:
	rts

;  __  __                      ____    _              
; |  \/  |   ___   _ __ ___   / ___|  (_)  ____   ___ 
; | |\/| |  / _ \ | '_ ` _ \  \___ \  | | |_  /  / _ \
; | |  | | |  __/ | | | | | |  ___) | | |  / /  |  __/
; |_|  |_|  \___| |_| |_| |_| |____/  |_| /___|  \___|
;
; Memory Size
; ===========
; Regs:		D = Various data manipulation (Mostly A)
;			W = Extended RAM accumulator

	PRAGMA cc
	
MemSize:
	; Enable MMU if not active, if not already active
	lda		$FF90				; Read the current content of the INIT0 register
	pshs	A					; Save the INIT0 register
	ora		#%01000000			; Turn on bit-6: MMU enable
	sta		$FF90				; Activate MMU if not already done
	; Switch to task 0 if not already there
	lda		$FF91				; Read the current content of the INIT1 register
	pshs	A					; Save the INIT1 register
	anda	#%11111110			; Turn off bit-0: Task 0/1
	sta		$FF91				; Switch to task 0
	; Save state of first MMU bank
	lda		$FFA0				; Read block number of first bank
	pshs	A					; Save the block number
	; Assume first 512K chip is already installed, substracting the base 64K
	ldw		#512-64				; 448KB extended by default
	; Verify if the 2nd 512K chip installed
	lda		#$40				; Block number $40 is the start of 2nd 512K chip
	sta		$FFA0				; Save it in bank 0 of task 0
	jsr		MemSizeValidate		; Test cell at $0000
	bcc		MemSizeDisplay		; If no valid cell is detected, display tally
	addw	#512				; Add 512KB to total
	; Verify if the 3rd 512K chip installed
	lda		#$80				; Block number $80 is the start of 3rd 512K chip
	sta		$FFA0				; Save it in bank 0 of task 0
	jsr		MemSizeValidate		; Test cell at $0000
	bcc		MemSizeDisplay		; If no valid cell is detected, display tally
	addw	#512				; Add 512KB to total
	; Verify if the 4th 512K chip installed
	lda		#$C0				; Block number $C0 is the start of 4th 512K chip
	sta		$FFA0				; Save it in bank 0 of task 0
	jsr		MemSizeValidate		; Test cell at $0000
	bcc		MemSizeDisplay		; If no valid cell is detected, display tally
	addw	#512				; Add 512KB to total
MemSizeDisplay:
	pshsw						; Save W to calculate total RAM
	pshsw						; Save W, because it gets clobberd by BinToBcd
	; Start printing mem stats
	ldx		#MemorySizeMsg		; Point to Memory Size message
	jsr		OutStr				; Output up till "bytes free"

	ldd		#RomStart			; Total free RAM available **** (Update to read non empty RAM)

	jsr		BinToBcd			; Convert to BCD
	jsr		OutBcd				; Print free base RAM
	jsr		OutStr				; Print till "Extended RAM:"
	puls	D					; Restore what was W in stack to D
	jsr		BinToBcd			; Convert total extended RAM to BCD => Q
	jsr		OutBcd				; Output BCD number (in Q)
	jsr		OutStr				; Output string till "blocks free"
	
	clra
	ldb		#$40-8				; **** (Update to count number of blocks used)
	jsr		BinToBcd			; Convert total extended RAM to BCD => Q
	jsr		OutBcd				; Output BCD number (in Q)

	jsr		OutStr				; Output string will "Total RAM"
	puls	D					; Restore Extended RAM tally to D
	addd	#64					; Add 64 to tally
	jsr		BinToBcd			; Convert total RAM to BCD
	jsr		OutBcd				; Output BCD number
	jsr		OutStr				; Output string to the end
MemSizeEnd:
	; Restore the state of the first MMU bank
	puls	A					; Get the saved bank block to accumulator
	sta		$FFA0				; Restore the block number to it's previous state
	; Restore the state of the task number
	puls	A					; Get the saved active task to accumulator
	sta		$FF91				; Restore active task to it's previous state
	; Restore MMU state
	puls	A					; Get the INIT1 status register to accumulator
	sta		$FF90				; Restore the INIT1 register to it's previous state
	rts

; MemSize subroutine
; ------------------

MemSizeValidate:
	pshs	D
	lda		$0000				; Read first byte of bank 0
	tfr		A,B					; Save existing data to B
	lda		#$55				; Load a test pattern in A
	sta		$0000				; Save test pattern in memory
	lda		$0000				; Reload from memory
	cmpa	#$55				; Compare values to see if they match
	bne		MemSizeEmpty		; If not equal, exit with Carry clear
	lda		#$AA				; Load a second test pattern in A, to test for a fluke
	sta		$0000				; Save test pattern in memory
	lda		$0000				; Reload from memory
	cmpa	#$AA				; Compare values to see if they match
	bne		MemSizeEmpty		; If not equal, exit with Carry clear
	orcc	#$01				; Set carry flag to indicate there is an active memory cell
	bra		MemSizeValEnd		; End subroutine
MemSizeEmpty:
	andcc	#$FE				; Clear Carry to indicate the memory cell is empty
MemSizeValEnd:
	stb		$0000				; Save back orginal data that was saved in B
	puls	D,PC

;  __  __   __  __   _   _ 
; |  \/  | |  \/  | | | | |
; | |\/| | | |\/| | | | | |
; | |  | | | |  | | | |_| |
; |_|  |_| |_|  |_|  \___/ 
;
; MMU commands
; ============

	PRAGMA cc

Mmu:
	jsr		SkipSpaces			; Skip leading spaces
	stx		TempWord			; Store string pointer for parameter list cycling
	lda		,X					; Load first character from parameter string to see if it's empty
	beq		MmuStatus			; If no parameter has been entered, then print MMU status
	inc		CmdErrorPtr			; Increment Error pointer 1 space to account for parameter delimiter
	lde		CmdErrorPtr			; Load command error pointer to E for later use
	ldy		#MmuList			; Load parameter list table location in Y
MmuParseChar:
	lda		,X+					; Load first character from parameter prompt string
	jsr		UpperCase			; Convert character to upper case (parameter list is in upper case)
	ldb		,Y+					; Load a character from the parameter list
	bmi		MmuParseValid		; Parameter code end delimiter? Execute parameter
	cmpr	A,B					; Compare parameter string to parameter list character
	bne		MmuParseSkip		; Skip parameter list entry and point to next parameter
	inc		CmdErrorPtr			; Increment command line error pointer
	bra		MmuParseChar		; Go and compare the next character
MmuParseSkip:
	ldx		TempWord			; Restore parameter prompt pointer to starting position
	ste		CmdErrorPtr			; Restore command prompt error pointer
MmuParseSkipLoop:
	ldb		,Y+					; Read next character
	bpl		MmuParseSkipLoop	; Loop until parameter list end delimiter is found
	leay	2,Y					; Jump over parameter address
	ldb		,Y					; Is it the end of the parameter list
	beq		MmuParseNone		; Yes it is, print error and exit
	bra		MmuParseChar		; Repeat process until parameter found
MmuParseValid:
	; Check for characters after valid parameter
	cmpa	#' '				; Check for a parameter separator (space)
	beq		MmuParseExecute		; Yes, then execute parameter
	cmpa	#$00				; Check for an end of line in string (null)
	bne		MmuParseNone		; If it's something else, the parameter invalid, else execute
MmuParseExecute:
;	inc		CmdErrorPtr			; Shift pointer by 1 for arguments in command line
	ldd		,Y					; Load address of parameter from table
	std		,--U				; Save address to user stack
	leax	-1,X				; Backup pointer 1 position, because of the auto advance above
	jmp		[,U++]				; Execute parameter
MmuParseNone:
	jsr		ErrInvalidParameter	;
	rts

; MMU subroutines
; ---------------

; Prints the status of the MMU (Enabled or not, Task 0 or 1, and all bank registers)
MmuStatus:
	ldx		#MmuMsg
	jsr		OutStr				; Print up to Enabled status
	; Is the MMU enabled or disabled
	lda		$FF90				; Load status of INIT0 register
	anda	#%01000000			; Check the status of bit 6
	bne		MmuEnabled			; If it's enabled, go print ON
	lda		#'O'				; Else print OFF
	jsr		OutChar
	lda		#'F'
	jsr		OutChar
	lda		#'F'
	jsr		OutChar
	bra		MmuTaskNum			; Check task number
MmuEnabled:
	lda		#'O'
	jsr		OutChar
	lda		#'N'
	jsr		OutChar
MmuTaskNum:
	; What is the task number?
	jsr		OutStr				; Print up to Task 0/1
	lda		$FF91				; Load the status of INIT1 register
	anda	#%00000001			; Check the status of bit 1
	bne		MmuTaskNum1			; If it's 1, go print 1
	lda		#'0'				; Else print 0
	jsr		OutChar
	bra 	MmuTaskRegs
MmuTaskNum1:
	lda		#'1'
	jsr		OutChar
MmuTaskRegs:
	; Print the status of the bank registers $FFA0 to $FFAF
	jsr		OutStr				; Print up to Task 1
	ldy		#TASK0				; Load base task 0 address ($FFA0)
	ldb		#8					; 8 block counter
MmuTask0Loop:
	lda		,Y					; Load content pointed by Y and increment to next address
	jsr		OutByte				; Print content
	lda		#'-'				; Print separator
	jsr		OutChar
	leay	1,Y
	decb						; Decrease pointer
	bne		MmuTask0Loop		; Loop until all 8 blocks are printed
	incb						; 0+1 is the number of characters to delete
	jsr		DelChar				; Delete last dash
	jsr		OutStr				; Print till Task 1:
	ldy		#TASK1				; Load base task 1 address ($FFA8)
	ldb		#8					; 8 block counter
MmuTask1Loop:
	lda		,Y					; Load the content pointed by Y and increment to next address
	jsr		OutByte				; Print content
	lda		#'-'				; Print separator
	jsr		OutChar
	leay	1,Y
	decb						; Decrement pointer
	bne		MmuTask1Loop		; Loop until all 8 blocks are printed
	incb						; 0+1 is the number of characters to delete
	jsr		DelChar				; Delete last dash
	jsr		OutCRLF				; Change line
MmuStatusEnd:
	rts

; Turns on the MMU
MmuOn:
	lda		$FF90				; Load INIT0
	ora		#%01000000			; Activate bit 6
	sta		$FF90				; Store INIT0 to activate MMU
	rts

; Turns off the MMU
MmuOff:
	lda		$FF90				; Load INIT0
	anda	#%10111111			; Deactivate bit 6
	sta		$FF90				; Store INIT0 to activate MMU
	rts
	
; Select the Task number
MmuTask:
	jsr		SkipSpaces			; Remove leading spaces
	lda		,X					; Load first character
	beq		MmuTaskErr			; Is it the end of the string?
	cmpa	#'0'				; Is it task 0?
	beq		MmuTaskSet0			; Yes, then set to task 0
	cmpa	#'1'				; Is it task 1?
	beq		MmuTaskSet1			; Yes, then set to task 1
	bra		MmuTaskErr
MmuTaskSet0:
	lda		$FF91				; Load INIT1
	anda	#%11111110			; Deactivate bit 0
	sta		$FF91				; Store INIT1 to switch to task 0
	rts
MmuTaskSet1:
	lda		$FF91				; Load INIT1
	ora		#%00000001			; Activate bit 0
	sta		$FF91				; Store INIT1 to switch to task 1
	rts
MmuTaskErr:
	jsr		ErrInvalidParameter	; Print invalid parameter message
	rts
	
; Reset the MMU to it's defaults
MmuReset:
	jsr		MmuOff				; Disable MMU
	jsr		MmuTaskSet0			; Switch to Task 0
	; Reset Banks to default
	ldx		#BlockTable			; Block table base address
	ldy		#TASK0				; Bank registers base address
	clra						; Set A to 0
MmuResetLoop:
	sta		,X+					; Store value in block table
	sta		,Y+					; Store value in bank register
	inca						; Increment A
	cmpa	#$0F				; Are we at the last address?
	bne		MmuResetLoop		; No, continue reseting the bank registers
	lda		#$07				; Set the 8th bank of task 1 to match that of task 0
	sta		,X					; Store it
	sta		,Y					; Store it
	rts

;  ____                  _    
; |  _ \    ___    ___  | | __
; | |_) |  / _ \  / _ \ | |/ /
; |  __/  |  __/ |  __/ |   < 
; |_|      \___|  \___| |_|\_\
;
; Read a byte from a specific or current address
; ==============================================

	PRAGMA cc
	
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

	PRAGMA cc
	
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

	PRAGMA cc
	
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

	PRAGMA cc
	
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
; ==============

	PRAGMA cc
	
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

	PRAGMA cc
	
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

	PRAGMA cc
	
SetAddress:
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
	rts

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
	pshs	A
SkipSpacesLoop:
	lda		,X					; Load character from string
	beq		SkipSpacesEnd		; Is it the end of the string? Yes, then exit
	cmpa	#' '				; Is it a space?
	bne		SkipSpacesEnd		; Not a space? Then end subroutine
	leax	1,X					; Increment index for next character
	inc		CmdErrorPtr			; Increment error pointer to next potential error location
	bra		SkipSpacesLoop		; Go and read another character
SkipSpacesEnd:
	puls	A,PC

; __        __                             ____                    _   
; \ \      / /   __ _   _ __   _ __ ___   | __ )    ___     ___   | |_ 
;  \ \ /\ / /   / _` | | '__| | '_ ` _ \  |  _ \   / _ \   / _ \  | __|
;   \ V  V /   | (_| | | |    | | | | | | | |_) | | (_) | | (_) | | |_ 
;    \_/\_/     \__,_| |_|    |_| |_| |_| |____/   \___/   \___/   \__|
;
; Warm boot the computer
; ======================

Warmboot:
	jmp		Warm				; Warm boots the computer
	
; __        __         _   _          
; \ \      / /  _ __  (_) | |_    ___ 
;  \ \ /\ / /  | '__| | | | __|  / _ \
;   \ V  V /   | |    | | | |_  |  __/
;    \_/\_/    |_|    |_|  \__|  \___|
;
; Write a sequence of bytes starting at a base address
; ====================================================

	PRAGMA cc

Write:
	; Get base address
	jsr		SkipSpaces			; Skipe leading white spaces
	lda		,X					; Load first character
	beq		WriteNoParameter	; If it's the end of the string, then missing parameter
	jsr		GetStrWord			; Get address from the input buffer
	bcc		WriteAddressError	; Error in address
	std		CurrAddress			; Save the address
	tfr		D,Y					; Copy address to Y
	; Get first byte
	clre						; Set number of bytes to zero
	jsr		SkipSpaces			; Skipe leading white spaces
	lda		,X					; Load character
	beq		WriteNoParameter	; If it's the end of the string, then missing parameter
	jsr		GetStrByte			; Get address from the input buffer
	bcc		WriteByteError		; Error in byte
	sta		,Y+					; Store byte at address
	ince						; Set byte count to 1
	; Get remaining bytes if any
WriteByteLoop:
	jsr		SkipSpaces			; Skipe leading white spaces
	lda		,X					; Load character
	beq		WriteConfirm		; Read back and print bytes to confirm proper write
	jsr		GetStrByte			; Get address from the input buffer
	bcc		WriteByteError		; Error in byte
	sta		,Y+					; Store byte at address
	ince						; Increment byte counter
	bra		WriteByteLoop
WriteNoParameter:
	jsr		ErrNoParameter		; Display no parameter error
	rts
WriteAddressError:
	jsr		ErrInvalidAddress	; Display address error
	rts
WriteByteError:
	jsr		ErrInvalidByte		; Display address error
	rts
WriteConfirm:	
	ldd		CurrAddress			; Load base address
	tfr		D,Y					; Copy address to Y
	jsr		OutWord				; Print base address
	lda		#':'				; Separate address and byte with colon
	jsr		OutChar				; Print separator
WriteConfirmLoop:
	lda		,Y+					; Read byte
	jsr		OutByte				; Print byte
	dece						; Decrement byte counter
	beq		WriteEnd			; Is it the end? Then exit
	lda		#','				; Separate bytes with comma
	jsr		OutChar				; Print comma
	bra		WriteConfirmLoop	; Check for next byte
WriteEnd:
	sty		CurrAddress			; Save state of current address
	jsr		OutCRLF				; Change line
	rts
	