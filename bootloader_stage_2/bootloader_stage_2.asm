ORG 0x500
SECTION .text
jmp init

init:
    mov si, msg
    call print_string
    hlt

%include "../asm_utils/io.asm"

SECTION .data
    msg: db "Loading OS...", 0x0D, 0x0A, 0x0
    times 512 - ($-$$) db 0x0