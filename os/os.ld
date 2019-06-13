ENTRY(main);


SECTIONS
{
    .text : ALIGN(0x100) { *(.text) } 
    .data : { *(.data) }
    .bss : { *(.bss) }
    /DISCARD/ : { *(.eh_frame) }
}
