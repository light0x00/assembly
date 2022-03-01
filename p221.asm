; 需求: 128位加法运算

assume cs:code

data segment
	; 1E F000 1000
	
	num1 dw 1000H
	dw 0F000H
	dw 1EH
	dw 0,0,0,0,0

	; 20 1000 1EF0
	num2 dw 1EF0H
	dw 1000H
	dw 20H
	dw 0,0,0,0,0
data ends

code segment
	start:
		mov ax,data
		mov ds,ax
		mov di,offset num1
		mov si,offset num2

		call add128
		call sub128

		mov ax,4c00h
		int 21h
	; 功能: 128位数字加法
	; 参数: ds:[di] 操作数1  ds:[si] 操作数2
	; 返回: ds:[di]
	add128:
		push di
		push si
		push ax
		push cx

		sub ax,ax	; 为了使 CF=0

		mov cx,8
		addc:
			mov ax,[di]
			adc ax,[si]
			mov [di],ax
			
			inc di
			inc di
			inc si
			inc si
		loop addc

		pop cx
		pop ax
		pop si
		pop di
		ret
	
	; 功能: 128位数字减法
	; 参数: ds:[di] 操作数1(被减数)  ds:[si] 操作数2(减数)
	; 返回: ds:[di]
	sub128:
		push di
		push si
		push ax
		push cx

		sub ax,ax	; 为了使 CF=0

		mov cx,8
		subc:
			mov ax,[di]
			sbb ax,[si]
			mov [di],ax

			inc di
			inc di
			inc si
			inc si			
		loop subc

		pop cx
		pop ax
		pop si
		pop di
		ret

code ends

end start