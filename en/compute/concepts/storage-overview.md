# Disks and file storage

To work with data, you can attach the following {{ compute-name }} resources to [VMs](vm.md):

| Resource | Description |
| ----- | ----- |
| [Disk](disk.md) | Virtual counterpart of a physical drive attached to a VM as a [network block device](https://en.wikipedia.org/wiki/Network_block_device). You cannot attach a single disk to two or more different VMs at the same time. You can make a copy of the disk file system by creating a [_disk snapshot_](snapshot.md). |
| [File storage](filesystem.md) | Virtual file system attached to a VM through the [Filesystem in Userspace](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) (FUSE) interface as a [virtiofs](https://www.kernel.org/doc/html/latest/filesystems/virtiofs.html) device. You can attach a single file storage to multiple VMs. |

You can attach multiple disks (in addition to the required boot disk) and multiple file stores to each VM.

There are technical restrictions on [reads and writes](storage-read-write.md) that apply to disks and file storages.