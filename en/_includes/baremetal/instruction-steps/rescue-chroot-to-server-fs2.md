View information about the server storage devices (disks and partitions created on them):

{% include [fdisk-l-in-rescue](../fdisk-l-in-rescue.md) %}

In the example above, the `fdisk` utility outputs information about the physical disks (`/dev/sda` and `/dev/sdb`) and their partitions, as well as the partitions of the RAID array created on the server (`/dev/md127`, `/dev/md126`, and `/dev/md125`).

The disks `/dev/sda` and `/dev/sdb` are used in the RAID array, whereas the root file system of the server OS resides in the `809.88 GiB` `/dev/md125` partition. This is the partition you need to mount.