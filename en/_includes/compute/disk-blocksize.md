Disks consist of blocks. By default, the block size is 4 KB for all new disks. When creating a disk, you can set the block size between 4 KB and 128 KB.

For network disks, the maximum disk size depends on the block size. The size of a newly created disk must be a multiple of 4 MB. The possible disk and block sizes are as follows:

Block size | Maximum disk size
--- | ---
4 KB | 8 TB
8 KB | 16 TB
16 KB | 32 TB
32 KB | 64 TB
64 KB | 128 TB
128 KB | 256 TB

For non-replicated SSDs and ultra high-speed network SSD storages with three replicas, you can select any block size for any disk size. The disk size must be a multiple of 93 GB.

You cannot change the block size after the disk is created.

{% note alert %}

The selected physical block size may affect disk performance.

{% endnote %}

Typically, the logical block size is 512 bytes. Although the guest OS tries to align data I/O with the physical block size, this may not always be feasible. When the software runs numerous read and write operations that are smaller than the physical block, these operations can reach the disk subsystem. When it comes to read operations, this means reading more data than actually requested, i.e., at least one physical block. Write operations are even more complex, as to write data smaller than the physical block, the system first reads the entire physical block, then modifies specific bytes, and, finally, rewrites this block (this is known as _read-modify-write_ operation). As long as such an operation is not aligned to the physical block size, it may require reading and rewriting two physical blocks. This can turn one logical write into two read and two write operations at the disk subsystem level. This extra load will not show up in the guest OS metrics but will affect performance and will be considered when assessing how close the load is to the disk limits.

This is why we recommend choosing large block sizes only when your software uses large requests (at least equal to the physical block size) when working with the file system or disk.