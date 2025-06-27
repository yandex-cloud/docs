# Disks, snapshots, and images

#### How much disk space can I use for a virtual machine? {#disk-size}

For disk space limits, see [{#T}](../../compute/concepts/limits.md).

#### How do I resize a disk? {#disk-resize}

To increase your disk size within the [limits](../../compute/concepts/limits.md#compute-limits-disks), follow [this guide](../../compute/operations/disk-control/update.md#change-disk-size). This will not affect your disk data. Be sure to wait until the operation is complete.

Due to the architectural constraints of {{ yandex-cloud }} technologies, disk downsizing is not supported. The same applies to creating a disk from a snapshot: it cannot be smaller than the parent disk.

If resizing the disk does not automatically expand the partition on your Linux boot disk, use these commands:

```bash
sudo growpart /dev/vda 2
```

```bash
sudo resize2fs /dev/vda2
```

Non-bootable disks do not have the partition size increased automatically. You will need to use native OS tools to work with disks and their partitions, such as `parted`, `fdisk`, `cfdisk`, `sfdisk`, and `growpart`. For more information, see [{#T}](../../compute/operations/disk-control/update.md#change-part-size-linux).

To avoid accidentally losing data when resizing, we recommend that you first [create](../../compute/operations/disk-control/create-snapshot.md) a disk snapshot.

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

* For Windows: Stop disk operations and use `SDelete`. You can learn more about this utility and download it from the [relevant Microsoft article]({{ ms.docs }}/sysinternals/downloads/sdelete).
* For Linux: Stop disk operations and run the following commands one by one:

   ```bash
   dd if=/dev/zero | pv > full.disk
   ```

   ```bash
   sync
   ```

   ```bash
   rm full.disk
   ```

Now, all unused space becomes actually empty and you can create a disk snapshot. The snapshot size will be nearly the same as the currently used disk space.


#### Can I create multiple snapshots of the same disk at a time? {#snapshot-simultaneous}

No, you can only create a single snapshot of a disk at a time. While a disk snapshot is being created (either manually or [on a schedule](../../compute/concepts/snapshot-schedule.md)), all other scheduled operations for the disk will be skipped.


#### How do snapshots count towards quotas? {#how-shapshot-qoutas-taken}

Snapshots are billed and count towards [quotas]({{ link-console-quotas }}) based on their actual sizes.

#### How do I move a VM to a different folder or cloud? {#move-vm-folder-cloud}

1. Assign the following roles in your cloud to a user from a different cloud:
   * Role for the cloud: `resource-manager.clouds.member`.
   * Role for the folder: `viewer` or `compute.images.user`.

   For details, see [{#T}](../../iam/operations/roles/grant.md)this guide.
1. Create an image from your snapshot under **{{ ui-key.yacloud.compute.snapshots_81jHX }}** or from the disk itself under **{{ ui-key.yacloud.compute.disks_ddfdb }}**.

A user in the cloud you want to move your VM to must follow these steps:
1. Run this [CLI](../../cli/) command:

   ```bash
   yc compute image create --source-image-id=<your_image_ID>
   ```

1. When creating a VM, specify this image as the boot disk.

#### How do I attach a new disk to my VM? {#attach-disk-to-vm}

After creating a new disk and attaching it to your VM, you need to mount it or assign it a letter, depending on your operating system. See [{#T}](../../compute/operations/vm-control/vm-attach-disk.md#mount-disk-and-fix-uuid).


#### How do I set up automatic backups? {#set-up-automatic-snapshot-creation}

For disk backups in {{ compute-name }}, you can make disk copies called [snapshots](../../compute/concepts/snapshot.md). To automatically create snapshots, use [schedules](../../compute/concepts/snapshot-schedule.md).

For more information, see [{#T}](../../compute/concepts/backups.md).


#### Why was a disk snapshot created later than scheduled? {#snapshot-schedule-delays}

{% include [snapshot-schedule-delay](../../_includes/compute/snapshot-schedule-delay.md) %}


#### Can I add a single disk to multiple schedules to create snapshots? {#snapshot-schedule-multiple}

Yes, you can add a disk to multiple schedules. There are fixed [limits](../../compute/concepts/limits.md#compute-limits-snapshot-schedule) on the number of schedules for a disk.


#### What time zone is used for configuring snapshot schedules? {#snapshot-schedule-tz}

All times are [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).


#### Can I choose a folder for scheduled disk snapshots? {#snapshot-schedule-catalog}

All snapshots will be created in the same folder as the schedule, regardless of whether the schedule includes disks from other folders.


#### What cron expression format is supported for disk snapshot schedules? {#snapshot-schedule-cron-format}

See [{#T}](../../compute/concepts/snapshot-schedule.md#cron).


#### If a schedule is configured to keep only the most recent disk snapshots, are older snapshots deleted before or after new ones are created? {#snapshot-schedule-retention-order}

After. A new snapshot is created first, then the oldest one is deleted. For example, if you want to keep only the most recent five snapshots, the first snapshot will only be deleted after the sixth one is created, the second snapshot will be deleted after the seventh one is created, and so on.


#### What happens to running operations and existing snapshots when I change, disable, or delete a disk snapshot schedule? {#snapshot-schedule-stop-delete}

All running snapshot creation or deletion operations initiated prior to changing, disabling, or deleting the schedule will be completed. Snapshots that were not deleted according to schedule [retention settings](../../compute/concepts/snapshot-schedule.md#retention) will stay unaffected.


#### What happens to my data when I delete a VM? {#delete-vm}

When selecting a disk to attach to your VM, you can specify whether to delete that disk when deleting the VM. You can enable this option when creating or updating a VM, or when attaching a new disk to it.

Disks attached to a VM prior to its deletion will automatically be detached. This will not affect disk data, and you will be able to attach this disk to another VM when needed.

If you want to have a disk deleted with the VM is it attached to, enable the relevant option when creating the VM, updating it, or attaching the disk. Such disks will be deleted along with the VM.

#### Do I have to stop a VM to create disk snapshots? Do I have to wait until disk snapshots are created before I can start a VM? {#create-snapshot}

You do not have to stop your VM. However, keep in mind that a snapshot only contains the data available on the disk at the time of creating the snapshot. You need to take care of data integrity yourself. For more information on how to create a disk snapshot, see [{#T}](../../compute/operations/disk-control/create-snapshot.md).

Snapshots are created asynchronously. You can resume writing data to your disk immediately after running the create snapshot command, without waiting for it to complete.

#### Can I download an image of a created VM? {#download-image}

This option is not currently supported. However, you can copy data from your VM using application software, such as `rsync`, `dd`, or `GNU Wget`.

If you would like us to implement an option to manually download or upload VM images and disk snapshots from or to external resources or a local device, consider [suggesting](https://yandex.cloud/ru/features) this feature or voting for a similar one. We regularly review all suggestions and add them to our development roadmap. We will notify you as soon as the feature you suggested or voted for has been implemented.

#### How do I detect processes that are putting a heavy load on the disk? {#disk-heavy-load}

You can detect these processes using [iotop](https://manpages.ubuntu.com/manpages/xenial/man8/iotop.8.html). Run it on a schedule with [cron](https://en.wikipedia.org/wiki/Cron) and log any processes that have a data transfer rate of more than 1,000 KB/s:

```bash
/usr/sbin/iotop -botqqqk --iter=60 | grep -P "\d\d\d\d.\d\d K/s" >> /var/log/iotop.log
```

#### How can I find out the terms and conditions of technical support for public images? {#public-image-support}

{% include [public-image-support](../../_includes/compute/public-image-support.md) %}