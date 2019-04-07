; ******************
; A sample program
; ******************
ORG 0x0000

; Make sure the data segment is pointing
; to the same location as code segment
mov ax, cs
mov ds, ax

mov al, 1
add ax, 0x66

mov si, succ_msg
call print_chars


hlt
%include "io.asm"
succ_msg: db "Program loaded successfully", 0x0
