Disks consist of blocks. By default, the block size of all created disks is 4 KB, but that's not enough for disks larger than 8 TB. You can set the block size when creating an empty disk. In this case, you will immediately see the maximum disk size. You can't change the block size after the disk is created.

The maximum disk size depends on the chosen block size. The size of a newly created disk must be a multiple of 4 MB.

| Block size | Maximum disk size |
--- | ---
| 4 KB | 8 TB |
| 8 KB | 16 TB |
| 16 KB | 32 TB |
| 32 KB | 64 TB |
| 64 KB | 128 TB |
| 128 KB | 256 TB |

{% note alert %}

The selected physical size of the block may affect disk performance.

{% endnote %}

In most cases, the logical block size is equal to 512 bytes. Even though the OS tries to align the I/O to the physical block size, this might not always be successful. In case you run multiple read and write operations with a size that is less than the physical block size, such small operations may reach the disk subsystem. When it comes to read operations, this means reading more data than actually requested, i.e., at least one physical block. In case of write operations, the situation is even more complicated: writing data with a size that is less than the physical block size requires first reading the entire physical block with the required bytes modified within it and, then, writing this block (this is called read-modify-write operation). As long as such an operation is not aligned to the physical block size, it may be required to read and overwrite as many as two physical blocks. Thus, a single logical write operation may turn into two read and two write operations at the disk subsystem level. This extra load will not reveal itself in the guest OS metrics, but will matter when the load is compared to the disk limits, and will eventually affect the performance.

Select a large block size only in case your software uses large requests (at least the physical block size) when working with the file system or disk.