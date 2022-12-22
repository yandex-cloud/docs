Disks consist of blocks. By default, the block size of all created disks is 4 KB, but that's not enough for disks larger than 8 TB. You can set the block size when creating an empty disk. In this case, you will immediately see the maximum disk size. You can't change the block size after the disk is created.

The maximum disk size depends on the chosen block size. The size of a newly created disk must be a multiple of 4 MB.

| Block size | Maximum disk size |
---- | ----
| 4 KB | 8 TB |
| 8 KB | 16 TB |
| 16 KB | 32 TB |
| 32 KB | 64 TB |
| 64 KB | 128 TB |
| 128 KB | 256 TB |

{% note alert %}

The selected physical size of the block may affect disk performance.

{% endnote %}

The block logical size is usually 512 bytes. Although the OS tries to align data I/O with the block physical size, this isn't always possible. If multiple reads and writes that are less than the physical block in size are being run, these small operations may reach the disk subsystem. If it's a read operation, more data has to be read than requested, at least one physical block. If it's a write, the situation is more complicated: to write the amount of data less than the block physical size, first, the entire physical block has to be read with the required bytes modified in it and then the entire physical block has to be written (the read-modify-write operation). If the write is not aligned with the block physical size in this case, it may be required to read and overwrite two physical blocks. That is, a single logical write may result in two read operations and two write operations at the disk subsystem level. You won't see this excess load in metrics at the guest OS level, but it will be factored in when estimating how close the load is to the disk limits and will affect its performance.

Select a large block size only if you're sure that your software interacts with the file system or disk through large requests that are not less than the block physical size.
