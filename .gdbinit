set disassembly-flavor intel
set architecture i8086
layout asm
layout reg
target remote localhost:26000
b *0x7c00
