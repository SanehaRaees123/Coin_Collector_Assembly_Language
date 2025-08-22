INCLUDE Coin_Procedure.inc

.code
Draw_Border PROC,
               var1:PTR BYTE
   NEW_LINE
   NEW_LINE
   WRITE_STRING_NO 3,0,var1          ;GROUND DISPLAY
   mov ecx,27
   mov bl,3
    lD:
	   WRITE_CHAR_XY bl,0,'*'
	   WRITE_CHAR_XY bl,74,'*'
       inc bl
	loop lD
	WRITE_STRING_NO 29,0,var1          ;GROUND DISPLAY
	ret
Draw_Border ENDP
END