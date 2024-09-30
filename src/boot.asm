bits 16
section .text
global _start
extern c_main

_start:
    cli                     ; Disable interrupts
    xor ax, ax              ; Set up segment registers
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00          ; Stack pointer

    call c_main             ; Call the C main function

    jmp $                   ; Infinite loop to halt execution after return

times 510-($-$$) db 0       ; Pad to 512 bytes
dw 0xAA55                   ; Boot signature
