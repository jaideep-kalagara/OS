[org 0x7e00]
[bits 16]

%include "bootloader/gdt.asm"

cli
lgdt [GDT_descriptor]
mov eax, cr0
or eax, 1
mov cr0, eax

; Must be a far jump to load new CS and switch modes
jmp 0x08:start_protected_mode

[bits 32]
start_protected_mode:
    ; Load data segment registers
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Output 'A' to screen in white
    mov dword [0xb8000], 0x0f004100

hang:
    jmp hang
