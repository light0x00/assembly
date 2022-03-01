assume cs:codesg

datasg segment
	db '1975','1976','1977','1995'	; 年份 0~15
	dd 16,22,382,5937000	; 收入	16~31
	dw 5,3,42,333	; 人数  32~39

	dtocdw_buf db 10 dup (' '),0	; 32位数字最多10个字符
	cell_buf db 20 dup (' '),0
	
datasg ends

table segment
	db 4 dup ('xxxx xxxx xx xx ')  ; 年 收入 人数 平均收入
table ends

stack segment
	dw 16 dup (0)
stack ends

codesg segment
	start:
		mov ax,datasg
		mov ds,ax
		mov bx,0

		mov ax,stack
		mov ss,ax
		mov sp,32
		
		; 1.年份(4b)
		mov si,offset cell_buf 
		mov cl,2	; 输出样式
		mov dh,10	; 输出行
		mov dl,0	; 输出列
		mov cx,4
		col1:
			mov ax,[bx]
			mov [si],ax
			mov ax,[bx+2]
			mov [si+2],ax

			push cx
			mov cx,2
			call show_str 
			pop cx

			add bx,4
			inc dh
		loop col1

		; 2.收入(4b)
		mov si,offset dtocdw_buf
		mov dh,10	; 输出行
		mov dl,20	; 输出列
		mov cx,4
		col2:
			; 2.1 转为10进制ascii
			push dx
			mov ax,[bx]
			mov dx,[bx+2]
			call dtocdw
			pop dx
			; 2.2 显示			
			push cx
			mov cx,2	; 输出样式
			call show_str 
			pop cx
			add bx,4
			inc dh
		loop col2

		; 3. 雇员数(2b)
		mov si,offset dtocdw_buf
		mov dh,10	; 输出行
		mov dl,60	; 输出列
		mov cx,4
		col3:
			; 3.1 转为10进制ascii
			push dx
			mov ax,[bx]
			mov dx,0
			call dtocdw
			pop dx
			; 3.2 显示			
			push cx
			mov cx,2	; 输出样式
			call show_str 
			pop cx
			add bx,2
			inc dh
		loop col3

		; 4. 平均(2b)
		mov dh,10	; 输出行
		mov dl,40	; 输出列
		mov cx,4
		mov bx,4*4	; 总收入偏移
		mov di,4*4+4*4	; 人数偏移
		col4:
			push cx
			push dx
			; 4.1. 计算平均值
			mov ax,[bx]
			mov dx,[bx+2]
			mov cx,[di]
			div cx
			; 4.2. 平均值转为10进制ascii
			mov dx,0 ; 丢弃余数
			call dtocdw
			pop dx	
			; 4.3 显示	
			push si
			mov si,offset dtocdw_buf	; 要输出的字符串的位置
			mov cx,2	; 输出样式
			call show_str 
			pop si
			add bx,4
			add di,2
			inc dh
			pop cx
		loop col4
	
	mov ax,4c00h
	int 21h
	
 	; 将32位数字(由「DX AX」构成)转换为ascii码,并写入到指定区域
	; 入参:	DX AX
	; 返回: ds:[dtocdw_buf]
	dtocdw:
		push di
		push cx
		push ax
		push dx

		; 用0作为结尾标志(避免调用多次 被上一次影响)
		mov di,0
		push di
		inc di
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
			mov di,offset dtocdw_buf
			reverse:
				pop ax
				mov [di],al
				inc di
			loop reverse

			pop dx
			pop ax
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
codesg ends

end start