GDT_Start:
    null_descriptor:
        dd 0
        dd 0

    code_descriptor:
        dw 0xFFFF       ; Segment limit low
        dw 0x0000       ; Base address low
        db 0x00         ; Base address middle
        db 0x9A         ; Access byte        (10011010b)
        db 0xCF         ; Flags + limit high (11001111b)
        db 0x00         ; Base address high

    data_descriptor:
        dw 0xFFFF
        dw 0x0000
        db 0x00
        db 0x92         ; 10010010b
        db 0xCF
        db 0x00
GDT_End:

GDT_descriptor:
    dw GDT_End - GDT_Start - 1  ; GDT size
    dd GDT_Start                ; GDT address

CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ data_descriptor - GDT_Start