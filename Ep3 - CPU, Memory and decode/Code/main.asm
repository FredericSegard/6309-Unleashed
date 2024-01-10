
;         ::::::::       ::::::::       :::::::       :::::::: 
;       :+:    :+:     :+:    :+:     :+:   :+:     :+:    :+: 
;      +:+                   +:+     +:+   +:+     +:+    +:+  
;     +#++:++#+          +#++:      +#+   +:+      +#++:++#+   
;    +#+    +#+            +#+     +#+   +#+            +#+    
;   #+#    #+#     #+#    #+#     #+#   #+#     #+#    #+#     
;   ########       ########       #######       ########       

; *********************************************************************************************************************
; * 6309 project, code named LogicSpark-09
; *
; * https://www.youtube.com/@microhobbyist
; * https://github.com/FredericSegard
; *
; * Copyright (C) 2024 Frédéric Segard (MicroHobbyist)
; *
; * This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General
; * Public License as published by the Free Software Foundation. You can use all or part of the code, regardless of
; * the version. But there is no warrenty of any kind.
; *
; * Reference:	ASCII text: https://www.messletters.com/en/big-text/ (alligator, standard)
; *				Editor tab-stops set to 4
; *				Assembler: VASM  (vasm6809_oldstyle -6309 -dotdir -chklabels -nocase %1.asm -Fbin -o %1.out -L %1.txt)
; *
; * Version 0.1 (Jan 10th 2024)
; *********************************************************************************************************************


; ---------------
; *** EQUATES ***
; ---------------

; I/O addresses
;--------------
RomDisable		= $FF08			; ROM disable (poke any value)

; ---------------------------------------------------------------------------------------------------------------------

	org		$0000

RESET:

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

ShadowCopyEnd:

	ds		Init-ShadowCopyEnd,$FF ; Fill memory with $FF for rapid programming


; ---------------------------------------------------------------------------------------------------------------------

	org		$8000


Init:
	bra		Init				; Currently does nothing. WiP

	
InitEnd:

	ds		Vectors-InitEnd,$FF	; Fill memory with $FF for rapid programming

; ---------------------------------------------------------------------------------------------------------------------


; ---------------
; *** VECTORS ***
; ---------------

	org		$FFF0

Vectors:
	dw		$0000	; Illegal Opcode and Division by Zero Trap (exception)
	dw		$0000	; SWI3
	dw		$0000	; SWI2
	dw		$0000	; SWI
	dw		$0000	; FIRQ
	dw		$0000	; IRQ
	dw		$0000	; NMI
	dw		$RESET	; RESET

	end











