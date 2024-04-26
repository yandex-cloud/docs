# File storages


_File storage_ is a virtual file system that can be attached to multiple {{ compute-name }} [VMs](vm.md) in the same availability zone. Users can share files in storage and use them from different VMs.

Each file storage is located either in the `{{ region-id }}-a` or `{{ region-id }}-b` availability zone where it is replicated to provide data protection. File storage is not replicated across availability zones.

Storage is attached to a VM through the [Filesystem in Userspace](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) (FUSE) interface as a [virtiofs](https://www.kernel.org/doc/html/latest/filesystems/virtiofs.html) device that is not linked to the host file system directly.

By default, file storages have a zero [quota](limits.md#compute-quotas). To increase the [quota]({{ link-console-quotas }}), contact [support](../../support/overview.md).

## File storage as a {{ yandex-cloud }} resource {#file-storage-as-resource}

File storage is created in a folder and inherits its access rights.

You are charged for the space used by a storage depending on its size. For more information, see [{#T}](../pricing.md). The maximum storage size is 8192 GB.

## File storage types {#types}

When creating a file storage, you can choose one of the following types:
* SSD storage (`network-ssd`): Fast file storage based on SSD drives.
* HDD storage (`network-hdd`): Standard network storage based on HDD drives.

Once you have created a storage, you cannot change its type.

## Attaching and detaching file storage {#attach-detach}

You can attach each file storage to one or more VMs. A storage and all VMs it is attached to must be in the same availability zone.

When you delete a VM, any attached storages are detached from it. In this case, the data the storages contain is saved and their links to other VMs persist.

## Requirements and restrictions {#requirements-and-limits}

### OS support {#os}

You can attach file storage to VMs running Linux with kernel version 5.4 or higher. To check the kernel version, use the `uname -r` command. If you create a VM from a custom [image](image.md), prepare it using [this guide](../operations/image-create/custom-image.md).

Attaching file storages to Windows-based VMs in {{ compute-name }} is currently not supported.

**See also**

* [{#T}](../operations/filesystem/create.md)
* [{#T}](../operations/filesystem/attach-to-vm.md)
* [{#T}](../operations/filesystem/detach-from-vm.md)
