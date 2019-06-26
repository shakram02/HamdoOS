; *********************
; io.asm
; I/O related routines
; *********************
bits 16 ; 16-bit mode

move_cursor:
    push ax
    push dx
    ; Move the cursor to a specified position to write
    mov dh, 0x0F
    mov dl, 0x0A
    mov ah, 0x02
    int 0x10
    pop dx
    pop ax
    ret

print_string:
    push ax
    mov ah, 0x0E
    
.print_loop:
    ; Loads a byte (starting from SI) into AL, 
    ; pointer is auto-incremented according to direction flag (DF)
    lodsb   
    ; Prints a string to the screen, character by character
    cmp al, 0x0
    je print_string.done

    int 0x10
    jmp print_string.print_loop

.done:
    pop ax
    ret
