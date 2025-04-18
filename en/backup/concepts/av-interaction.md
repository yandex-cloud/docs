---
title: '{{ backup-full-name }} interaction with an antivirus'
description: In this tutorial, you will learn how an antivirus can affect incremental backups in {{ backup-name }}.
---


# Interaction with an antivirus

[Backup policies](policy.md) in {{ backup-full-name }} provide an [option](policy.md#specification) for quick backups: `fastBackupEnabled`. When creating an [incremental backup](backup.md#types) under such a policy, the {{ backup-name }} agent checks not all files but only those of them whose size or last accessing time changed. This allows creating incremental backups faster.

After an antivirus run, creating an incremental backup under a policy with enabled quick backups can take much longer than usual. This is because the antivirus changes the `access time` (last accessing time) value for each file being scanned. When creating another incremental copy, the {{ backup-name }} agent checks the disk in block mode and backs up the whole disk if it detects data in blocks has changed.

At the same time, the final size of an incremental backup does not change much: algorithms detect actual data on the disk has not changed.


## How to detect the antivirus affects backups {#symphtoms}

The antivirus affects quick backups in the following cases:

* You are using Linux.
* The antivirus performed a scan before the backup start.
* The {{ backup-name }} agent has processed the whole disk to create an incremental copy.
* The final backup size is comparable with previous incremental copies.
* The time required to create an incremental copy of a VM or {{ baremetal-name }} server has increased drastically.


## Solution {#decision}

* If backup time is not crucial, you can ignore the antivirus impact.

* However, if backup time is crucial and exceeds the allocated period, we recommend changing the volume mounting settings in `fstab` and disabling the `access time` parameter. To do this, specify the `noatime` parameter for the mounting point of a disk volume or partition in the `/etc/fstab` file.

For example:

```bash
/dev/mapper/vg1-disk /storage auto rw,noatime 0 0
```

or

```bash
mount -t ext4 /dev/mapper/vg1-disk /storage -o rw,noatime
```

In this case, `access time (atime)` is not written to the disk, and the antivirus scan does not affect backups.

