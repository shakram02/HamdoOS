;*********************
; bootloader.asm
; Simple bootloader
;*********************
org 0x7C00 ; Starting address after PROC finishes
bits 16; 16-bit mode

;%include "io.asm"

;start:
;    jmp boot


;printMsg:
;    mov BP, msg 
;    call Print
;    ret

init:
    cli
    mov si, msg
    mov ah, 0x0E

	.print_char	; This is a local label, used for jumpring
	lodsb                   
    cmp al, 0x0
    je done
    int 0x10
    jmp .print_char

done:
    hlt

;boot:
;    cli ; disable interrupts
;    cld ; clear direction flag
;    
;    hlt ; halt the system

; The bootloader has to be 512 byets. Clear the rest of
; the bytes with 0

msg: db "Welcome to Oviz Operating System!", 0x0, 0x0

times 510 - ($-$$) db 0
dw 0xAA55   ; Boot signature


; ;org 0x7C00                      ; BIOS loads our programm at this address
; ;bits 16                         ; We're working at 16-bit mode here

; start:
; 	cli                     ; Disable the interrupts
; 	mov si, msg             ; SI now points to our message
; 	mov ah, 0x0E            ; Indicate BIOS we're going to print chars
; .loop	lodsb                   ; Loads SI into AL and increments SI [next char]
; 	or al, al               ; Checks if the end of the string
; 	jz halt                 ; Jump to halt if the end
; 	int 0x10                ; Otherwise, call interrupt for printing the char
; 	jmp .loop               ; Next iteration of the loop

; halt:	hlt                     ; CPU command to halt the execution
; msg:	db "Hello, World!", 0   ; Our actual message to print

; ;; Magic numbers
; times 510 - ($ - $$) db 0
; dw 0xAA55

