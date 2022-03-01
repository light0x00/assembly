; 复制 0:0~0:15 的数据到 cs:0 cs:f
; 利用栈来作为缓冲: 
; 1. push [src]  
; 2. pop [dst]
assume cs:codesg

codesg segment

dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h  ; cs:0 ~ cs:fh
dw 0,0,0,0,0,0,0,0,0,0  ; cs:10h ~ cs:23h
code: 
	; stack
	mov ax,cs
	mov ss,ax
	mov sp,24h
	; src 
	mov ax,0
	mov ds,ax
	; dst
	mov bx,0

	mov cx,8

	c:
	push [bx]
	pop cs:[bx]
	add bx,2
	loop c

	mov ax,4c00h
	int 21h

codesg ends
end code