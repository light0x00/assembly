assume cs:d

a segment
	dw 1,2,3,4,5,6,7,8
a ends

b segment
	dw 1,2,3,4,5,6,7,8
b ends

c segment
	dw 0,0,0,0,0,0,0,0
c ends

d segment
	start:
	mov ax,a
	mov ds,ax
	
	mov ax,b
	mov es,ax

	mov ax,c
	mov ss,ax

	mov cx,8
	mov bx,0

	l:
	mov ax,ds:[bx]
	add ax,es:[bx]
	mov ss:[bx],ax
	add bx,2
	loop l

	mov ax,4c00h
	int 21h
d ends
end start