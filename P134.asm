assume cs:code

data segment
	dw 123H,0456H
data ends

stack segment
	dw 0,0
stack ends

code segment
	s:
	mov ax,stack
	mov ss,ax
	mov sp,10h

	mov ax,data
	mov ds,ax
	
	push ds:[0]
	push ds:[2]
	pop ds:[2]
	pop ds:[0]

	mov ax,4c00h
	int 21h
code ends
end s