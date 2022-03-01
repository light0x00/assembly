; 需求: 寻址 2000h:0 之后第一个非0字节
assume cs:code
code segment 
	mov ax,2000h
	mov ds,ax
	mov bx,0
	mov cx,-1
	no:
	inc bx
	mov cl,[bx]
	; if cx == 0
	; 	jmp no
	jcxz no

	ok:
	dec bx
	mov dx,bx

	mov ax,4c00h
	int 21h
code ends
end