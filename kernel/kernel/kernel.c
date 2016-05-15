#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include <stdio.h>

#include <kernel/tty.h>

void kernel_early(void)
{
	terminal_initialize();
}

void kernel_main(void)
{
	printf("Hello, kernel World!\n");
        printf("This is just a simple test of the kernal!\n");
        printf("If you can see this, you have built and ran ninesnow!\n");
        
}

void update_cursor(int row, int col)
{
        unsigned short position=(row*80) + col;
 
        // cursor LOW port to vga INDEX register
        outb(0x3D4, 0x0F);
        outb(0x3D5, (unsigned char)(position&0xFF));
        // cursor HIGH port to vga INDEX register
        outb(0x3D4, 0x0E);
        outb(0x3D5, (unsigned char )((position>>8)&0xFF));
}
