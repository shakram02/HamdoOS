; *********************
; io.asm
; I/O related routines
; *********************
bits 16            ; 16-bit mode

print_string:
    ; Prints a string at the specified location by DH and DL
    push cx
    push bx
    push es
    push ax
    mov ax, 0xB800 ; Text mode buffer
    mov bx, 0      ; Counter
    mov es, ax

.loop:
    ; Loads a byte (starting from SI) into AL,
    ; pointer is auto-incremented according to direction flag (DF)
    lodsb
    ; Prints a string to the screen, character by character
    cmp al, 0x0
    je print_string.done

    ; TODO: print to correct location
    ; cmp al, 0x0A
    ; je print_string.adjust_for_new_line

    mov [es:bx], al
    add bx,2

    jmp print_string.loop

.done:
    pop ax
    pop es
    pop bx
    pop cx
    ret

; .adjust_for_new_line:
; TODO: increment BX according to DH and DL
; add bx, screen_width
; jmp print_string.loop

clear_background:
    push cx
    push bx
    push es
    push ax
    mov ax, 0xB800 ; Text mode buffer
    mov es, ax
    mov cx, screen_width * screen_height -1
    mov bx, 1
    ; The attribute byte is split up like this: the lower four bits control the character color, the next three bits control the background color, and the last bit controls whether the character should blink or not (1 means blink, 0 means don't blink).
    ; FLASH-BG-BG-BG-FG-FG-FG-FG
    ; 8 --                  -- 0
.loop:
    cmp cx,bx
    je clear_background.done
    mov ax, [es:bx]
    and ax, 0x8F   ; clear background and flash
    or ax, 0x30
    and ax, 0xF0   ; black text
    mov [es:bx], ax
    add bx, 2      ; move to the next text attribute byte
    jmp clear_background.loop

    .done:
    pop ax
    pop es
    pop bx
    pop cx
    ret

screen_width: equ 320
screen_height: equ 200
; TODO: use those later to store row & col state
row: RESB 1
col: RESB 1