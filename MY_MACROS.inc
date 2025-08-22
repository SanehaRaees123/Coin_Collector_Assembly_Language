INCLUDE IRVINE32.INC

 SETCOLOR MACRO
    MOV EAX, BLACK+(BLUE*11)		                         
	CALL SETTEXTCOLOR
 ENDM

 NEW_LINE MACRO
    CALL CRLF
 ENDM

 GOTO_XY MACRO X,Y
     MOV DH,X
     MOV DL,Y
     CALL GOTOXY
 ENDM

 READ_STRING MACRO STR
    MOV EDX , STR
    CALL READSTRING
 ENDM

 WRITE_STRING MACRO X,Y,STR
     GOTO_XY X,Y
    MOV EDX,OFFSET STR
    CALL WRITESTRING
 ENDM

  WRITE_STRING_NO MACRO X,Y,STR
     GOTO_XY X,Y
    MOV EDX,STR
    CALL WRITESTRING
 ENDM

XY_COUT MACRO X,Y,text
     LOCAL string     
.data
     string BYTE text,0 
.code
     GOTO_XY X,Y
       push edx
       mov edx,OFFSET string
       call WriteString
pop edx
ENDM

XY_COUTINT MACRO X,Y,S
   GOTO_XY X,Y
     push eax
     mov al,S
     CALL WRITEINT
pop eax
ENDM

COUTINT MACRO S
     push eax
     mov al,S
     CALL WRITEINT
pop eax
ENDM

CHAR_CIN MACRO INPUT
    call ReadChar
    mov INPUT,al
ENDM

 WRITE_CHAR MACRO CHAR_1
    MOV AL,CHAR_1
    CALL WRITECHAR
 ENDM

 WRITE_CHAR_XY MACRO X,Y,CHAR_1
    GOTO_XY X,Y
    MOV AL,CHAR_1
    CALL WRITECHAR
 ENDM