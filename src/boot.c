// bootloader.c
void main() {
    char *video_memory = (char *) 0xb8000;  // VGA memory
    const char *message = "Hello, World!";
    
    // Print the message to the screen
    for (int i = 0; message[i] != '\0'; ++i) {
        video_memory[i * 2] = message[i];    // Character
        video_memory[i * 2 + 1] = 0x07;       // Attribute (light grey on black background)
    }

    // Infinite loop to keep the bootloader running
    while (1);
}
