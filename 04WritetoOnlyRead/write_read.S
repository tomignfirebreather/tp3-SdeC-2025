.code16
.global _start
_start:
    cli
    
    /* ENTRAMOS AL MODO PROTEGIDO*/

    /* Le decimos al procesador donde esta la GDT en la memoria */
    lgdt gdt_descriptor

    /* Set PE (Protection Enable) bit in CR0 (Control Register 0),*/
    mov %cr0, %eax
    orl $0x1, %eax
    mov %eax, %cr0

    /* Saltamos a la sección de código de 32 bits*/
    ljmp $0x08, $protected_mode

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
        .byte 0b10010000
        .byte 0b11001111
        .byte 0x0
    gdt_end:
    gdt_descriptor:
        .word gdt_end - gdt_start
        .long gdt_start

    .code32
    protected_mode:
        /* Configuramos los otros segmentos*/
        mov $0x10, %ax
        mov %ax, %ds
        mov %ax, %gs
        mov %ax, %ss

        movl $0x22222222, 0x00100000  /*0x00007c40 ocurre aca el general protection fault*/ 
