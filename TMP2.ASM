assume cs:code
code segment
   
	; stack range: 20h:0 ~ 20h:f
	mov ax,20h
	mov ss,ax
	mov sp,10h
	
	mov bx,0f0f0h

	push bl
	pop cx

	mov ax,4c00h
	int 21h
code ends
end
