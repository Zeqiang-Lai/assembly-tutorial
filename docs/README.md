# 汇编语言简易教程

编译链接指令：

```shell
nasm -f elf [input].asm
ld -m elf_i386 -s -o [output] [input].o
```

如果用C做驱动程序的话（参见附录）

```shell
nasm -f elf input.asm
gcc -o output input.o driver.c asm_io.o -m32
```

查看编译后的机器码是一个很好的学习方法，指令如下：

```
objdump -s -d -M intel input.o/executable
```

