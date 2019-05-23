ENTRY(main) /* Set main to be the entry point of the program */
SECTIONS
{
    /*
     This command combines all .text sections from all object files with
     *(.text) syntax into a final .text section. The * is the
     wildcard which matches any file name
    */
    . = 0x10000;
    .text : { *(.text) }

    . = 0x8000000;
    .data : { *(.data) }
    .bss : { *(.bss) }
}