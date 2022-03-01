assume cs:code

stack segment
	db 16 dup(0)
stack ends

code segment
	start:
		mov ax,stack
		mov ss,ax
		mov sp,16
		
		mov ax,0
		push ax
		popf
		mov ax,0fff0h
		add ax,0010h
		pushf
		pop ax
		and al,11000101B
		and ah,00001000B

		mov ax,4c00h
		int 21h
code ends
end start