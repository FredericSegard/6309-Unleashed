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
	.str	"CLS"
	.db		EOD
	.dw		Cls					; Clear screen
	.str	"DIAG"
	.db		EOD
	.dw		Diagnostics			; Display content of memory
	.str	"DUMP"
	.db		EOD
	.dw		Dump				; Display content of memory
	.str	"HELP"
	.db		EOD
	.dw		CmdHelp				; Help for various commands
	.str	"INT"
	.db		EOD
	.dw		IntTest				; Test priority interrupt encoder
	.str	"LOAD"
	.db		EOD
	.dw		LoadIntelHex		; Upload Intel Hex code
	.str	"MAP"
	.db		EOD
	.dw		MemoryMap			; Memory map of LogicSpark-09
	.str	"MEM"
	.db		EOD
	.dw		MemSize				; Memory Size installed
	.str	"MMU"
	.db		EOD
	.dw		Mmu					; MMU Commands and status
	.str	"PEEK"
	.db		EOD
	.dw		Peek				; Read a byte of memory
	.str	"PLAY"
	.db		EOD
	.dw		Play				; Play a song
	.str	"POKE"
	.db		EOD
	.dw		Poke				; Write a byte of memory
	.str	"REG"
	.db		EOD
	.dw		PrintRegisters		; Print registers
	.str	"RUN"
	.db		EOD
	.dw		Run					; Run code at current or specified address
	.str	"TAG"
	.db		EOD
	.dw		MemTag				; Tags memory cells to block numbers (except #07)
	.str	"WARM"
	.db		EOD
	.dw		Warmboot			; Warmboot the monitor
	.str	"WRITE"
	.db		EOD
	.dw		Write				; Write sequetial bytes to memory
	.db		NULL

CmdHelpMsg:	;                                        *                       *               *
	.str	"List of valid commands:"
	.db		CR,LF
	.str	"   ADDR: Set current address"
	.db		CR,LF
	.str	"   CLS: Clear screen"
	.db		CR,LF
	.str	"   DIAG: Diagnostics"
	.db		CR,LF
	.str	"   DUMP: Display memory content"
	.db		CR,LF
	.str	"   HELP: This help screen"
	.db		CR,LF
	.str	"   INT: Test priority interrupt encoder"
	.db		CR,LF
	.str	"   LOAD: Load Intel Hex from console"
	.db		CR,LF
	.str	"   MAP: Memory and I/O map of system"
	.db		CR,LF
	.str	"   MEM: Available memory on system"
	.db		CR,LF
	.str	"   MMU: Memory Management Unit Commands and Status"
	.db		CR,LF
	.str	"   PEEK: Read a byte of memory"
	.db		CR,LF
	.str	"   PLAY: Play a song (1 or 2)"
	.db		CR,LF
	.str	"   POKE: Write a byte into memory"
	.db		CR,LF
	.str	"   REG: Print the registers content"
	.db		CR,LF
	.str	"   RUN: Execute code"
	.db		CR,LF
	.str	"   TAG: Tags memory to block numbers (except #07)"
	.db		CR,LF
	.str	"   WARM: Warm boots the computer"
	.db		CR,LF
	.str	"   WRITE: Write data sequentially to memory"
	.db		CR,LF,NULL

DiagMessage:
	.str	"Diagnostics"
	.db		CR,LF,NULL

DiagTestingMsg:
	.str	"  Testing 512K chip #"
	.db		NULL

DiagPassMsg:
	.str	"Pass"
	.db		CR,LF,NULL

DiagFailMsg:
	.str	"Fail"
	.db		CR,LF,NULL

DiagSkipMsg:
	.str	"Skip"
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
	.str	"   RAM:        $0000-$"
	.db		NULL,CR,LF
	.str	"   Flash:      $"
	.db		NULL,CR,LF
	.str	"   Const. RAM: $FE00-$FEFF"
	.db		CR,LF
	.str	"   I/O range:  $FF00-$FFEF"
	.db		CR,LF
	.str	"   Vectors:    $FFF0-$FFFF"
	.db		CR,LF
	.str	"I/O Map:"
	.db		CR,LF
	.str	"   Int. Vect.: $FF09 (R)"
	.db		CR,LF
	.str	"   ACIA #1:    $FF68-FF6B"
	.db		CR,LF
	.str	"   ACIA #2:    $FF6C-FF6F"
	.db		CR,LF,NULL

MemorySizeMsg:
	; Memory Size:
	.str	"Memory Size:"
	.db		CR,LF
	.str	"   Base RAM:     64KB ("
	.db		NULL
	.str	" bytes free)"
	.db		CR,LF
	.str	"   Extended RAM: "
	.db		NULL
	.str	"KB ("
	.db		NULL
	.str	" blocks free)"
	.db		CR,LF
	.str	"   Total RAM:    "
	.db		NULL
	.str	"KB"
	.db		CR,LF,NULL

MmuMsg:
	; MMU status:
	.str	"MMU Status:"
	.db		CR,LF
	.str	"   MMU (ON/OFF): "
	.db		NULL,CR,LF
	.str	"   Task (0/1): "
	.db		NULL,CR,LF
	.str	"Task registers:"
	.db		CR,LF
	.str	"   Task 0: "
	.db		NULL,CR,LF
	.str	"   Task 1: "
	.db		NULL

MmuList:
	.str	"ON"
	.db		EOD
	.dw		MmuOn
	.str	"OFF"
	.db		EOD
	.dw		MmuOff
	.str	"TASK"
	.db		EOD
	.dw		MmuTask
	.str	"RESET"
	.db		EOD
	.dw		MmuReset
	.db		NULL
