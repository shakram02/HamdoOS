BUILD_DIR=build
BOOTLOADER=$(BUILD_DIR)/bootloader/bootloader.o
OS=$(BUILD_DIR)/os/os
DISK_IMG=disk.img

all: bootdisk

.PHONY: bootdisk bootloader os

bootloader:
	make -B -C bootloader

os:
	make -B -C os

bootdisk: bootloader os
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	dd conv=notrunc if=$(BOOTLOADER) of=$(DISK_IMG) bs=512 count=1 seek=0
	dd conv=notrunc if=$(OS) of=$(DISK_IMG) bs=512 count=$$(($(shell stat --printf="%s" $(OS))/512)) seek=1

qemu: bootdisk	# Depend on bootdisk task, so everytime the whole thing is compiled
	# qemu-system-i386 -machine q35 -fda disk.img -gdb tcp::26000 -S
	qemu-system-i386 -machine q35 -drive file=disk.img,format=raw -gdb tcp::26000 -S
clean:
	make -C os clean
	make -C bootloader clean
