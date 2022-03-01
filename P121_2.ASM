assume cs:code

code segment
   mov ax,20h
   mov ds,ax

   mov bx,0
   mov cx,64

   c: mov ds:[bx],bl
   inc bl
   loop c

   mov ax,4c00h
   int 21h

code ends
end
