; 需求: 使用过程调用+栈传参数 实现 (a+b)^c
assume cs:codesg
data segment
	db 'result:xx',0
data ends
stack segment
	dw 16 dup (0)
stack ends

codesg segment
	start:
	mov ax,stack
	mov ss,ax
	mov sp,32

	mov ax,data
	mov ds,ax

	; 装填入参
	mov ax,3
	push ax	; a
	mov ax,7
	push ax	; b
	mov ax,2
	push ax	; c

	call calc

	mov ds:[7],ax
	mov dh,10
	mov dl,30
	mov cl,2
	mov si,0

	call show_str

	mov ax,4c00h
	int 21h

	calc:
		push bp
		mov bp,sp
		; 取出入参执行计算
		mov ax,[bp+8]
		add ax,[bp+6]
		mov cx,[bp+4]
		dec cx
		mov dx,0
		l:
			mul ax
		loop l
		pop bp
		ret 6
	
	; 在指定的位置用指定的样式打印 ds:si 开始的字符串
	; dh 行	0~24
	; dl 列		0~79
	; cl 颜色
	; si 开始位置
	show_str:
		; 1. 确定输出位置
		; 2. 输出
		push ax
		push bx
		push cx
		push dx
		push es	; 显存段地址
		push si	; 字符索引
		push di	; 输出显存索引

		mov ax,0B800H
		mov es,ax

		; 显存中的输出开始地址: 	(dh-1)*160+dl*2
		; 计算行偏移 结果放入di
		sub dh,1
		mov al,dh
		mov bl,160
		mul bl
		mov di,ax
		; 计算列偏移 结果放入ax
		mov al,dl
		mov bl,2
		mul bl
		; 计算总偏移 结果放入di
		add di,ax

		mov al,cl		
		mov ch,0
		l1:
		mov cl,[si]
		jcxz ok
		mov es:[di],cl
		mov byte ptr es:[di+1],al
		inc si
		add di,2
		jmp l1
		
		ok:
		pop di	; 输出显存索引
		pop si	; 字符索引
		pop es	; 显存段地址
		pop dx
		pop cx
		pop bx
		pop ax

		ret
codesg ends
end start