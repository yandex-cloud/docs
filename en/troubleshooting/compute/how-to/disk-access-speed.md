# How to check the disk access speed for a VM instance



## Case description {#case-description}

You need to find out the disk access speed of a virtual machine and what it depends on.

## Solution {#case-resolution}

The speed depends on the disk type, the physical block size, and the disk size. To learn more, see [this article](../../../compute/concepts/disk.md#performance).

{% note info %}

The access speed is not affected by whether the disk is a boot or data one. 

{% endnote %}

Disks have limits on IOPS and bandwidth. You can read more about this [here](../../../compute/concepts/limits.md#limits-disks).

For maximum IOPS, limit the size of reads and writes to 4 KB or less, and for maximum bandwidth, to 4 MB.
