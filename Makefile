# This file is part of "pongos"
# Under the MIT License
# Copyright (c) 2022 Antonin Hérault

ASM = nasm
LINKER = ld

IMG = build/pongos.img
BUILD_DIR = build/out
BOOT_OBJ = $(BUILD_DIR)/boot.o

SYSTEM_SRC = $(shell find src/system/ -name '*.asm')
SYSTEM_OBJ = $(patsubst src/system/%.asm, $(BUILD_DIR)/%.o, $(SYSTEM_SRC))
SYSTEM_OUT = $(BUILD_DIR)/system


_init :
	mkdir -p build/ $(BUILD_DIR)

build : _init $(IMG)

run : build
	qemu-system-x86_64 -boot a -drive file=$(IMG),format=raw

clean :
	rm -rf build/

# Link system object files to one at address 0x1000
# Generate a runnable os image
$(IMG) : $(BOOT_OBJ) $(SYSTEM_OUT)
	cat $^ /dev/zero | dd of=$@ bs=512 count=2880

$(SYSTEM_OUT) : $(SYSTEM_OBJ)
	$(LINKER) --oformat binary -Ttext 1000 -o $@ $^

# Create the bootloader
$(BOOT_OBJ) : src/boot/boot.asm
	$(ASM) -I src/boot/ -o $@ $<

# Assemble system files to object files
$(BUILD_DIR)/%.o : src/system/%.asm
	$(ASM) -I inc/ -f elf64 -o $@ $<
