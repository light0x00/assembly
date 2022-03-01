; 需求: 将 datasg:0~datasg:fh 复制到 datasg:10h~datasg:1fh
; 实现: 利用si作为偏移指针, 源位 si+0 , 目的位 si+10h
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

	mov cx,16
	l:
	mov al,[si]
	mov [si+10h],al
	inc si 
	loop l

	mov ax,4c00h
	int 21h
codesg ends

end start