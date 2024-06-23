.MODEL SMALL 
.STACK 100H 
.DATA


ARR DW 100 DUP(?) 
CR EQU 0DH
LF EQU 0AH 

N DW ? 
M DW ?
SIZE DW ? 
ISNEG DB ?

foundmsg db 'Given element Found at position: $'
msg db 'Take an integer : $' 
msg2 db 'Take array elements  : $'     
msg3 db 'Array elements after insertion sort : $'
msg4 db 'Take an integer for binary search : $'      
notfoundmsg db 'Given element not found $'
 
.CODE 
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX  
               
    LEA SI, ARR
    
    LEA DX,msg
    MOV AH,09H
    INT 21H
    
    CALL NEWLINE

    CALL INPUT
    MOV N,BX
    
    CMP N,0
    JNG EXIT    ;NEGATIVE/0 HOILE EXIT KORBE
     
    
    MOV CX,N
    MOV M,CX
    MOV SIZE,CX
               
    CALL NEWLINE
    LEA DX,msg2
    MOV AH,09H
    INT 21H 
 
    
    POPULATE:
    CALL NEWLINE
    CALL INPUT
    MOV [SI],BX
    ADD SI,2
    DEC N
    CMP N,0
    JNE POPULATE
    
    CALL NEWLINE
    LEA DX,msg3
    MOV AH,09H
    INT 21H 
    CALL NEWLINE
    
    
    CMP SIZE,1
    JE EQUAL1                       
    
    MOV CX,2       
FIRST_LOOP:
        MOV DX,CX
        DEC DX      
        LEA SI, ARR
        ADD SI, DX
        ADD SI, DX
        MOV AX,[SI] 
        
        
        
SECOND_LOOP:

        CMP [SI-2],AX
        JLE SECOND_LOOP_EXIT
        MOV BX,[SI-2]
        MOV [SI],BX
        DEC SI
        DEC SI
        DEC DX
        JNZ SECOND_LOOP 
        
        
SECOND_LOOP_EXIT:

        MOV [SI],AX
        INC CX      
        CMP CX,SIZE
        JLE FIRST_LOOP          
                   
                   

EQUAL1:
            
    LEA SI,ARR
    
OUTPUTPRINT:

    MOV CX, [SI]    
    CALL OUTPUT
    ADD SI,2  
    DEC M
    CMP M,0            
    JNE OUTPUTPRINT
    
   
    
                  
BINARY_SEARCH: 
    
    CALL NEWLINE
    
    LEA DX,msg4
    MOV AH,09H
    INT 21H    
    
    CALL NEWLINE
    
    CALL INPUT
    
    MOV CX,BX 
    
    CALL NEWLINE
    
    LEA SI,ARR
    
    XOR AX,AX
    MOV DX,SIZE
    DEC DX
    
    SEARCH_MID:
    CMP AX,DX
    JG  NOT_FOUND
    MOV BX,AX
    
    ADD BX,DX ; CURRENT SIZE
    
    SHR BX,1 ; HALF
    
    MOV DI,SI
    ADD DI,BX
    ADD DI,BX
    
    CMP CX,[DI]
    
    JE FOUND            
    JG HIGH
    JNGE LOW 
    
    
HIGH:
   INC BX 
   MOV AX,BX ;HALF+1
   JMP SEARCH_MID
    

LOW:
    DEC BX
    MOV DX,BX;HALF-1 
    JMP SEARCH_MID

FOUND: 
    LEA DX,foundmsg
    ADD BX,1     
    MOV CX,BX
    MOV AH,09h
    INT 21h 
    CALL OUTPUT
    JMP BINARY_SEARCH
    
   
    
NOT_FOUND:
    LEA DX,notfoundmsg
    MOV AH,09h
    INT 21h 
    JMP BINARY_SEARCH  
    
       
EXIT:
MOV AH, 4CH
INT 21H


  
MAIN ENDP 

NEWLINE PROC
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV DL, LF
    INT 21H
    RET
NEWLINE ENDP
    
    
INPUT PROC 
    XOR BX,BX
    MOV ISNEG,0 
    
    MOV AH, 1
    INT 21H 
    
    CMP AL,'-'
    JNE DIGITINPUT 
    INC ISNEG
    INT 21H
    
    DIGITINPUT: 
           
    CMP AL, CR    
    JE END_INPUT_LOOP
    CMP AL, LF
    JE END_INPUT_LOOP
    AND AX, 000FH
    
   
    MOV CX, AX
    
    
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX
    MOV AH, 1
    INT 21H
    JMP DIGITINPUT
    
    END_INPUT_LOOP:
    CMP ISNEG,0
    JE RETURN
    
    NEG BX
    
    
    CALL NEWLINE
    RETURN:
    RET
    
INPUT ENDP
    
    ;GIVE OUTPUT 
OUTPUT PROC  
    XOR BL, BL
                        
    CMP CX, 0 
            
    JG OUTPUT1
    JE PRINTZERO
    
    NEG CX         
    
    MOV AH, 2
    MOV DL, '-'
    INT 21H           
    JMP OUTPUT1
    
    PRINTZERO:               
    MOV AH, 2
    MOV DL, '0'
    INT 21H
          
    OUTPUT1:
    CMP CX, 0
    JE BREAK_OUTPUT1 
    
    XOR DX, DX      
    MOV AX, CX     
    MOV CX, 10      
    DIV CX          
    
    MOV CX, AX      
    ADD DX, '0'     
    PUSH DX
    INC BL          
    
    JMP OUTPUT1
    
    
            
    
    
    BREAK_OUTPUT1:
    SUB BL, 1        
    JL PRINTED
    
    POP DX           
    MOV AH, 2
    INT 21H          
    
    JMP BREAK_OUTPUT1       
    
    
    PRINTED:    
    CALL NEWLINE
    RET
    
    
OUTPUT ENDP 

