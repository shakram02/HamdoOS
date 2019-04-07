; *********************
; io.asm
; I/O related routines
; *********************
bits 16          ; 16-bit mode

; get_cursor:
;     ; Load information about the cursor, I'll use that with gdb to get info
;     mov BH, 0
;     mov AH, 0x03
;     int 0x10
; 	ret

move_cursor:
    ; Move the cursor to a specified position to write
    mov DH, 0x0F
    mov DL, 0x0A
    mov ah, 0x02
    int 0x10
    ret

print_chars:
    ; Prints a string to the screen, character by character
    lodsb
    cmp al, 0x0
    je .done
    mov ah, 0x0E
    int 0x10
    jmp print_chars
    .done ret

print_string:
    ; Prints a string from bp to the screen
    mov AL, 0x01 ; Update cursor after writing
    mov DH, 0x0F
    mov DL, 0x0F
    mov AH, 0x13 ; function 13 - write string
    int 0x10
	ret
