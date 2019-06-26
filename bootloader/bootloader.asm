; *********************
; bootloader.asm
; Simple bootloader
; *********************
bits 16                          ; 16-bit mode
org 0x7C00              ; Starting address (set by the linker script)

mov ax, 0
mov ss, ax
mov sp, $

jmp init

load_os:
    mov ah, 0x2                  ; Read sectors from drive [BIOS Interrupt]
    mov al, 0x5                  ; Read sectors from drive
    mov ch, 0x0                  ; Cylinder 0
    mov cl, 0x2                  ; Sector 2
    mov dh, 0x0                  ; Head 0

    mov bx, bootloader_load_addr ; The address is calculated as: 16 * ES + BX
    mov es, bx
    xor bx, bx
    int 0x13                     ; call BIOS
    ret                          ; You can only be guaranteed that your bootloader will be loaded and run from physical address 0x00007c00
                                 ; and that the boot drive number is loaded into the DL register.
                                 ; https://stackoverflow.com/questions/34178717/load-segment-from-floppy-with-int13h


init:
    cli                          ; Disable interrupts
    cld                          ; Set the direction flag to be positive direction
                                 ; call move_cursor

                                 ; start the stack right before the bootloader (stack grows downwards)
                                 ; https://wiki.osdev.org/My_Bootloader_Does_Not_Work


    mov si, msg
    call print_string

    ; http://3zanders.co.uk/2017/10/16/writing-a-bootloader2/
    ; mov ax, 0x2401
    ; int 0x15 ; enable A20 bit
    
    ; mov ax, 0x3
    ; int 0x10 ; set vga text mode 3

    call load_os
    jc print_fail                ; Jump if CF is set (error) ( return value from interrupt )

    jmp 0x500

print_fail:
    mov si, fail_msg
    jmp print_string
    hlt

msg: db "Welcome to HamdoOS!", 0x0D, 0x0A, 0x0
fail_msg: db 0x0,"Failed to read disk", 0x0D, 0x10, 0x0
bootloader_load_addr: equ 0x050

%include "../asm_utils/io.asm"

; The bootloader has to be 512 byets. Clear the rest of
; the bytes with 0
times 510 - ($-$$) db 0x0
dw 0xAA55                        ; Boot signature
