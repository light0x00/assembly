; 需求: 将字符串中的hello 首字母转为大写
assume cs:codesg

datasg segment
	db '1.hello'
	db '2.hello'
	db '3.hello'
	db '4.hello'
	db '5.hello'
datasg ends

codesg segment
start:
	mov ax,datasg
	mov ds,ax

	mov bx,2
	mov cx,5

	c:
	mov al,[bx]
	and al,11011111b
	mov [bx],al
	add bx,7
	loop c

	mov ax,4c00h
	int 21h
codesg ends

end start
