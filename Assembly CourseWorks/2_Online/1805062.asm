.MODEL SMALL 
.STACK 100H 
.DATA

V DB 'Vowel','$'
C DB 'Consonant','$'
N DB 'Nonalphabet','$'

D DB ? 


CR EQU 0DH
LF EQU 0AH

.CODE 
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
     
    MOV AH,1
    INT 21H
    MOV D,AL
    
    MOV DL,CR
    MOV AH,2
    INT 21H
    MOV DL,LF
    MOV AH,2
    INT 21H
    
    CMP D,65
    JL NONAL
    CMP D,90
    JG GREAT
    JNG VA
    
    GREAT:
    SUB D,32
    
    
    VA:
    CMP D,65
    JL NONAL
    JE VOWEL
    JNE VE
    
    VE:
    CMP D,69
    JE VOWEL
    JNE VI
    
    VI:
    CMP D,73
    JE VOWEL
    JNE VO 
    
    VO:
    CMP D,79
    JE VOWEL
    JNE VU 
    
    VU:
    CMP D,85
    JE VOWEL
    JNE CON
    
    
    
    
     
    VOWEL:
    LEA DX,V
    MOV AH,09H
    INT 21H
    JMP END_IF
    
    CON:
    LEA DX,C
    MOV AH,09H
    INT 21H
    JMP END_IF
    
    NONAL:
    LEA DX,N
    MOV AH,09H
    INT 21H
    JMP END_IF
    
    
      

	; interrupt to exit
	END_IF:
    MOV AH, 4CH
    INT 21H
    
  
MAIN ENDP 
END MAIN 


