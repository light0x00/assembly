; 利用栈实现反转顺序
assume cs:codesg

codesg segment
   dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h  ; cs:0 ~ cs:fh
   dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0   ; cs:10h ~ cs:2fh   预留f个单元 不知道为啥

   code:
	  mov ax,cs
      mov ss,ax     ; ss = cs:00h
      mov sp,30h    ; sp = cs:30h

      mov cx,8		
      mov bx,0
      c0:
      push cs:[bx]
      add bx,2
      loop c0

      mov cx,8
      mov bx,0
      c1:
      pop cs:[bx]
      add bx,2
      loop c1

      mov ax,4c00h
      int 21h
codesg ends
end code
