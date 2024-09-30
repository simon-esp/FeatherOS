; boot.asm
org 0x7C00            ; BIOS loads the bootloader at memory address 0x7C00
bits 16

done:
    jmp start
    
start:
    mov ah, 0x0E        ; BIOS teletype function (prints characters)
    mov bx, varName     ; Load address of string into BX

print_loop:
    mov al, [bx]        ; Load the next character from the string
    cmp al, 0           ; Check if it’s the null terminator
    je done             ; If yes, exit the loop
    int 0x10            ; Call BIOS interrupt to print the character
    inc bx              ; Move to the next character
    jmp print_loop      ; Repeat the loop

get_char:
    int 0x16

jmp $               ; Infinite loop to halt execution

varName:
    db "it works! \n is literal, because its printed character by character", 0    ; String to print with null terminator

times 510-($-$$) db 0   ; Pad the boot sector to 512 bytes
dw 0xAA55               ; Boot sector signature (must be 0xAA55)
