# Disks and file storage

To work with data, you can attach the following {{ compute-name }} resources to [VMs](vm.md):

| Resource | Description |
| ----- | ----- |
| [Disk](disk.md) | A virtual analog of a physical drive attached to a VM as a [network block device](https://en.wikipedia.org/wiki/Network_block_device). You can only attach one disk to a single VM. You can make a copy of the disk's file system: a [_disk snapshot_](snapshot.md). |
| [File storage](filesystem.md) | _File storage is at the [Preview](../../overview/concepts/launch-stages.md) stage._ <br> A virtual file system attached to a VM through the [Filesystem in Userspace]{% if lang == "en" %}(https://en.wikipedia.org/wiki/Filesystem_in_Userspace){% else %}(https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)){% endif %} (FUSE) interface as a [virtiofs](https://www.kernel.org/doc/html/latest/filesystems/virtiofs.html) device. You can attach one file storage to multiple VMs. |

You can attach multiple disks (in addition to the required boot disk) and multiple file stores to each VM.

There are some technical restrictions on [reads and writes](storage-read-write.md) that apply to disks and file storage.