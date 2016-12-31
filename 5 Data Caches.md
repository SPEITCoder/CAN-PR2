# 5 Data Caches

+ memory_latency

We give a delay time between the memory's receipt of a read request and its release of data corresponding with the request. So the IF, MEM and WB will have delay in the pipelining.
Other stages will also have delays for the data dependency.
![image](img/51.png)

```
Dcache: 
Accesses: 500  hits: 220  misses: 280  hit rate: 44%  total size: 16
```

+ dcache_total_block_number

dcache_total_block_number = 4
```
Dcache: 
total size: 16
Accesses: 500 hits: 220 misses: 280 hit rate: 44%
```
dcache_total_block_number = 8
```
Dcache: 
total size: 32
Accesses: 499 hits: 381 misses: 118 hit rate: 76.35%
```

dcache_total_block_number = 16
```
Dcache:
total size: 64
Accesses: 500 hits: 411 misses: 89 hit rate: 82.2% 
```

dcache_total_block_number = 32
```
Dcache: 
total size: 128
Accesses: 500 hits: 492 misses: 8 hit rate: 98.4%
```

dcache_total_block_number = 64
```
Dcache:
total size: 256
Accesses: 500 hits: 492 misses: 8 hit rate: 98.4% 
```

Conclusion:

The cache size is changed from 16 to 256, and the hit rate has a continuous growth. With regard to the cache size, the case when  dcache_total_block_number = 32 performs best.

+ dcache_associativity with dcache_total_block_number = 8

dcache_associativity = 2, dacache_replacement_policy = FIFO
```
Dcache:
hit rate: 74.55%
```

dcache_associativity = 2, dacache_replacement_policy = LRU
```
Dcache:
hit rate: 77.35%
```
dcache_associativity = 4, dacache_replacement_policy = FIFO
```
Dcache:
total size: 32
rate: 83.97%
```

dcache_associativity = 4, dacache_replacement_policy = LRU
```
Dcache:
total size: 32
hit rate: 85.97%
```

dcache_associativity = 8, dacache_replacement_policy = FIFO
```
Dcache:
total size: 32
hit rate: 83.37%
```
dcache_associativity = 8, dacache_replacement_policy = LRU
```
Dcache:
total size: 32
hit rate: 87.58%
```
dcache_associativity = 1, dacache_replacement_policy = DIRECT_MAPPED

```
Dcache:
total size: 32
hit rate: 76.35%
```

Conclusion:

The two replacement policies with a higher data cache associativity have better performances than the original DIRECT_MAPPED with the same total size in general.

+ dcache_block_size with LRU 4 way associativity and dcache_total_block_number = 8

dcache_block_size = 4
```
total size: 32
hit rate: 85.97%
```
dcache_block_size = 8
```
total size: 64
hit rate: 96.8% 
```
dcache_block_size = 16	
```
total size: 128
hit rate: 99.6%
```
dcache_block_size = 32
```
total size: 256
hit rate: 99.6%
```
Conclusion:

Compared with block number section, the scheme to increase the block size has better performance than the scheme to increase the block number, with the same total cache size.

+ C code examination

The data are accessed by the program in array buf and in counters (spatial locality and temporal locality), so the data is reused frequently.

The capacity miss dominates the cache's performance in this program because the data used is very fixed.

The program actually access the data:

1. SIZE numbers to sort: but[SIZE]

2. two counters: i * 3

3. the temporary variable: tmp

4. the variable minIdx

   in total 8+3+1+1 = 15.

+ Final question

The configuration dcache_block_size = 16/32, 4-way set-associative, total number of cache blocks = 8 performs the best (the hit rate 99.6% exceeds all the others cases).

The configuration:  dcache_block_size = 8, 4-way set-associative, total number of cache blocks = 8 made the best trade-off between the total cache size and the hit rate. Because the hit rate is rather good and close to 100% (96.8%), but the total cache size is merely half of the best performance case(the case total size = 128, hit rate = 99.6%) in block size section. 

From the result of changing data cache number and size, we can observe that as the total size increase, the hit rate is significantly enhanced, and from question 4 that as the total cache size is fixed, the enhance of hit rate is limited. So we can conclude that the total cache size is the most relevant parameter to the hit rate. And this conclusion is coherent with the analysis of data access that the data is reused very frequently and the most dominant factor of the hit rate is the cache size.