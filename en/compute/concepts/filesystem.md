---
title: File storages
description: In this article, you will learn about the concept of file storages, their types, as well as related requirements and limitations.
---

# File storages


A _file storage_ is a virtual file system that can be attached to multiple {{ compute-name }} [VMs](vm.md) in the same availability zone. Users can share files in a storage and use them from different VMs.

Each file storage resides in an availability zone where it is replicated for data protection. File storages are not replicated across availability zones.

A storage is attached to a VM through [Filesystem in Userspace](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) (FUSE) as a [virtiofs](https://www.kernel.org/doc/html/latest/filesystems/virtiofs.html) device without a direct link to the host file system.

By default, file storages have a zero [quota](limits.md#compute-quotas). To get your [quotas]({{ link-console-quotas }}) increased, contact [support](../../support/overview.md).

## File storage as a {{ yandex-cloud }} resource {#file-storage-as-resource}

A file storage is created in a folder and inherits its access permissions.

You are charged for the space used by a storage depending on its size. For more information, see [{#T}](../pricing.md). The maximum storage size is 8,192 GB.

## File storage types {#types}

When creating a file storage, you can choose one of the following types:
* SSD storage (`network-ssd`): High-speed SSD-based file storage.
* HDD storage (`network-hdd`): Standard HDD-based file storage.

Once you have created a storage, you cannot change its type.

## Attaching and detaching a file storage {#attach-detach}

You can attach each file storage to one or multiple VMs. A storage and all VMs it is attached to must be in the same availability zone.

When you delete a VM, any attached storages are detached from it. In this case, the data the storages contain is saved and their connections to other VMs persist.

## Requirements and restrictions {#requirements-and-limits}

### OS support {#os}

You can attach a file storage to VMs running Linux with kernel version 5.4 or higher. To check the kernel version, use the `uname -r` command. If you create a VM from a custom [image](image.md), prepare it using [this guide](../operations/image-create/custom-image.md).

Attaching file storages to Windows-based VMs in {{ compute-name }} is currently not supported.

**See also**

* [{#T}](../operations/filesystem/create.md)
* [{#T}](../operations/filesystem/attach-to-vm.md)
* [{#T}](../operations/filesystem/detach-from-vm.md)
