; cal the sum of mem unit between ffff:0 ~ ffff:b
assume cs:code

code segment
   mov ax,0ffffh
   mov ds,ax

   mov dx,0  ;sum
   mov bx,0  ;index
   mov cx,12 ;loop count
   mov ax,0  ;store byte from mem
   c: mov al,ds:[bx]
   add dx,ax
   inc bx
   loop c

   mov ax,4c00h
   int 21h
code ends
end
