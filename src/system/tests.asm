; This file is part of "pongos"
; Under the MIT License
; Copyright (c) 2022 Antonin Hérault

tests:
    ; Write "Hi" in grey-on-black on top of the screen
        global .vga
    .vga:
        mov dword [0xB8000], 0x07690748
