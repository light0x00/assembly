assume cs:code
code segment
  mov ax,2
  mov cx,11
  c: add ax,ax
  loop c

  mov ax,4c00h
  int 21h
code ends
end
