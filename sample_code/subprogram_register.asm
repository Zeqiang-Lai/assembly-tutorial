; implementation of subprogram using register.
;
; Using Linux and gcc:
; nasm -f elf subprogram_register.asm
; gcc -o subprogram_register subprogram_register.o driver.c asm_io.o -m32

%include "asm_io.inc"

segment .text
    global  asm_main
asm_main:
    enter 0, 0      
    
    ;main code
    xor eax, eax    ; initialize eax
    mov edx, 10     ; initialize edx
    mov ecx, ret1    ; set up return address
    jmp double
ret1: 
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
    jmp ecx
    