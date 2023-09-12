# Changing the boot disk for an instance to SSD

## Issue description {#case-description}
You need to change the boot disk type for an existing Compute Cloud instance from HDD to SSD.

## Solution {#case-description}

You can change the boot disk type from HDD to SSD by recreating your instance from a disk snapshot or image.

A [disk snapshot](../../../compute/concepts/snapshot) only contains the data that had already been written to the disk when the snapshot was created. If the disk is attached to a running VM, the OS and app cache will not be included in the snapshot. Snapshots are better suited for regular backups inside instances.

For more information about preparing a VM for disk snapshot creation and maintaining the integrity of the snapshot data, see [Creating a disk snapshot](../../../compute/operations/disk-control/create-snapshot#prepare) in the documentation.

[Images](../../../compute/concepts/image) are better suited for quick resource deployment, for example, from bootable VM disks. This means that it takes less time to create disks and instances from images than from snapshots.

To change the disk type for your VM instance, follow these steps:
1. Using a snapshot:
   - [Create a snapshot](../../../compute/operations/disk-control/create-snapshot.md) of the current disk.
   - [Create a new VM from the snapshot](../../../compute/operations/vm-create/create-from-snapshots.md).

1. Using an image:
   - [Create an image](../../../compute/operations/image-create/create-from-disk.md) from the current disk.
   - [Create a new VM from the image](../../../compute/operations/vm-create/create-from-user-image.md).

Make sure that the new VM boots and includes all the required data. After that, you can delete the old VM.