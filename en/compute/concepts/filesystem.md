# File storage

{% note info %}

File storage is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}

_File storage_ is a virtual file system that can be attached to multiple {{ compute-name }} [VMs](vm.md) in the same availability zone. Users can share files in storage and use them from different VMs.

Each file storage is located either in availability zone `{{ region-id }}-a` or in availability zone `{{ region-id }}-b` where it's replicated to safeguard the data. File storage is not replicated across availability zones.

Storage is attached to a VM through the [Filesystem in Userspace]{% if lang == "en" %}(https://en.wikipedia.org/wiki/Filesystem_in_Userspace){% else %}(https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)){% endif %} (FUSE) interface as a [virtiofs](https://www.kernel.org/doc/html/latest/filesystems/virtiofs.html) device that is not linked to the host file system directly.

By default, file storages have a [quota](limits.md#compute-quotas) of zero. To increase the [quota]({{ link-console-quotas }}), contact [support](../../support/overview.md).

## File storage as a {{ yandex-cloud }} resource {#file-storage-as-resource}

File storage is created in a folder and inherits access rights.

You're charged for the space used by storage depending on its size. For more information, see [{#T}](../pricing.md). The maximum storage size is 8192 GB.

## OS support {#os}

You can attach file storage to VMs running Linux with kernel version 5.4 or higher. To check the kernel version, use the `uname -r` command. If you create a VM from a custom [image](image.md), prepare it by following the [instructions](../operations/image-create/custom-image.md).

Attaching file storage to Windows-based VMs in {{ compute-name }} is currently not supported.

## File storage types {#types}

When creating file storage, you can choose one of the following types:
* SSD storage (`network-ssd`): Fast file storage on SSD drives.
* HDD storage (`network-hdd`): Standard network storage on HDD drives.

After creating storage, you can't change its type.

## Attaching and detaching file storage {#attach-detach}

Each file storage can be attached to one or more VMs. Storage and all the VMs it's attached to must be in the same availability zone.

When you delete a VM, any attached storage is detached from it. In this case, the data in storage is saved and their attachments to other VMs are preserved.

**See also**

* [{#T}](../operations/filesystem/create.md)
* [{#T}](../operations/filesystem/attach-to-vm.md)
* [{#T}](../operations/filesystem/detach-from-vm.md)