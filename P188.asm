; 需求: 显示 Hello World
; 实现: 写入数据到 显存(B8000H ~ BFFFFH)
; B7000 ~ B7
assume cs:codesg

datasg segment
	db 'hello,world!'
datasg ends

codesg segment
	
	start:
	mov ax,0B800H
	mov es,ax

	mov ax,datasg
	mov ds,ax

	mov bx,0
	; mov bp,0
	mov bp,1760

	mov cx,12
	c:
		mov al,[bx]
		mov es:[bp],al	; ascii
		mov byte ptr es:[bp+1],2	; 属性
		add bp,2
		inc bx
	loop c

	mov ax,4c00h
	int 21h
codesg ends

end start