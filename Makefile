BUILD_DIR=build
BOOTLOADER=$(BUILD_DIR)/bootloader/bootloader.o
BOOTLOADER_STAGE_2=$(BUILD_DIR)/bootloader_stage_2/bootloader_stage_2.o
OS=$(BUILD_DIR)/os/os
DISK_IMG=disk.img

all: bootdisk

.PHONY: bootdisk bootloader bootloader_stage_2 #os

bootloader:
	make -B -C bootloader

bootloader_stage_2:
	make -B -C bootloader_stage_2

os:
	make -B -C os

bootdisk: bootloader bootloader_stage_2 #os
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	dd conv=notrunc if=$(BOOTLOADER) of=$(DISK_IMG) bs=512 count=1 seek=0
	dd conv=notrunc if=$(BOOTLOADER_STAGE_2) of=$(DISK_IMG) bs=512 count=$$(($(shell stat --printf="%s" $(BOOTLOADER_STAGE_2))/512)) seek=1
	# dd conv=notrunc if=$(OS) of=$(DISK_IMG) bs=512 count=$$(($(shell stat --printf="%s" $(OS))/512)) seek=$(STAGE2_SIZE)

qemu: bootdisk	# Depend on bootdisk task, so everytime the whole thing is compiled
	# qemu-system-i386 -machine q35 -fda disk.img -gdb tcp::26000 -S
	qemu-system-i386 -machine q35 -drive file=disk.img,format=raw -gdb tcp::26000 -S
clean:
	make -C os clean
	make -C bootloader clean
