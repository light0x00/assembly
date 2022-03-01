assume cs:code

code segment
   ; define word
   dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
   ; instruction
   start:
       mov ax,0
       mov bx,0
       mov cx,8
       c:
       add ax,cs:[bx]
       add bx,2
       loop c

       mov ax,4c00h
       int 21h
   
code ends
end start
