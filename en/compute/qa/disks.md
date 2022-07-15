# Disks, snapshots, and images

#### How much disk space can I use for a virtual machine? {#disk-size}

For disk limitations, see [{#T}](../concepts/limits.md).

#### How do I change the size of a disk? {#disk-resize}

You can increase your disk size within the [limits](../concepts/limits.md#limits-disks) by following the instructions [{#T}](../operations/disk-control/update.md#change-disk-size). The data on the disk is kept. Make sure to wait until the operation is complete.

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

Follow the instructions: [{#T}](../operations/image-create/upload.md).

To ensure that the VM created from your image functions properly, follow all of the instructions.

If you have followed all the recommendations, but the image fails to start up, or if you have other questions, contact support.

#### Should I use swap? {#swap-use}

Avoid using swap in cloud systems whenever possible because the disk subsystem can become a "bottleneck" for the entire guest system. [Network disk limits](../concepts/limits.md#compute-limits-disk) are too low to use the disk as a RAM "extension".

Instead of swap, you can use the `zram-config` utility. It allows you to organize a kind of swap inside the RAM itself thanks to compression, which is ten times faster than IO with a disk. Keep in mind that with a high load on IO and/or vCPUs, the use of `zram-config` may negatively affect `iowait` and, consequently, the operation of the network, disks, and vCPUs.

The best solution for increasing available memory is to expand the vRAM on the VM.

#### Why is the size of a snapshot bigger than the amount of data on the disk? {#snapshot-size-larger}

This happens because occupied sectors remain on the disk after you delete files from it.

The solution is to write a file consisting of zeros to the entire unoccupied disk space, then flush the cache to the disk and delete the record about this file.

* For Windows: stop disk operations and use the `SDelete` utility. You can find out how it works and download it in the [Microsoft documentation]({{ ms.docs }}/sysinternals/downloads/sdelete).
* For Linux: stop disk operations and enter the following commands one by one:

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

#### How are snapshot quotas counted? {#how-shapshot-qoutas-taken}

Snapshots count against [quotas]({{ link-console-quotas }}) by their parent disk sizes. For example, if a snapshot was created from a 250 GB disk, the quota for the size of snapshots allows for 250 GB, even if the actual size of the snapshot is 20 GB. This is done so that both developers and customers can realistically understand possible loads on the disk snapshot service.

This approach to quotas doesn't affect pricing: snapshots are charged according to their real size.

#### How do I move a virtual machine to another folder/cloud? {#move-vm-folder-cloud}

1. Grant rights in your cloud to a user from another cloud:
   * Role for the cloud: `resource-manager.clouds.member`.
   * Role for the folder: `viewer` or `compute.images.user`.


   See the instructions [{#T}](../../iam/operations/roles/grant.md).
1. Create an image from your snapshot under **Disk snapshots** or from the disk itself under **Disks**.

A user in another cloud must:
1. Run the [CLI](../../cli/) command below:

   ```bash
   yc compute image create --source-image-id=<your_image_ID>
   ```

1. When creating a VM, specify this image as a boot disk.


#### How do I attach a new disk to a virtual machine? {#attach-disk-to-vm}

After creating and connecting a new disk to the VM, you need to mount it or assign it a letter, depending on the operating system. Follow the instructions: [{#T}](../operations/vm-control/vm-attach-disk.md#mount-disk-and-fix-uuid).

#### How do I set up automatic backups? {#set-up-automatic-snapshot-creation}

Currently, {{ compute-name }} doesn't have a ready-made solution for automatic backups, but you can use the approach described in our blog: [Creating scheduled disk snapshots with {{ sf-full-name }}](https://cloud.yandex.ru/blog/posts/2020/01/snapshot-triggers).

Note that the code is provided as is. {{ yandex-cloud }} has no commitment to revise or update it.

To back up the data manually, [use disk snapshots](../concepts/backups.md).

#### What happens to my data when I delete a virtual machine? {#delete-vm}

When selecting a disk to attach to a VM, you can specify whether the disk should be deleted along with the VM. You can choose this option when creating a VM, reconfiguring it, or attaching a new disk.

If a VM had previously created disks attached, they will be detached when you delete the VM. The disk data is preserved, and this disk can be attached to another VM later.

If you would like to delete a disk with a VM, specify this option when creating the VM, reconfiguring it, or attaching the disk. Such disks will be deleted along with the VM.

#### Do I need to stop a VM to create disk snapshots? Do I have to wait until disk snapshots are created before I can start a virtual machine? {#create-snapshot}

You don't have to stop the VM. However, keep in mind that a snapshot contains only the data written to disk when creating the snapshot. You need to take care of the data integrity yourself. For information about how to create disk snapshots, see [{#T}](../operations/disk-control/create-snapshot.md).

A snapshot is created asynchronously. You can resume writing data to disk immediately after running the create snapshot command, without waiting for the snapshot creation to be completed.
