# Using objdump to examine the address 0x10000
objdump -z -M intel -S -D main.elf | less