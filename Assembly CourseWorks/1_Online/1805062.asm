.MODEL SMALL 


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH 

PIN  DB 'ENTER A CAPITAL LETTER: $'
POUT DB 'OUTPUT IS: $' 



X DB ?


.CODE

MAIN PROC
    ;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX 
    
    ;PRINT PROMPT
    LEA DX, PIN
    MOV AH, 9
    INT 21H
     
    ;INPUT
    MOV AH, 1
    INT 21H
    MOV X, AL
    sub X,97
    
    
    ;NEW LINE PRINT
    MOV DL,CR
    MOV AH,2
    INT 21H
    MOV DL,LF
    MOV AH,2
    INT 21H
    
    
    ADD BH,5AH
    Sub BH,X
    sub BH,X
    
    
    ;PRINT PROMPT
    LEA DX, POUT
    MOV AH, 9
    INT 21H
    
    
    ;OUTPUT UPDATED VALUE OF X
    MOV DL,BH
    MOV AH,2
    INT 21H
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN