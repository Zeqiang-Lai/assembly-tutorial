; Using Linux and gcc:
; nasm -f elf template.asm
; gcc -o template template.o driver.c asm_io.o -m32

%include "asm_io.inc"

segment .text
        global  asm_main
asm_main:
    enter   0,0               ; setup routine
    pusha

    ;#### Put your code here ####

    ;############################
    
    popa
    mov     eax, 0            ; return back to C
    leave                     
    ret

; You can define any extra data you need.