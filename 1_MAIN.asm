INCLUDE Coin_Procedure.inc

.data
c_cdisplay   BYTE  " ",0ah,0dh
     BYTE  "                 ____   ____               ____   ____               ____  _____   ____    ___       ",0ah,0dh
     BYTE  "                |      |    |  | |\  |    |      |    | |     |     |        |    |    |  |___|      ",0ah,0dh
     BYTE  "                |      |    |  | | \ |    |      |    | |     |     |----    |    |    |  | \         ",0ah,0dh
     BYTE  "                |____  |____|  | |  \|    |___   |____| |___  |____ |____    |    |____|  |  \        ",0
	 ground  BYTE "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *",0
score BYTE 0                   ;for vara
score2 BYTE 0                  ;for varb
n BYTE "Enter Name: ",0
p1 DWORD 20 DUP(?)             ;for vara
p2 DWORD 20 DUP(?)             ;for varb name
play1 BYTE " Player:1 ",0
play2 BYTE " Player:2 ",0
varb BYTE "B",0
xPos BYTE 10    ;for varb
yPos BYTE 15
vara BYTE "A",0
xPos2 BYTE 15    ;for vara
yPos2 BYTE 27
xCoinPos BYTE 5
yCoinPos BYTE 15
inputChar BYTE ?

.code
main PROC
	   
	SETCOLOR
	CALL CLRSCR

	WRITE_STRING 10,25,c_cdisplay                                ; DISPLAY COIN COLLECTOR 

	INVOKE Player_name,ADDR n,ADDR p1,ADDR play1,20               ; PLAYER:1 NAME
	INVOKE Player_name,ADDR n,ADDR p2,ADDR play2,22               ; PLAYER:2 NAME
	
	mov eax,1000                                             ; DELAY
	call DELAY

	 SETCOLOR     
	 CALL CLRSCR
     
	 NEW_LINE
	 XY_COUT 1,25,"----- COIN COLLECTOR ----- "
		
	
        INVOKE Draw_Border, ADDR ground                       ; PROCEDURE CALL TO DISPLAY BORDER
        INVOKE Draw_Score,ADDR play1,ADDR p1,ADDR vara,10          ; DRAW SCORE OF VARA
		INVOKE Draw_Score,ADDR play2,ADDR p2,ADDR varb,15        ; DRAW SCORE OF VARB
		
	INVOKE DrawPlayer , xPos  , yPos  , varb                 ; DRAW PLAYER VARB
	INVOKE DrawPlayer , xPos2 , yPos2 , vara                 ; DRAW PLAYER VARA
	call CreateRandomCoin                                    ; CREATE RANDOMCOIN                                        
	call Randomize
	mov ecx,00FFFFFFFh
gameLoop: 
        push ecx
		                         ;SCORE 
		XY_COUTINT 11,97,score
		XY_COUTINT 16,97,score2
        call CHECK 
        call CHECK2
		pop ecx
		loop gameloop
main ENDP

CreateRandomCoin PROC
	mov eax,70
	inc eax
	ljj:
	call RandomRange
	cmp al,1
	jbe ljj
	mov xCoinPos,al
	l1:
	mov eax,28
	call RandomRange
	cmp al,3
	jbe l1
	mov yCoinPos,al
	mov eax,yellow (black * 16) ;coin color set
	call SetTextColor
	 GOTO_XY yCoinPos,xCoinPos
	WRITE_CHAR 'O'
	ret
CreateRandomCoin ENDP

CHECK PROC
pushad
	  onGround:
		CHAR_CIN inputChar
		cmp inputChar,"6"
		je exitGame

		cmp inputChar,"i"
		jne d1
		    INVOKE UpdatePlayer,xPos , yPos 
			dec yPos
			INVOKE  DrawPlayer,xPos , yPos , varb
			jmp S_DISPLAY
		d1:
		cmp inputChar,"m"
		jne d2
		   INVOKE UpdatePlayer,xPos , yPos 
		   inc yPos
		   INVOKE  DrawPlayer,xPos , yPos , varb
		   jmp S_DISPLAY
        d2:
		cmp inputChar,"j"
		jne d3
		    INVOKE UpdatePlayer,xPos , yPos 
		    dec xPos
		    INVOKE  DrawPlayer,xPos , yPos , varb
			jmp S_DISPLAY
		d3:
		cmp inputChar,"l"
		jne d4
		    INVOKE UpdatePlayer,xPos , yPos
		    inc xPos
		    INVOKE  DrawPlayer,xPos , yPos , varb
			jmp S_DISPLAY
		d4:
		cmp inputChar,"w"
		jne d5
		    INVOKE UpdatePlayer,xPos2 , yPos2
			dec yPos2
			INVOKE  DrawPlayer,xPos2 , yPos2 , vara
			jmp S_DISPLAY
		d5:
		cmp inputChar,"z"
		jne d6
		    INVOKE UpdatePlayer,xPos2 , yPos2
	     	inc yPos2
	    	INVOKE  DrawPlayer,xPos2 , yPos2 , vara
			jmp S_DISPLAY
		d6:
		cmp inputChar,"a"
		jne d7
		   	INVOKE UpdatePlayer,xPos2 , yPos2
	     	dec xPos2
		    INVOKE  DrawPlayer,xPos2 , yPos2 , vara
			jmp S_DISPLAY
		d7:
		cmp inputChar,"d"
		jne onGround
		    INVOKE UpdatePlayer,xPos2 , yPos2
		    inc xPos2
		    INVOKE  DrawPlayer,xPos2 , yPos2 , vara
			jmp S_DISPLAY
S_DISPLAY:
popad
ret
CHECK ENDP
CHECK2 PROC
  cmp score, 15
    ja gameoverj
    cmp score2, 15
    ja gameoverj
    INVOKE Game_Over,xPos , yPos                             ; GAMEOVER PROCEDURE VARB
   	cmp eax,8
   	je gameoverj 
   	INVOKE Game_Over,xPos2 , yPos2                           ; GAMEOVER PROCEDURE VARA    
	cmp eax,8
	je gameoverj
		                                
    INVOKE coin_Collect,xPos,xCoinPos,yPos,yCoinPos          ; COIN COLLECT OR NOT FOR VARB
	cmp eax,1
	jne b4                                                        ; RETURN EAX DECIDE SCORE INCREMENT OR NOT
	inc score2
	jmp b3

	 b4:
		INVOKE coin_Collect,xPos2,xCoinPos,yPos2,yCoinPos   ; COIN COLLECT OR NOT FOR VARB
		cmp eax,1                                                 ; RETURN EAX DECIDE SCORE INCREMENT OR NOT
		jne notcollecting
		inc score

	 b3:
		call CreateRandomCoin                                ; COLLECT COIN ,SCORE INCREMENT, GENERATE NEW COIN

    notCollecting:
		SETCOLOR    
		jmp gameLoop2
		;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    gameoverj:
	    call clrscr
	   SETCOLOR
	    call clrscr                                              ; CLEAR-SCREEN
	call crlf
	call crlf

	WRITE_STRING 2,15,c_cdisplay                                ; DISPLAY COIN COLLECTOR 
	

	call crlf

	
		WRITE_STRING 8,18,ground
	INVOKE score_dwin , ADDR play1 , ADDR p1 , ADDR vara , score,38
	INVOKE score_dwin , ADDR play2 , ADDR p2 , ADDR varb , score2,58
	INVOKE Winner_Display ,score,score2,ADDR p1,ADDR p2


	
	 GOTO_XY 26,25
	mov eax, 1000
	call delay
	exitgame::
	exit
	gameLoop2:
	ret
	CHECK2 ENDP
END main