# 4. Branch Prediction
+ Comperation of two predictor

We compare the performance of 1 bit predictor and 2 bit predictor:

log file of 1 bit predictor
```
INFO  [openDLX]: Jumps correctly predicted: 88 mispredicted: 37 misprediction rate: 29,6%
```

log file of 2 bit predictor
```
INFO  [openDLX]: Jumps correctly predicted: 99 mispredicted: 26 misprediction rate: 20,8%
```

We can see that the number of prediction are both 125 and 1 bit prediction has higher misprediction rate.

+ Detail

1 bit predictor
```
INFO  [openDLX]: bpc: 0x00001078 [120] tgts: [0x00001024] a:44 t/nt: 36/8 mp/cp: 16/28 mp-ratio: 0,36
INFO  [openDLX]: bpc: 0x00001050 [80] tgts: [0x00001060] a:36 t/nt: 31/5 mp/cp: 11/25 mp-ratio: 0,31
INFO  [openDLX]: bpc: 0x000010f4 [116] tgts: [0x000010b4] a:9 t/nt: 8/1 mp/cp: 2/7 mp-ratio: 0,22
INFO  [openDLX]: bpc: 0x000011ac [44] tgts: [0x00001108] a:9 t/nt: 8/1 mp/cp: 2/7 mp-ratio: 0,22
INFO  [openDLX]: bpc: 0x0000101c [28] tgts: [0x0000106c] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
INFO  [openDLX]: bpc: 0x00001090 [16] tgts: [0x00001130] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
INFO  [openDLX]: bpc: 0x00001128 [40] tgts: [0x00001000] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
INFO  [openDLX]: bpc: 0x000010ac [44] tgts: [0x000010ec] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
INFO  [openDLX]: bpc: 0x00001100 [0] tgts: [0x000011a4] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
INFO  [openDLX]: bpc: 0x000011e8 [104] tgts: [0x00001098] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
```
2 bit prodictor
```
INFO  [openDLX]: bpc: 0x00001078 [120] tgts: [0x00001024] a:44 t/nt: 36/8 mp/cp: 9/35 mp-ratio: 0,2
INFO  [openDLX]: bpc: 0x00001050 [80] tgts: [0x00001060] a:36 t/nt: 31/5 mp/cp: 7/29 mp-ratio: 0,19
INFO  [openDLX]: bpc: 0x000010f4 [116] tgts: [0x000010b4] a:9 t/nt: 8/1 mp/cp: 2/7 mp-ratio: 0,22
INFO  [openDLX]: bpc: 0x000011ac [44] tgts: [0x00001108] a:9 t/nt: 8/1 mp/cp: 2/7 mp-ratio: 0,22
INFO  [openDLX]: bpc: 0x0000101c [28] tgts: [0x0000106c] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
INFO  [openDLX]: bpc: 0x00001090 [16] tgts: [0x00001130] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
INFO  [openDLX]: bpc: 0x00001128 [40] tgts: [0x00001000] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
INFO  [openDLX]: bpc: 0x000010ac [44] tgts: [0x000010ec] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
INFO  [openDLX]: bpc: 0x00001100 [0] tgts: [0x000011a4] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
INFO  [openDLX]: bpc: 0x000011e8 [104] tgts: [0x00001098] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
```
When we look at the situation of each branch,we find that the difference bewteen two predictor is more signficant when the branch is executed lots of times. For example, the branch ```0x00001024```. However, 2 bit predictor is not alway better than 1 bit predictor. On branchs ```0x000010b4``` to ```0x00001098```, perdormences of two predictor are the same.

+ Explanation of the difference

```1078:       1440ffea        bnez    v0,1024 <minIndex+0x24>```  
C Code <minIndex>: ```for(i = 0; i < n; i++)```, the condition after for-loop. It is usually taken.

```1050:       10400003        beqz    v0,1060 <minIndex+0x60>```  
C Code <minIndex>: ```if (array[i] < array[minIdx])```, usually taken.

```10f4:       1440ffef        bnez    v0,10b4 <main+0x1c>```  
C Code <main>: ```for(i = 0; i < SIZE; i++)```, the condition after for-loop. It is usually taken.

```11ac:       1440ffd6        bnez    v0,1108 <main+0x70>```  
C Code <main>: ```for(i = 0; i < SIZE; i++)```, the condition after for-loop. It is usually taken.

```101c:       10000013        b       106c <minIndex+0x6c>```  
C code <minIndex>: ```for(i = 0; i < n; i++)```, the condition before for-loop. It is always taken and PC jumps to the condition after for-loop.

```1090:       03e00008        jr      ra```  
C Code <minIndex>: ```return minIndx```, Alway taken.

```1128:       0c000400        jal     1000 <minIndex>```  
C Code <main>: ```minIndex(&buf[i], SIZE - i)```, Always taken.

```10ac:       1000000f        b       10ec <main+0x54>```  
```1100:       10000028        b       11a4 <main+0x10c>```  
C Code <main>: the condition before for-loop. It is usually taken.
   
```11e8:       0c000426        jal     1098 <main>```  
C Code <__start>: ```main()```, Always taken.

The 1 bit predictor do its prediction based on the recent result of the branch. We firstly assume that each branck has its own bit, i.e for every branch instruction address, a mod k are not equal to other.  
The instruction 1078 correspond to the condition of exiting the for-loop in minIndex function. function minIndex be called 8 time in the programme. The 1 bit predictor will have a misprediction in the first loop and the last loop, thus we have 16 mispresictions. Meanwhile, the 2 bit predictor, at the beginning, has the 2-bit 00. In the first two loops, the predictor will not take the branch, because the bit patterns are 00 and 01. After that, the predictor will take the branch because of its bit partterns: 11 or 10 and we can see that the bit pattern will be always 11 and 10. So 2 bit predictor will only has a misprediction when exiting the loop, add the first two mispredictions, it has totally 9 mispredictions.

+ Penalties  
 
We find that there is always a nop instruction after condition instruction and the penalties are:   
PC/Prediction taken/untaken: 3  
PC/Prediction taken/taken: 2  
PC/Prediction untaken/taken: 3  
PC/Prediction untaken/untaken: 2  

Because there is a nop after condition, CPU only need to flush when a misprediction occur. In addition, CPU has the same behavier after a taken/untaken or a untaken/taken, which could simplfy the design.