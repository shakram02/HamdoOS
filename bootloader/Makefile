BUILD_DIR=../build/bootloader
SHELL := /bin/bash

BOOTLOADER_SRCS := $(wildcard *.asm)
BOOTLOADER_OBJS := $(patsubst %.asm, $(BUILD_DIR)/%.o, $(BOOTLOADER_SRCS))

all: $(BOOTLOADER_OBJS)

# nasm -f bin $< -o $@	;$@ is a special variable that refers to the output of the recipe: %.o.
$(BUILD_DIR)/%.o: %.asm
	nasm -f elf $< -F dwarf -g -o $@.temp
	$(TARGET)-ld -m elf_i386 -T bootloader.ld $@.temp -o $@.elf
	$(TARGET)-objcopy -O binary $(BUILD_DIR)/bootloader.o.elf $@

clean:
	rm $(BUILD_DIR)/*
