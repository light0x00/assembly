; 需求: 将数据段的两个字符串分别转换为大写、小写
; 实现: 使用 [bx+xx] 的方式寻址
assume cs:codesg

datasg segment
	db 'BaSuC'	
	db 'MinIX'	
datasg ends

codesg segment
start:
	mov ax,datasg
	mov ds,ax
	mov cx,5
	mov bx,0
	l:
	mov al,[bx]
	and al,11011111b	; 第6位变0 即可转为大写
	mov [bx],al

	mov al,[bx+5]
	or al,00100000b		; 第6位变1 即可转为小写
	mov [bx+5],al	
	
	inc bx
	loop l

	mov ax,4c00h
	int 21h
codesg ends
end start