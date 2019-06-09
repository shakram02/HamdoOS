ENTRY(main) /* Set main to be the entry point of the program */

PHDRS
{
    headers PT_PHDR FILEHDR PHDRS AT(0x500);
    /*
    FLAGS:
    E: 0x1
    W: 0x2
    R: 0x4
    The values are put as decimal
    e.g. FLAGS (0x3) is equivalent to WE
    */
    code PT_LOAD FILEHDR FLAGS (0x1 | 0x4);
}

SECTIONS
{
    /*
     This command combines all .text sections from all object files with
     *(.text) syntax into a final .text section. The * is the
     wildcard which matches any file name
    */
    . = 0x10000;
    .text : { *(.text) } : code

    . = 0x8000000;
    .data : { *(.data) }
    .bss : { *(.bss) }
    /DISCARD/ : { *(.eh_frame) }
}