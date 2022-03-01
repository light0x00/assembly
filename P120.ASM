assume cs:code
code segment
   mov ax,0ffffh
   mov ds,ax

   mov ax,20h
   mov es,ax

   mov bx,0
   mov cx,6

   c: mov ax,[bx]
   mov es:[bx],ax
   inc bx
   inc bx
   loop c

   mov ax,4c00h
   int 21h
code ends
end
