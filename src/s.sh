#!/bin/bash

# Set the output files
BOOTLOADER_O="bootloader.o"
BOOTLOADER_BIN="bootloader.bin"
FLOPPY_IMG="floppy.img"

# Remove previous output files if they exist
rm -f $BOOTLOADER_O $BOOTLOADER_BIN $FLOPPY_IMG

# Compile the bootloader
echo "Compiling bootloader.c..."
gcc -ffreestanding -c bootloader.c -o $BOOTLOADER_O
if [ $? -ne 0 ]; then
    echo "Error: Failed to compile bootloader.c"
    exit 1
fi

# Link the object file into a binary format
echo "Linking bootloader..."
ld -T linker.ld -o $BOOTLOADER_BIN $BOOTLOADER_O
if [ $? -ne 0 ]; then
    echo "Error: Failed to link bootloader"
    exit 1
fi

# Create a bootable floppy image
echo "Creating floppy image..."
dd if=/dev/zero of=$FLOPPY_IMG bs=512 count=2880
if [ $? -ne 0 ]; then
    echo "Error: Failed to create floppy image"
    exit 1
fi

dd if=$BOOTLOADER_BIN of=$FLOPPY_IMG conv=notrunc
if [ $? -ne 0 ]; then
    echo "Error: Failed to write bootloader to floppy image"
    exit 1
fi

# Run it with QEMU
echo "Running bootloader in QEMU..."
qemu-system-i386 -drive format=raw,file=$FLOPPY_IMG
