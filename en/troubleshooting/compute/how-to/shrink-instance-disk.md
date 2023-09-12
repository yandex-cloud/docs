# Decreasing VM disk size

## Issue description {#case-description}
You need to decrease the size of a disk, snapshot, or image on your Compute Cloud VM.

## Solution {#case-resolution}

Due to the Yandex Cloud architecture, you can only expand the disk size. For more information, see the [documentation article](../../../compute/operations/disk-control/update.md#change-disk-size).

If you need to decrease the boot disk size on your VM instance, you need to recreate the instance with the required disk size.

For this, you can create a disk snapshot of your VM and create a new disk from the snapshot, specifying the new size.

{% note alert %}

Bear in mind, a snapshot cannot be used to create a disk smaller than its parent disk.

{% endnote %}

If, however, you need to decrease the size of a non-boot disk on your instance, you can create an empty desk of the required size and move the data from the old disk to the new one without recreating your VM. Once the data is moved, you can delete the old disk.

You can also store your data in Object Storage. You can use [FUSE and GeeseFS](../../../storage/tools/geesefs.md) to mount your bucket as a folder