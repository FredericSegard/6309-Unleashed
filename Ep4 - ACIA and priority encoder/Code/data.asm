; ****************************************************************************************
; * Text and Data
; ****************************************************************************************

	PRAGMA cc

BootMsg:	;                                        *                       *               *
	.str	"----------------------------------------"
	.db		CR,LF
	.str	"MicroHobbyist's Retro Homebrew Computers"
	.db		CR,LF
	.str	"LogicSpark-09, a 6309 project, rev "
	.db		NULL,CR,LF
	.str	"Designed by Frederic Segard  (2024)"
	.db		CR,LF,LF,NULL
	.str	" bytes free "
	.db		CR,LF,NULL
	.str	" bytes of unallocated shadow RAM"
	.db		CR,LF
	.str	"----------------------------------------"
	.db		CR,LF,LF,NULL

CmdList:
	.str	"ADDR"
	.db		EOD
	.dw		SetAddress			; Run code at current or specified address
	.str	"BANK"
	.db		EOD
	.dw		SetBank				; Run code at current or specified address
	.str	"DUMP"
	.db		EOD
	.dw		Dump				; Display content of memory
	.str	"HELP"
	.db		EOD
	.dw		CmdHelp				; Help for various commands
	.str	"LOAD"
	.db		EOD
	.dw		LoadIntelHex		; Upload Intel Hex code
	.str	"MAP"
	.db		EOD
	.dw		MemoryMap			; Memory map of LogicSpark-09
	.str	"PEEK"
	.db		EOD
	.dw		Peek				; Read a byte of memory
	.str	"POKE"
	.db		EOD
	.dw		Poke				; Write a byte of memory
	.str	"REG"
	.db		EOD
	.dw		PrintRegisters		; Print registers
	.str	"RUN"
	.db		EOD
	.dw		Run					; Run code at current or specified address
	.db		NULL

CmdHelpMsg:	;                                        *                       *               *
	.str	"List of valid commands:"
	.db		CR,LF
	.str	"  - ADDR: Set current address"
	.db		CR,LF
	.str	"  - BANK: Set current bank"
	.db		CR,LF
	.str	"  - DUMP: Display memory content"
	.db		CR,LF
	.str	"  - HELP: This help screen"
	.db		CR,LF
	.str	"  - LOAD: Load Intel Hex from console"
	.db		CR,LF
	.str	"  - MAP: Memory and I/O map of system"
	.db		CR,LF
	.str	"  - PEEK: Read a byte of memory"
	.db		CR,LF
	.str	"  - POKE: Write a byte into memory"
	.db		CR,LF
	.str	"  - REG: Print the registers content"
	.db		CR,LF
	.str	"  - RUN: Execute code"
	.db		CR,LF,NULL

ErrInvalidAddrMsg:
	.str	"Invalid address!"
	.db		CR,LF,NULL

ErrInvalidByteMsg:
	.str	"Invalid byte!"
	.db		CR,LF,NULL

ErrInvalidParamMsg:
	.str	"Invalid parameter!"
	.db		CR,LF,NULL

ErrNoParameterMsg:
	.str	"No parameter was specified."
	.db		CR,LF,NULL

ErrInvalidCmdMsg:
	.str	"Invalid command!"
	.db		CR,LF,NULL

ErrSyntaxErrorMsg:
	.str	"Syntax error!"
	.db		CR,LF,NULL
	
LoadStartMsg:
	.str	"Load 6309 code in Intel Hex format"
	.db		CR,LF
	.str	"Press ESC to cancel."
	.db		CR,LF,NULL

LoadUserAbortErr:
	.str	"Transfer aborted by user"
	.db		CR,LF,NULL

LoadRecordErr:
	.str	"Unknown record type: "
	.db		NULL

LoadFailedErr:
	.str	"Download failed due to checksum error"
	.db		CR,LF,NULL

LoadSuccessMsg:
	.str	"Download Successful"
	.db		CR,LF,NULL

MemoryMapMsg:
	; Memory Map:
	.str	"Memory Map:"
	.db		CR,LF
	.str	"  RAM:       $0000-$"
	.db		NULL,CR,LF
	.str	"  ROM:       $"
	.db		NULL
	.str	"-$FDFF"
	.db		CR,LF
	.str	"  Const RAM: $FE00-$FEFF"
	.db		CR,LF
	.str	"  I/O range: $FF00-$FFEF"
	.db		CR,LF
	.str	"  Vectors:   $FFF0-$FFFF"
	.db		CR,LF
	.str	"I/O Map:"
	.db		CR,LF
	.str	"  ROM Dissable: $FF08 (W)"
	.db		CR,LF
	.str	"  Int. Vector:  $FF09 (R)"
	.db		CR,LF
	.str	"  ACIA1 (USB):  $FF68-$FF6B"
	.db		CR,LF,NULL
