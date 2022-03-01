; 需求: 计算 data:0 ~ data:f 的每一个字节的3次幂
; 实现: bx存放参数 ax、dx存放mul指令的结果
assume cs:code

data segment
	dw 1,2,3,4,5,6,7,8	; 存放底数
	dd 0,0,0,0,0,0,0,0	; 存放幂
data ends

code segment
	start:
	mov ax,data
	mov ds,ax
	mov di,0
	mov si,10h
	mov cx,8

	c:
		mov bx,[di]	; bx存放入参
		call cube
		mov [si],ax	; 幂的低16位
		mov [si+2],dx	; 幂的高16位

		add di,2
		add si,4
	loop c

	mov ax,4c00h
	int 21h

	cube:
		mov ax,bx
		mul bx
		mul bx
		ret
code ends
end start