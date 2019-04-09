# 附录

## print字符串的中断写法

以下程序功能为向控制台输出一个字符串`"Hello, world!"`。

```assembly
segment .data
msg db 'Hello, world!', 0xa  ;string to be printed
len equ $ - msg     ;length of the string

segment .text
    global _start

_start:
    mov	edx,len     ;message length
    mov	ecx,msg     ;message to write
    mov	ebx,1       ;file descriptor (stdout)
    mov	eax,4       ;system call number (sys_write)
    int	0x80        ;call kernel
	
    mov	eax,1       ;system call number (sys_exit)
    int	0x80        ;call kernel
```

### 数据定义

首先`.text`部分定义了两个变量：

- `msg`为待输出的字符串，`0xa`为ascii码的换行符。
- `len`为字符串的长度，`$`表示当前指令或变量的首地址。
  - `$ - msg`  相当于求出了前面那个字符串的长度。

`db` ， `equ` ，还有变量的定义参加 [TODO]。

### 系统调用

向屏幕输出的系统调用方法如下：

- 把字符串长度放在`edx`，equ定义的是常量，所以len是实际的值不是地址。
- 把字符串首地址放在`ecx`。
- 设置`ebx`为1，表示输出到`stdout`。
- 设置`eax`为4，表示引发的是`sys_write`系统调用。
- `int 0x80 `触发系统调用中断。

## print调用C的写法

