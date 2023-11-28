Disks consist of blocks. By default, the block size of all new disks is 4 KB. You can set block size in the range from 4 KB to 128 KB when creating a disk.

For network disks, the maximum disk size depends on the block size. The size of a newly created disk must be a multiple of 4 MB. The possible disk and block sizes are as follows:

| Block size | Maximum disk size |
| --- | --- |
| 4 KB | 8 TB |
| 8 KB | 16 TB |
| 16 KB | 32 TB |
| 32 KB | 64 TB |
| 64 KB | 128 TB |
| 128 KB | 256 TB |

For non-replicated and high-performance SSDs, you can select any block size for any disk size. The size of a disk must be a multiple of 93 GB.

You cannot change the block size after the disk is created.

{% note alert %}

The selected physical block size may affect disk performance.

{% endnote %}

In most cases, the logical block size is equal to 512 bytes. Although the OS tries to align data I/O with the physical block size, this might not always be possible. In case the software performs many read/write operations with a size that is less than the physical block size, such small operations may reach the disk subsystem. When it comes to read operations, this means reading more data than actually requested, i.e., at least one physical block. In case of write operations, the situation is even more complicated, as writing data with a size that is less than the physical block size requires first reading the entire physical block, then modifying the requested bytes, and, finally, rewriting this block (this is known as _read-modify-write_ operation). As long as such an operation is not aligned to the physical block size, it may also be required to read and rewrite as many as two physical blocks. Thus, a single logical write operation may turn into two read and two write operations at the disk subsystem level. This extra load will not reveal itself in the guest OS metrics, but will matter when the load is compared to the disk limits and will eventually affect performance.

This is why we recommend picking large block sizes only in case your software uses large requests (at least equal to the physical block size) when working with the file system or disk.