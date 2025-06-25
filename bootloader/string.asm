print_string:
	mov ah, 0x0E
	.loop:
		mov al, [bx]
		cmp al, 0x00
		je .end
		int 0x10
		inc bx
		jmp .loop
	.end:
		ret

print_char:
    mov ah, 0x0e
    int 0x10
    ret