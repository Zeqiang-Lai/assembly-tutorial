; implementation of subprogram using stack(call and ret).
;
; Using Linux and gcc:
; nasm -f elf subprogram_stack.asm
; gcc -o subprogram_stack subprogram_stack.o driver.c asm_io.o -m32

%include "asm_io.inc"

segment .text
    global  asm_main
asm_main:
    enter 0, 0      
    
    ;main code
    xor eax, eax    ; initialize eax
    mov edx, 10     ; initialize edx
    call double
    call print_int
    ;#########

    pusha
    popa
    mov eax, 0            ; return back to C
    leave                     
    ret

double:
    add eax, edx
    add eax, edx
    ret
    