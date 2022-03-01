; 需求: 将一个32位数字转换为10进制ascii码并显示到屏幕上
assume cs:code

data segment
	digit dd 5
	char db 10 dup (' ')	; 32位数字最多10个字符
	db 0
data ends

stack segment
	dw 16 dup (0)
stack ends

code segment
	main:
		mov ax,data
		mov ds,ax
		mov bx,0

		mov ax,stack
		mov ss,ax
		mov sp,32

		; 转为10进制ascii
		mov ax,ds:[bx+ offset digit]
		mov dx,ds:[bx+ offset digit + 2]
		call dtoc
		; 将10进制ascii输出到显存
		mov si,offset char
		mov dh,13
		mov dl,0
		mov cl,2
		call show_str

		mov ax,4c00h
		int 21h

	; 将32位数字(由「DX AX」构成)转换为ascii码,并写入到指定区域
	; 入参:	DX AX
	; 返回: ds:[char]
	dtoc:
		push di
		push cx

		mov di,0
		mov cx,10
		div16:
			; 除16
			call divdw
			; 余数+30H写入ascii
			add cl,30H
			; mov [di],cl	
			push cx
			inc di
			; 检查 (dx ax)是否为0, 如果是则停止除16, 否则继续
			mov cx,ax
			jcxz lzero 	; 如果低16位为0
			mov cx,10
			jmp div16
		lzero: 
			mov cx,dx
			jcxz hzero	; 如果高16位为为0
			jmp div16
		hzero: 
			mov cx,di
			mov di,offset char
			reverse:
				pop ax
				mov [di],al
				inc di
			loop reverse
			
			pop cx
			pop di
			ret
	
	; 32位除法
	; 参数:
		; 被除数:  DX AX
		; 除数: CX
	; 返回:
		; 商: DX AX
		; 余数: CX
	divdw:
		push bx

		; H/N
		mov bx,ax	; 暂存L
		mov ax,dx
		mov dx,0
		div cx
		push ax	; 暂存int(H/N)
		; ( rem(H/N)*10000H + L ) / N
		mov ax,bx
		div cx
		mov cx,dx	; 余数放到 CX
		pop dx	; int(H/N)放到DX

		pop bx
		ret

	; 在指定的位置用指定的样式打印 ds:si 开始的字符串
	; dh 行	0~24
	; dl 列		0~79
	; cl 颜色
	; si 开始位置
	show_str:
		push ax
		push bx
		push cx
		push dx
		push es	; 显存段地址
		push si	; 字符索引
		push di	; 输出显存索引

		mov ax,0B800H
		mov es,ax
		; 显存中的输出开始地址: 	(行-1)*160+列*2 => (dh-1)*160+dl*2
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

code ends
end main