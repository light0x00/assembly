; 使用多个段
; 实现 数据反转(P127的升级版)
assume cs:code  ; 后两者没有作用

data segment
dw 0,1,2,3,4,5,6,7 	;ds:10h ~ ds:1f
data ends

stack segment
dw 0,0,0,0,0,0,0,0   ; ds:20h ~ ds:2fh
dw 0,0,0,0,0,0,0,0   ; ds:30h ~ ds:3fh
stack ends

code segment
s:
	; words need reverse
	mov ax,data
	mov ds,ax
	; stack as buffer
	mov ax,stack
	mov ss,ax
	mov sp,20h

	mov bx,0
	mov cx,8
	c:
		push [bx]
		add bx,2
	loop c

	mov bx,0
	mov cx,8
	c1:
		pop [bx]
		add bx,2
	loop c1

	mov ax,4c00h
	int 21h	
code ends

end s  ; 设置ip指向 cs:0