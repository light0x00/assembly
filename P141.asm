; 需求: 将数据段的两个字符串分别转换为大写、小写
; 实现: 利用 and、or 反转指定位  
assume cs:codesg

datasg segment
	db 'BaSiC'
	db 'iNfOrMaTiOn'
datasg ends

codesg segment
	s: 
	mov ax,datasg
	mov ds,ax
	; 小写转大写
	mov cx,5
	mov bx,0
	l:
	mov al,[bx]
	and al,0DFh		; 11011111 , 第6位变0
	mov [bx],al
	inc bx
	loop l
	; 大写转小写
	mov cx,11
	l1:
	mov al,[bx]
	or al,20h	; 00100000 , 第6位变1
	mov [bx],al
	inc bx
	loop l1

	mov ax,4c00h
	int 21h
codesg ends

end s