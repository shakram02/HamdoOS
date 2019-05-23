ENTRY(main) /* Set main to be the entry point of the program */

PHDRS
{
    null PT_NULL;
    /*
    FLAGS:
    E: 0x001
    W: 0x010
    R: 0x100
    The values are put as decimal
    e.g. FLAGS (3) is equivalent to WE
    */
    code PT_LOAD FLAGS (5);
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
}