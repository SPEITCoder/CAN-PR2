OPENDLX=openDLX
MIPS_CC=mips-linux-gnu-gcc
MIPS_OBJCPY=mips-linux-gnu-objcopy

MIPS_CFLAGS=-g -Wall -O0 -fno-builtin -mips32 -EL -nostdlib -nostartfiles -static -Ttext 0x1000

.PHONY: all run clean

all: bin/insertion-sort.bin cfg/*.cfg

run: insertion-sort-bp-2bit-saturation.log insertion-sort-bp-1bit.log

bin/insertion-sort.elf: src/insertion-sort.c
	$(MIPS_CC) $(MIPS_CFLAGS) -o $@ $<

bin/insertion-sort.bin: bin/insertion-sort.elf
	$(MIPS_OBJCPY) -O binary -S $< $@

cfg/*.cfg: bin/insertion-sort.elf
	bin/updatecfgFiles.sh $< ./cfg > /dev/null 2>&1

%.log: cfg/%.cfg bin/insertion-sort.bin
	$(OPENDLX) -c cfg/$*.cfg


clean:
	rm -f bin/insertion-sort.elf bin/insertion-sort.bin *.log
