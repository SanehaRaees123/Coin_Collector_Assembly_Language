INCLUDE Coin_Procedure.inc

.code
Draw_Score PROC,
              var1:PTR BYTE , var2:PTR BYTE ,  var3:PTR BYTE , var4:BYTE
	 WRITE_STRING_NO var4,85,var1
	 WRITE_STRING_NO var4,95,var2
	 add var4,1
	 WRITE_STRING_NO var4,95,var3
	 WRITE_CHAR ":" 
	 ret
Draw_Score ENDP
END