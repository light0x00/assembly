; 需求: 寻址 200h:0 之后第一个为0的字节
assume cs:code
code segment 
	mov ax,200h
	mov ds,ax
	mov bx,0
	mov cx,0
	no:
	mov cl,[bx]
	; if cx == 0  
	;	jmp ok
	; else
	; 	inc bx
	;	jmp short no
	jcxz ok
		inc bx
		jmp short no
	ok:
		mov dx,bx

	mov ax,4c00h
	int 21h
code ends
end