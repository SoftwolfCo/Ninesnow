global loader                  ; the entry symbol for ELF
extern kmain

    global outb             ; make the label outb visible outside this file

    ; outb - send a byte to an I/O port
    ; stack: [esp + 8] the data byte
    ;        [esp + 4] the I/O port
    ;        [esp    ] return address
    outb:
        mov al, [esp + 8]    ; move the data to be sent into the al register
        mov dx, [esp + 4]    ; move the address of the I/O port into the dx register
        out dx, al           ; send the data to the I/O port
        ret                  ; return to the calling function

MAGIC_NUMBER    equ 0x1BADB002      ; define the magic number constant
ALIGN_MODULES   equ 0x00000001      ; tell GRUB to align modules
FLAGS        equ 0x0           ; multiboot flags
CHECKSUM        equ -(MAGIC_NUMBER + ALIGN_MODULES)

section .text:                      ; start of the text (code) section
    align 4                             ; the code must be 4 byte aligned
        dd MAGIC_NUMBER                 ; write the magic number
        dd ALIGN_MODULES                ; write the align modules instruction
        dd CHECKSUM                     ; write the checksum


;; Reserve memory for kernel stack
KERNEL_STACK_SIZE equ 4096     ; size of stack in bytes

section .bss
align 4                        ; align at 4 bytes
kernel_stack:                  ; label points to beginning of memory
    resb KERNEL_STACK_SIZE     ; reserve stack for the kernel

section .text:                 ; start of the text (code) section
align 4                        ; the code must be 4 byte aligned
dd MAGIC_NUMBER                ; write the magic number to the machine code
dd FLAGS                       ; the flags,
dd CHECKSUM                    ; and the checksum

loader:                        ; the loader label (defined as entry point in linker script)
mov eax, 0xCAFEBABE            ; place the number 0xCAFEBABE in the register eax
mov esp, kernel_stack + KERNEL_STACK_SIZE   ; point esp to the start of the
                                            ; stack (end of memory area)
call kmain
.loop:
jmp .loop                      ; loop forever
