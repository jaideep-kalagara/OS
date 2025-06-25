


# compile bootloader
boot.asm: bootloader/boot.asm
	mkdir -p bootloader/out
	nasm -f bin bootloader/boot.asm -o bootloader/out/boot.bin


# bootloader qemu
bootloader-qemu:
	qemu-system-x86_64 -drive file=bootloader/out/boot.bin,format=raw