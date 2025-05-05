#include "common.h" /*Lo usamos solo para imprimir en pantalla*/

BEGIN
    .code16
    cli
    
    /* ENTRAMOS AL MODO PROTEGIDO*/
    
    /* Para entrar al modo protegido, es necesario configurar la tabla global de descriptores (GDT)*/
    .equ CODE_SEG, 8
    .equ DATA_SEG, gdt_data - gdt_start

    /* Le decimos al procesador donde esta la GDT en la memoria */
    lgdt gdt_descriptor

    /* Set PE (Protection Enable) bit in CR0 (Control Register 0),*/
    mov %cr0, %eax
    orl $0x1, %eax
        mov %eax, %cr0

    /* Saltamos a la sección de código de 32 bits*/
    ljmp $CODE_SEG, $protected_mode

    /*ACA YA ESTAMOS EN MODO PROTEGIDO, EL RESTO ES CONFIGURACIÓN DE SEGMENTO DE LA MEMORIA*/

    gdt_start:
    gdt_null:
        .long 0x0
        .long 0x0
    gdt_code:
        .word 0xffff
        .word 0x0
        .byte 0x0
        .byte 0b10011010
        .byte 0b11001111
        .byte 0x0
    gdt_data:
        .word 0xffff
        .word 0x0
        .byte 0x0
        .byte 0b10010010
        .byte 0b11001111
        .byte 0x0
    gdt_end:
    gdt_descriptor:
        .word gdt_end - gdt_start
        .long gdt_start
    vga_current_line:
        .long 0
    
    .code32
    protected_mode:
        /* Configuramos los otros segmentos*/
        mov $DATA_SEG, %ax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov %ax, %ss

        mov $0X7000, %ebp
        mov %ebp, %esp



        push %eax
        push %ebx
        push %ecx
        push %edx

        mov $message, %ecx
        mov vga_current_line, %eax
        mov $0, %edx

        mov $25, %ebx
        div %ebx
        mov %edx, %eax

        mov $160, %edx
        mul %edx
        /* 0xb8000 == VGA BUFFER */
        lea 0xb8000(%eax), %edx
        mov $0x0f, %ah

    loop:
        mov (%ecx), %al
        cmp $0, %al
        je end
        mov %ax, (%edx)
        add $1, %ecx
        add $2, %edx
        jmp loop
    end:
        incl vga_current_line

        pop %edx
        pop %ecx
        pop %ebx
        pop %eax

        jmp .

        /* Fin VGA_PRINT_STRING */
    message:
        .asciz "hello world, de parte de NullPointerException"