assume cs:code

code segment
   mov ax,cs
   mov ds,ax  ; from
   mov ax,0020h
   mov es,ax  ; to

   mov bx,0
   mov cx,23   ; 23 bytes need transfer

   ; transfer byte
   s:
   mov al,[bx]
   mov es:[bx],al
   inc bx
   loop s

   mov ax,4c00h
   int 21h
code ends
end
