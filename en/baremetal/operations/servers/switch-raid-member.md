---
title: How to replace a failed disk in a {{ baremetal-full-name }} server’s RAID array
description: In this tutorial, you will learn how to replace a failed disk in a {{ baremetal-name }} server’s RAID array.
---

# Replacing a disk in a RAID array

If a disk in a {{ baremetal-name }} server’s RAID array fails, stop using it, [remove](#remove-from-raid) it from the array, [request](#request-swap) a replacement drive from support, and [add](#add-to-raid) the new disk to the array.

{% note info %}

This guide does not apply to disk failures in `RAID 0` arrays. Such arrays are not fault-tolerant; a single disk failure results in complete data loss and requires full array reconstruction.

This guide covers a standard RAID10 configuration with four HDDs under Ubuntu 24.04. If your setup differs from this standard configuration, adjust the following steps accordingly.

{% endnote %}

## Remove the failed disk from the RAID array {#remove-from-raid}

1. Connect to the server over SSH:

    ```bash
    ssh root@<server_public_IP_address>
    ```

    You can also access the server via the [KVM console](./server-kvm.md) using your username and password.
1. Check the current disk and partition layout in the RAID array:

    ```bash
    cat /proc/mdstat
    ```

    Result:

    ```text
    Personalities : [raid10] [raid0] [raid1] [raid6] [raid5] [raid4]
    md3 : active raid10 sdb4[1] sdc4[2] sdd4[3] sda4[0]
          3893569536 blocks super 1.2 256K chunks 2 near-copies [4/4] [UUUU]
          bitmap: 0/30 pages [0KB], 65536KB chunk

    md2 : active raid10 sdc3[2] sdb3[1] sdd3[3] sda3[0]
          2095104 blocks super 1.2 256K chunks 2 near-copies [4/4] [UUUU]

    md1 : active raid10 sdc2[2] sdb2[1](F) sda2[0] sdd2[3]
          8380416 blocks super 1.2 256K chunks 2 near-copies [4/3] [U_UU]
    ```

    As shown, the RAID array consists of three RAID partitions: `md1` composed of `sdb2` and `sda2` disk partitions (on physical disks `sdb` and `sda`, respectively), `md2` composed of `sdb3` and `sda3` disk partitions, and `md3` composed of `sdb4` and `sda4` disk partitions. The command output shows that the `sdb` disk has failed, indicated by the `(F)` flag next to its name.

    Additionally, you can check the role of each partition in the RAID array:

    ```bash
    lsblk
    ```

    Result:

    ```text
    NAME    MAJ:MIN RM  SIZE RO TYPE   MOUNTPOINTS
    sda       8:0    0  1.8T  0 disk
    ├─sda1    8:1    0  299M  0 part
    ├─sda2    8:2    0    4G  0 part
    │ └─md1   9:1    0    8G  0 raid10 /boot
    ├─sda3    8:3    0    1G  0 part
    │ └─md2   9:2    0    2G  0 raid10 [SWAP]
    └─sda4    8:4    0  1.8T  0 part
      └─md3   9:3    0  3.6T  0 raid10 /
    sdb       8:16   0  1.8T  0 disk
    ├─sdb1    8:17   0  299M  0 part
    ├─sdb2    8:18   0    4G  0 part
    │ └─md1   9:1    0    8G  0 raid10 /boot
    ├─sdb3    8:19   0    1G  0 part
    │ └─md2   9:2    0    2G  0 raid10 [SWAP]`
    └─sdb4    8:20   0  1.8T  0 part
      └─md3   9:3    0  3.6T  0 raid10 /
    sdc       8:32   0  1.8T  0 disk
    ├─sdc1    8:33   0  299M  0 part
    ├─sdc2    8:34   0    4G  0 part
    │ └─md1   9:1    0    8G  0 raid10 /boot
    ├─sdc3    8:35   0    1G  0 part
    │ └─md2   9:2    0    2G  0 raid10 [SWAP]
    └─sdc4    8:36   0  1.8T  0 part
      └─md3   9:3    0  3.6T  0 raid10 /
    sdd       8:48   0  1.8T  0 disk
    ├─sdd1    8:49   0  299M  0 part
    ├─sdd2    8:50   0    4G  0 part
    │ └─md1   9:1    0    8G  0 raid10 /boot
    ├─sdd3    8:51   0    1G  0 part
    │ └─md2   9:2    0    2G  0 raid10 [SWAP]
    └─sdd4    8:52   0  1.8T  0 part
      └─md3   9:3    0  3.6T  0 raid10 /
    ```

    In our example:
    * `md1`: `/boot` partition.
    * `md2`: `SWAP` partition.
    * `md3`: `/` root partition.
    
1. Assume the `/dev/sdb` disk has failed. Detach the `/dev/sdb` disk's partitions from the RAID array:

    ```bash
    mdadm /dev/md1 --remove /dev/sdb2
    mdadm /dev/md2 --remove /dev/sdb3
    mdadm /dev/md3 --remove /dev/sdb4
    ```

    The `mdadm` utility prevents disk removal from a RAID array if the disk is still operational or if removal can cause array failure, triggering a `Device busy` error:

    ```text
    mdadm: hot remove failed for /dev/sdb2: Device or resource busy
    ```

    In this case, first mark the disk as failed before retrying the removal:

    ```bash
    mdadm /dev/md1 --fail /dev/sdb2
    mdadm /dev/md1 --remove /dev/sdb2
    mdadm /dev/md2 --fail /dev/sdb3
    mdadm /dev/md2 --remove /dev/sdb3
    mdadm /dev/md3 --fail /dev/sdb4
    mdadm /dev/md3 --remove /dev/sdb4
    ```

1. Get the failed disk's ID:

    ```bash
    fdisk -l
    ```

    Result:

    ```text
    ...
    Disk /dev/sdb: 838.36 GiB, 900185481216 bytes, 1758174768 sectors
    Disk model: SAMSUNG MZ7GE900
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: gpt
    Disk identifier: CD2ACB4C-1618-4BAF-A6BB-D2B9********
    ...
    ```

    Save the `Disk identifier` value for your support ticket.

## Request physical disk replacement {#request-swap}

[Submit](../../../support/overview.md#response-time) a disk replacement ticket to technical support, including your {{ baremetal-name }} server ID and failed disk ID.

Wait for data center engineers to replace the failed disk.

## Add the new disk to your RAID array {#add-to-raid}

After the physical drive replacement, partition the new disk and add it to the existing RAID array.

1. Use the `gdisk` utility to specify the partition table type: `GPT` or `MBR`. If needed, install `gdisk` on your server’s operating system.

    Run the following command, specifying the ID of the remaining operational disk in the RAID array:

    ```bash
    gdisk -l /dev/sda
    ```

    Depending on the partition table type, the result will be as follows:

    {% list tabs group=partition_table_type %}

    - GPT {#gpt}

      ```text
      Partition table scan:
        MBR: protective
        BSD: not present
        APM: not present
        GPT: present
      ...
      ```

    - MBR {#mbr}

      ```text
      Partition table scan:
        MBR: MBR only
        BSD: not present
        APM: not present
        GPT: not present
      ...
      ```

    {% endlist %}

1. Copy the partition table layout from the remaining operational disk in the RAID array to the new disk:

    {% list tabs group=partition_table_type %}

    - GPT {#gpt}

      If the source disk uses a GPT partition table:

      1. Create a copy of the source disk partition table:

          ```bash
          sgdisk --backup=table /dev/sda
          ```

          Result:

          ```text
          The operation has completed successfully.
          ```
      1. Restore the partition table from the backup copy to the new disk:

          ```bash
          sgdisk --load-backup=table /dev/sdb
          ```

          Result:

          ```text
          The operation has completed successfully.
          ```
      1. Assign a new random UUID to the new disk:

          ```bash
          sgdisk -G /dev/sdb
          ```

          Result:

          ```text
          The operation has completed successfully.
          ```

    - MBR {#mbr}

      If the source disk uses an MBR partition table:

      1. Copy the partition table:

          ```bash
          sfdisk -d /dev/sda | sfdisk /dev/sdb
          ```

          Where:
          * `/dev/sda`: The remaining operational disk in the RAID array used as the partition table template.
          * `/dev/sdb`: The new disk that will receive the partition table copy from the source disk.
      1. If new partitions are not visible after copying, reload the partition table:

          ```bash
          sfdisk -R /dev/sdb
          ```

    {% endlist %}

1. Add the disk to the RAID array by sequentially adding each of its partitions to their corresponding RAID components. The correspondence between disk partitions and RAID components was described earlier in [{#T}](#remove-from-raid).

    Run the following commands:

    ```bash
    mdadm /dev/md1 --add /dev/sdb2
    mdadm /dev/md2 --add /dev/sdb3
    mdadm /dev/md3 --add /dev/sdb4
    ```

    Once added to the array, the disk begins synchronizing. The sync speed depends on the disk capacity and type: `ssd` or `hdd`.

    Result:

    ```text
    mdadm: added /dev/sdb2
    mdadm: added /dev/sdb3
    mdadm: added /dev/sdb4
    ```

1. Make sure the new disk has been successfully added to the RAID array:

    ```bash
    cat /proc/mdstat
    ```

    Result:

    ```text
    Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5] [raid4] [raid10]
    md2 : active raid1 sdb3[2] sda3[0]
          6287360 blocks super 1.2 [2/2] [UU]

    md3 : active raid1 sdb4[2] sda4[0]
          849215488 blocks super 1.2 [2/2] [UU]
          bitmap: 4/7 pages [16KB], 65536KB chunk

    md1 : active raid1 sdb2[2] sda2[0]
          10477568 blocks super 1.2 [2/2] [UU]

    unused devices: <none>
    ```
1. Install the Linux bootloader on the new disk:

    ```bash
    grub-install /dev/sdb
    ```

    Result:

    ```text
    Installing for i386-pc platform.
    Installation finished. No error reported.
    ```

#### See also {#see-also}

* [{#T}](./use-hwatcher.md)
* [{#T}](./rescue-boot.md)
* [{#T}](./reset-password.md)
* [{#T}](./restore-grub.md)