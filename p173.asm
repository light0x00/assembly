assume cs:codesg

datasg segment
	db '1995','1976','1977','1978'	; 年份 0~15
	dd 10,15,21,100002	; 收入	16~31
	dw 2,5,10,100	; 人数  32~39
datasg ends

table segment
	db 4 dup ('xxxx xxxx xx xx ')  ; 年 收入 人数 平均收入
table ends

codesg segment
start:
	mov ax,datasg
	mov ds,ax
	mov bx,0	; 年份索引
	mov si,16	; 收入索引
	mov di,32	; 人数索引

	mov ax,table
	mov ss,ax
	mov bp,0
	
	mov cx,4
	c:
		; 年份(4b)
		mov ax,[bx]
		mov [bp],ax
		mov ax,[bx+2]
		mov [bp+2],ax
		add bx,4
		add bp,4

		; 空格(1b)
		add bp,1 

		; 收入(4b)
		mov ax,[si]
		mov [bp],ax
		mov ax,[si+2]
		mov [bp+2],ax
		add si,4
		add bp,4
		
		; 空格(1b)
		add bp,1 

		; 雇员数
		mov ax,[di]
		mov [bp],ax
		add di,2
		add bp,2

		; 空格(1b)
		add bp,1 

		; 人均收入(2b)
		; 收入为4字节,作为被除数,应将高16位放至DX,低16位放至AX
		mov dx,[si-2]
		mov ax,[si-4]
		div word ptr [di-2]
		mov [bp],ax
		add bp,2

		; 空格(1b)
		add bp,1 

	loop c

	mov ax,4c00h
	int 21h
codesg ends

end start