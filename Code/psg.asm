; PSG declarations
Snd1Addr		=	$FF11		; Writing to this address will latch the address of the register
Snd1Write		=	$FF10		; Writing to this address will write to the addressed register
Snd1Read		=	$FF11		; Reading to this address will read the addressed register
Snd2Addr		=	$FF13		; Writing to this address will latch the address of the register
Snd2Write		=	$FF12		; Writing to this address will write to the addressed register
Snd2Read		=	$FF13		; Reading to this address will read the addressed register
Snd3Addr		=	$FF15		; Writing to this address will latch the address of the register
Snd3Write		=	$FF14		; Writing to this address will write to the addressed register
Snd3Read		=	$FF15		; Reading to this address will read the addressed register
Snd4Addr		=	$FF17		; Writing to this address will latch the address of the register
Snd4Write		=	$FF16		; Writing to this address will write to the addressed register
Snd4Read		=	$FF17		; Reading to this address will read the addressed register

; PSG register array
ToneA_Fine		=	0		; 8-bit fine tune A
ToneA_Coarse	=	1		; 4-bit coarse tune A
ToneB_Fine		=	2		; 8-bit fine tune B
ToneB_Coarse	=	3		; 4-bit coarse tune B
ToneC_Fine		=	4		; 8-bit fine tune C
ToneC_Coarse	=	5		; 4-bit coarse tune C
Noise			=	6		; 5-bit control
Enable			=	7		; IOB, IOA, /NoiseC, /NoiseB, /NoiseC, /ToneC, /ToneB, /ToneA
AmplA			=	8		; M, L3, L2, L1, L0
AmplB			=	9		; M, L3, L2, L1, L0
AmplC			=	10		; M, L3, L2, L1, L0
EnvFine			=	11		; 8-bit fine tune enveloppe
EnvCoarse		=	12		; 8-bit coarse tune enveloppe
EnvShapeCycle	=	13		; CONT, ATT, ALT, HOLD
IOportA			=	14		; 8-bit parallel I/O port A
IOportB			=	15		; 8-bit parallel I/O port B

; Tempered Chromatic Scale (f clock = 1.78977MHz)
; 12-bit (converted from octal chart to hex)
; MSB = Coarse, LSB = Fine
XX			=	$0FFF		; Don't care
C1			=	$0D5D
Cs1			=	$0C9C
Db1			=	$0C9C
D1			=	$0BE7
Ds1			=	$0B3C
Eb1			=	$0B3C
E1			=	$0A9B
F1			=	$0A02
Fs1			=	$0973
Gb1			=	$0973
G1			=	$08EB
Gs1			=	$086B
Ab1			=	$086B
A1			=	$07F2
As1			=	$0780
Bb1			=	$0780
B1			=	$0714
C2			=	$06AE
Cs2			=	$064E
Db2			=	$064E
D2			=	$05F4
Ds2			=	$059E
Eb2			=	$059E
E2			=	$054D
F2			=	$0501
Fs2			=	$04B9
Gb2			=	$04B9
G2			=	$0475
Gs2			=	$0435
Ab2			=	$0435
A2			=	$03F9
As2			=	$03C0
Bb2			=	$03C0
B2			=	$038A
C3			=	$0357
Cs3			=	$0327
Db3			=	$0327
D3			=	$02FA
Ds3			=	$02CF
Eb3			=	$02CF
E3			=	$02A7
F3			=	$0281
Fs3			=	$025D
Gb3			=	$025D
G3			=	$023B
Gs3			=	$021B
Ab3			=	$021B
A3			=	$01FC
As3			=	$01E0
Bb3			=	$01E0
B3			=	$01C5
C4			=	$01AC
Cs4			=	$0194
Db4			=	$0194
D4			=	$017D
Ds4			=	$0168
Eb4			=	$0168
E4			=	$0153
F4			=	$0140
Fs4			=	$012E
Gb4			=	$012E
G4			=	$011D
Gs4			=	$010D
Ab4			=	$010D
A4			=	$00FE
As4			=	$00F0
Bb4			=	$00F0
B4			=	$00E2
C5			=	$00D6
Cs5			=	$00CA
Db5			=	$00CA
D5			=	$00BE
Ds5			=	$00B4
Eb5			=	$00B4
E5			=	$00AA
F5			=	$00A0
Fs5			=	$0097
Gb5			=	$0097
G5			=	$008F
Gs5			=	$0087
Ab5			=	$0087
A5			=	$007F
As5			=	$0078
Bb5			=	$0078
B5			=	$0071
C6			=	$006B
Cs6			=	$0065
Db6			=	$0065
D6			=	$005F
Ds6			=	$005A
Eb6			=	$005A
E6			=	$0055
F6			=	$0052
Fs6			=	$004C
Gb6			=	$004C
G6			=	$0047
Gs6			=	$0043
Ab6			=	$0043
A6			=	$0040
As6			=	$003C
Bb6			=	$003C
B6			=	$0039
C7			=	$0035
Cs7			=	$0032
Db7			=	$0032
D7			=	$0030
Ds7			=	$002D
Eb7			=	$002D
E7			=	$002A
F7			=	$0028
Fs7			=	$0026
Gb7			=	$0026
G7			=	$0024
Gs7			=	$0022
Ab7			=	$0022
A7			=	$0020
As7			=	$001E
Bb7			=	$001E
B7			=	$001C
C8			=	$001B
Cs8			=	$0019
Db8			=	$0019
D8			=	$0018
Ds8			=	$0016
Eb8			=	$0016
E8			=	$0015
F8			=	$0014
Fs8			=	$0013
Gb8			=	$0013
G8			=	$0012
Gs8			=	$0011
Ab8			=	$0011
A8			=	$0010
As8			=	$000F
Bb8			=	$000F
B8			=	$000E

; Voice NUMBERS (LSB nibble is dropped at import)
EOT			=	$0000
Voice1		=	$1000
Voice2		=	$2000
Voice3		=	$3000
Voice4		=	$4000
Voice5		=	$5000
Voice6		=	$6000
Voice7		=	$7000
Voice8		=	$8000
Voice9		=	$9000
Voice10		=	$A000
Voice11		=	$B000
Voice12		=	$C000
Noise1		=	$D000
Noise2		=	$E000
Noise3		=	$F000

; COMMON AMPLITUDE LEVELS
Off			=	$0000
Low			=	$0300
Mid			=	$0700
High		=	$0B00
Full		=	$0F00

; NOTE AND REST DURATION (LSB byte is dropped at import)
Whole		=	$0080
Half		=	$0040
Quarter		=	$0020
Sixth		=	$0018
Eighth		=	$0010
Twelth		=	$000C
Sixteenth	=	$0008
Thirtieth	=	$0004
Sixtieth	=	$0002
Pause		=	$0002
None		=	$0000


;  ____                  ___           _   _   
; |  _ \   ___    __ _  |_ _|  _ __   (_) | |_ 
; | |_) | / __|  / _` |  | |  | '_ \  | | | __|
; |  __/  \__ \ | (_| |  | |  | | | | | | | |_ 
; |_|     |___/  \__, | |___| |_| |_| |_|  \__|
;                |___/                         
;
; Initialize all the PSGs
; =======================

PSGinit:

	; Initialize registers
	lda	#Enable			; Mixer Control - I/O Enable (R7 octal)
	sta	Snd1Addr
	sta	Snd2Addr
	sta	Snd3Addr
	sta	Snd4Addr
	lda	#$38			; Disable Noise and Enable tone on all channels
	sta	Snd1Write
	sta	Snd2Write
	sta	Snd3Write
	sta	Snd4Write
	;Initialize amplitude to 0
	lda	#AmplA			; Amplitude Control (R10 octal)
	sta	Snd1Addr
	sta	Snd2Addr
	sta	Snd3Addr
	sta	Snd4Addr
	lda	#Off			; xxx1000 - Amplitude "mode"
	sta	Snd1Write
	sta	Snd2Write
	sta	Snd3Write
	sta	Snd4Write
	lda	#AmplB			; Amplitude Control (R11 octal)
	sta	Snd1Addr
	sta	Snd2Addr
	sta	Snd3Addr
	sta	Snd4Addr
	lda	#Off			; xxx1000 - Amplitude "mode"
	sta	Snd1Write
	sta	Snd2Write
	sta	Snd3Write
	sta	Snd4Write
	lda	#AmplC			; Amplitude Control (R12 octal)
	sta	Snd1Addr
	sta	Snd2Addr
	sta	Snd3Addr
	sta	Snd4Addr
	lda	#Off			; xxx1000 - Amplitude "mode"
	sta	Snd1Write
	sta	Snd2Write
	sta	Snd3Write
	sta	Snd4Write
	rts

;  ____    _                 
; |  _ \  | |   __ _   _   _ 
; | |_) | | |  / _` | | | | |
; |  __/  | | | (_| | | |_| |
; |_|     |_|  \__,_|  \__, |
;                      |___/ 
;
; Play song command
; =================

Play:
	jsr		SkipSpaces			; Remove leading white spaces
	lda		,X					; Read a character from string
	beq		PlayDefault			; If empty, play boot music
	cmpa	#'1'				; Is it the 1st song (Mario)
	bne		Play2				; No, then check if its the second song?
	jmp		MarioSong			; Play Mario song
Play2:
	cmpa	#'2'				; Is it the 2nd song (Monkey Island)
	bne		PlayInvalid			; No, then say it's invalid
	jmp		MonkeyIslandSong	; Play Monkey Island song
PlayDefault:
	jmp		BootTune
PlayInvalid:
	jsr		ErrInvalidParameter
	rts

;  ____    _                   _   _           _          
; |  _ \  | |   __ _   _   _  | \ | |   ___   | |_    ___ 
; | |_) | | |  / _` | | | | | |  \| |  / _ \  | __|  / _ \
; |  __/  | | | (_| | | |_| | | |\  | | (_) | | |_  |  __/
; |_|     |_|  \__,_|  \__, | |_| \_|  \___/   \__|  \___|
;                      |___/
;
; Play a note
; ===========

PlayNote:
	pshs	A
	lda		SndVoice			; Load Voice number from current record

PlayNoteVoice1:
	cmp	#>Voice1		; Is it Voice 1?
	bne	PlayNoteVoice2	; No, check if it's Voice 2
	
	lda	#ToneA_Fine		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd1Write		; Store fine tone value

	lda	#ToneA_Coarse		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd1Write		; Store fine tone value
	
	lda	#AmplA			; Amplitude control register
	sta	Snd1Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd1Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

PlayNoteVoice2:
	cmp	#>Voice2		; Is it Voice 2?
	bne	PlayNoteVoice3	; No, check if it's Voice 3
	
	lda	#ToneB_Fine		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd1Write		; Store fine tone value

	lda	#ToneB_Coarse		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd1Write		; Store fine tone value
	
	lda	#AmplB			; Amplitude control register
	sta	Snd1Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd1Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

PlayNoteVoice3:
	cmp	#>Voice3		; Is it Voice 3?
	bne	PlayNoteVoice4	; No, check if it's Voice 4
	
	lda	#ToneC_Fine		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd1Write		; Store fine tone value

	lda	#ToneC_Coarse		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd1Write		; Store fine tone value
	
	lda	#AmplC			; Amplitude control register
	sta	Snd1Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd1Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

PlayNoteVoice4:
	cmp	#>Voice4		; Is it Voice 4?
	bne	PlayNoteVoice5	; No, check if it's Voice 5
	
	lda	#ToneA_Fine		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd2Write		; Store fine tone value

	lda	#ToneA_Coarse		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd2Write		; Store fine tone value
	
	lda	#AmplA			; Amplitude control register
	sta	Snd2Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd2Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

PlayNoteVoice5:
	cmp	#>Voice5		; Is it Voice 5?
	bne	PlayNoteVoice6	; No, check if it's Voice 6
	
	lda	#ToneB_Fine		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd2Write		; Store fine tone value

	lda	#ToneB_Coarse		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd2Write		; Store fine tone value
	
	lda	#AmplB			; Amplitude control register
	sta	Snd2Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd2Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

PlayNoteVoice6:
	cmp	#>Voice6		; Is it Voice 6?
	bne	PlayNoteVoice7	; No, check if it's Voice 7
	
	lda	#ToneC_Fine		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd2Write		; Store fine tone value

	lda	#ToneC_Coarse		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd2Write		; Store fine tone value
	
	lda	#AmplC			; Amplitude control register
	sta	Snd2Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd2Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

PlayNoteVoice7:
	cmp	#>Voice7		; Is it Voice 7?
	bne	PlayNoteVoice8	; No, check if it's Voice 8
	
	lda	#ToneA_Fine		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd3Write		; Store fine tone value

	lda	#ToneA_Coarse		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd3Write		; Store fine tone value
	
	lda	#AmplA			; Amplitude control register
	sta	Snd3Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd3Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

PlayNoteVoice8:
	cmp	#>Voice8		; Is it Voice 8?
	bne	PlayNoteVoice9	; No, check if it's Voice 9
	
	lda	#ToneB_Fine		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd3Write		; Store fine tone value

	lda	#ToneB_Coarse		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd3Write		; Store fine tone value
	
	lda	#AmplB			; Amplitude control register
	sta	Snd3Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd3Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

PlayNoteVoice9:
	cmp	#>Voice9		; Is it Voice 9?
	bne	PlayNoteVoice10	; No, check if it's Voice 10
	
	lda	#ToneC_Fine		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd3Write		; Store fine tone value

	lda	#ToneC_Coarse		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd3Write		; Store fine tone value
	
	lda	#AmplC			; Amplitude control register
	sta	Snd3Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd3Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

PlayNoteVoice10:
	cmp	#>Voice10		; Is it Voice 10?
	bne	PlayNoteVoice11	; No, check if it's Voice 11
	
	lda	#ToneA_Fine		; Tone Generator Control - Fine
	sta	Snd4Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd4Write		; Store fine tone value

	lda	#ToneA_Coarse		; Tone Generator Control - Fine
	sta	Snd4Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd4Write		; Store fine tone value
	
	lda	#AmplA			; Amplitude control register
	sta	Snd4Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd4Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

PlayNoteVoice11:
	cmp	#>Voice11		; Is it Voice 11?
	bne	PlayNoteVoice12	; No, check if it's Voice 12
	
	lda	#ToneB_Fine		; Tone Generator Control - Fine
	sta	Snd4Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd4Write		; Store fine tone value

	lda	#ToneB_Coarse		; Tone Generator Control - Fine
	sta	Snd4Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd4Write		; Store fine tone value
	
	lda	#AmplB			; Amplitude control register
	sta	Snd4Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd4Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

PlayNoteVoice12:
	cmp	#>Voice12		; Is it Voice 12?
	bne	play_note_Noise_1	; No, check if it's Noise1
	
	lda	#ToneC_Fine		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd2Write		; Store fine tone value

	lda	#ToneC_Coarse		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd2Write		; Store fine tone value
	
	lda	#AmplC			; Amplitude control register
	sta	Snd2Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd2Write		; Store fine tone value

	jmp	play_note_duration	; Set duration

play_note_Noise_1:
	cmp	#>Noise1		; Is it Noise 1?
	bne	play_note_Noise_2	; No, check if it's Noise2
	jmp	play_note_end

play_note_Noise_2:
	cmp	#>Noise2		; Is it Noise 1?
	bne	play_note_Noise_3	; No, check if it's Noise3
	jmp	play_note_end

play_note_Noise_3:
	cmp	#>Noise3		; Is it Noise 1?
	bne	play_note_no_channel	; No, end routine
	jmp	play_note_end

play_note_no_channel:
	bra	play_note_end

play_note_duration:
	lda	SndDuration		; Load duration value
	beq	play_note_end
	
play_note_duration_loop:
	jsr	play_delay
	dec
	bne	play_note_duration_loop

play_note_end:	
	puls	A,PC

;  ____                    _     _____                        
; | __ )    ___     ___   | |_  |_   _|  _   _   _ __     ___ 
; |  _ \   / _ \   / _ \  | __|   | |   | | | | | '_ \   / _ \
; | |_) | | (_) | | (_) | | |_    | |   | |_| | | | | | |  __/
; |____/   \___/   \___/   \__|   |_|    \__,_| |_| |_|  \___|
;
; Boot tune that resembles Win95 boot music
; =========================================

BootTune:
	stx	SndTable		; Save table pointer (LSB)
	sty	SndTable+1		; Save table pointer (MSB)

play_tune_load_data:
	; CHECK IF ESC has been pressed
	jsr	read_char
	cmp	#ESC			; Has ESCAPE key been pressed?
	bne	play_tune_fine		; Go check for record marker
	printString playaborted		; *MACRO*
	rts				; Exit

play_tune_fine:
	; FINE NOTE
	lda	(SndTable)		; Load fine portion of note data
	sta	SndNoteFine		; Save fine portion of note data
	jsr	inc_table		; Increment table pointer

	; COARSE NOTE
	lda	(SndTable)		; Reload merged Voice and coarse note data
	and	#$0F			; Filter out Voice data to only keep coarse note data
	sta	SndNoteCoarse		; Sage coarse portion of note data
	
	; Voice
	lda	(SndTable)		; Load merged Voice and coarse note data
	and	#$F0			; Filter out note data to only keep Voice number
	sta	SndVoice		; Save Voice number
	jsr	inc_table		; Increment table pointer

	; DURATION
	lda	(SndTable)		; Load merged Voice and coarse note data
	sta	SndDuration		; Save Voice number
	jsr	inc_table		; Increment table pointer

	; VOLUME
	lda	(SndTable)		; Load merged (future nibble data) and volume data
	and	#$0F			; Filter out MSB to only keep volume data
	sta	SndVolume		; Save volume data
	jsr	inc_table		; Increment table pointer
	
	lda	SndVoice		; Load Voice number from current record

play_tune_Voice_1:
	cmp	#>Voice1		; Is it Voice 1?
	bne	play_tune_Voice_2	; No, check if it's Voice 2
	
	lda	#ToneA_Fine		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd1Write		; Store fine tone value

	lda	#ToneA_Coarse		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd1Write		; Store fine tone value
	
	lda	#AmplA			; Amplitude control register
	sta	Snd1Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd1Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Voice_2:
	cmp	#>Voice2		; Is it Voice 2?
	bne	play_tune_Voice_3	; No, check if it's Voice 3
	
	lda	#ToneB_Fine		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd1Write		; Store fine tone value

	lda	#ToneB_Coarse		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd1Write		; Store fine tone value
	
	lda	#AmplB			; Amplitude control register
	sta	Snd1Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd1Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Voice_3:
	cmp	#>Voice3		; Is it Voice 3?
	bne	play_tune_Voice_4	; No, check if it's Voice 4
	
	lda	#ToneC_Fine		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd1Write		; Store fine tone value

	lda	#ToneC_Coarse		; Tone Generator Control - Fine
	sta	Snd1Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd1Write		; Store fine tone value
	
	lda	#AmplC			; Amplitude control register
	sta	Snd1Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd1Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Voice_4:
	cmp	#>Voice4		; Is it Voice 4?
	bne	play_tune_Voice_5	; No, check if it's Voice 5
	
	lda	#ToneA_Fine		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd2Write		; Store fine tone value

	lda	#ToneA_Coarse		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd2Write		; Store fine tone value
	
	lda	#AmplA			; Amplitude control register
	sta	Snd2Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd2Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Voice_5:
	cmp	#>Voice5		; Is it Voice 5?
	bne	play_tune_Voice_6	; No, check if it's Voice 6
	
	lda	#ToneB_Fine		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd2Write		; Store fine tone value

	lda	#ToneB_Coarse		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd2Write		; Store fine tone value
	
	lda	#AmplB			; Amplitude control register
	sta	Snd2Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd2Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Voice_6:
	cmp	#>Voice6		; Is it Voice 6?
	bne	play_tune_Voice_7	; No, check if it's Voice 7
	
	lda	#ToneC_Fine		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd2Write		; Store fine tone value

	lda	#ToneC_Coarse		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd2Write		; Store fine tone value
	
	lda	#AmplC			; Amplitude control register
	sta	Snd2Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd2Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Voice_7:
	cmp	#>Voice7		; Is it Voice 7?
	bne	play_tune_Voice_8	; No, check if it's Voice 8
	
	lda	#ToneA_Fine		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd3Write		; Store fine tone value

	lda	#ToneA_Coarse		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd3Write		; Store fine tone value
	
	lda	#AmplA			; Amplitude control register
	sta	Snd3Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd3Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Voice_8:
	cmp	#>Voice8		; Is it Voice 8?
	bne	play_tune_Voice_9	; No, check if it's Voice 9
	
	lda	#ToneB_Fine		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd3Write		; Store fine tone value

	lda	#ToneB_Coarse		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd3Write		; Store fine tone value
	
	lda	#AmplB			; Amplitude control register
	sta	Snd3Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd3Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Voice_9:
	cmp	#>Voice9		; Is it Voice 9?
	bne	play_tune_Voice_10	; No, check if it's Voice 10
	
	lda	#ToneC_Fine		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd3Write		; Store fine tone value

	lda	#ToneC_Coarse		; Tone Generator Control - Fine
	sta	Snd3Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd3Write		; Store fine tone value
	
	lda	#AmplC			; Amplitude control register
	sta	Snd3Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd3Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Voice_10:
	cmp	#>Voice10		; Is it Voice 10?
	bne	play_tune_Voice_11	; No, check if it's Voice 11
	
	lda	#ToneA_Fine		; Tone Generator Control - Fine
	sta	Snd4Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd4Write		; Store fine tone value

	lda	#ToneA_Coarse		; Tone Generator Control - Fine
	sta	Snd4Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd4Write		; Store fine tone value
	
	lda	#AmplA			; Amplitude control register
	sta	Snd4Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd4Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Voice_11:
	cmp	#>Voice11		; Is it Voice 11?
	bne	play_tune_Voice_12	; No, check if it's Voice 12
	
	lda	#ToneB_Fine		; Tone Generator Control - Fine
	sta	Snd4Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd4Write		; Store fine tone value

	lda	#ToneB_Coarse		; Tone Generator Control - Fine
	sta	Snd4Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd4Write		; Store fine tone value
	
	lda	#AmplB			; Amplitude control register
	sta	Snd4Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd4Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Voice_12:
	cmp	#>Voice12		; Is it Voice 12?
	bne	play_tune_Noise_1	; No, check if it's Noise1
	
	lda	#ToneC_Fine		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteFine		; Read fine value
	sta	Snd2Write		; Store fine tone value

	lda	#ToneC_Coarse		; Tone Generator Control - Fine
	sta	Snd2Addr		; Store register in PSG
	lda	SndNoteCoarse		; Read fine value
	sta	Snd2Write		; Store fine tone value
	
	lda	#AmplC			; Amplitude control register
	sta	Snd2Addr		; Store register in PSG
	lda	SndVolume		; Read volume value
	sta	Snd2Write		; Store fine tone value

	jmp	play_tune_duration	; Set duration

play_tune_Noise_1:
	cmp	#>Noise1		; Is it Noise 1?
	bne	play_tune_Noise_2	; No, check if it's Noise2
	jmp	play_tune_end

play_tune_Noise_2:
	cmp	#>Noise2		; Is it Noise 1?
	bne	play_tune_Noise_3	; No, check if it's Noise3
	jmp	play_tune_end

play_tune_Noise_3:
	cmp	#>Noise3		; Is it Noise 1?
	bne	play_tune_no_channel	; No, end routine
	jmp	play_tune_end

play_tune_no_channel:
	bra	play_tune_end

play_tune_duration:
	lda	SndDuration		; Load duration value
	bne	play_tune_duration_loop
	jmp	play_tune_load_data
	
play_tune_duration_loop:
	jsr	play_delay
	dec
	bne	play_tune_duration_loop
	jmp	play_tune_load_data

play_tune_end:	
	rts


;          _                               _          _                 
;  _ __   | |   __ _   _   _            __| |   ___  | |   __ _   _   _ 
; | '_ \  | |  / _` | | | | |          / _` |  / _ \ | |  / _` | | | | |
; | |_) | | | | (_| | | |_| |         | (_| | |  __/ | | | (_| | | |_| |
; | .__/  |_|  \__,_|  \__, |  _____   \__,_|  \___| |_|  \__,_|  \__, |
; |_|                  |___/  |_____|                             |___/ 
 
; ----------------------------------------------------------------------------------------------------------------------

play_delay:
	pha
	lda	SndTempo
	jsr	millis
	pla
	rts


;  _                          _             _       _        
; (_)  _ __     ___          | |_    __ _  | |__   | |   ___ 
; | | | '_ \   / __|         | __|  / _` | | '_ \  | |  / _ \
; | | | | | | | (__          | |_  | (_| | | |_) | | | |  __/
; |_| |_| |_|  \___|  _____   \__|  \__,_| |_.__/  |_|  \___|
;                    |_____|                                 
		    
; Increment SndTable (16-bit address) - Does not roll-over
; ----------------------------------------------------------------------------------------------------------------------
; INPUT: SndTable and SndTable+1
; RETURNS: Carry bit clear = Did not increment. Already at $FFFF
;          Carry bit set =   Incremented

inc_table:
	pha
	lda	SndTable+1
	cmp	#$FF			; Is MSB = $FF?
	bne	inc_table_add		; No, then proceed to increment
	lda	SndTable
	cmp	#$FF			; Is LSB = $FF
	bne	inc_table_add		; No, then proceed to increment
	clc				; Carry clear indicate reached $FFFF
	pla
	rts
inc_table_add:
	clc				; Clear carry bit
	lda	SndTable		; Load LSB into A
	adc	#1			; Add 1
	sta	SndTable		; Store the result in LSB
	bcc	inc_table_end		; If result does not roll over(FF -> 00), then end subroutine
	inc	SndTable+1		; IF it does, then add 1 to MSB
inc_table_end:
	sec				; Carry set indicates incrementation done
	pla
	rts


;  _                                          _          
; (_)  _ __     ___           _ __     ___   | |_    ___ 
; | | | '_ \   / __|         | '_ \   / _ \  | __|  / _ \
; | | | | | | | (__          | | | | | (_) | | |_  |  __/
; |_| |_| |_|  \___|  _____  |_| |_|  \___/   \__|  \___|
;                    |_____|                             

; Increment PSG_NOTE (12-bit value)
; ----------------------------------------------------------------------------------------------------------------------
; INPUT: SndNoteFine and SndNoteCoarse

inc_note:
	pha
	lda	SndNoteCoarse
	cmp	#$0F			; Is MSB = $0F?
	bne	inc_note_add		; No, then proceed to increment
	lda	SndNoteFine
	cmp	#$FF			; Is LSB = $FF
	bne	inc_note_add		; No, then proceed to increment
	pla
	rts
inc_note_add:
	clc				; Clear carry bit
	lda	SndNoteFine		; Load LSB into A
	adc	#1			; Add 1
	sta	SndNoteFine		; Store the result in LSB
	bcc	inc_note_end		; If result does not roll over(FF -> 00), then end subroutine
	inc	SndNoteCoarse		; IF it does, then add 1 to MSB
inc_note_end:
	pla
	rts
	

;          _                           _                       _             _                          
;  _ __   | |   __ _   _   _          | |__     ___     ___   | |_          | |_   _   _   _ __     ___ 
; | '_ \  | |  / _` | | | | |         | '_ \   / _ \   / _ \  | __|         | __| | | | | | '_ \   / _ \
; | |_) | | | | (_| | | |_| |         | |_) | | (_) | | (_) | | |_          | |_  | |_| | | | | | |  __/
; | .__/  |_|  \__,_|  \__, |  _____  |_.__/   \___/   \___/   \__|  _____   \__|  \__,_| |_| |_|  \___|
; |_|                  |___/  |_____|                               |_____|                             

; Windows 95 boot tune
; ----------------------------------------------------------------------------------------------------------------------

play_boot_tune:
	lda	#12			; Load tempo
	sta	SndTempo

	ldx	#<boot_tune		; Get LSB address
	ldy	#>boot_tune		; Get MSB address
	jsr	play_tune		; 
	
	rts

; ----------------------------------------------------------------------------------------------------------------------

BootTuneData:
	; 0:0	 Voice    Note   Vol   Dur
	.dw		(Voice1 | XX),  (Off | Sixteenth)
	
	; 1:1	 Voice    Note   Vol   Dur
	.dw		(Voice1 | Eb6), (Mid | None)
	.dw		(Voice3 | Eb6), (Low | None)
	.dw		(Voice4 | Eb6), (Low | None)
	.dw		(Voice5 | Ab4), (Mid | None)
	.dw		(Voice6 | Eb4), (Mid | None)
	.dw		(Voice7 | Ab3), (Mid | None)
	.dw		(Voice8 | F2),  (Mid | None)
	.dw		(Voice10| F1),  (Mid | Eighth)
	.dw		(Voice1 | XX),  (Off | None)

	; 1:2	 Voice    Note   Vol   Dur
	.dw		(Voice1 | Eb5), (Mid | Sixteenth)
	.dw		(Voice1 | XX),  (Off | None)

	; 1:3,4	 Voice    Note   Vol   Dur
	.dw		(Voice1 | Bb5), (Mid | Sixteenth)
	.dw		(Voice2 | Bb5), (Mid | Eighth)
	.dw		(Voice1 | XX),  (Off | None)
	.dw		(Voice8 | XX),  (Off | None)
	.dw		(Voice10| XX),  (Off | None)

	; 1:5	 Voice    Note   Vol   Dur
	.dw		(Voice1 | Ab5), (Mid | None)
	.dw		(Voice2 | Ab4), (Mid | None)
	.dw		(Voice8 | Ab2), (Mid | None)
	.dw		(Voice10| Ab1), (Mid | Quarter)
	.dw		(Voice1 | XX),  (Off | None)
	.dw		(Voice2 | XX),  (Off | None)
	
	; 1:6	 Voice    Note   Vol   Dur
	.dw		(Voice1 | Eb6), (Mid | None)
	.dw		(Voice1 | Eb5), (Mid | Eighth)
	.dw		(Voice1 | XX),  (Off | None)
	.dw		(Voice2 | XX),  (Off | None)
	.dw		(Voice3 | XX),  (Low | None)
	.dw		(Voice4 | XX),  (Low | None)
	.dw		(Voice5 | XX),  (Off | None)
	.dw		(Voice6 | XX),  (Off | None)
	.dw		(Voice7 | XX),  (Off | None)
	.dw		(Voice8 | XX),  (Off | None)
	.dw		(Voice10| XX),  (Off | None)

	; 2:1	 Voice    Note   Vol   Dur
	.dw		(Voice1 | Bb6), (Mid | None)
	.dw		(Voice2 | Bb5), (Mid | None)
	.dw		(Voice3 | Bb6), (Low | None)
	.dw		(Voice4 | Bb5), (Low | None)
	.dw		(Voice5 | G4),  (Mid | None)
	.dw		(Voice6 | Eb4), (Mid | None)
	.dw		(Voice7 | G3),  (Mid | None)
	.dw		(Voice8 | Bb3), (Mid | None)
	.dw		(Voice9 | Eb3), (Mid | None)
	.dw		(Voice10| Eb2), (Mid | None)
	.dw		(Voice11| Eb1), (Mid | Half)
	.dw		(Voice1 | XX),  (Off | None)
	.dw		(Voice2 | XX),  (Off | None)
	.dw		(Voice3 | XX),  (Off | None)
	.dw		(Voice4 | XX),  (Off | None)
	.dw		(Voice5 | XX),  (Off | None)
	.dw		(Voice6 | XX),  (Off | None)
	.dw		(Voice7 | XX),  (Off | None)
	.dw		(Voice8 | XX),  (Off | None)
	.dw		(Voice9 | XX),  (Off | None)
	.dw		(Voice10| XX),  (Off | None)
	.dw		(Voice11| XX),  (Off | None)

	; EOT
	.dw		$0000, $0000
