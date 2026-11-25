# Disks, snapshots, and images

{% include [minitoc](minitoc/disks.md) %}

#### How much disk space can I use for a virtual machine? {#disk-size}

For disk space limits, see [{#T}](../../compute/concepts/limits.md).

#### How do I resize a disk? {#disk-resize}

To learn how to increase the disk size within the [limits](../../compute/concepts/limits.md#compute-limits-disks), see [this guide](../../compute/operations/disk-control/update.md#change-disk-size). The data on your disk remain intact; however, you need to wait for the operation to complete.

If the new size appears in the API response, CLI, and management console, but is not available inside the guest OS, extend the partition and file system by following [this guide](../../compute/operations/disk-control/update.md#change-part-size-linux). Commands vary depending on the disk layout and file system type. Before extending partitions, [create a disk snapshot](../../compute/operations/disk-control/create-snapshot.md).

Shrinking an existing disk or creating a smaller disk from a snapshot of it is not supported. For a boot disk, create a new VM with a disk of the size you need and transfer the data. For an additional disk, create an [empty disk](../../compute/operations/disk-create/empty.md), [attach it to your VM](../../compute/operations/vm-control/vm-attach-disk.md), and copy the data. Check the transferred data before deleting the old disk.

#### How do I upload a custom image? {#load-image}

See [{#T}](../../compute/operations/image-create/upload.md).

To ensure your VM created from a custom image works properly, follow all steps in the guide.

If you have followed all recommended steps but still have issues with the image, or in case you have other questions, create a support request.

#### What happens to VMs running outdated OS versions? {#end-of-life}

{% include [end-of-life](../../_includes/compute/end-of-life.md) %}

#### Should I use swap? {#swap-use}

Swap is strongly discouraged in cloud environments, as the disk subsystem can become a bottleneck for the entire guest system. [Network disk limits](../../compute/concepts/limits.md#compute-limits-disks) are too low to use the disk as a RAM extension.

Instead of swap, you can use `zram-config`. It enables you to create a swap-like space within RAM itself, leveraging compression that is significantly faster than disk I/O. Keep in mind that under high I/O and/or vCPU loads, `zram-config` may negatively impact `iowait`, affecting network, disk, and vCPU performance.

The most effective way to increase available memory is to expand vRAM on your VM.

#### What should I do if a snapshot is larger than the actual data on the disk? {#snapshot-size-larger}

This happens when deleted files leave behind filled sectors on the disk.

To resolve this, create a zero-filled file to overwrite all unused disk space, flush the cache to the disk, and then delete the file entry.

{% note info %}

This does not work for [encrypted disks](../../compute/concepts/encryption.md#encryption-options), as the written zeros get encrypted with the disk key and are not compressed. After the free space is filled with zeros, the snapshot will expand to the full disk size.

{% endnote %}

{% list tabs group=operating_system %}

- Windows {#windows}

  Stop disk operations and use the `SDelete` utility. You can learn more about this utility and download it from the [relevant Microsoft article]({{ ms.docs }}/sysinternals/downloads/sdelete).

- Linux {#linux}

  Stop disk operations and run the following commands one by one:

  ```bash
  dd if=/dev/zero | pv > full.disk
  ```

  ```bash
  sync
  ```

  ```bash
  rm full.disk
  ```

{% endlist %}

Now, all unused space becomes actually empty and you can create a disk snapshot. The snapshot size will be nearly the same as the currently used disk space.

#### Can I create multiple snapshots of the same disk at a time? {#snapshot-simultaneous}

No, you can only create a single snapshot of a disk at a time. While a disk snapshot is being created (either manually or [on a schedule](../../compute/concepts/snapshot-schedule.md)), all other scheduled operations for the disk will be skipped.


#### How do snapshots count towards quotas? {#how-shapshot-qoutas-taken}

Snapshots are billed and count towards [quotas]({{ link-console-quotas }}) based on their actual sizes.

#### How do I move a VM to a different folder or cloud? {#move-vm-folder-cloud}

To migrate an existing VM, follow these guides:

* [Moving a VM to a different folder](../../compute/operations/vm-control/vm-change-folder.md)
* [Moving a VM to a different cloud](../../compute/operations/vm-control/vm-change-cloud.md)

#### How do I attach a new disk to my VM? {#attach-disk-to-vm}

After creating a new disk and attaching it to your VM, you need to mount it or assign it a letter, depending on your operating system. See [{#T}](../../compute/operations/vm-control/vm-attach-disk.md#mount-disk-and-fix-uuid).


#### How do I set up automatic backups? {#set-up-automatic-snapshot-creation}

Set up [scheduled disk snapshots](../../compute/operations/snapshot-control/create-schedule.md). To restore data from a snapshot, [create a new VM](../../compute/operations/vm-create/create-from-snapshots.md) or [disk](../../compute/operations/disk-create/from-snapshot.md) from it.


You can also use [{{ backup-full-name }}](../../backup/concepts/backup.md) for backup and restore. For supported OSs and requirements, see [this article](../../backup/concepts/vm-connection/compute.md).


For more details, see [Backups](../../compute/concepts/backups.md).

#### Why was a disk snapshot created later than scheduled? {#snapshot-schedule-delays}

{% include [snapshot-schedule-delay](../../_includes/compute/snapshot-schedule-delay.md) %}


#### Can I add a single disk to multiple schedules to create snapshots? {#snapshot-schedule-multiple}

Yes, you can add a disk to multiple schedules. There are fixed [limits](../../compute/concepts/limits.md#compute-limits-snapshot-schedule) on the number of schedules for a disk.


#### What time zone is used for snapshot schedules? {#snapshot-schedule-tz}

Use [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).


#### Can I choose a folder for scheduled disk snapshots? {#snapshot-schedule-catalog}

All snapshots will be created in the same folder as the schedule, regardless of whether the schedule includes disks from other folders.


#### What cron expression format is supported for disk snapshot schedules? {#snapshot-schedule-cron-format}

See [{#T}](../../compute/concepts/snapshot-schedule.md#cron).


#### If a schedule is configured to keep only the most recent disk snapshots, are older snapshots deleted before or after new ones are created? {#snapshot-schedule-retention-order}

After. A new snapshot is created first, then the oldest one is deleted. For example, if you want to keep only the most recent five snapshots, the first snapshot will only be deleted after the sixth one is created, the second snapshot will be deleted after the seventh one is created, and so on.


#### What happens to operations and existing snapshots if I edit, stop, or delete a disk snapshot schedule? {#snapshot-schedule-stop-delete}

All running snapshot creation or deletion operations initiated prior to changing, disabling, or deleting the schedule will be completed. Snapshots that were not deleted according to schedule [retention settings](../../compute/concepts/snapshot-schedule.md#retention) will stay unaffected.


#### What happens to the data if I delete a VM? {#delete-vm}

When selecting a disk to attach to your VM, you can specify whether to delete that disk when deleting the VM. You can enable this option when creating or updating a VM, or when attaching a new disk to it.

Disks attached to a VM prior to its deletion will automatically be detached. This will not affect disk data, and you will be able to attach this disk to another VM when needed.

If you want to have a disk deleted with the VM is it attached to, enable the relevant option when creating the VM, updating it, or attaching the disk. Such disks will be deleted along with the VM.

#### Do I have to stop the VM to create disk snapshots? Do I have to wait until disk snapshots are created before I can start a VM? {#create-snapshot}

You do not have to stop your VM. However, keep in mind that a snapshot only contains the data available on the disk at the time of creating the snapshot. You need to take care of data integrity yourself. For more information on how to create a disk snapshot, see [{#T}](../../compute/operations/disk-control/create-snapshot.md).

Snapshots are created asynchronously. You can resume writing data to your disk immediately after running the create snapshot command, without waiting for it to complete.

#### Can I download an image of a created VM? {#download-image}

{{ compute-name }} features no dedicated operation for downloading a VM image.

You can use [Yandex Cloud Disk Export Tool](https://github.com/yandex-cloud-examples/yc-disk-export-tool) to export a disk, image, or snapshot to an {{ objstorage-name }} bucket as a QCOW2 file, which you can further download to your local machine.

You can also copy data from your VM using [rsync](https://en.wikipedia.org/wiki/Rsync), [dd](https://en.wikipedia.org/wiki/Dd_(Unix)), or [GNU Wget](https://en.wikipedia.org/wiki/Wget).

To copy a disk using `dd`:

1. [Stop your source VM](../../compute/operations/vm-control/vm-stop-and-start.md#stop), as the disk data must not change while copying.
1. [Create a disk image](../../compute/operations/image-create/create-from-disk.md).
1. From this image, [create a disk](../../compute/operations/disk-create/from-image.md) and [attach it as a secondary disk](../../compute/operations/vm-control/vm-attach-disk.md) to a helper Linux VM. Do not mount file systems from this disk, since `dd` reads the block device directly.
1. [Connect to the helper VM over SSH](../../compute/operations/vm-connect/ssh.md) and identify the secondary disk name using `lsblk`. Make sure you selected the source disk copy.
1. On your local machine, run this command (replace the placeholders with your own username, helper VM IP address, and path to the secondary disk):

   ```bash
   ssh <username>@<VM_IP_address> 'sudo -n dd if=<disk_path> status=progress' > disk.img
   ```

   This command requires permissions to read the disk using `sudo` without an interactive password prompt. Make sure your local machine has enough free space for the full disk size. Verify that the command completes without errors before using the image.

1. Once you have verified the image, delete any unneeded helper resources to stop incurring charges.

#### How to transfer a disk image to an S3-compatible storage of a third-party provider? {#export-disk-to-s3}

Follow [this guide](../../compute/operations/disk-control/disk-migration-to-external-s3.md). It describes creating a byte-for-byte disk image, uploading a compressed file to an external S3-compatible storage, and test recovery to a dedicated disk.

#### How do I detect processes that cause a heavy load on the disk? {#disk-heavy-load}

You can detect these processes using [iotop](https://manpages.ubuntu.com/manpages/xenial/man8/iotop.8.html). Run it on a schedule with [cron](https://en.wikipedia.org/wiki/Cron) and log any processes that have a data transfer rate of more than 1,000 KB/s:

```bash
/usr/sbin/iotop -botqqqk --iter=60 | grep -P "\d\d\d\d.\d\d K/s" >> /var/log/iotop.log
```

#### How can I find out the terms and conditions of technical support for public images? {#public-image-support}

{% include [public-image-support](../../_includes/compute/public-image-support.md) %}

#### How do I create a VM with a different boot disk type? {#change-boot-disk-type}

You cannot change the type of an existing boot disk. You will need to create a new VM from a [snapshot](../../compute/operations/vm-create/create-from-snapshots.md) or [image](../../compute/operations/vm-create/create-from-user-image.md) of the source disk and select the new type you need. The new VM will get a different ID.

Before creating a snapshot, [get your disk ready](../../compute/operations/disk-control/create-snapshot.md#prepare) to ensure data integrity. Check that your new VM starts correctly, and verify its data and network settings before deleting the old one.

#### Can I create a VM from an ISO image? {#iso-image}

No, you cannot create a VM from an ISO image directly; only QCOW2, VMDK, VHD, and RAW are supported. To view the image requirements, see [this guide](../../compute/operations/image-create/custom-image.md#create-image-file).

To migrate Linux, install it from an ISO image on your local hypervisor, get your disk image ready by following the guide above, [upload it to {{ objstorage-name }}](../../compute/operations/image-create/upload.md), and [create a VM from your image](../../compute/operations/vm-create/create-from-user-image.md).


For Windows, first review the [Microsoft Product Terms](../../microsoft/licensing.md).


#### What should I do if a non-replicated disk fails? {#nonreplicated-disk-error}

If a non-replicated disk fails and gets the `ERROR` status, you will no longer be able to restore data from it. You can only restore your data to a new disk from a previously created backup.

Therefore, do not rely on a non-replicated disk as your only storage for critical data. To enable fault tolerance, configure backups and redundant storage at the application level or using [RAID](https://en.wikipedia.org/wiki/RAID). Note that RAID is not a replacement for backups.

[Non-replicated disk placement groups](../../compute/concepts/disk-placement-group.md) allow you to place disks in different server racks. For more details on their properties and limitations, see [Non-replicated disks](../../compute/concepts/disk.md#nr-disks).

#### Why do I fail to create disk snapshots or snapshot schedules? {#snapshot-creation-failed}

Check your quotas for the number and total size of snapshots, as well as the number of schedules. If these quotas are exceeded, new snapshots will not be created, including scheduled ones. For more info on checking usage and increasing quotas, see [{{ compute-name }} quotas and limits](../../compute/concepts/limits.md).

If a snapshot is already being created for a disk, subsequent scheduled runs are skipped until the operation completes. For more details, see [Can I create multiple snapshots of the same disk at a time?](#snapshot-simultaneous).
