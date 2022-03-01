assume cs:code
code segment
   mov ax,0
   mov bx,236
   mov cx,123
   c: add ax,bx
   loop c

   mov ax,4c00h
   int 21h
code ends
end
