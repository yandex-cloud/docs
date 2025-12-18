# How to reduce the size of a VM disk


## Case description {#case-description}

You need to decrease the size of a disk, snapshot, or image on your {{ compute-name }} VM.

## Solution {#case-resolution}

Due to certain specifics of the {{ yandex-cloud }} architecture, you can only expand the disk size. For more information about this, see the [relevant guide](../../../compute/operations/disk-control/update.md#change-disk-size).

To reduce the boot disk size on your VM, you will need to recreate the VM with the required disk size.

{% note warning %}

You cannot use a snapshot to create a disk that is smaller than its parent disk.

{% endnote %}

If you need to reduce the size of data disks in your VM, you can do the following:

* Create an empty disk of the required size.
* Without recreating the VM, transfer data from your old disk to the new one. 
* Remove the old disk after you are done migrating your data.

You can also store your data in {{ objstorage-name }}. Use [FUSE and GeeseFS](../../../storage/tools/geesefs.md) to mount your bucket as a folder.