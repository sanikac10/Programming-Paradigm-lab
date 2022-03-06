//
//  8086.s
//  Assemly
//
//  Created by sanika chavan on 16/05/21.
//
section .data
hello   db  "The answer is %d", 0x0a, 0x00

section .text
;default rel

global _main
extern _printf, _exit

_main:
    push ebp
    mov ebp, esp          ; Set up stack frame
    mov eax, 40
    mov ebx, 2255
    add ebx, eax
    sub esp, 8            ; 16-byte align stack + room for parameters passed
                          ; to functions we call

    mov dword[esp+4], ebx ; Second parameter at esp+4
    mov dword[esp], hello ; First parameter at esp+0
    call _printf

    xor eax, eax          ; Return value = 0
    mov esp, ebp
    pop ebp               ; Remove stack frame
    ret                   ; We linked with C library that calls _main
                          ; after initialization. We can do a RET to
                          ; return back to the C runtime code that will
                          ; exit the program and return the value in EAX
                          ; We can do this instead of calling _exit
