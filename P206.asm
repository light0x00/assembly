; 需求: 实现一个工具函数 可在指定行列 输出指定样式的字符串
assume cs:codesg

datasg segment
	db 'Welcome to masm!',0
datasg ends

stack segment
	db 16 dup (0)
stack ends

codesg segment
	start:
	mov ax,datasg
	mov ds,ax

	mov ax,stack
	mov ss,ax
	mov sp,10h

	mov si,0 ; 字符串开始位置
	mov dh,10	; 行
	mov dl,30	; 列
	mov cl,2	; 颜色

	call show_str

	mov ax,4c00h
	int 21h

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
		l:
		mov cl,[si]
		jcxz ok
		mov es:[di],cl
		mov byte ptr es:[di+1],al
		inc si
		add di,2
		jmp l
		
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