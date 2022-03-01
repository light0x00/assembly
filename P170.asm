; 需求: 100002 / 100 
assume cs:codesg
datasg segment
	dd 100002
	dw 100
	dw 0
datasg ends

codesg segment
start:
	; 186A2h 分别放在dx、ax
	mov ax,datasg
	mov ds,ax

	; 被除数是双字(4字节),高16位放ax,低16位放dx
	mov ax,ds:[0]
	mov dx,ds:[2]

	; 由于被除数是32位, 因此除数应该作为16位(只有这样,CPU才会分别去AX、DX取被除数)
	div word ptr ds:[4]

	; 商在AX, 余数在DX
	mov ds:[6],ax

	mov ax,4c00h
	int 21h
codesg ends

end start