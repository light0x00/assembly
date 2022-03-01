; 需求: 更改每个单词的后5个字母
; 实现: 嵌套循环

assume cs:codesg

datasg segment
	db 'hello,world'
	db 'hello,world'
	db 'hello,world'
datasg ends

stacksg segment
	dw 0
stacksg ends

codesg segment
start:
	; 数据段
	mov ax,datasg
	mov ds,ax
	; 栈段
	mov ax,stacksg
	mov ss,ax
	mov sp,10h

	; 外层循环
	mov bx,6	; 当前行的开始位置
	mov cx,3	; 共3行,循环3次
	c:
		push cx	; 保存外层循环状态

		; 内层循环
		mov cx,5	; 需修改5个字节,内层循环5次
		mov di,0	; 相对于bx的偏移量(记录处理到的字节位置)
		c2:
		mov al,[bx+di]
		and al,11011111b 
		mov [bx+di],al
		inc di
		loop c2

		add bx,11	; 移动到下一行的开始位置
		pop cx	;
	loop c

	mov ax,4c00h
	int 21h

codesg ends

end start
