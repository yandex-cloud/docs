# What is the disk access speed for a VM



## Scenario description {#case-description}

What is the access speed to the disks of a VM instance, and what affects it?

## Solution {#case-resolution}

The speed is determined by the type of disk, the physical block size, and the disk size. You can read more about this in the [documentation](../../../compute/concepts/disk#performance).

{% note info %}

The speed of access to the disks is not affected by disk type: boot or secondary.

{% endnote %}

Disks have limits on IOPS and bandwidth. You can read more about this [here](../../../compute/concepts/limits#limits-disks).

To achieve the maximum IOPS, we recommend making reads and writes of no more than 4 KB, and to achieve the maximum bandwidth, of up to 4 MB.
