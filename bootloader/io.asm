; *********************
; io.asm
; I/O related routines
; *********************
bits 16          ; 16-bit mode

get_cursor:
    ; Load information about the cursor, I'll use that with gdb to get info
    mov BH, 0
    mov AH, 0x03
    int 0x10

move_cursor:
    ; Move the cursor to a specified position to write
    mov DH, 0x0F
    mov DL, 0x0A
    mov ah, 0x02
    int 0x10
    ret

print_char:
    ; Prints a string to the screen, character by character
    lodsb
    cmp al, 0x0
    je .done
    mov ah, 0x0E
    int 0x10
    jmp print_char
    .done ret

print_string:
    ; Prints a string to the screen
    mov AL, 0x01 ; Update cursor after writing
    mov DH, 0x10
    mov DL, 0x00
    mov AH, 0x13
    int 0x10
