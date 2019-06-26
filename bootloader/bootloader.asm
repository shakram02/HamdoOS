; *********************
; bootloader.asm
; Simple bootloader
; *********************
bits 16                          ; 16-bit mode
; After loading the boot sector into memory the BIOS sets the IP register to 0x7C00 and sets the CS register to 0x0 (or just 0).
; Together this memory address looks like 0x0:0x7C00. https://web.archive.org/web/20130119004022/http://supernovah.com/Tutorials/BootSector2.php
org 0x7C00              ; Starting address (set by the linker script)

; The trick is, if we specify a segment, even if it is 0x0, the jmp will be a far jump 
; and the CS register will be loaded with the value 0x0 and the IP register will be loaded 
; with the address of the next instruction to be executed. 
jmp 0x0:init

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
                                 ; start the stack right before the bootloader (stack grows downwards)
                                 ; https://wiki.osdev.org/My_Bootloader_Does_Not_Work

    ; Setup the stack to be at 0x70000:C00
    ; the stack grows downwards
    mov ax, 0x7000
    mov ss, ax
    mov sp, 0xC00

    mov si, msg
    call print_string

    ; http://3zanders.co.uk/2017/10/16/writing-a-bootloader2/
    ; mov ax, 0x2401
    ; int 0x15 ; enable A20 bit
    
    ; mov ax, 0x3
    ; int 0x10 ; set vga text mode 3

    call load_os
    jc print_fail                ; Jump if CF is set (error) ( return value from interrupt )

    jmp 0x500   ; Free memory range:  500 - 9FBFF

print_fail:
    mov si, fail_msg
    jmp print_string
    hlt

msg: db "[STAGE1]: Welcome to HamdoOS!", 0x0D, 0x0A, 0x0
fail_msg: db 0x0,"Failed to read disk", 0x0D, 0x10, 0x0
bootloader_load_addr: equ 0x050

%include "../asm_utils/io.asm"

; The bootloader has to be 512 byets. Clear the rest of
; the bytes with 0
times 510 - ($-$$) db 0x0
dw 0xAA55                        ; Boot signature
