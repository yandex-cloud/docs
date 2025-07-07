View information about server storage devices, including disks and their partitions:

{% include [fdisk-l-in-rescue](../fdisk-l-in-rescue.md) %}

In the example above, the `fdisk` utility displayed information about the `/dev/sda` and `/dev/sdb` physical disks, their partitions, and the partitions of the server’s RAID array: `/dev/md127`, `/dev/md126`, and `/dev/md125`.

The `/dev/sda` and `/dev/sdb` disks are configured in a RAID array, and the `809.88 GiB` `/dev/md125` partition contains the server OS root filesystem. This is the partition you need to mount.