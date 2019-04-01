; *********************
; bootloader.asm
; Simple bootloader
; *********************
org 0x7C00 ; Starting address after PROC finishes
bits 16    ; 16-bit mode

jmp init

%include "io.asm"

init:
    cli    ; Disable interrupts
    mov si, msg
    call move_cursor
    call print_char
    hlt

msg: db "Welcome to Ovizivo Operating System!", 0x0, 0x0

; The bootloader has to be 512 byets. Clear the rest of
; the bytes with 0
times 510 - ($-$$) db 0
dw 0xAA55  ; Boot signature
