void print(const char* str) {
    while (*str) {
        asm volatile (
            "mov ah, 0x0E \n"    // BIOS teletype function
            "mov al, %[character] \n"
            "int 0x10"
            :
            : [character] "r"(*str)
        );
        str++;
    }
}

void wait_for_key() {
    asm volatile (
        "mov ah, 0x00 \n"
        "int 0x16"                // BIOS interrupt to wait for a keypress
    );
}

void c_main() {
    print("It works! Press any key to continue...");
    wait_for_key();
}
