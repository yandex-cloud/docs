# Disks, snapshots, and images

#### How much disk space can I use for a virtual machine? {#disk-size}

For disk limitations, see [{#T}](../../compute/concepts/limits.md).

#### How do I change the size of a disk? {#disk-resize}

You can increase your disk size within the [limits](../../compute/concepts/limits.md#compute-limits-disks) by following the instructions [{#T}](../../compute/operations/disk-control/update.md#change-disk-size). The data on the disk is kept. Make sure to wait until the operation is complete.

However, the architecture of technologies used in {{ yandex-cloud }} doesn't enable you to decrease the disk size. It's also impossible to create from the snapshot a disk smaller than the parent disk.

If the partition on the Linux boot disk doesn't expand automatically after increasing the disk size, use the following commands:

```bash
sudo growpart /dev/vda 2
```

```bash
sudo resize2fs /dev/vda2
```

For non-bootable disks, the partition size won't expand automatically. Use standard OS tools for this purpose (for example, `parted`).

#### How do I upload a custom image? {#load-image}

Follow this guide: [{#T}](../../compute/operations/image-create/upload.md).

To ensure that the VM created from your image functions properly, follow the steps specified in the guide.

If you have followed all recommendations and the image still fails to start up, or in case you have other questions, contact support.

#### What happens to the VMs running outdated OS versions? {#end-of-life}

{% include [end-of-life](../../_includes/compute/end-of-life.md) %}

#### Should I use swap? {#swap-use}

Avoid using swap in cloud systems whenever possible because the disk subsystem can become a bottleneck for the entire guest system. [Network disk limits](../../compute/concepts/limits.md#compute-limits-disks) are too low to use the disk as a RAM extension.

Instead of swap, you can use the `zram-config` utility. It allows you to organize a kind of swap inside the RAM itself thanks to compression, which is ten times faster than I/O with a disk. Keep in mind that with a high load on I/O and/or vCPUs, the use of `zram-config` may negatively affect `iowait` and, consequently, the performance of the network, disks, and vCPUs.

The best solution for increasing available memory is to expand the vRAM on the VM.

#### What should I do if a snapshot is larger than the data on the disk? {#snapshot-size-larger}

This happens if occupied sectors remain on a disk after you delete files from it.

The solution is to write a file consisting of zeros to the entire unoccupied disk space, then flush the cache to the disk, and delete the record about this file.

* For Windows: stop disk operations and use the `SDelete` utility. You can learn more about the utility and download it in the [Microsoft documentation]({{ ms.docs }}/sysinternals/downloads/sdelete).
* For Linux: stop disk operations and enter the following commands one-by-one:

   ```bash
   dd if=/dev/zero | pv > full.disk
   ```

   ```bash
   sync
   ```

   ```bash
   rm full.disk
   ```

The "empty" space on the disk then becomes truly empty and you can create a disk snapshot. Its size will become closer to the currently used disk space.


#### Can I create several snapshots of the same disk at a time? {#snapshot-simultaneous}

No, only a single snapshot can be created for one disk at a time. All other schedules for a given disk are ignored until a snapshot for this disk is created (manually or as [scheduled](../../compute/concepts/snapshot-schedule.md)).


#### How are snapshot quotas counted? {#how-shapshot-qoutas-taken}

Snapshots are billable and count towards [quotas]({{ link-console-quotas }}) with their actual sizes.

#### How do I move a VM to another folder/cloud? {#move-vm-folder-cloud}

1. Grant rights in your cloud to a user from another cloud:
   * Role for the cloud: `resource-manager.clouds.member`.
   * Role for the folder: `viewer` or `compute.images.user`.


   See the instructions [{#T}](../../iam/operations/roles/grant.md).
1. Create an image from your snapshot under **{{ ui-key.yacloud.compute.switch_snapshots }}** or from the disk itself under **{{ ui-key.yacloud.compute.switch_disks }}**.

A user in another cloud must:
1. Run the [CLI](../../cli/) command below:

   ```bash
   yc compute image create --source-image-id=<your_image_ID>
   ```

1. When creating a VM, specify this image as a boot disk.


#### How do I attach a new disk to a VM? {#attach-disk-to-vm}

After creating and connecting a new disk to the VM, you need to mount it or assign it a letter, depending on the operating system. Follow this guide: [{#T}](../../compute/operations/vm-control/vm-attach-disk.md#mount-disk-and-fix-uuid).


#### How do I set up automatic backups? {#set-up-automatic-snapshot-creation}

For disk backups in {{ compute-name }}, you can make disk copies — [snapshots](../../compute/concepts/snapshot.md). For automatic creation of snapshots, use [schedules](../../compute/concepts/snapshot-schedule.md).

For more information, see [{#T}](../../compute/concepts/backups.md).


#### Why was a disk snapshot created later rather than exactly at the scheduled time? {#snapshot-schedule-delays}

{% include [snapshot-schedule-delay](../../_includes/compute/snapshot-schedule-delay.md) %}


#### Can I create snapshots of the same disk according to several schedules? {#snapshot-schedule-multiple}

Yes, you can add a disk to several schedules. There are fixed [limits](../../compute/concepts/limits.md#compute-limits-snapshot-schedule) on the number of disk schedules.


#### In what time zone is the time written in disk snapshot schedule settings? {#snapshot-schedule-tz}

The time is provided for the [UTC](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00) time zone.


#### Can I choose a folder for scheduled disk snapshots? {#snapshot-schedule-catalog}

Snapshots are created in the same folder as the schedule, even if disks from other folders are added to the schedule.


#### What format of cron expressions is supported in disk snapshot schedules? {#snapshot-schedule-cron-format}

See section [{#T}](../../compute/concepts/snapshot-schedule.md#cron).


#### If the schedule is configured to keep several of the last disk snapshots, are old snapshots deleted before or after new ones are created? {#snapshot-schedule-retention-order}

After. A new snapshot is created first, then the old one is deleted. For example, if you want to keep only the last five snapshots, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, etc.


#### What happens to operations and created snapshots when disk snapshot schedules are changed, interrupted, or deleted? {#snapshot-schedule-stop-delete}

All snapshot creation or deletion operations that started prior to changing, interrupting or deleting the schedule will be completed. Snapshots that were not deleted according to schedule [retention settings](../../compute/concepts/snapshot-schedule.md#retention) are kept.


#### What happens to my data when I delete a virtual machine? {#delete-vm}

When selecting a disk to attach to a VM, you can specify that the disk should be deleted once you delete the VM. This option is also available when you create a VM, reconfigure it, or attach a new disk to it.

If a VM had any previously created disks attached, they will be detached when you delete the VM. The disk data is preserved, and this disk can be attached to another VM later.

If you would like to delete a disk with a VM, specify this option when creating the VM, reconfiguring it, or attaching the disk. Such disks will be deleted along with the VM.

#### Do I need to stop a VM to create disk snapshots? Do I have to wait until disk snapshots are created before I can start a virtual machine? {#create-snapshot}

You don't have to stop the VM. However, keep in mind that a snapshot contains only the data written to disk when creating the snapshot. You need to take care of the data integrity yourself. For information about how to create disk snapshots, see [{#T}](../../compute/operations/disk-control/create-snapshot.md).

A snapshot is created asynchronously. You can resume writing data to your disk immediately after running the create snapshot command without waiting for the snapshot generation to be completed.

#### Is it possible to download an image of a created VM? {#download-image}

This is not supported yet. However, you can copy data from a VM using application software, such as rsync, dd, or GNU Wget.

If you would like us to implement downloading or manually exporting VM images and disk snapshots to external resources or a local device, [suggest](https://cloud.yandex.ru/features) this idea or vote for a similar one. We regularly review all the suggestions and add them to our development roadmap. We will notify you as soon as the idea you suggested or voted for has been implemented.

#### How do I detect processes that put a heavy load on a disk? {#disk-heavy-load}

You can detect these processes using the [iotop](https://manpages.ubuntu.com/manpages/xenial/man8/iotop.8.html) utility. Run it on a schedule with [cron](https://en.wikipedia.org/wiki/Cron) and save a log with processes that have a data transfer speed of more than 1,000 KB/s:

```bash
/usr/sbin/iotop -botqqqk --iter=60 | grep -P "\d\d\d\d.\d\d K/s" >> /var/log/iotop.log
```
