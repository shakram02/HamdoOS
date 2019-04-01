; *********************
; bootloader.asm
; Simple bootloader
; *********************
org 0x7C00 ; Starting address after PROC finishes
bits 16    ; 16-bit mode

jmp init

; %include "io.asm"

; start:
; jmp boot


; printMsg:
; mov BP, msg
; call Print
; ret

init:
    cli    ; Disable interrupts
    mov si, msg
    call mov_cursor
    call print_char

    mov dl, 0x00
    mov al, 0x40

    .print_alphabet:
    add al, 0x01
    mov ah, 0x0E
    int 0x10
    cmp al, 'Z'
    jne .print_alphabet

    hlt

print_char:
    lodsb
    cmp al, 0x0
    je .done
    mov ah, 0x0E
    int 0x10
    jmp print_char
    .done ret

mov_cursor:
    ; Move the cursor to a specified position to write
    ; mov BH, 0x00
    mov DH, 0x0F
    mov DL, 0x0A
    mov ah, 0x02
    int 0x10
    ret

    ; boot:
    ; cli
    ; cld ; clear direction flag

    ; hlt ; halt the system

    ; The bootloader has to be 512 byets. Clear the rest of
    ; the bytes with 0

msg: db "Welcome to Ovizo Operating System!", 0x0, 0x0

times 510 - ($-$$) db 0
dw 0xAA55  ; Boot signature
