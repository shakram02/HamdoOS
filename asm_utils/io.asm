; *********************
; io.asm
; I/O related routines
; *********************
bits 16          ; 16-bit mode

move_cursor:
    ; Move the cursor to a specified position to write
    mov DH, 0x0F
    mov DL, 0x0A
    mov ah, 0x02
    int 0x10
    ret

print_string:
    ; Prints a string to the screen, character by character
    lodsb
    cmp al, 0x0
    je .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
    .done ret
