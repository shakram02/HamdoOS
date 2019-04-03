; *********************
; bootloader.asm
; Simple bootloader
; *********************
bits 16                 ; 16-bit mode
org 0x7C00              ; Starting address after PROC finishes

jmp init



; read_disk:
; mov ch, 0x0
; mov cl, 0x2
; mov dh, 0x0
; mov ah, 0x02


init:
    cli                 ; Disable interrupts
    cld                 ; Set the direction flag to be positive direction
                        ; call move_cursor
    mov si, msg
    call print_chars

    mov ah, 0x2         ; Read sectors from drive [BIOS Interrupt]
    mov al, 0x2         ; Read 2 sectors from drive
    mov ch, 0x0         ; Cylinder 0
    mov cl, 0x2         ; Sector 2
    mov dh, 0x0         ; Head 0

    mov bx, 0x0500
    mov es, bx          ; ES = 0x500
    xor bx, bx          ; Clear BX
    int 0x13            ; call BIOS
                        ; You can only be guaranteed that your bootloader will be loaded and run from physical address 0x00007c00
                        ; and that the boot drive number is loaded into the DL register.
                        ; https://stackoverflow.com/questions/34178717/load-segment-from-floppy-with-int13h

    jc print_fail       ; Jump if CF is set (error)

    jmp 0x0500:0x0        ; jump and execute the code

print_fail:
    mov si, fail_msg
    jmp print_chars
    hlt

    ; TODO: print a single char

msg: db "Welcome to Ovizivo Operating System!", 0x0
fail_msg: db "Failed to read disk", 0x0

%include "io.asm"

; The bootloader has to be 512 byets. Clear the rest of
; the bytes with 0
times 510 - ($-$$) db 0x0
dw 0xAA55               ; Boot signature
