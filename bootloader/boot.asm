[org 0x7c00] 
mov [BOOT_DISK], dl

STAGE_2_LOC equ 0x7e00

; setting up the stack
xor ax, ax                          
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

mov bx, STAGE_2_LOC

; clear screen
mov ah, 0x00
mov al, 0x03
int 0x10

; reading the disk
mov ah, 2
mov al, 1
mov ch, 0
mov dh, 0
mov cl, 2
mov dl, [BOOT_DISK]
int 0x13
jc disk_read_error
cmp ah, 0
jne disk_read_error

mov bx, DISK_SUCCESS_MSG
call print_string

; printing what is in the next sector
mov al, [STAGE_2_LOC]
call print_char
jmp $

disk_read_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

BOOT_DISK: db 0
DISK_ERROR_MSG: db "Disk read failed! Restart system to try again.", 0x0A, 0xD, 0
DISK_SUCCESS_MSG: db "Disk read successful! Continuing with boot...", 0x0A, 0xD, 0

%include "bootloader/string.asm"

; magic padding

times 510-($-$$) db 0              
dw 0xaa55

; filling the second sector ( the one that will be readed ) with 'A's

times 512 db 'A'