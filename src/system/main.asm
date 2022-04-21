; This file is part of "pongos"
; Under the MIT License
; Copyright (c) 2022 Antonin Hérault

; Entry start of the system core
; Loaded at 0x1000
    global _start
_start:
    call main
    jmp _start

%include "screen.inc"
%include "tests.inc"

; Main function called by `_start` 
main:
    ; call tests.vga
    
    mov rdx, 0
    mov rdx, 'B'
    mov r8, 0x02
    call screen.write_char

    ret
