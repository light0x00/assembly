; copy data from 0:0~0:f to cs:0~cs:f
assume cs:codesg

codesg segment
	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h  ; cs:0 ~ cs:fh
	code:
		mov ax,0
		mov ds,ax

		mov bx,0
		c:
		; ds:[bx] => cs:[bx]
		mov ax,[bx] 	
		mov cs:[bx],ax
		add bx,2
		loop c

		mov ax,4c00h
		int 21h		

codesg ends
end code