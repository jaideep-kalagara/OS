# Default target
all: bootloader/out/bootloader.bin

# Compile stage 1
bootloader/out/boot.bin: bootloader/boot.asm
	mkdir -p bootloader/out
	nasm -f bin bootloader/boot.asm -o bootloader/out/boot.bin

# Compile stage 2
bootloader/out/stage_2.bin: bootloader/stage_2.asm
	mkdir -p bootloader/out
	nasm -f bin bootloader/stage_2.asm -o bootloader/out/stage_2.bin

# Link stage 1 and stage 2 into final bootloader
bootloader/out/bootloader.bin: bootloader/out/boot.bin bootloader/out/stage_2.bin
	cat bootloader/out/boot.bin bootloader/out/stage_2.bin > bootloader/out/bootloader.bin

# Run with QEMU
bootloader-qemu: bootloader/out/bootloader.bin
	qemu-system-x86_64 -fda bootloader/out/bootloader.bin

# Clean build artifacts
clean:
	rm -rf bootloader/out
