; This file is part of "pongos"
; Under the MIT License
; Copyright (c) 2022 Antonin Hérault

%include "vga.inc"

screen:
    ; rcx   : offset
    ; rdx   : character to write
    ; r8    : color
        global .write_char
    .write_char:
        mov [VGA_ADDRESS], rdx
        mov [VGA_ADDRESS + 1], r8
        ret

        global .clear
    .clear:
        ret

