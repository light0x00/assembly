; 需求: 将 datasg:0~datasg:fh 复制到 datasg:10h~datasg:1fh
; 实现: 利用si、di作为源和目的的偏移指针
assume cs:codesg

datasg segment
	db 'welcome to masm!'
	db '................'
datasg ends

codesg segment
start:
	mov ax,datasg
	mov ds,ax

	mov si,0
	mov di,10h

	mov cx,16
	l:
	mov al,[si]
	mov [di],al
	inc si 
	inc di
	loop l

	mov ax,4c00h
	int 21h
codesg ends

end start