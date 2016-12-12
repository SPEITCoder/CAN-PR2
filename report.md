# 2 Warm Up
## 2.1 MIPS Tools
+ Compile insertion-sort.c

bin/insertion-sort.elf: src/insertion-sort.c
	$(MIPS_CC) $(MIPS_CFLAGS) -o $@ $<

bin/insertion-sort.bin: bin/insertion-sort.elf
	$(MIPS_OBJCPY) -O binary -S $< $@

cfg/*.cfg: bin/insertion-sort.elf
    bin/updatecfgFiles.sh $< ./cfg > /dev/null 2>&1

+  -nostdlib and -nostartfiles

-nostdlib
          Do not use the standard system startup files or libraries when linking.  No startup files and only the
          libraries you specify will be passed to the linker, options specifying linkage of the system libraries,
          such as "-static-libgcc" or "-shared-libgcc", will be ignored.  The compiler may generate calls to
          "memcmp", "memset", "memcpy" and "memmove".  These entries are usually resolved by entries in libc.
          These entry points should be supplied through some other mechanism when this option is specified.

          One of the standard libraries bypassed by -nostdlib and -nodefaultlibs is libgcc.a, a library of
          internal subroutines which GCC uses to overcome shortcomings of particular machines, or special needs
          for some languages.

          In most cases, you need libgcc.a even when you want to avoid other standard libraries.  In other words,
          when you specify -nostdlib or -nodefaultlibs you should usually specify -lgcc as well.  This ensures
          that you have no unresolved references to internal GCC library subroutines.  (For example, __main, used
          to ensure C++ constructors will be called.)

-nostdlib
          Do not use the standard system startup files or libraries when linking.  No startup files and only the
          libraries you specify will be passed to the linker, options specifying linkage of the system libraries,
          such as "-static-libgcc" or "-shared-libgcc", will be ignored.  The compiler may generate calls to
          "memcmp", "memset", "memcpy" and "memmove".  These entries are usually resolved by entries in libc.
          These entry points should be supplied through some other mechanism when this option is specified.

          One of the standard libraries bypassed by -nostdlib and -nodefaultlibs is libgcc.a, a library of
          internal subroutines which GCC uses to overcome shortcomings of particular machines, or special needs
          for some languages.

          In most cases, you need libgcc.a even when you want to avoid other standard libraries.  In other words,
          when you specify -nostdlib or -nodefaultlibs you should usually specify -lgcc as well.  This ensures
          that you have no unresolved references to internal GCC library subroutines.  (For example, __main, used
          to ensure C++ constructors will be called.)

+ look at the assembly code

sjtu@sjtu-OptiPlex-3010:~/Documents/DossierNicolasien/PR2$ mips-linux-gnu-objdump -d bin/insertion-sort.elf 

bin/insertion-sort.elf:     file format elf32-tradlittlemips


Disassembly of section .text:

00001000 <minIndex>:
   1000:       27bdffe8        addiu   sp,sp,-24
   1004:       afbe0014        sw      s8,20(sp)
   1008:       03a0f025        move    s8,sp
   100c:       afc40018        sw      a0,24(s8)
   1010:       afc5001c        sw      a1,28(s8)
   1014:       afc0000c        sw      zero,12(s8)
   1018:       afc00008        sw      zero,8(s8)
   101c:       10000013        b       106c <minIndex+0x6c>
   1020:       00000000        nop
   1024:       8fc20008        lw      v0,8(s8)
   1028:       00021080        sll     v0,v0,0x2
   102c:       8fc30018        lw      v1,24(s8)
   1030:       00621021        addu    v0,v1,v0
   1034:       8c430000        lw      v1,0(v0)
   1038:       8fc2000c        lw      v0,12(s8)
   103c:       00021080        sll     v0,v0,0x2
   1040:       8fc40018        lw      a0,24(s8)
   1044:       00821021        addu    v0,a0,v0
   1048:       8c420000        lw      v0,0(v0)
   104c:       0062102a        slt     v0,v1,v0
   1050:       10400003        beqz    v0,1060 <minIndex+0x60>
   1054:       00000000        nop
   1058:       8fc20008        lw      v0,8(s8)
   105c:       afc2000c        sw      v0,12(s8)
   1060:       8fc20008        lw      v0,8(s8)
   1064:       24420001        addiu   v0,v0,1
   1068:       afc20008        sw      v0,8(s8)
   106c:       8fc30008        lw      v1,8(s8)
   1070:       8fc2001c        lw      v0,28(s8)
   1074:       0062102a        slt     v0,v1,v0
   1078:       1440ffea        bnez    v0,1024 <minIndex+0x24>
   107c:       00000000        nop
   1080:       8fc2000c        lw      v0,12(s8)
   1084:       03c0e825        move    sp,s8
   1088:       8fbe0014        lw      s8,20(sp)
   108c:       27bd0018        addiu   sp,sp,24
   1090:       03e00008        jr      ra
   1094:       00000000        nop

00001098 <main>:
   1098:       27bdffb0        addiu   sp,sp,-80
   109c:       afbf004c        sw      ra,76(sp)
   10a0:       afbe0048        sw      s8,72(sp)
   10a4:       03a0f025        move    s8,sp
   10a8:       afc00018        sw      zero,24(s8)
   10ac:       1000000f        b       10ec <main+0x54>
   10b0:       00000000        nop
   10b4:       3c020001        lui     v0,0x1
   10b8:       8fc30018        lw      v1,24(s8)
   10bc:       00031880        sll     v1,v1,0x2
   10c0:       24421210        addiu   v0,v0,4624
   10c4:       00621021        addu    v0,v1,v0
   10c8:       8c430000        lw      v1,0(v0)
   10cc:       8fc20018        lw      v0,24(s8)
   10d0:       00021080        sll     v0,v0,0x2
   10d4:       27c40018        addiu   a0,s8,24
   10d8:       00821021        addu    v0,a0,v0
   10dc:       ac43000c        sw      v1,12(v0)
   10e0:       8fc20018        lw      v0,24(s8)
   10e4:       24420001        addiu   v0,v0,1
   10e8:       afc20018        sw      v0,24(s8)
   10ec:       8fc20018        lw      v0,24(s8)
   10f0:       28420008        slti    v0,v0,8
   10f4:       1440ffef        bnez    v0,10b4 <main+0x1c>
   10f8:       00000000        nop
   10fc:       afc00018        sw      zero,24(s8)
   1100:       10000028        b       11a4 <main+0x10c>
   1104:       00000000        nop
   1108:       27c30024        addiu   v1,s8,36
   110c:       8fc20018        lw      v0,24(s8)
   1110:       00021080        sll     v0,v0,0x2
   1114:       00622021        addu    a0,v1,v0
   1118:       24030008        li      v1,8
   111c:       8fc20018        lw      v0,24(s8)
   1120:       00621023        subu    v0,v1,v0
   1124:       00402825        move    a1,v0
   1128:       0c000400        jal     1000 <minIndex>
   112c:       00000000        nop
   1130:       00401825        move    v1,v0
   1134:       8fc20018        lw      v0,24(s8)
   1138:       00621021        addu    v0,v1,v0
   113c:       afc2001c        sw      v0,28(s8)
   1140:       8fc2001c        lw      v0,28(s8)
   1144:       00021080        sll     v0,v0,0x2
   1148:       27c30018        addiu   v1,s8,24
   114c:       00621021        addu    v0,v1,v0
   1150:       8c42000c        lw      v0,12(v0)
   1154:       afc20020        sw      v0,32(s8)
   1158:       8fc20018        lw      v0,24(s8)
   115c:       00021080        sll     v0,v0,0x2
   1160:       27c30018        addiu   v1,s8,24
   1164:       00621021        addu    v0,v1,v0
   1168:       8c43000c        lw      v1,12(v0)
   116c:       8fc2001c        lw      v0,28(s8)
   1170:       00021080        sll     v0,v0,0x2
   1174:       27c40018        addiu   a0,s8,24
   1178:       00821021        addu    v0,a0,v0
   117c:       ac43000c        sw      v1,12(v0)
   1180:       8fc20018        lw      v0,24(s8)
   1184:       00021080        sll     v0,v0,0x2
   1188:       27c30018        addiu   v1,s8,24
   118c:       00621021        addu    v0,v1,v0
   1190:       8fc30020        lw      v1,32(s8)
   1194:       ac43000c        sw      v1,12(v0)
   1198:       8fc20018        lw      v0,24(s8)
   119c:       24420001        addiu   v0,v0,1
   11a0:       afc20018        sw      v0,24(s8)
   11a4:       8fc20018        lw      v0,24(s8)
   11a8:       28420008        slti    v0,v0,8
   11ac:       1440ffd6        bnez    v0,1108 <main+0x70>
   11b0:       00000000        nop
   11b4:       0000000d        break
   11b8:       8fc20024        lw      v0,36(s8)
   11bc:       03c0e825        move    sp,s8
   11c0:       8fbf004c        lw      ra,76(sp)
   11c4:       8fbe0048        lw      s8,72(sp)
   11c8:       27bd0050        addiu   sp,sp,80
   11cc:       03e00008        jr      ra
   11d0:       00000000        nop

000011d4 <__start>:
   11d4:       27bdffe0        addiu   sp,sp,-32
   11d8:       afbf001c        sw      ra,28(sp)
   11dc:       afbe0018        sw      s8,24(sp)
   11e0:       03a0f025        move    s8,sp
   11e4:       3c1d0f00        lui     sp,0xf00
   11e8:       0c000426        jal     1098 <main>
   11ec:       00000000        nop
   11f0:       00000000        nop
   11f4:       03c0e825        move    sp,s8
   11f8:       8fbf001c        lw      ra,28(sp)
   11fc:       8fbe0018        lw      s8,24(sp)
   1200:       27bd0020        addiu   sp,sp,32
   1204:       03e00008        jr      ra
   1208:       00000000        nop
   120c:       00000000        nop

+ look at the code + .c

sjtu@sjtu-OptiPlex-3010:~/Documents/DossierNicolasien/PR2$ mips-linux-gnu-objdump -S bin/insertion-sort.elf 

bin/insertion-sort.elf:     file format elf32-tradlittlemips


Disassembly of section .text:

00001000 <minIndex>:
#define SIZE 8

int input[] = {60, 41, 46, 50, 44, 3, 84, 80, 55, 57, 91, 22, 21, 12, 64, 59, 71, 34, 81, 77, 69, 95, 2, 24, 61, 73, 25, 19, 29, 91, 45, 53, 39, 15, 47, 58, 3, 62, 81, 0, 33, 83, 12, 64, 75, 59, 32, 68, 98, 68, 53, 74, 88, 30, 65, 23, 97, 66, 49, 46, 18, 22, 0, 30, 3, 33, 13, 33, 31, 61, 14, 87, 57, 95, 20, 92, 67, 71, 42, 52, 18, 98, 2, 93, 95, 69, 90, 8, 97, 46, 26, 68, 69, 84, 73, 35, 44, 88, 79, 65};

int minIndex(int *array, int n)
{
   1000:       27bdffe8        addiu   sp,sp,-24
   1004:       afbe0014        sw      s8,20(sp)
   1008:       03a0f025        move    s8,sp
   100c:       afc40018        sw      a0,24(s8)
   1010:       afc5001c        sw      a1,28(s8)
       int i,minIdx = 0;
   1014:       afc0000c        sw      zero,12(s8)
       for(i = 0; i < n; i++)
   1018:       afc00008        sw      zero,8(s8)
   101c:       10000013        b       106c <minIndex+0x6c>
   1020:       00000000        nop
       {
               if (array[i] < array[minIdx])
   1024:       8fc20008        lw      v0,8(s8)
   1028:       00021080        sll     v0,v0,0x2
   102c:       8fc30018        lw      v1,24(s8)
   1030:       00621021        addu    v0,v1,v0
   1034:       8c430000        lw      v1,0(v0)
   1038:       8fc2000c        lw      v0,12(s8)
   103c:       00021080        sll     v0,v0,0x2
   1040:       8fc40018        lw      a0,24(s8)
   1044:       00821021        addu    v0,a0,v0
   1048:       8c420000        lw      v0,0(v0)
   104c:       0062102a        slt     v0,v1,v0
   1050:       10400003        beqz    v0,1060 <minIndex+0x60>
   1054:       00000000        nop
               {
                       minIdx = i;
   1058:       8fc20008        lw      v0,8(s8)
   105c:       afc2000c        sw      v0,12(s8)
int input[] = {60, 41, 46, 50, 44, 3, 84, 80, 55, 57, 91, 22, 21, 12, 64, 59, 71, 34, 81, 77, 69, 95, 2, 24, 61, 73, 25, 19, 29, 91, 45, 53, 39, 15, 47, 58, 3, 62, 81, 0, 33, 83, 12, 64, 75, 59, 32, 68, 98, 68, 53, 74, 88, 30, 65, 23, 97, 66, 49, 46, 18, 22, 0, 30, 3, 33, 13, 33, 31, 61, 14, 87, 57, 95, 20, 92, 67, 71, 42, 52, 18, 98, 2, 93, 95, 69, 90, 8, 97, 46, 26, 68, 69, 84, 73, 35, 44, 88, 79, 65};

int minIndex(int *array, int n)
{
       int i,minIdx = 0;
       for(i = 0; i < n; i++)
   1060:       8fc20008        lw      v0,8(s8)
   1064:       24420001        addiu   v0,v0,1
   1068:       afc20008        sw      v0,8(s8)
   106c:       8fc30008        lw      v1,8(s8)
   1070:       8fc2001c        lw      v0,28(s8)
   1074:       0062102a        slt     v0,v1,v0
   1078:       1440ffea        bnez    v0,1024 <minIndex+0x24>
   107c:       00000000        nop
               {
                       minIdx = i;
               }
       }

       return minIdx;
   1080:       8fc2000c        lw      v0,12(s8)
}
   1084:       03c0e825        move    sp,s8
   1088:       8fbe0014        lw      s8,20(sp)
   108c:       27bd0018        addiu   sp,sp,24
   1090:       03e00008        jr      ra
   1094:       00000000        nop

00001098 <main>:

int main()
{
   1098:       27bdffb0        addiu   sp,sp,-80 // r29, r29, -80 ?
   109c:       afbf004c        sw      ra,76(sp) // 76(r29), r31
   10a0:       afbe0048        sw      s8,72(sp) // 72r(r29), r31
   10a4:       03a0f025        move    s8,sp // or r30, r29, r0
       int buf[SIZE];
       int i;

       for(i = 0; i < SIZE; i++)
   10a8:       afc00018        sw      zero,24(s8) // sw 24(r30), r0
   10ac:       1000000f        b       10ec <main+0x54> // beqz r0, 0x3c, jump
   10b0:       00000000        nop
       {
               buf[i] = input[i];
   10b4:       3c020001        lui     v0,0x1 // v0 = 1 << 16?
   10b8:       8fc30018        lw      v1,24(s8) // v1: input[i], s8: 
   10bc:       00031880        sll     v1,v1,0x2 // v1 *= 4
   10c0:       24421210        addiu   v0,v0,4624 // 4624 offset ?
   10c4:       00621021        addu    v0,v1,v0 // v0 += 
   10c8:       8c430000        lw      v1,0(v0) // v1 = v0
   10cc:       8fc20018        lw      v0,24(s8) // v0 = i
   10d0:       00021080        sll     v0,v0,0x2 // v0 = 4i
   10d4:       27c40018        addiu   a0,s8,24 // s8 = a0 + 24
   10d8:       00821021        addu    v0,a0,v0 // v0 = v0 + a0 ?
   10dc:       ac43000c        sw      v1,12(v0) // M[v0 + 12] = v1 -> loading in to memory, v0 = 0xeffffc8+4k
int main()
{
       int buf[SIZE];
       int i;

       for(i = 0; i < SIZE; i++)
   10e0:       8fc20018        lw      v0,24(s8) // i
   10e4:       24420001        addiu   v0,v0,1 // i++
   10e8:       afc20018        sw      v0,24(s8) 
   10ec:       8fc20018        lw      v0,24(s8) // i load from memory?
   10f0:       28420008        slti    v0,v0,8 // i < 8 ?
   10f4:       1440ffef        bnez    v0,10b4 <main+0x1c> 
   10f8:       00000000        nop
       {
               buf[i] = input[i];
       }

       for(i = 0; i < SIZE; i++)
   10fc:       afc00018        sw      zero,24(s8)
   1100:       10000028        b       11a4 <main+0x10c>
   1104:       00000000        nop
       {
               int minIdx = i + minIndex(&buf[i], SIZE - i);
   1108:       27c30024        addiu   v1,s8,36
   110c:       8fc20018        lw      v0,24(s8)
   1110:       00021080        sll     v0,v0,0x2
   1114:       00622021        addu    a0,v1,v0
   1118:       24030008        li      v1,8
   111c:       8fc20018        lw      v0,24(s8)
   1120:       00621023        subu    v0,v1,v0
   1124:       00402825        move    a1,v0
   1128:       0c000400        jal     1000 <minIndex>
   112c:       00000000        nop
   1130:       00401825        move    v1,v0
   1134:       8fc20018        lw      v0,24(s8)
   1138:       00621021        addu    v0,v1,v0
   113c:       afc2001c        sw      v0,28(s8)
               int tmp = buf[minIdx];
   1140:       8fc2001c        lw      v0,28(s8)
   1144:       00021080        sll     v0,v0,0x2
   1148:       27c30018        addiu   v1,s8,24
   114c:       00621021        addu    v0,v1,v0
   1150:       8c42000c        lw      v0,12(v0)
   1154:       afc20020        sw      v0,32(s8)
               buf[minIdx] = buf[i];
   1158:       8fc20018        lw      v0,24(s8)
   115c:       00021080        sll     v0,v0,0x2
   1160:       27c30018        addiu   v1,s8,24
   1164:       00621021        addu    v0,v1,v0
   1168:       8c43000c        lw      v1,12(v0)
   116c:       8fc2001c        lw      v0,28(s8)
   1170:       00021080        sll     v0,v0,0x2
   1174:       27c40018        addiu   a0,s8,24
   1178:       00821021        addu    v0,a0,v0
   117c:       ac43000c        sw      v1,12(v0)
               buf[i] = tmp;
   1180:       8fc20018        lw      v0,24(s8)
   1184:       00021080        sll     v0,v0,0x2
   1188:       27c30018        addiu   v1,s8,24
   118c:       00621021        addu    v0,v1,v0
   1190:       8fc30020        lw      v1,32(s8)
   1194:       ac43000c        sw      v1,12(v0)
       for(i = 0; i < SIZE; i++)
       {
               buf[i] = input[i];
       }

       for(i = 0; i < SIZE; i++)
   1198:       8fc20018        lw      v0,24(s8)
   119c:       24420001        addiu   v0,v0,1
   11a0:       afc20018        sw      v0,24(s8)
   11a4:       8fc20018        lw      v0,24(s8)
   11a8:       28420008        slti    v0,v0,8
   11ac:       1440ffd6        bnez    v0,1108 <main+0x70>
   11b0:       00000000        nop
               int tmp = buf[minIdx];
               buf[minIdx] = buf[i];
               buf[i] = tmp;
       }

       asm volatile ("break");
   11b4:       0000000d        break
       return buf[0];
   11b8:       8fc20024        lw      v0,36(s8)
}
   11bc:       03c0e825        move    sp,s8
   11c0:       8fbf004c        lw      ra,76(sp)
   11c4:       8fbe0048        lw      s8,72(sp)
   11c8:       27bd0050        addiu   sp,sp,80
   11cc:       03e00008        jr      ra
   11d0:       00000000        nop

000011d4 <__start>:

void __start()
{
   11d4:       27bdffe0        addiu   sp,sp,-32
   11d8:       afbf001c        sw      ra,28(sp)
   11dc:       afbe0018        sw      s8,24(sp)
   11e0:       03a0f025        move    s8,sp
 asm volatile ("lui $sp, 0xf00");
   11e4:       3c1d0f00        lui     sp,0xf00
 main();
   11e8:       0c000426        jal     1098 <main>
   11ec:       00000000        nop
 // does not return
}
   11f0:       00000000        nop
   11f4:       03c0e825        move    sp,s8
   11f8:       8fbf001c        lw      ra,28(sp)
   11fc:       8fbe0018        lw      s8,24(sp)
   1200:       27bd0020        addiu   sp,sp,32
   1204:       03e00008        jr      ra
   1208:       00000000        nop
   120c:       00000000        nop

+ Symbols in 

sjtu@sjtu-OptiPlex-3010:~/Documents/DossierNicolasien/PR2$ mips-linux-gnu-objdump -t -j.data -j.text bin/insertion-sort.elf

bin/insertion-sort.elf:     file format elf32-tradlittlemips

SYMBOL TABLE:
00001000 l    d  .text  00000000 .text
00011210 l    d  .data  00000000 .data
00011210 g       .data  00000000 _fdata
00011210 g     O .data  00000190 input
000011d4 g     F .text  00000038 __start
00001000 g       .text  00000000 _ftext
000113a0 g       .data  00000000 __bss_start
00001098 g     F .text  0000013c main
000113a0 g       .data  00000000 _edata
000113a0 g       .data  00000000 _end
00001000 g     F .text  00000098 minIndex
000113a0 g       .data  00000000 _fbss

>> Symbol for INPUT in C code :
00011210 l    d  .data  00000000 .data
00011210 g       .data  00000000 _fdata
00011210 g     O .data  00000190 input

+ Loading address of input into register.

>> 
for(i = 0; i < SIZE; i++)
   10e0:       8fc20018        lw      v0,24(s8)
   10e4:       24420001        addiu   v0,v0,1
   10e8:       afc20018        sw      v0,24(s8)
   10ec:       8fc20018        lw      v0,24(s8)
   10f0:       28420008        slti    v0,v0,8
   10f4:       1440ffef        bnez    v0,10b4 <main+0x1c>
   10f8:       00000000        nop
       {
               buf[i] = input[i];
       }

## 2.2 openDLX

+ Checking 0x11210, match against input array
0x3c => 60_(10), ox29 => 41 ...

+ determine the address to which the store instruction is writing

0x8fc20018 100011 | 11 110 | 0 0010 | 0000 0000 0001 1000
rt = 2, rs = 30, imm = 24

+ Values in memory are sirted

+ 9 cycles misprediction

11e8:       0c000426        jal     1098 <main>

an unconditional branch 