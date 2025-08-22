INCLUDE Coin_Procedure.inc

.code
coin_Collect PROC,
             var1:BYTE , var2:BYTE ,  var3:BYTE , var4:BYTE 
   mov bl,var1
   cmp bl,var2
   jne b1
   mov bl,var3
   cmp bl,var4
   jne b1
   mov eax,1
   jmp b2
	b1:
	  mov eax,-1
	b2:
  ret
coin_Collect ENDP
END