ENTRY(init);

SECTIONS
{
    . = 0x7c00;
    .text : { *(.text) }
}