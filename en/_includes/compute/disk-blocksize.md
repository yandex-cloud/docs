Disks consist of blocks. By default, the block size of all created disks is 4 KB, but that's not enough for disks larger than 8 TB. You can set the block size when creating an empty disk. You can't change the block size after the disk is created.

The maximum disk size depends on the chosen block size. The size of a newly created disk must be a multiple of 4 MB.

| Block size | Maximum disk size |
| ---- | ---- |
| 4 KB | 8 TB |
| 8 KB | 16 TB |
| 16 KB | 32 TB |
| 32 KB | 64 TB |
| 64 KB | 128 TB |
| 128 KB | 256 TB |

{% note alert %}

Selected block size may affect disk performance.

{% endnote %}

Usually logical block size is equal to 512 bytes. Even though guest OS tries to align i/o to physical block size, it is not always possible. In case the software running in your VM does many read/write operations whose size is less than physical block size, these small operations may reach the disk subsystem. In case of read operations it leads to reading more data than actually requested by software: it's necessary to read at least 1 physical block. In case of write operations the situation is even worse: in order to write an amount of data whose size is less than physical block size, it is necessary to first read the whole physical block, change the requested bytes and then rewrite this block (it's a so called read-modify-write operation). If this write operation is not aligned to physical block boundary, it may be necessary to read and rewrite even 2 physical blocks. Thus, one logical write operation may lead to 2 read operations and 2 write operations at the disk subsystem level. This extra load won't be observable in guest OS metrics, but will be taken into account when the load is compared to the disk limits and will affect performance.

Please, choose large block size only if you are fairly certain that your software uses large requests when working with filesystem / disk. The size of these requests shouldn't be smaller than the selected block size to achieve maximum performance.
