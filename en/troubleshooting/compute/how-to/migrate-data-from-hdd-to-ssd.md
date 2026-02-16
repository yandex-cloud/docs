# How to change a boot disk type for a VM instance


## Case description {#case-description}

You need to change the boot disk type for an existing {{ compute-name }} VM instance.

## Solution {#case-resolution}

You can change the boot disk type by recreating your VM from a disk snapshot or image.

A [disk snapshot](../../../compute/concepts/snapshot.md) only contains the data written to the disk at the time its snapshot was created. If the disk is attached to a running VM, the OS and app cache will not be included in the snapshot. Snapshots are better suited for regular VM backups. 

For more information about preparing a VM for a disk snapshot and maintaining the snapshot data integrity, see [**Creating a disk snapshot**](../../../compute/operations/disk-control/create-snapshot.md#prepare).

[Images](../../../compute/concepts/image.md) are better suited for quick resource deployment, for example, from bootable VM disks. This means it takes less time to create disks and VMs from images than from snapshots.

To change the disk type for your VM, follow these steps:

1. Using a snapshot:
   * [Create a snapshot](../../../compute/operations/disk-control/create-snapshot.md) of your current disk.
   * [Create a new VM from the snapshot](../../../compute/operations/vm-create/create-from-snapshots.md).

1. Using an image:
   * [Create an image](../../../compute/operations/image-create/create-from-disk.md) from your current disk.
   * [Create a new VM from the image](../../../compute/operations/vm-create/create-from-user-image.md).
  
{% note info %}

Make sure the new VM boots and includes all required data. After that, you can delete your old VM.

{% endnote %}