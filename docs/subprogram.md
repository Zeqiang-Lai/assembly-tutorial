# 子程序跳转

> A subprogram is an independent unit of code that can be used from different parts of a program.

最直接的子程序的实现方式是使用`jmp`指令。使用jmp可以跳到子程序的第一条指令开始执行，但是简单的跳过去，返回调用程序就会成为问题。

一个简单的解决方案是在返回位置设置一个`label`，然后在子函数结束位置跳回那个label。但是这种方案仍然存在问题。不同的调用函数调用同一个子函数时会有不同的返回地址，label不能hard code进子函数。

因此，返回地址必须能够通过某种方式传递给子函数。不同的传递方式造成了不同的调用子函数的方法，如

- 返回地址放在某个规定的**寄存器**中，如`ECX`。该寄存器在子程序执行过程中，不能被修改。
  - 返回地址还可以放在某个规定的**内存区域**中，这个与寄存器类似，不过这次寄存器放的是返回地址在内存中的地址。
- 返回地址放在**栈**中，这个是最常见的做法。

## 寄存器实现

以下代码实现了将`edx`翻倍并输出的程序。

```assembly
segment .text
    global  asm_main
asm_main:
    enter 0, 0      
    
    ;main code
    xor eax, eax    ; initialize eax
    mov edx, 10     ; initialize edx
    mov ecx, ret1    ; set up return address
    jmp short double
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
```

> 编译该代码需要依赖，请到assembly_tutorial_sample_code查看完整代码及其编译方法。

主要看`main code`部分，其他部分用于辅助输出，具体可以看附录print_int。

- `double`部分是我们的子程序，其功能可以用如下算式表示：`eax = eax+edx+edx`。

- 最后`jmp`回`ecx`指定的返回地址。

## 栈实现

栈的使用参见stack.md。

使用栈实现子程序调用需要用到两个命令：

1. `call`
2. `ret`

`call`先把返回地址（call的下一条指令地址）压入栈，然后无条件跳转到子程序的第一条指令位置。

`ret` 回pop出返回地址，然后返回该地址。

### call与ret的等价形式

call等价于如下指令



ret等级于如下指令



事实上，call和ret可以不用共同存在，可以有call没ret，但是这时需要用ret的等价指令返回调用程序。

### 例子

用`call`和`ret`改写寄存器实现中的例子，如下所示：

```assembly
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
```

## 调用规范

当调用程序和被调用程序需要传递参数时，二者必须定义一个规范，它们将通过这个规范来放参数和取参数。

当混合高级语言与汇编语言的时候（互相调用），我们也需要定义规范。

这个规范因汇编器，语言的不同各有差异。下面介绍一种较为通用的规范。

### 通过栈传递参数



### 通过栈存储局部变量

