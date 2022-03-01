; 需求: 实现 32位/16位=32位

assume cs:codesg

stack segment
	dw 16 dup (0)
stack ends

codesg segment

start:
	mov ax,stack
	mov ss,ax
	mov sp,32

	mov dx,0FH
	mov ax,4240H
	mov cx,0AH
	call divdw

	mov ax,4c00h
	int 21h
; - 参数
; 	- 被除数,dx视为高16位,ax存放低16位
; 	- 除数,cx
; - 结果
; 	- 商,dx存放高16位,ax存放低16位
; 	- 余数,cx
divdw:
	; 问题分析:
	; (高16位/除数)*10000h + ((低16位+高余数*10000H)/除数)

	mov bp,sp
	sub sp,4
	; 保存 L
	mov [bp-2],ax

	; =======高16位=======
	; H/N
	mov ax,dx
	mov dx,0
	div cx	
	mov [bp-4],ax	; 保存 int(H/N)
	; =======低16位=======
	; [ rem(H/N) * 10000h + L ] / N
	mov ax,[bp-2]
	div cx
	mov cx,dx	; 余数放到CX
	mov dx,[bp-4]	; 高16位放到DX
	
	add sp,4
	ret

codesg ends

end start
