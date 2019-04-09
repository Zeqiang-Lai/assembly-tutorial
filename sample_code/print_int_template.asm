; Using Linux and gcc:
; nasm -f elf print_int_template.asm
; gcc -o print_int_template print_int_template.o driver.c asm_io.o -m32

%include "asm_io.inc"

segment .data
input1 dw 10

segment .text
        global  asm_main
asm_main:
    enter   0,0               ; setup routine
    pusha

    mov     eax, [input1]
    call    print_int 
    
    popa
    mov     eax, 0            ; return back to C
    leave                     
    ret