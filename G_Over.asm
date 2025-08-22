INCLUDE Coin_Procedure.inc

.code
Game_Over PROC,
                var1:BYTE , var2:BYTE 
   mov bl,var1
   cmp bl,74
   je over
   mov bl,var1
   cmp bl,0
   je over
   mov bl,var2
   cmp bl,3
   jbe over
   mov bl,var2
   cmp bl,28
   ja over
   jmp quite
	over:
	   mov eax,8
    quite:
   ret
Game_Over ENDP
END