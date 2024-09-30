# setup.sh
nasm -f elf32 boot.asm -o boot_asm.o
i386-elf-gcc -m16 -ffreestanding -c boot.c -o boot.o
i386-elf-ld -Ttext 0x7C00 --oformat elf32-i386 -o boot.elf boot_asm.o boot.o
i386-elf-objcopy -O binary boot.elf boot.bin
qemu-system-x86_64 -drive format=raw,file=boot.bin
