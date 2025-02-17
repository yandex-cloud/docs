---
title: How to replace a defective disk in a {{ baremetal-full-name }} server RAID array
description: Follow this guide to replace a defective disk in a {{ baremetal-name }} server RAID array.
---

# Replacing a disk in a RAID array

If there is a RAID array disk failure on a {{ baremetal-name }} server, you must [remove](#remove-from-raid) the defective disk from the array, [request](#request-swap) support to replace the physical drive on the server, and then [add](#add-to-raid) the new disk to the RAID array.

{% note info %}

This guide does not apply to disk failures in `RAID 0` arrays. Such arrays are not fault-tolerant, so if one of the disks fails, all the array data will be lost and the array will have to be completely rebuilt.

{% endnote %}

## Remove the defective disk from the RAID array {#remove-from-raid}

1. Connect to the server over SSH:

    ```bash
    ssh root@<server_public_IP_address>
    ```

    You can also connect to the server through the [KVM console](./server-kvm.md) using your username and password.
1. Get information about the RAID array's current disk and partition layout:

    ```bash
    cat /proc/mdstat
    ```

    Result:

    ```text
    Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5] [raid4] [raid10]
    md2 : active raid1 sdb3[1] sda3[0]
          6287360 blocks super 1.2 [2/2] [UU]

    md3 : active raid1 sdb4[1] sda4[0]
          849215488 blocks super 1.2 [2/2] [UU]
          bitmap: 4/7 pages [16KB], 65536KB chunk

    md1 : active raid1 sdb2[1] sda2[0]
          10477568 blocks super 1.2 [2/2] [UU]
    ```

    The above example shows a RAID array consisting of three partitions: `md1` (disk partitions `sdb2` and `sda2`), `md2` (disk partitions `sdb3` and `sda3`), and `md3` (disk partitions `sdb4` and `sda4`).

1. Get information about the roles of the RAID array partitions:

    ```bash
    lsblk
    ```

    Result:

    ```text
    NAME    MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
    sda       8:0    0 838.4G  0 disk
    ├─sda1    8:1    0   299M  0 part
    ├─sda2    8:2    0    10G  0 part
    │ └─md1   9:1    0    10G  0 raid1 /boot
    ├─sda3    8:3    0     6G  0 part
    │ └─md2   9:2    0     6G  0 raid1 [SWAP]
    └─sda4    8:4    0   810G  0 part
      └─md3   9:3    0 809.9G  0 raid1 /
    sdb       8:16   0 838.4G  0 disk
    ├─sdb1    8:17   0   299M  0 part
    ├─sdb2    8:18   0    10G  0 part
    │ └─md1   9:1    0    10G  0 raid1 /boot
    ├─sdb3    8:19   0     6G  0 part
    │ └─md2   9:2    0     6G  0 raid1 [SWAP]
    └─sdb4    8:20   0   810G  0 part
      └─md3   9:3    0 809.9G  0 raid1 /
    ```

    In the above example:
    * `md1`: `/boot` partition.
    * `md2`: `SWAP` partition.
    * `md3`: `/` partition with the root file system.
1. Let's assume the `/dev/sdb` disk is down. Remove the `/dev/sdb` disk's partitions from the RAID array's partitions:

    ```bash
    mdadm /dev/md1 --remove /dev/sdb2
    mdadm /dev/md2 --remove /dev/sdb3
    mdadm /dev/md3 --remove /dev/sdb4
    ```

    The `mdadm` utility will not allow you to remove a disk from a RAID array if it considers it operational or if the action can cause the array failure. In which case you will be notified that the device is busy:

    ```text
    mdadm: hot remove failed for /dev/sdb2: Device or resource busy
    ```

    If this is the case, tentatively mark the disk as defective and retry the removal:

    ```bash
    mdadm /dev/md1 --fail /dev/sdb2
    mdadm /dev/md1 --remove /dev/sdb2
    mdadm /dev/md2 --fail /dev/sdb3
    mdadm /dev/md2 --remove /dev/sdb3
    mdadm /dev/md3 --fail /dev/sdb4
    mdadm /dev/md3 --remove /dev/sdb4
    ```

1. Get the defective disk's ID:

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

    Save the defective disk's ID (`Disk identifier`): you will need it to report the problem to tech support.

## Request physical replacement of the disk {#request-swap}

[Create](../../../support/overview.md#response-time) a disk replacement request to support stating the {{ baremetal-name }} server's and defective disk's IDs.

Wait for the data center engineers to replace the defective disk.

## Add the new disk to your RAID array {#add-to-raid}

Once the physical drive is replaced on the server, you must partition the drive and add it to the existing RAID array.

1. Use the `gdisk` utility to set the partition table type: `GPT` or `MBR`. Install `gdisk` for your server's OS if needed.

    Run the command stating the ID of the RAID array's remaining operational disk:

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

1. Copy the partition table layout from the RAID array's remaining operational disk to the new disk:

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
      1. Recover the partition table from the copy to the new disk:

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

      If the source disk uses a MBR partition table:

      1. Copy the partition table:

          ```bash
          sfdisk -d /dev/sda | sfdisk /dev/sdb
          ```

          Where:
          * `/dev/sda`: RAID array's remaining source disk to copy the partition table from.
          * `/dev/sdb`: Target (new) disk to copy the partition table to from the source disk.
      1. If the partitions are not displayed after copying, re-read the partition table:

          ```bash
          sfdisk -R /dev/sdb
          ```

    {% endlist %}

1. Add the disk to the RAID array by adding the corresponding disk partitions to the RAID partitions one by one. The mapping between these partitions was done earlier in [{#T}](#remove-from-raid).

    Run the following commands:

    ```bash
    mdadm /dev/md1 --add /dev/sdb2
    mdadm /dev/md2 --add /dev/sdb3
    mdadm /dev/md3 --add /dev/sdb4
    ```

    Once a disk is added to the array, synchronization begins, its speed depending on disk size and type (`ssd`/`hdd`).

    Result:

    ```text
    mdadm: added /dev/sdb2
    mdadm: added /dev/sdb3
    mdadm: added /dev/sdb4
    ```

1. Make sure the new disk is added to the RAID array:

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
1. Install the Linux OS bootloader on the new disk:

    ```bash
    grub-install /dev/sdb
    ```

    Result:

    ```text
    Installing for i386-pc platform.
    Installation finished. No error reported.
    ```

#### See also {#see-also}

* [{#T}](./rescue-boot.md)
* [{#T}](./reset-password.md)
* [{#T}](./restore-grub.md)