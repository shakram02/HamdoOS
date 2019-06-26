; *********************
; bootloader.asm
; Simple bootloader
; *********************
bits 16                            ; 16-bit mode
                                   ; After loading the boot sector into memory the BIOS sets the IP register to 0x7C00 and sets the CS register to 0x0 (or just 0).
                                   ; Together this memory address looks like 0x0:0x7C00. https://web.archive.org/web/20130119004022/http://supernovah.com/Tutorials/BootSector2.php
org 0x7C00                         ; Starting address (set by the linker script)

; The trick is, if we specify a segment, even if it is 0x0, the jmp will be a far jump
; and the CS register will be loaded with the value 0x0 and the IP register will be loaded
; with the address of the next instruction to be executed.
jmp 0x0:init

load_stage_two:
    mov ah, 0x2                  ; Read sectors from drive [BIOS Interrupt]
    mov al, 0x5                  ; Read sectors from drive
    mov ch, 0x0                  ; Cylinder 0
    mov cl, 0x2                  ; Sector 2
    mov dl, 0x80                 ; Our disk image represents the first drive for QEMU (check out the Makefile) https://en.wikipedia.org/wiki/INT_13H
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
    mov dx, 0xF0

    call clear_background

    mov si, msg
    call print_string

    call load_stage_two
    jc print_fail                ; Jump if CF is set (error) ( return value from interrupt )

    jmp 0x500   ; Free memory range:  500 - 9FBFF (Load stage 2)

print_fail:
    mov si, fail_msg
    jmp print_string
    hlt

; When we reference our string we need the physical memory location that this string will exist at in memory.
; Our boot sector is loaded at the memory location 0x7C00 and our string appears directly after our instructions
; so our string won't be far after that.
; Nasm knows the offset of the start of our string based on the code and data it compiles before our string.
; Nasm then takes that offset and adds it to the address given to it by the ORG directive which is 0x7C00 in our
; case (where our boot sector is loaded into memory).
; Because of the ORG directive, Nasm knows exactly where to find our string in the physical memory during execution.
; https://web.archive.org/web/20130119003944/http://supernovah.com/Tutorials/BootSector3.php
msg: db "[STAGE1]: Welcome to HamdoOS!", 0x0A, 0x0D, 0x0
fail_msg: db "Failed to read disk", 0x0A, 0x0D, 0x0
bootloader_load_addr: equ 0x050

%include "../asm_utils/io.asm"

; The bootloader has to be 512 byets. Clear the rest of
; the bytes with 0
times 510 - ($-$$) db 0x0
dw 0xAA55                          ; Boot signature
