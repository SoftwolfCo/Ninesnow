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
