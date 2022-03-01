
assume cs:code

data segment
	db 0FFh,0,1,2
data ends

code segment
start:
	mov ax,data
	mov ds,ax

	; mov al,-128
	mov al,-2
	cmp al,1
	; -128 - 1  = 127
	ja e
	mov bx,1

	e: mov ax,4c00h
	int 21h
code ends
end start
