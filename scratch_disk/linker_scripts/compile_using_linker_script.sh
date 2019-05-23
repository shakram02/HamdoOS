gcc -m32 -g -c main.c

# -m Specify object file format that ld produces. In the example, elf_i386 means a 32-bit ELF is to be produced.
ld -m elf_i386 -o main.elf -T main.lds main.o