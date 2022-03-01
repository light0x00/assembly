; 需求: 统计数据段中的等于8的字节数量
assume cs:code

data segment
	db 8,11,8,1,8,5,63,38
data ends

code segment
	start:	
		mov ax,data
		mov ds,ax

		mov di,0	; 字节偏移
		mov bx,0	; 统计次数
		mov cx,8	; 循环次数

		c:
			cmp byte ptr [di],8
			jne next		
			inc bx	;如果当前字节!=8 则此指令被跳过
			next:
			inc di
		loop c

		mov ax,4c00h
		int 21h
code ends

end start