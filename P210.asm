; 16进制转换为10进制

assume cs:code

data segment
	db 16 dup (0)
data ends

code segment
	start:
		mov ax,data
		mov ds,ax

		mov ax,12666
		call htoc

		mov dh,15
		mov dl,30
		mov cl,2
		mov si,0
		call show_str

		mov ax,4c00h
		int 21h

	htoc:
		mov di,0
		mov bx,10
		c:
			mov dx,0
			div bx
			add dl,30H	; ascii
			mov [di],dl	; 写入ascii
			inc di
			mov cx,ax
			jcxz ok
			jmp c
		ok: 
			ret
	
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
		jcxz ok2
		mov es:[di],cl
		mov byte ptr es:[di+1],al
		inc si
		add di,2
		jmp l1
		
		ok2:
		pop di	; 输出显存索引
		pop si	; 字符索引
		pop es	; 显存段地址
		pop dx
		pop cx
		pop bx
		pop ax
		ret
code ends

end start