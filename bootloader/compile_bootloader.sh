set -e # Exit on error

echo "Compiling assembly file..."
nasm -f bin bootloader.asm -o bootloader

echo "Making disk image..."
dd if=/dev/zero of=disk.img bs=512 count=2880

echo "Writing bootloader to the 1st sector of the drive..."

# The option conv=notrunc preserves the original size of the floppy disk.
# Without this option, the 1.4 MB disk image will be completely replaced
# by the new disk.img with only 512 bytes
dd conv=notrunc if=bootloader of=disk.img bs=512 count=1 seek=0
