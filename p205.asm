; 需求: 解决过程调用时寄存器冲突问题
; 实现: 通过栈来保存外部过程的寄存器状态,当子过程返回时恢复28
assume cs:codesg

datasg segment
	db 'hello',0,'world'
datasg	ends

stack segment
	db 16 dup (0)
stack ends

codesg segment
start:
	mov ax,datasg
	mov ds,ax
	mov bx,0

	mov ax,stack
	mov ss,ax
	mov sp,10h

	mov cx,2
	l:
		call capital
		add bx,6
	loop l
	
	mov ax,4c00h
	int 21h

	capital:
		push cx
		push bx

		mov ch,0
		change: 
		mov cl,[bx]
		jcxz ok
		and byte ptr [bx],11011111b
		inc bx
		jmp change

	ok:	pop bx
		pop cx
	 	ret
codesg ends
end start