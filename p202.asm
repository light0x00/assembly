; 需求: 使用过程调用方式小写转大写

assume cs:code

data segment
	db 'conversation'
data ends

code segment
	start:
	mov ax,data
	mov ds,ax
	mov cx,12	; 字符串长度
	mov bx,0	; 字符串起始位置
	call capital
	mov ax,4c00h
	int 21h

	capital:
		and byte ptr ds:[bx],11011111b
		inc bx
		loop capital
		ret	
code ends
end start