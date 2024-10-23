mario1:

	; 1:1	Voice    Note   Vol   Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 1:2
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 1:3
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 1:4
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 1:5
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 2:1	Voice+Note,Vol+Dur
	.dw		Voice1+G5,Mid+None
	.dw		Voice2+B4,Mid+None
	.dw		Voice3+G4,Mid+None
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice3+XX,Off+None
	.dw		Voice4+XX,Off+Quarter

	; 2:2
	.dw		Voice1+G4,Mid+None
	.dw		Voice4+G2,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice4+XX,Off+Quarter

	; EOT
	.dw		$0000,$0000

; ----------------------------------------------------------------------------------------------------------------------

mario2:
	; 3:1	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 3:2
	.dw		Voice1+G4,Mid+None
	.dw		Voice2+C4,Mid+None
	.dw		Voice4+E3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 3:3
	.dw		Voice1+E4,Mid+None
	.dw		Voice2+G3,Mid+None
	.dw		Voice4+C3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth
	
	; 4:1 	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+C4,Mid+None
	.dw		Voice4+F3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 4:2
	.dw		Voice1+B4,Mid+None
	.dw		Voice2+D4,Mid+None
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 4:3
	.dw		Voice1+As4,Mid+None
	.dw		Voice2+Cs4,Mid+None
	.dw		Voice4+Fs3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 4:4
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+C4,Mid+None
	.dw		Voice4+F3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 5:1	Voice+Note,Vol+Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice2+C4,Mid+None
	.dw		Voice4+E3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 5:2
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+G4,Mid+None
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 5:3
	.dw		Voice1+G5,Mid+None
	.dw		Voice2+B4,Mid+None
	.dw		Voice4+E4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 5:4
	.dw		Voice1+A5,Mid+None
	.dw		Voice2+C5,Mid+None
	.dw		Voice4+F4,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 5:5
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+A4,Mid+None
	.dw		Voice4+D4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 5:6
	.dw		Voice1+G5,Mid+None
	.dw		Voice2+B4,Mid+None
	.dw		Voice4+E4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 6:1	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+A4,Mid+None
	.dw		Voice4+C4,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 6:2
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+A4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 6:3
	.dw		Voice1+D5,Mid+None
	.dw		Voice2+F4,Mid+None
	.dw		Voice4+B4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 6:4
	.dw		Voice1+B4,Mid+None
	.dw		Voice2+D4,Mid+None
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; EOT
	.dw		$0000,$0000
	
; ----------------------------------------------------------------------------------------------------------------------

mario3:
	; 7:1	Voice+Note,Vol+Dur
	.dw		Voice4+C3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause
	
	; 7:2	Voice+Note,Vol+Dur
	.dw		Voice1+G5,Mid+None
	.dw		Voice2+E5,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 7:3	Voice+Note,Vol+Dur
	.dw		Voice1+Fs5,Mid+None
	.dw		Voice2+Ds5,Mid+None
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 7:4	Voice+Note,Vol+Dur
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+D5,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause

	; 7:5	Voice+Note,Vol+Dur
	.dw		Voice1+Ds5,Mid+None
	.dw		Voice2+B4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause

	; 7:6	Voice+Note,Vol+Dur
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 7:7	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+C5,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 8:1	Voice+Note,Vol+Dur
	.dw		Voice4+F3,Mid+Eighth

	; 8:2	Voice+Note,Vol+Dur
	.dw		Voice1+Gs4,Mid+None
	.dw		Voice2+E4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 8:3	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+F4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 8:4	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+G4,Mid+None
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 8:5	Voice+Note,Vol+Dur
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice4+XX,Off+Pause

	; 8:6	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+C4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 8:7	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+F3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 8:8	Voice+Note,Vol+Dur
	.dw		Voice1+D5,Mid+None
	.dw		Voice2+F4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 9:1	Voice+Note,Vol+Dur
	.dw		Voice4+C3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause

	; 9:2	Voice+Note,Vol+Dur
	.dw		Voice1+G5,Mid+None
	.dw		Voice2+E5,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 9:3	Voice+Note,Vol+Dur
	.dw		Voice1+Fs5,Mid+None
	.dw		Voice2+Ds5,Mid+None
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 9:4	Voice+Note,Vol+Dur
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+D5,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause

	; 9:5	Voice+Note,Vol+Dur
	.dw		Voice1+Ds5,Mid+None
	.dw		Voice2+B4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause

	; 9:6	Voice+Note,Vol+Dur
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice4+XX,Off+Pause
	
	; 9:7	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+C5,Mid+None
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 10:1	Voice+Note,Vol+Dur
	.dw		Voice1+C6,Mid+None
	.dw		Voice2+G5,Mid+None
	.dw		Voice4+F5,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 10:2	Voice+Note,Vol+Dur
	.dw		Voice1+C6,Mid+None
	.dw		Voice2+G5,Mid+None
	.dw		Voice3+F5,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice3+XX,Off+Pause
	
	; 10:3	Voice+Note,Vol+Dur
	.dw		Voice1+C6,Mid+None
	.dw		Voice2+G5,Mid+None
	.dw		Voice4+F5,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 10:4	Voice+Note,Vol+Dur
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause

	; 11:1	Voice+Note,Vol+Dur
	.dw		Voice4+C3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause
	
	; 11:2	Voice+Note,Vol+Dur
	.dw		Voice1+G5,Mid+None
	.dw		Voice2+E5,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 11:3	Voice+Note,Vol+Dur
	.dw		Voice1+Fs5,Mid+None
	.dw		Voice2+Ds5,Mid+None
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 11:4	Voice+Note,Vol+Dur
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+D5,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause

	; 11:5	Voice+Note,Vol+Dur
	.dw		Voice1+Ds5,Mid+None
	.dw		Voice2+B4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause

	; 11:6	Voice+Note,Vol+Dur
	.dw		Voice4+C4,Mid+Eighth

	; 11:7	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+C5,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 12:1	Voice+Note,Vol+Dur
	.dw		Voice4+F3,Mid+Eighth

	; 12:2	Voice+Note,Vol+Dur
	.dw		Voice1+Gs4,Mid+None
	.dw		Voice2+E4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 12:3	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+F4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 12:4	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+G4,Mid+None
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 12:5	Voice+Note,Vol+Dur
	.dw		Voice4+C4,Mid+Eighth

	; 12:6	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+C4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 12:7	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+F3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 12:8	Voice+Note,Vol+Dur
	.dw		Voice1+D5,Mid+None
	.dw		Voice2+F4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 13:1	Voice+Note,Vol+Dur
	.dw		Voice4+C3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause

	; 13:2	Voice+Note,Vol+Dur
	.dw		Voice1+Ds5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Gs3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth
	
	; 13:3	Voice+Note,Vol+Dur
	.dw		Voice1+D5,Mid+None
	.dw		Voice2+F4,Mid+None
	.dw		Voice4+As3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth
	
	; 14:1	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+C4,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth
	
	; 14:2	Voice+Note,Vol+Dur
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice4+XX,Off+Pause
	
	; 14:3	Voice+Note,Vol+Dur
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause
	
	; 14:4	Voice+Note,Vol+Dur
	.dw		Voice4+C3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause
	
	; EOT
	.dw		$0000,$0000

; ----------------------------------------------------------------------------------------------------------------------
	
mario4:
	; 15:1	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Gs2,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 15:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth
	
	; 15:3	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Ds3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth
	
	; 15:4	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 15:5	Voice+Note,Vol+Dur
	.dw		Voice1+D5,Mid+None
	.dw		Voice2+As4,Mid+None
	.dw		Voice4+Gs3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 16:1	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+G4,Mid+None
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 16:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+E4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth
	
	; 16:3	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+C3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 16:4	Voice+Note,Vol+Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice2+C4,Mid+Quarter
	
	; 16:5	Voice+Note,Vol+Dur
	.dw		Voice4+G2,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 17:1	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Gs2,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 17:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 17:3	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Ds3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 17:4	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause

	; 17:5	Voice+Note,Vol+Dur
	.dw		Voice1+D5,Mid+None
	.dw		Voice2+As4,Mid+None
	.dw		Voice4+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause

	; 17:6	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+G4,Mid+None
	.dw		Voice4+Gs3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 18:1 	Voice+Note,Vol+Dur
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice4+XX,Off+Eighth

	; 18:2	Voice+Note,Vol+Dur
	.dw		Voice4+C3,Mid+Eighth
	.dw		Voice4+XX,Off+Quarter

	; 18:3	Voice+Note,Vol+Dur
	.dw		Voice4+G2,Mid+Quarter
	.dw		Voice4+XX,Off+Pause

	; 19:1	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Gs2,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 19:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth
	
	; 19:3	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Ds4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth
	
	; 19:4	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 19:5	Voice+Note,Vol+Dur
	.dw		Voice1+D5,Mid+None
	.dw		Voice2+As4,Mid+None
	.dw		Voice4+Gs3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 20:1	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+G4,Mid+None
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 20:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+E4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth
	
	; 20:3	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+C3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 20:4	Voice+Note,Vol+Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice2+C4,Mid+Quarter
	
	; 20:5	Voice+Note,Vol+Dur
	.dw		Voice4+G2,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 21:1	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 21:2	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth
	
	; 21:3	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 21:4	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 21:5	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 22:1	Voice+Note,Vol+Dur
	.dw		Voice1+G5,Mid+None
	.dw		Voice2+B4,Mid+None
	.dw		Voice3+G4,Mid+None
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice3+XX,Off+None
	.dw		Voice4+XX,Off+Quarter

	; 22:2	Voice+Note,Vol+Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice4+G2,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice4+XX,Off+Quarter

	; EOT
	.dw		$0000,$0000
	
; ----------------------------------------------------------------------------------------------------------------------

mario6:
	; 27:1	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+C5,Mid+None
	.dw		Voice4+C3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause

	; 27:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+A4,Mid+Eighth
	.dw		Voice4+XX,Off+Pause

	; 27:3	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+A4,Mid+Eighth
	.dw		Voice4+XX,Off+Pause

	; 27:4	Voice+Note,Vol+Dur
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Eighth
	
	; 27:5	Voice+Note,Vol+Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+Fs3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 27:6	Voice+Note,Vol+Dur
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause

	; 27:7	Voice+Note,Vol+Dur
	.dw		Voice1+Gs4,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+C4,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 28:1	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+F4,Mid+None
	.dw		Voice4+F3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 28:2	Voice+Note,Vol+Dur
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+C5,Mid+Eighth
	.dw		Voice4+XX,Off+Eighth

	; 28:3	Voice+Note,Vol+Dur
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+C5,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 28:4	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+F4,Mid+None
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice4+XX,Off+Pause

	; 28:5	Voice+Note,Vol+Dur
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 28:6	Voice+Note,Vol+Dur
	.dw		Voice4+F4,Mid+Quarter
	.dw		Voice4+XX,Off+Pause

	; 29:1	Voice+Note,Vol+Dur
	.dw		Voice1+B4,Mid+None
	.dw		Voice2+G4,Mid+None
	.dw		Voice4+D3,Mid+Sixth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 29:2	Voice+Note,Vol+Dur
	.dw		Voice1+A5,Mid+None
	.dw		Voice2+F5,Mid+Sixth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 29:3	Voice+Note,Vol+Dur
	.dw		Voice1+A5,Mid+None
	.dw		Voice2+F5,Mid+None
	.dw		Voice4+F3,Mid+Sixth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 29:4	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+F5,Mid+None
	.dw		Voice4+G3,Mid+Sixth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 29:5	Voice+Note,Vol+Dur
	.dw		Voice1+G5,Mid+None
	.dw		Voice2+E5,Mid+Sixth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 29:6	Voice+Note,Vol+Dur
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+D5,Mid+None
	.dw		Voice4+B3,Mid+Sixth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 30:1	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+C5,Mid+None
	.dw		Voice4+F3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 30:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+A4,Mid+Eighth
	.dw		Voice4+XX,Off+Pause
	
	; 30:3	Voice+Note,Vol+Dur
	.dw		Voice4+F3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	
	; 30:4	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+F4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 30:5	Voice+Note,Vol+Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice4+XX,Off+Pause
	
	; 30:6	Voice+Note,Vol+Dur
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause
	
	; 30:7	Voice+Note,Vol+Dur
	.dw		Voice4+F3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause
	
	; 31:1	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+C5,Mid+None
	.dw		Voice4+C3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 31:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+A4,Mid+None
	.dw		Voice4+XX,Off+Eighth	
	
	; 31:3	Voice+Note,Vol+Dur
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Eighth
	
	; 31:4	Voice+Note,Vol+Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+Fs3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause	
	
	; 31:5	Voice+Note,Vol+Dur
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause	
	
	; 31:6	Voice+Note,Vol+Dur
	.dw		Voice1+Gs4,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+C4,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause	
	
	; 32:1	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+F4,Mid+None
	.dw		Voice4+F3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 32:2	Voice+Note,Vol+Dur
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+C5,Mid+Eighth
	.dw		Voice4+XX,Off+Pause	
	
	; 32:3	Voice+Note,Vol+Dur
	.dw		Voice4+F3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause
	
	; 32:4	Voice+Note,Vol+Dur
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+C5,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause	
	
	; 32:5	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+F4,Mid+None
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice4+XX,Off+Pause	
	
	; 32:6	Voice+Note,Vol+Dur
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause	
	
	; 32:7	Voice+Note,Vol+Dur
	.dw		Voice4+F3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause	
	
	; 33:1	Voice+Note,Vol+Dur
	.dw		Voice1+B4,Mid+None
	.dw		Voice2+G4,Mid+None
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause	
	
	; 33:2	Voice+Note,Vol+Dur
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+D5,Mid+None
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause	
	
	; 33:3	Voice+Note,Vol+Dur
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+D5,Mid+None
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause	
	
	; 33:4	Voice+Note,Vol+Dur
	.dw		Voice1+F5,Mid+None
	.dw		Voice2+D5,Mid+None
	.dw		Voice4+G3,Mid+Sixth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause	
	
	; 33:5	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+C5,Mid+None
	.dw		Voice4+A3,Mid+Sixth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause	
	
	; 33:6	Voice+Note,Vol+Dur
	.dw		Voice1+D5,Mid+None
	.dw		Voice2+B4,Mid+None
	.dw		Voice4+B3,Mid+Sixth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause	
	
	; 34:1	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+G4,Mid+None
	.dw		Voice4+C4,Mid+Eighth
	.dw		Voice2+XX,Off+Pause

	; 34:2	Voice+Note,Vol+Dur
	.dw		Voice1+E4,Mid+None
	.dw		Voice4+XX,Off+Pause	

	; 34:3	Voice+Note,Vol+Dur
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice1+XX,Off+Pause

	; 34:4	Voice+Note,Vol+Dur
	.dw		Voice1+E4,Mid+Eighth
	.dw		Voice4+XX,Off+Pause	

	; 34:5	Voice+Note,Vol+Dur
	.dw		Voice1+C4,Mid+None
	.dw		Voice4+C3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice4+XX,Off+Quarter	

	; EOT
	.dw		$0000,$0000

; ----------------------------------------------------------------------------------------------------------------------

mario7:
	; 35:1	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Gs2,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None

	; 35:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 35:3	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Ds3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 35:4	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 35:5	Voice+Note,Vol+Dur
	.dw		Voice1+D5,Mid+None
	.dw		Voice2+As4,Mid+None
	.dw		Voice4+Gs3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 36:1	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+G4,Mid+None
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause

	; 36:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+E4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 36:3	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+C3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 36:4	Voice+Note,Vol+Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice2+C4,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None

	; 36:5	Voice+Note,Vol+Dur
	.dw		Voice4+G2,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 37:1	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Gs2,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None

	; 37:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 37:3	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Ds3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 37:4	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 37:5	Voice+Note,Vol+Dur
	.dw		Voice1+D5,Mid+None
	.dw		Voice2+As4,Mid+None
	.dw		Voice4+Gs3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 37:6	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+G4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 38:1	Voice+Note,Vol+Dur
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice4+XX,Off+Pause

	; 38:2	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+Eighth
	.dw		Voice1+XX,Off+Pause

	; 38:3	Voice+Note,Vol+Dur
	.dw		Voice1+G5,Mid+None
	.dw		Voice4+C3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 38:4	Voice+Note,Vol+Dur
	.dw		Voice1+E6,Mid+Eighth
	.dw		Voice1+XX,Off+Pause

	; 38:x	Voice+Note,Vol+Dur
	.dw		Voice1+C6,Mid+Eighth
	.dw		Voice1+XX,Off+Pause

	; 38:x	Voice+Note,Vol+Dur
	.dw		Voice1+D6,Mid+None
	.dw		Voice4+G2,Mid+Eighth
	.dw		Voice1+XX,Off+Pause

	; 38:x	Voice+Note,Vol+Dur
	.dw		Voice1+G6,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 39:1	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Gs2,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None

	; 39:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 39:3	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+None
	.dw		Voice4+Ds3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 39:4	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Gs4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 39:5	Voice+Note,Vol+Dur
	.dw		Voice1+D5,Mid+None
	.dw		Voice2+As4,Mid+None
	.dw		Voice4+Gs3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 40:1	Voice+Note,Vol+Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+G4,Mid+None
	.dw		Voice4+G3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+Pause

	; 40:2	Voice+Note,Vol+Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+E4,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 40:3	Voice+Note,Vol+Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+C3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 40:4	Voice+Note,Vol+Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice2+C4,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None

	; 40:5	Voice+Note,Vol+Dur
	.dw		Voice4+G2,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 41:1	Voice    Note   Vol   Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 41:2	Voice    Note   Vol   Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 41:3	Voice    Note   Vol   Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 41:4	Voice    Note   Vol   Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Eighth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 41:5	Voice    Note   Vol   Dur
	.dw		Voice1+E5,Mid+None
	.dw		Voice2+Fs4,Mid+None
	.dw		Voice4+D3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 42:1	Voice+Note,Vol+Dur
	.dw		Voice1+G5,Mid+None
	.dw		Voice2+B4,Mid+None
	.dw		Voice3+G4,Mid+None
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice3+XX,Off+None
	.dw		Voice4+XX,Off+Quarter

	; 42:2	Voice    Note   Vol   Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice4+G2,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice4+XX,Off+Quarter

	; EOT
	.dw		$0000,$0000

; ----------------------------------------------------------------------------------------------------------------------

mario9:
	; 51:1	Voice    Note   Vol   Dur
	.dw		Voice1+C5,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+G3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 51:2	Voice    Note   Vol   Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice2+C4,Mid+None
	.dw		Voice4+E3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Eighth

	; 51:3	Voice    Note   Vol   Dur
	.dw		Voice1+E4,Mid+None
	.dw		Voice2+G3,Mid+None
	.dw		Voice4+C3,Mid+Quarter
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+Pause

	; 52:1	Voice    Note   Vol   Dur
	.dw		Voice1+A4,Mid+None
	.dw		Voice2+F4,Mid+None
	.dw		Voice4+C3,Mid+None
	.dw		Voice5+F2,Mid+Sixth
	.dw		Voice1+XX,Off+Pause
	
	; 52:2	Voice    Note   Vol   Dur
	.dw		Voice1+B4,Mid+Sixth
	.dw		Voice1+XX,Off+Pause

	; 52:3	Voice    Note   Vol   Dur
	.dw		Voice1+A4,Mid+Sixth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+None
	.dw		Voice5+XX,Off+Pause

	; 52:4	Voice    Note   Vol   Dur
	.dw		Voice1+Gs4,Mid+None
	.dw		Voice2+F4,Mid+None
	.dw		Voice4+Gs2,Mid+None
	.dw		Voice5+Cs2,Mid+Sixth
	.dw		Voice1+XX,Off+Pause

	; 52:5	Voice    Note   Vol   Dur
	.dw		Voice1+As4,Mid+Sixth
	.dw		Voice1+XX,Off+Pause

	; 52:6	Voice    Note   Vol   Dur
	.dw		Voice1+A4,Mid+Sixth
	.dw		Voice1+XX,Off+None
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+None
	.dw		Voice5+XX,Off+Pause

	; 53:1	Voice    Note   Vol   Dur
	.dw		Voice1+G4,Mid+None
	.dw		Voice2+E4,Mid+None
	.dw		Voice4+G2,Mid+None
	.dw		Voice5+C2,Mid+Eighth
	.dw		Voice2+XX,Off+Pause

	; 53:2	Voice    Note   Vol   Dur
	.dw		Voice2+D4,Mid+Eighth
	.dw		Voice2+XX,Off+Pause

	; 53:3	Voice    Note   Vol   Dur
	.dw		Voice1+E4,Mid+Half
	.dw		Voice1+XX,Off+Eighth
	.dw		Voice2+XX,Off+None
	.dw		Voice4+XX,Off+None
	.dw		Voice5+XX,Off+Pause

	; EOT
	.dw		$0000,$0000
