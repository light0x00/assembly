assume cs:codesg,ss:stack

stack segment
	db 16 dup (0)
stack ends

codesg segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,16
	
	mov ax,0
	call s
	inc ax
	s:
	pop ax

	mov ax,4c00h
	int 21h
codesg ends

end start