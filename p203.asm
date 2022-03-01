assume cs:code

data segment
	db 'conversation',0
data ends

code segment
	start:
	mov ax,data
	mov ds,ax
	mov bx,0
	call capital

	mov ax,4c00h
	int 21h

	capital:
		mov cl,[bx]
		mov ch,0
		jcxz ok
		and byte ptr [bx],11011111b
		inc bx
		jmp capital
		ok: ret
code ends
end start