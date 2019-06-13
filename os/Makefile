BUILD_DIR=../build/os
OS=$(BUILD_DIR)/os
SHELL := /bin/bash

CFLAGS+=-ffreestanding -nostdlib -gdwarf-4 -m32 -ggdb3

OS_SRCS := $(wildcard *.c)
OS_OBJS := $(patsubst %.c, $(BUILD_DIR)/%.o, $(OS_SRCS))

all: $(OS)


$(BUILD_DIR)/%.o: %.c
	$(TARGET)-gcc -c $< -o $@

$(OS): $(OS_OBJS)
	$(TARGET)-ld -m elf_i386 --nmagic -T os.ld $(OS_OBJS) -o $@

clean:
	rm $(BUILD_DIR)/*