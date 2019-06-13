set disassembly-flavor intel
set architecture i8086
set history save on
set print pretty on
set pagination off
set confirm off
layout asm
layout reg
target remote localhost:26000
b *0x7c00
b *0x7c2f
b *0x600
add-symbol-file ./build/bootloader/bootloader.o.elf
add-symbol-file ./build/os/os