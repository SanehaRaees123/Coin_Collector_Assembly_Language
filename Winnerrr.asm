INCLUDE Coin_Procedure.inc

.code
Winner_Display PROC,
            var1:BYTE , var2:BYTE , var4:PTR BYTE, var5:PTR BYTE
  mov al,var1
  cmp al,var2
  ja p1w
  jb p2w
  XY_COUT 21,46,"BOTH PLAYERS HAVE SAME SCORE ."
  jmp endwin
    p1w:
       XY_COUT 19,37, "* * * * * * WINNER * * * * * *"
	   NEW_LINE
	   WRITE_STRING_NO 21,51,var4        ;name of 1st player
   jmp endwin
   p2w:
       XY_COUT 19,37, "* * * * * * WINNER * * * * * *"
	   NEW_LINE
	   WRITE_STRING_NO 21,49,var5         ;name of 2nd player
   endwin:
  ret
Winner_Display ENDP
END