assume cs:code

code segment
	mov ax,200h
	mov ds,ax

	mov bx,0
	s:
		mov cl,[bx]
		mov ch,0
		inc cx	; 因为loop会现将cx-1再判断是否为0, 所以这里先cx+1, 当ds:[bx]的值为0时,cx+1值为1, 之后loop时cx-1=0所以会停止循环.
		inc bx
	loop s

	dec bx
	mov dx,bx

	mov ax,4c00h
	int 21h

code ends

end