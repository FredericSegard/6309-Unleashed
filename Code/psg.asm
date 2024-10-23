; PSG declarations
Snd1Addr		EQU	$FF11		; Writing to this address will latch the address of the register
Snd1Write		EQU	$FF10		; Writing to this address will write to the addressed register
Snd1Read		EQU	$FF11		; Reading to this address will read the addressed register
Snd2Addr		EQU	$FF13		; Writing to this address will latch the address of the register
Snd2Write		EQU	$FF12		; Writing to this address will write to the addressed register
Snd2Read		EQU	$FF13		; Reading to this address will read the addressed register
Snd3Addr		EQU	$FF15		; Writing to this address will latch the address of the register
Snd3Write		EQU	$FF14		; Writing to this address will write to the addressed register
Snd3Read		EQU	$FF15		; Reading to this address will read the addressed register
Snd4Addr		EQU	$FF17		; Writing to this address will latch the address of the register
Snd4Write		EQU	$FF16		; Writing to this address will write to the addressed register
Snd4Read		EQU	$FF17		; Reading to this address will read the addressed register

; PSG register array
ToneA_Fine		EQU	0		; 8-bit fine tune A
ToneA_Coarse	EQU	1		; 4-bit coarse tune A
ToneB_Fine		EQU	2		; 8-bit fine tune B
ToneB_Coarse	EQU	3		; 4-bit coarse tune B
ToneC_Fine		EQU	4		; 8-bit fine tune C
ToneC_Coarse	EQU	5		; 4-bit coarse tune C
Noise			EQU	6		; 5-bit control
Enable			EQU	7		; IOB, IOA, /NoiseC, /NoiseB, /NoiseC, /ToneC, /ToneB, /ToneA
AmplA			EQU	8		; M, L3, L2, L1, L0
AmplB			EQU	9		; M, L3, L2, L1, L0
AmplC			EQU	10		; M, L3, L2, L1, L0
EnvFine			EQU	11		; 8-bit fine tune enveloppe
EnvCoarse		EQU	12		; 8-bit coarse tune enveloppe
EnvShapeCycle	EQU	13		; CONT, ATT, ALT, HOLD
IOportA			EQU	14		; 8-bit parallel I/O port A
IOportB			EQU	15		; 8-bit parallel I/O port B

; Voice NUMBERS (LSB nibble is dropped at import)
EOT			EQU	$0000
Voice1		EQU	$1000
Voice2		EQU	$2000
Voice3		EQU	$3000
Voice4		EQU	$4000
Voice5		EQU	$5000
Voice6		EQU	$6000
Voice7		EQU	$7000
Voice8		EQU	$8000
Voice9		EQU	$9000
Voice10		EQU	$A000
Voice11		EQU	$B000
Voice12		EQU	$C000
Noise1		EQU	$D000
Noise2		EQU	$E000
Noise3		EQU	$F000

; Tempered Chromatic Scale (f clock EQU 1.78977MHz)
; 12-bit (converted from octal chart to hex)
; MSB EQU Coarse, LSB EQU Fine
XX			EQU	$0FFF		; Don't care
C1			EQU	$0D5D
Cs1			EQU	$0C9C
Db1			EQU	$0C9C
D1			EQU	$0BE7
Ds1			EQU	$0B3C
Eb1			EQU	$0B3C
E1			EQU	$0A9B
F1			EQU	$0A02
Fs1			EQU	$0973
Gb1			EQU	$0973
G1			EQU	$08EB
Gs1			EQU	$086B
Ab1			EQU	$086B
A1			EQU	$07F2
As1			EQU	$0780
Bb1			EQU	$0780
B1			EQU	$0714
C2			EQU	$06AE
Cs2			EQU	$064E
Db2			EQU	$064E
D2			EQU	$05F4
Ds2			EQU	$059E
Eb2			EQU	$059E
E2			EQU	$054D
F2			EQU	$0501
Fs2			EQU	$04B9
Gb2			EQU	$04B9
G2			EQU	$0475
Gs2			EQU	$0435
Ab2			EQU	$0435
A2			EQU	$03F9
As2			EQU	$03C0
Bb2			EQU	$03C0
B2			EQU	$038A
C3			EQU	$0357
Cs3			EQU	$0327
Db3			EQU	$0327
D3			EQU	$02FA
Ds3			EQU	$02CF
Eb3			EQU	$02CF
E3			EQU	$02A7
F3			EQU	$0281
Fs3			EQU	$025D
Gb3			EQU	$025D
G3			EQU	$023B
Gs3			EQU	$021B
Ab3			EQU	$021B
A3			EQU	$01FC
As3			EQU	$01E0
Bb3			EQU	$01E0
B3			EQU	$01C5
C4			EQU	$01AC
Cs4			EQU	$0194
Db4			EQU	$0194
D4			EQU	$017D
Ds4			EQU	$0168
Eb4			EQU	$0168
E4			EQU	$0153
F4			EQU	$0140
Fs4			EQU	$012E
Gb4			EQU	$012E
G4			EQU	$011D
Gs4			EQU	$010D
Ab4			EQU	$010D
A4			EQU	$00FE
As4			EQU	$00F0
Bb4			EQU	$00F0
B4			EQU	$00E2
C5			EQU	$00D6
Cs5			EQU	$00CA
Db5			EQU	$00CA
D5			EQU	$00BE
Ds5			EQU	$00B4
Eb5			EQU	$00B4
E5			EQU	$00AA
F5			EQU	$00A0
Fs5			EQU	$0097
Gb5			EQU	$0097
G5			EQU	$008F
Gs5			EQU	$0087
Ab5			EQU	$0087
A5			EQU	$007F
As5			EQU	$0078
Bb5			EQU	$0078
B5			EQU	$0071
C6			EQU	$006B
Cs6			EQU	$0065
Db6			EQU	$0065
D6			EQU	$005F
Ds6			EQU	$005A
Eb6			EQU	$005A
E6			EQU	$0055
F6			EQU	$0052
Fs6			EQU	$004C
Gb6			EQU	$004C
G6			EQU	$0047
Gs6			EQU	$0043
Ab6			EQU	$0043
A6			EQU	$0040
As6			EQU	$003C
Bb6			EQU	$003C
B6			EQU	$0039
C7			EQU	$0035
Cs7			EQU	$0032
Db7			EQU	$0032
D7			EQU	$0030
Ds7			EQU	$002D
Eb7			EQU	$002D
E7			EQU	$002A
F7			EQU	$0028
Fs7			EQU	$0026
Gb7			EQU	$0026
G7			EQU	$0024
Gs7			EQU	$0022
Ab7			EQU	$0022
A7			EQU	$0020
As7			EQU	$001E
Bb7			EQU	$001E
B7			EQU	$001C
C8			EQU	$001B
Cs8			EQU	$0019
Db8			EQU	$0019
D8			EQU	$0018
Ds8			EQU	$0016
Eb8			EQU	$0016
E8			EQU	$0015
F8			EQU	$0014
Fs8			EQU	$0013
Gb8			EQU	$0013
G8			EQU	$0012
Gs8			EQU	$0011
Ab8			EQU	$0011
A8			EQU	$0010
As8			EQU	$000F
Bb8			EQU	$000F
B8			EQU	$000E

; COMMON AMPLITUDE LEVELS
Off			EQU	$0000
Low			EQU	$0300
Mid			EQU	$0700
High		EQU	$0B00
Full		EQU	$0F00

; NOTE AND REST DURATION (LSB byte is dropped at import)
Whole		EQU	$0080
Half		EQU	$0040
Quarter		EQU	$0020
Sixth		EQU	$0018
Eighth		EQU	$0010
Twelth		EQU	$000C
Sixteenth	EQU	$0008
Thirtieth	EQU	$0004
Sixtieth	EQU	$0002
Pause		EQU	$0002
None		EQU	$0000


;  ____                  ___           _   _   
; |  _ \   ___    __ _  |_ _|  _ __   (_) | |_ 
; | |_) | / __|  / _` |  | |  | '_ \  | | | __|
; |  __/  \__ \ | (_| |  | |  | | | | | | | |_ 
; |_|     |___/  \__, | |___| |_| |_| |_|  \__|
;                |___/                         
;
; Initialize all the PSGs
; =======================

PsgInit:

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

PlayCmd:
	jsr		SkipSpaces			; Remove leading white spaces
	lda		,X					; Read a character from string
	beq		PlayCmdDefault		; If empty, play boot music
	cmpa	#'1'				; Is it the 1st song (Mario)
	bne		PlayCmd2			; No, then check if its the second song?
	jmp		MarioSong			; Play Mario song
PlayCmd2:
	cmpa	#'2'				; Is it the 2nd song (Monkey Island)
	bne		PlayCmdInvalid		; No, then say it's invalid
	jmp		MonkeyIslandSong	; Play Monkey Island song
PlayCmdDefault:
	jmp		BootTune
PlayCmdInvalid:
	jsr		ErrInvalidParameter
	rts

;  ____    _                   _   _           _          
; |  _ \  | |   __ _   _   _  | \ | |   ___   | |_    ___ 
; | |_) | | |  / _` | | | | | |  \| |  / _ \  | __|  / _ \
; |  __/  | | | (_| | | |_| | | |\  | | (_) | | |_  |  __/
; |_|     |_|  \__,_|  \__, | |_| \_|  \___/   \__|  \___|
;                      |___/
;
; Play a note on a specific channel
; =================================

PlayNote:
	pshs	X
	lda		SndVoice			; Load Voice number from current record
PlayNoteVoice1:
	cmpa	#$10				; Is it Voice 1?
	bne		PlayNoteVoice2		; No, check if it's Voice 2
	; Coarse
	lda		#ToneA_Coarse		; Tone Generator Control - Coarse
	sta		Snd1Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd1Write			; Store coare tone value
	; Fine
	lda		#ToneA_Fine			; Tone Generator Control - Fine
	sta		Snd1Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd1Write			; Store fine tone value
	; Amplitude
	lda		#AmplA				; Amplitude control register
	sta		Snd1Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd1Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteVoice2:
	cmpa	#$20				; Is it Voice 2?
	bne		PlayNoteVoice3		; No, check if it's Voice 3
	; Coarse
	lda		#ToneB_Coarse		; Tone Generator Control - Coarse
	sta		Snd1Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd1Write			; Store coare tone value
	; Fine
	lda		#ToneB_Fine			; Tone Generator Control - Fine
	sta		Snd1Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd1Write			; Store fine tone value
	; Amplitude
	lda		#AmplB				; Amplitude control register
	sta		Snd1Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd1Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteVoice3:
	cmpa	#$30				; Is it Voice 3?
	bne		PlayNoteVoice4		; No, check if it's Voice 4
	; Coarse
	lda		#ToneC_Coarse		; Tone Generator Control - Coarse
	sta		Snd1Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd1Write			; Store coare tone value
	; Fine
	lda		#ToneC_Fine			; Tone Generator Control - Fine
	sta		Snd1Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd1Write			; Store fine tone value
	; Amplitude
	lda		#AmplC				; Amplitude control register
	sta		Snd1Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd1Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteVoice4:
	cmpa	#$40				; Is it Voice 4?
	bne		PlayNoteVoice5		; No, check if it's Voice 5
	; Coarse
	lda		#ToneA_Coarse		; Tone Generator Control - Coarse
	sta		Snd2Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd2Write			; Store coare tone value
	; Fine
	lda		#ToneA_Fine			; Tone Generator Control - Fine
	sta		Snd2Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd2Write			; Store fine tone value
	; Amplitude
	lda		#AmplA				; Amplitude control register
	sta		Snd2Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd2Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteVoice5:
	cmpa	#$50				; Is it Voice 5?
	bne		PlayNoteVoice6		; No, check if it's Voice 6
	; Coarse
	lda		#ToneB_Coarse		; Tone Generator Control - Coarse
	sta		Snd2Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd2Write			; Store coare tone value
	; Fine
	lda		#ToneB_Fine			; Tone Generator Control - Fine
	sta		Snd2Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd2Write			; Store fine tone value
	; Amplitude
	lda		#AmplB				; Amplitude control register
	sta		Snd2Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd2Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteVoice6:
	cmpa	#$60				; Is it Voice 6?
	bne		PlayNoteVoice7		; No, check if it's Voice 7
	; Coarse
	lda		#ToneC_Coarse		; Tone Generator Control - Coarse
	sta		Snd2Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd2Write			; Store coare tone value
	; Fine
	lda		#ToneC_Fine			; Tone Generator Control - Fine
	sta		Snd2Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd2Write			; Store fine tone value
	; Amplitude
	lda		#AmplC				; Amplitude control register
	sta		Snd2Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd2Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteVoice7:
	cmpa	#$70				; Is it Voice 7?
	bne		PlayNoteVoice8		; No, check if it's Voice 8
	; Coarse
	lda		#ToneA_Coarse		; Tone Generator Control - Coarse
	sta		Snd3Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd3Write			; Store coare tone value
	; Fine
	lda		#ToneA_Fine			; Tone Generator Control - Fine
	sta		Snd3Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd3Write			; Store fine tone value
	; Amplitude
	lda		#AmplA				; Amplitude control register
	sta		Snd3Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd3Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteVoice8:
	cmpa	#$80				; Is it Voice 8?
	bne		PlayNoteVoice9		; No, check if it's Voice 9
	; Coarse
	lda		#ToneB_Coarse		; Tone Generator Control - Coarse
	sta		Snd3Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd3Write			; Store coare tone value
	; Fine
	lda		#ToneB_Fine			; Tone Generator Control - Fine
	sta		Snd3Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd3Write			; Store fine tone value
	; Amplitude
	lda		#AmplB				; Amplitude control register
	sta		Snd3Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd3Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteVoice9:
	cmpa	#$90				; Is it Voice 9?
	bne		PlayNoteVoice10		; No, check if it's Voice 10
	; Coarse
	lda		#ToneC_Coarse		; Tone Generator Control - Coarse
	sta		Snd3Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd3Write			; Store coare tone value
	; Fine
	lda		#ToneC_Fine			; Tone Generator Control - Fine
	sta		Snd3Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd3Write			; Store fine tone value
	; Amplitude
	lda		#AmplC				; Amplitude control register
	sta		Snd3Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd3Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteVoice10:
	cmpa	#$A0				; Is it Voice 10?
	bne		PlayNoteVoice11		; No, check if it's Voice 11
	; Coarse
	lda		#ToneA_Coarse		; Tone Generator Control - Coarse
	sta		Snd4Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd4Write			; Store coare tone value
	; Fine
	lda		#ToneA_Fine			; Tone Generator Control - Fine
	sta		Snd4Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd4Write			; Store fine tone value
	; Amplitude
	lda		#AmplA				; Amplitude control register
	sta		Snd4Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd4Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteVoice11:
	cmpa	#$B0				; Is it Voice 11?
	bne		PlayNoteVoice12		; No, check if it's Voice 12
	; Coarse
	lda		#ToneB_Coarse		; Tone Generator Control - Coarse
	sta		Snd4Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd4Write			; Store coare tone value
	; Fine
	lda		#ToneB_Fine			; Tone Generator Control - Fine
	sta		Snd4Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd4Write			; Store fine tone value
	; Amplitude
	lda		#AmplB				; Amplitude control register
	sta		Snd4Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd4Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteVoice12:
	cmpa	#$C0				; Is it Voice 12?
	bne		PlayNoteNoise1		; No, check if it's Noise1
	; Coarse
	lda		#ToneC_Coarse		; Tone Generator Control - Coarse
	sta		Snd4Addr			; Store register in PSG
	lda		SndNoteCoarse		; Read coarse value
	sta		Snd4Write			; Store coare tone value
	; Fine
	lda		#ToneC_Fine			; Tone Generator Control - Fine
	sta		Snd4Addr			; Store register in PSG
	lda		SndNoteFine			; Read fine value
	sta		Snd4Write			; Store fine tone value
	; Amplitude
	lda		#AmplC				; Amplitude control register
	sta		Snd4Addr			; Store register in PSG
	lda		SndVolume			; Read volume value
	sta		Snd4Write			; Store volume value
	; Duration
	jmp		PlayNoteDuration	; Interpret duration
PlayNoteNoise1:
	cmpa	#$D0				; Is it Noise 1?
	bne		PlayNoteNoise2		; No, check if it's Noise2
	jmp		PlayNoteEnd			; ***** Noise not yet implemented
PlayNoteNoise2:
	cmpa	#$E0				; Is it Noise 2?
	bne		PlayNoteNoise3		; No, check if it's Noise3
	jmp		PlayNoteEnd			; ***** Noise not yet implemented
PlayNoteNoise3:
	cmpa	#$F0				; Is it Noise 3?
	bne		PlayNoteNoChannel	; No, end routine
	jmp		PlayNoteEnd			; ***** Noise not yet implemented
PlayNoteNoChannel:
	bra		PlayNoteEnd			; If no voice numnber has been declared, end playback
PlayNoteDuration:
	lda		SndDuration			; Load duration value
	beq		PlayNoteEnd			; If 0, then end playing note
PlayNoteDurLoop:
	ldb		SndTempo			; Set number of milliseconds to wait
	jsr		Millisecond			; Wait Tempo milliseconds
	deca						; Decrement timer
	bne		PlayNoteDurLoop		; If not ended, continue tempo delay
PlayNoteEnd:	
	puls	X,PC

;  ____    _                   _____                        
; |  _ \  | |   __ _   _   _  |_   _|  _   _   _ __     ___ 
; | |_) | | |  / _` | | | | |   | |   | | | | | '_ \   / _ \
; |  __/  | | | (_| | | |_| |   | |   | |_| | | | | | |  __/
; |_|     |_|  \__,_|  \__, |   |_|    \__,_| |_| |_|  \___|
;                      |___/                                
;
; Boot tune that resembles Win95 boot music
; =========================================

PlayTune:
	; Voice number
	lda		,X					; Load merged Voice and coarse note data
	anda	#$F0				; Filter out note data to only keep voice number
	beq		PlayTuneEnd			; End playing tune if voice number is 0
	sta		SndVoice			; Save voice number
	; Coarse note
	lda		,X+					; Load coarse portion of note data
	anda	#$0F				; Filter out voice number to only keep coarse note data
	sta		SndNoteCoarse		; Save coarse portion of note data
	; Fine note
	lda		,X+					; Load fine portion of note data
	sta		SndNoteFine			; Sage fine portion of note data
	; Volume
	lda		,X+					; Load volume data
	sta		SndVolume			; Save volume data
	; Duration
	lda		,X+					; Load duration data
	sta		SndDuration			; Save duration data
	; Play note
	jsr		PlayNote
	bra		PlayTune
PlayTuneEnd:	
	rts

;  __  __                  _           ____                          
; |  \/  |   __ _   _ __  (_)   ___   / ___|    ___    _ __     __ _ 
; | |\/| |  / _` | | '__| | |  / _ \  \___ \   / _ \  | '_ \   / _` |
; | |  | | | (_| | | |    | | | (_) |  ___) | | (_) | | | | | | (_| |
; |_|  |_|  \__,_| |_|    |_|  \___/  |____/   \___/  |_| |_|  \__, |
;                                                              |___/ 
;
; Super Mario Song
; ================

MarioSong:
	lda		#9					; Load tempo
	sta		SndTempo
	; 1-2
	ldx		#mario1
	jsr		PlayTune
	; 3-6
	ldx		#mario2
	jsr		PlayTune
	; Repeat
	ldx		#mario2
	jsr		PlayTune
	; 7-14
	ldx		#mario3
	jsr		PlayTune
	; Repeat
	ldx		#mario3	
	jsr		PlayTune
	; 15-22
	ldx		#mario4	
	jsr		PlayTune
	; 23-26 (Same as 3-6)
	ldx		#mario2	
	jsr		PlayTune
	; Repeat
	ldx		#mario2	
	jsr		PlayTune
	; 27-34
	ldx		#mario6	
	jsr		PlayTune
	; Repeat
	ldx		#mario6	
	jsr		PlayTune
	; 35-42
	ldx		#mario7	
	jsr		PlayTune
	; 43-50 (same as 27-34)
	ldx		#mario6	
	jsr		PlayTune
	; Repeat
	ldx		#mario6	
	jsr		PlayTune
	; 51-53
	ldx		#mario9	
	jsr		PlayTune
	rts

;  __  __                   _                       ___         _                       _ 
; |  \/  |   ___    _ __   | | __   ___   _   _    |_ _|  ___  | |   __ _   _ __     __| |
; | |\/| |  / _ \  | '_ \  | |/ /  / _ \ | | | |    | |  / __| | |  / _` | | '_ \   / _` |
; | |  | | | (_) | | | | | |   <  |  __/ | |_| |    | |  \__ \ | | | (_| | | | | | | (_| |
; |_|  |_|  \___/  |_| |_| |_|\_\  \___|  \__, |   |___| |___/ |_|  \__,_| |_| |_|  \__,_|
;                                         |___/                                           

; Monkey Island Song
; ==================

MonkeyIslandSong:
	lda		#18					; Load tempo
	sta		SndTempo
	ldx		#MonkeyIslandData	; Get LSB address
	jsr		PlayTune			; 
	rts

;  ____                    _     _____                        
; | __ )    ___     ___   | |_  |_   _|  _   _   _ __     ___ 
; |  _ \   / _ \   / _ \  | __|   | |   | | | | | '_ \   / _ \
; | |_) | | (_) | | (_) | | |_    | |   | |_| | | | | | |  __/
; |____/   \___/   \___/   \__|   |_|    \__,_| |_| |_|  \___|
;
; Windows 95 boot tune
; ====================

BootTune:
	lda		#12					; Load tempo
	sta		SndTempo			; Set tempo in memory
	ldx		#BootTuneData		; Point to tune data
	jsr		PlayTune			; Play the tune
	rts

; -------------------------------------------------------------------

BootTuneData:
	; 0:0	Voice+Note,Vol+Dur
	.word	Voice1+XX,Off+Sixteenth
	
	; 1:1	 Voice    Note   Vol   Dur
	.word	Voice1+Eb6,Mid+None
	.word	Voice3+Eb6,Low+None
	.word	Voice4+Eb6,Low+None
	.word	Voice5+Ab4,Mid+None
	.word	Voice6+Eb4,Mid+None
	.word	Voice7+Ab3,Mid+None
	.word	Voice8+F2,Mid+None
	.word	Voice10+F1,Mid+Eighth
	.word	Voice1+XX,Off+None

	; 1:2	 Voice    Note   Vol   Dur
	.word	Voice1+Eb5,Mid+Sixteenth
	.word	Voice1+XX,Off+None

	; 1:3,4	 Voice    Note   Vol   Dur
	.word	Voice1+Bb5,Mid+Sixteenth
	.word	Voice2+Bb5,Mid+Eighth
	.word	Voice1+XX,Off+None
	.word	Voice8+XX,Off+None
	.word	Voice10+XX,Off+None

	; 1:5	 Voice    Note   Vol   Dur
	.word	Voice1+Ab5,Mid+None
	.word	Voice2+Ab4,Mid+None
	.word	Voice8+Ab2,Mid+None
	.word	Voice10+Ab1,Mid+Quarter
	.word	Voice1+XX,Off+None
	.word	Voice2+XX,Off+None
	
	; 1:6	 Voice    Note   Vol   Dur
	.word	Voice1+Eb6,Mid+None
	.word	Voice1+Eb5,Mid+Eighth
	.word	Voice1+XX,Off+None
	.word	Voice2+XX,Off+None
	.word	Voice3+XX,Low+None
	.word	Voice4+XX,Low+None
	.word	Voice5+XX,Off+None
	.word	Voice6+XX,Off+None
	.word	Voice7+XX,Off+None
	.word	Voice8+XX,Off+None
	.word	Voice10+XX,Off+None

	; 2:1	 Voice    Note   Vol   Dur
	.word	Voice1+Bb6,Mid+None
	.word	Voice2+Bb5,Mid+None
	.word	Voice3+Bb6,Low+None
	.word	Voice4+Bb5,Low+None
	.word	Voice5+G4,Mid+None
	.word	Voice6+Eb4,Mid+None
	.word	Voice7+G3,Mid+None
	.word	Voice8+Bb3,Mid+None
	.word	Voice9+Eb3,Mid+None
	.word	Voice10+Eb2,Mid+None
	.word	Voice11+Eb1,Mid+Half
	.word	Voice1+XX,Off+None
	.word	Voice2+XX,Off+None
	.word	Voice3+XX,Off+None
	.word	Voice4+XX,Off+None
	.word	Voice5+XX,Off+None
	.word	Voice6+XX,Off+None
	.word	Voice7+XX,Off+None
	.word	Voice8+XX,Off+None
	.word	Voice9+XX,Off+None
	.word	Voice10+XX,Off+None
	.word	Voice11+XX,Off+None

	; EOT
	.word	$0000,$0000
