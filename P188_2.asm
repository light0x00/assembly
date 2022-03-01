; 需求: 显示 Hello World
; 实现: 写入数据到 显存(B8000H ~ BFFFFH)
assume cs:codesg

datasg segment
	db 'welcome to masm!'
datasg ends

codesg segment
	
	start:
	mov ax,0B800H
	mov es,ax

	mov ax,datasg
	mov ds,ax

	; 第一行
	mov bx,0
	mov bp,1760		; 输出到第12行
	mov cx,16
	c0:
		mov al,[bx]
		mov es:[bp+64],al	; ascii
		mov byte ptr es:[bp+65],2	; 属性
		add bp,2
		inc bx
	loop c0

	; 第二行
	mov bx,0
	mov bp,1920		; 输出到第11行
	mov cx,16
	c1:
		mov al,[bx]
		mov es:[bp+64],al	; ascii
		mov byte ptr es:[bp+65],24h	; 属性
		add bp,2
		inc bx
	loop c1

	; 第三行
	mov bx,0
	mov bp,2080		; 输出到第11行
	mov cx,16
	c2:
		mov al,[bx]
		mov es:[bp+64],al	; ascii
		mov byte ptr es:[bp+65],71H	; 属性 
		add bp,2
		inc bx
	loop c2

	mov ax,4c00h
	int 21h
codesg ends

end start