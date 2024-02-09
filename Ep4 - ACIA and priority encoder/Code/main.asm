;
;         ::::::::       ::::::::       :::::::       :::::::: 
;       :+:    :+:     :+:    :+:     :+:   :+:     :+:    :+: 
;      +:+                   +:+     +:+   +:+     +:+    +:+  
;     +#++:++#+          +#++:      +#+   +:+      +#++:++#+   
;    +#+    +#+            +#+     +#+   +#+            +#+    
;   #+#    #+#     #+#    #+#     #+#   #+#     #+#    #+#     
;   ########       ########       #######       ########       
;
; ****************************************************************************************
; * 6309 project, code named LogicSpark-09
; *
; * http://microhobbyist.com
; *
; * Copyright (C) 2024 Frédéric Segard (MicroHobbyist)
; *
; * This library is free software; you can redistribute it and/or modify it under the
; * terms of the GNU Lesser General Public License as published by the Free Software
; * Foundation. You can use all or part of the code, regardless of the version. But there
; * is no warrenty of any kind.
; *
; * Reference:	ASCII text: https://www.messletters.com/en/big-text/ (alligator, standard)
; *				Editor tab-stops set to 4
; *				Assembler: LWASM %1.asm --6309 --raw --output=%1.bin
; *
; * Hardware:	CPU: HD63C09E, ROM: SST39010A (128KB Flash), RAM: AS6C4008-55 (512KB SRAM)
; *				COM1: R65C51 (ACIA->USB-B), Priority Interrupt Encoder
; ****************************************************************************************

; Revision
; --------
RevMajor	EQU	$00				; Major revision number: 0 = Breadboard, 1+ = PCB revision
RevMinor	EQU	$0004			; Minor revision number

; Keystrokes and delimiters
; -------------------------
NULL		EQU $00				; End delimiter
BS			EQU $08				; Backspace
TAB			EQU $09				; Horizontal Tab
CR			EQU $0D				; Carriage return
LF			EQU $0A				; Line feed
ESC			EQU $1B				; Escape
SPACE		EQU	$20				; Space
EOD			EQU $FF				; End of data, used by some routines

; Misc
; ----
RomStart	EQU	$E000			; Start of ROM
ShadowBlk	EQU	$FF00-RomStart	; Shadow code block size to copy
SysStack	EQU	$FC00			; Position system stack before Constant RAM space
UsrStack	EQU	$FA00			; Position user stack before system stack
ScrHorzRes	EQU	80				; Default horizontal screen size
ScrVertRes	EQU	24				; Default vertical screen size
PromptSize	EQU	2+1+4+1+1		; Bank + ':' + Current address + '>' + space
MaxCmdSize	EQU	ScrHorzRes-PromptSize-1	; Command prompt max size
BytePerLine	EQU 16				; Dump bytes per line. If screen = 80 then 16, else 8

; I/O addresses
; -------------
RomDisable	EQU $FF08			; ROM disable (poke any value)
IntVector	EQU $FF09			; Priority Interrupt Controller (reads a vector value)

; ----------------------------------------------------------------------------------------

	PRAGMA cd					; Detailed cycle count
	PRAGMA ct					; Cycle count running subtotal

	ORG $0000					; Start of code

Reset:

	orcc	#$50				; Disable interrupts, just in case
	ldmd	#$01				; Begin processing in 6309 native mode

; -------------------
; *** SHADOW COPY ***
; -------------------
; Copies everything to RAM, except the I/O region. RAM is writable but not readable,
; until RomDisable has been written to, at which point ROM is disabled until reset.

ShadowCopy:
	; Copies everything, except the IO region and vectors ($0000-$FF00)
	ldx		#$0000				; Source address: Read only ROM
	ldy		#$0000				; Destination address: Write only RAM
	ldw		#$FF00				; Number of bytes to copy
	tfm		X+,Y+				; Transfer data and increment pointers
	; Skip $FF00 to $FFF0		; I/O range
	; Copy the vectors ($FFF0-$FFFF)
	ldx		#$FFF0				; Source address: Read only ROM
	ldy		#$FFF0				; Destination address: Write only RAM
	ldw		#$0010				; Number of bytes to copy (8x 16-bit vectors)
	tfm		X+,Y+				; Transfer data and increment pointers
	jmp		Init

ShadowEnd:
	FILL $00,Init-ShadowEnd		; Fill RAM with $00 so RUN does not execute garbage

; ----------------------------------------------------------------------------------------

	PRAGMA cc
	
	ORG RomStart

Init:
	sta		RomDisable			; Poke any value to disable the ROM

	; Clear the shadow copy code
	ldx		#$0100				; Source address containing saved value
	ldy		#$0000				; Destination address
	ldw		#$0100				; Number of bytes to copy (Clear page RTS)
	tfm		X,Y+				; Transfer data and increment pointers

	; Configure the stacks
	ldu		#UsrStack			; Set the user stack
	stu		RegU				; Save user stack
	lds		#SysStack			; Sets the system stack
	sts		RegS				; Save system stack
	
	; Initialize peripherals
	jsr		Com1Init			; Initialize ACIA1
	
	; Print boot message
	jsr		Cls					; Clears the screen
	ldx		#BootMsg			; Print title
	jsr		OutStr				;
	lda		#RevMajor			; Print major version
	jsr		OutByteNLZ			;
	lda		#'.'				; Print dot
	jsr		OutChar				;
	ldd		#RevMinor			; Print minor version
	jsr		OutWordNLZ			;
	jsr		OutStr				;
	ldd		#RomStart			; Free RAM available
	jsr		BinToBcd			; Convert to BCD
	jsr		OutBcd
	jsr		OutStr
	ldd		#JmpStart-VarEnd	; Free shadow RAM left
	jsr		BinToBcd			; Convert to BCD
	jsr		OutBcd
	jsr		OutStr

	; Clear the registers
	clrd						; Clear the D register (A & B)
	clrw						; Clear the W register (E & F)
	ldx		#$0000				; Clear X register
	ldy		#$0000				; Clear Y register

	; Clears some variables
	std		CurrAddress
	clr		CurrBank
	clr		RunFlag				; 0 = Run not executed, Non-Zero = Run executed
	
	PRAGMA cc

Main:
	jsr		CmdPrompt			; Print the command prompt BB:AAAA> 
	ldb		#MaxCmdSize			; Command prompt max string size
	ldx		#InStrBuffer		; Point to a memory address to write string to
	jsr		InStr				; Read the a string
	bcc		Main				; If no data in string then bypass parser
	jsr		CmdParse			; Parse prompt and execute command
	; Save registers after execution of a run command
	pshs	CC					; Save the CC as not to alter it to record the run return
	tst		RunFlag				; Is it returning from the run command?
	bne		MainRunExec			; Yes it's returning from a run
	puls	CC					; Restore CC
	bra		Main				; Loop back, without recording the resistors
MainRunExec:
	puls	CC					; Restore CC
	jsr		PushRegisters		; Save the state of the registers
	clr		RunFlag				; Reset run flag
	bra		Main				; Loop back after recording the registers

;  ___                  _               _              
; |_ _|  _ __     ___  | |  _   _    __| |   ___   ___ 
;  | |  | '_ \   / __| | | | | | |  / _` |  / _ \ / __|
;  | |  | | | | | (__  | | | |_| | | (_| | |  __/ \__ \
; |___| |_| |_|  \___| |_|  \__,_|  \__,_|  \___| |___/
;
; Include files to segment code and data into manageable portions
; ---------------------------------------------------------------

	INCLUDE	"convert.asm"		; Conversion subroutines
	INCLUDE	"io.asm"			; Input and Output subroutines
	INCLUDE	"monitor.asm"		; Monitor commands subroutines
	INCLUDE	"data.asm"			; Keep data include file at the end of the list

;  ___           _                                          _         
; |_ _|  _ __   | |_    ___   _ __   _ __   _   _   _ __   | |_   ___ 
;  | |  | '_ \  | __|  / _ \ | '__| | '__| | | | | | '_ \  | __| / __|
;  | |  | | | | | |_  |  __/ | |    | |    | |_| | | |_) | | |_  \__ \
; |___| |_| |_|  \__|  \___| |_|    |_|     \__,_| | .__/   \__| |___/
;                                                  |_|
; ----------------------------------------------------------------------------------------

	PRAGMA cc
	
IllegalDiv0:
	rti
	
	PRAGMA cc

SoftInt3:
	rti
	
	PRAGMA cc

SoftInt2:
	rti
	
	PRAGMA cc

SoftInt1:
	rti
	
	PRAGMA cc

FIRQInt:
	rti

	PRAGMA cc

IRQInt:
	rti

	PRAGMA cc

NMIInt:
	rti

;  ____                   __     __                 _           _       _
; / ___|   _   _   ___    \ \   / /   __ _   _ __  (_)   __ _  | |__   | |   ___   ___ 
; \___ \  | | | | / __|    \ \ / /   / _` | | '__| | |  / _` | | '_ \  | |  / _ \ / __|
;  ___) | | |_| | \__ \     \ V /   | (_| | | |    | | | (_| | | |_) | | | |  __/ \__ \
; |____/   \__, | |___/      \_/     \__,_| |_|    |_|  \__,_| |_.__/  |_|  \___| |___/
;          |___/
;
; System variables used by monitor subroutines
; ============================================

InStrBuffer:	.DS		$100	; String input for console input
CmdErrorPtr:	.DS		1		; Command prompt error pointer
CurrAddress:	.DS		2		; Current address, useful for monitor actions
CurrBank:		.DS		1		; Current bank number, relative to current address
RunFlag			.DS		1		; Run flag to indicate registers should be saved or not
RegCC:			.DS		1		; Register CC
RegDP:			.DS		1		; Register DP
RegA:			.DS		1		; Register A
RegB:			.DS		1		; Register B
RegE:			.DS		1		; Register E
RegF:			.DS		1		; Register F
RegX:			.DS		2		; Register X
RegY:			.DS		2		; Register Y
RegU:			.DS		2		; User stack
RegS:			.DS		2		; System stack
RegPC:			.DS		2		; Register PC
TempByte:		.DS		1		; Temporary storage byte (8-bit)
TempWord:						; Temporary storage word (16-bit deconstructed)
TempW1:			.DS		1		; Word MSB
TempW2:			.DS		1		; Word LSB
TempQuad:						; Temporary storage quad (32-bit deconstructed)
TempQ1:			.DS		1		; Quad High MSB
TempQ2:			.DS		1		; Quad Low MSB
TempQ3:			.DS		1		; Quad High LSB
TempQ4:			.DS		1		; Quad Low LSB
VarEnd:

	FILL 'S',JmpStart-VarEnd	; Clear area with $00

;      _                             
;     | |  _   _   _ __ ___    _ __  
;  _  | | | | | | | '_ ` _ \  | '_ \ 
; | |_| | | |_| | | | | | | | | |_) |
;  \___/   \__,_| |_| |_| |_| | .__/ 
;                             |_|    
;
; Subroutine jump table to be called by external programs
; =======================================================

	ORG $FD00

JmpStart:
JmpCls:				.DW		Cls
JmpDelChar:			.DW		DelChar
JmpGetStrByte:		.DW		GetStrByte
JmpGetStrNibble:	.DW		GetStrNibble
JmpGetStrWord:		.DW		GetStrWord
JmpInByte:			.DW		InByte
JmpInChar:			.DW		InChar
JmpInCharNW:		.DW		InCharNW
JmpInStr:			.DW		InStr
JmpInWord:			.DW		InWord
JmpOutChar:			.DW		OutChar
JmpOutByte:			.DW		OutByte
JmpOutCRLF:			.DW		OutCRLF
JmpOutNibble:		.DW		OutNibble
JmpOutStr:			.DW		OutStr
JmpOutWord:			.DW		OutWord
JmpAscToBinNibble:	.DW		AscToBinNibble
JmpAscToBinByte:	.DW		AscToBinByte
JmpAscToBinWord:	.DW		AscToBinWord
JmpBinToAscNibble:	.DW		BinToAscNibble
JmpBinToAscByte:	.DW		BinToAscByte
JmpBinToAscWord:	.DW		BinToAscWord
JmpBinToBcd:		.DW		BinToBcd
JmpUpperCase:		.DW		UpperCase
JmpOutBcd:			.DW		OutBcd
JmpTableEnd:

	FILL 'J',ConstRAM-JmpTableEnd ; Clear area with $00

;   ____                         _                     _   
;  / ___|   ___    _ __    ___  | |_    __ _   _ __   | |_ 
; | |      / _ \  | '_ \  / __| | __|  / _` | | '_ \  | __|
; | |___  | (_) | | | | | \__ \ | |_  | (_| | | | | | | |_ 
;  \____|  \___/  |_| |_| |___/  \__|  \__,_| |_| |_|  \__|
;
; This range is constant to all upper 8th block in a RAM banking system
; =====================================================================

	PRAGMA cc
	ORG $FE00					; Constant RAM ($FE00-$FEFF)
	
ConstRAM:
	.DS		256					

	ORG $FF00					; I/O range ($FF00-$FFEF)

InputOutputRange:
	.DS		240

	ORG $FFF0					; Reset and Interrupt vectors ($FFF0-$FFFF)

Vectors:
	.DW		IllegalDiv0			; Illegal Opcode and Division by Zero Trap (6309 only)
	.DW		SoftInt3			; SWI3
	.DW		SoftInt2			; SWI2
	.DW		SoftInt1			; SWI
	.DW		FIRQInt				; FIRQ
	.DW		IRQInt				; IRQ
	.DW		NMIInt				; NMI
	.DW		Reset				; RESET

	END
