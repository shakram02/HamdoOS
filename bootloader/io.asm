;*********************
; io.asm
; I/O related routines
;*********************
USE16

;SetGraphicsMode:
; The colorful mode with colors
;    mov AL, 0x13 ; 13h - graphical mode. 40x25. 256 colors. 320x200 pixels. 1 page
;    mov AH, 0x40
;    int 0x10

GetCursor:
; Load information about the cursor, I'll use that with gdb to get info
    mov BH, 0
    mov AH, 0x03
    int 0x10

mov_cursor:
; Move the cursor to a specified position to write
	mov BH, 0
	mov DH, 0x0F
	mov DL, 0x0F
	mov AH, 0x02
	int 0x10
	ret

;PutChar:
; Print a character at the designated position
;    mov AL, BL
;    mov BH, 0xAF    ; Set background color
;    mov CX, 0xF     ; Repeat 16 times
;    MISSING AH
;    int 0x10

Print:
; Prints a string to the screen
    mov AL, 0x01    ; Update cursor after writing
    mov DH, 0x10
    mov DL, 0x00
    mov AH, 0x13
    int 0x10
