## 跳转指令

``` assembly
jmp short [offset]
```

- short 表示跳转的offset不会超过一个字节。
- offset为跳转地址与当前jmp地址的差值。
  - 跳转地址计算方法：**JMP**_Address **+ 2 +** Second_Byte_value **=** Next_Instruction_Address
- 可以往前跳，也可以往后，offset均不超过128。

参考资料

https://thestarman.pcministry.com/asm/2bytejumps.htm

