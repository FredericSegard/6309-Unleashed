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
; * https://www.youtube.com/@microhobbyist
; * https://github.com/FredericSegard
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
; *				Assembler: VASM  (vasm6809_oldstyle) 
; *				Args: -6309 -dotdir -chklabels -nocase %1.asm -Fbin -o %1.bin -L %1.txt)
; *
; * Version 0.2 (Jan 17th 2024)
; ****************************************************************************************

; ---------------
; *** EQUATES ***
; ---------------

; Keystrokes
; ----------
NULL	=	$00					; End delimiter
BS		=	$08					; Backspace
TAB		=	$09					; Horizontal Tab
CR		=	$0D					; Carriage return
LF		=	$0A					; Line feed
ESC		=	$1B					; Escape

; I/O addresses
; -------------
RomDisable	= $FF08				; ROM disable (poke any value)
IntVector	= $FF09				; Priority Interrupt Controller (reads a vector value)

; ----------------------------------------------------------------------------------------

	org		$0000

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
	ldw		#$FF00				; Number of bytes to copy (64K - 256 bytes)
	tfm		X+,Y+				; Transfer data and increment pointers
	
	; Copies only the vectors ($FFF0-$FFFF)
	ldx		#$FFF0				; Source address: Read only ROM
	ldy		#$FFF0				; Destination address: Write only RAM
	ldw		#16					; Number of bytes to copy (8x 16-bit vectors)
	tfm		X+,Y+				; Transfer data and increment pointers

	; Disable ROM and make RAM Read/Write.
	sta		RomDisable			; Poke any value to disable the ROM
	jmp		Init

ShadowEnd:
	ds		Init-ShadowEnd,$FF	; Fill memory with $FF for rapid programming

; ----------------------------------------------------------------------------------------

	org		$E000

Init:
	lds		#$E000-1			; Sets the system stack
	jsr		Com1Init			; Initialize ACIA1

	;jsr		Cls					; Clears the screen
	ldx		#WelcomeMsg			; Message to print
StrLoop:
	lda		,X+					; Read character pointed by X, then increments X
	beq		Main				; End routine if end of string (null) has been reached

NotReady:
	ldb		Com1_Status			; Load the status register
	andb	#%00010000			; Is the transmit buffer full?
	beq		NotReady			; Yes, then check until it's empty
	sta		Com1_Data			; Send out the character
	
	bra		StrLoop				; Get the next character

;	jsr		OutStr				; Print the above message

Main:
	bra		Main

;  ___                  _               _              
; |_ _|  _ __     ___  | |  _   _    __| |   ___   ___ 
;  | |  | '_ \   / __| | | | | | |  / _` |  / _ \ / __|
;  | |  | | | | | (__  | | | |_| | | (_| | |  __/ \__ \
; |___| |_| |_|  \___| |_|  \__,_|  \__,_|  \___| |___/
;
; Include files to segment code and data into manageable portions
; ---------------------------------------------------------------

	include "convert.asm"		; Conversion subroutines
	include "io.asm"			; Input and Output subroutines
	include	"data.asm"			; Keep data include file at the end of the list

IncEnd:
	ds	InStrBuffer-IncEnd,$FF	; Fill memory with $FF for rapid programming


;  ____                   __     __                 _           _       _
; / ___|   _   _   ___    \ \   / /   __ _   _ __  (_)   __ _  | |__   | |   ___   ___ 
; \___ \  | | | | / __|    \ \ / /   / _` | | '__| | |  / _` | | '_ \  | |  / _ \ / __|
;  ___) | | |_| | \__ \     \ V /   | (_| | | |    | | | (_| | | |_) | | | |  __/ \__ \
; |____/   \__, | |___/      \_/     \__,_| |_|    |_|  \__,_| |_.__/  |_|  \___| |___/
;          |___/
;
; System variables used by system subroutines
; -------------------------------------------

InStrBuffer:	ds	$FF,0		; String input for console input
InStrLen:		ds	$2,0		; String length limit for InString routine
TempWord:		ds	$2,0		; Temporary 16-bit local storage

SysVarEnd:
	ds	IllegalDiv0-SysVarEnd,$FF	; Fill memory with $FF for rapid programming


;  ___           _                                          _         
; |_ _|  _ __   | |_    ___   _ __   _ __   _   _   _ __   | |_   ___ 
;  | |  | '_ \  | __|  / _ \ | '__| | '__| | | | | | '_ \  | __| / __|
;  | |  | | | | | |_  |  __/ | |    | |    | |_| | | |_) | | |_  \__ \
; |___| |_| |_|  \__|  \___| |_|    |_|     \__,_| | .__/   \__| |___/
;                                                  |_|
; ----------------------------------------------------------------------------------------

IllegalDiv0:
	rti
	
SoftInt3:
	rti
	
SoftInt2:
	rti
	
SoftInt1:
	rti
	
FIRQ:
	rti

IRQ:
	rti

NMI:
	rti

IntEnd:
	ds	ConstRAM-IntEnd,$FF	; Fill memory with $FF for rapid programming

;   ____                         _                     _   
;  / ___|   ___    _ __    ___  | |_    __ _   _ __   | |_ 
; | |      / _ \  | '_ \  / __| | __|  / _` | | '_ \  | __|
; | |___  | (_) | | | | | \__ \ | |_  | (_| | | | | | | |_ 
;  \____|  \___/  |_| |_| |___/  \__|  \__,_| |_| |_|  \__|
;
; This range is considered constant to all upper 8th block in a RAM banking system
; --------------------------------------------------------------------------------

	org	$FE00				; Constant range used in bank switching ($FE00-$FFFF)

ConstRAM:					; Constant RAM ($FE00-$FEFF)
	ds		256,$00			; Zero constant RAM region 

InputOutputRange:			; I/O range ($FF00-$FFEF)
	ds		240,$10			; Filled with $10 to represent IO (Will not be shadow copied)

Vectors:					; Reset and Interrupt vectors ($FFF0-$FFFF)
	dw		IllegalDiv0		; Illegal Opcode and Division by Zero Trap (6309 only)
	dw		SoftInt3		; SWI3
	dw		SoftInt2		; SWI2
	dw		SoftInt1		; SWI
	dw		FIRQ			; FIRQ
	dw		IRQ				; IRQ
	dw		NMI				; NMI
	dw		Reset			; RESET

	end
