; 将数据区、堆栈区 从代码段分离
; 注: 本质上,分成多个段只是汇编程序给的语法糖, 
; assume cs:code,ds:data,ss:stack  ; 后两者没有作用
assume cs:code  ; 后两者没有作用

data segment
dw 0,1,2,3,4,5,6,7 	;ds:10h ~ ds:1f
data ends

stack segment
dw 0,1,2,3,4,5,6,7,8,9   ; ds:20h ~ ds:33h  注: ds:34 ~ ds:3f 将补0, 这是因为段寄存器只能是16的倍数, cs将指向ds:40h
stack ends

code segment
s:
	; src
	mov ax,0
	mov ds,ax
	; dst
	mov ax,data
	mov es,ax
	; stack as buffer
	mov ax,stack
	mov ss,ax
	mov sp,34h

	mov bx,0
	mov cx,8
	c:
		push [bx]
		pop es:[bx]
		add bx,2
	loop c

	mov ax,4c00h
	int 21h	
code ends

end s  ; 设置ip指向 cs:0