# Disks

_Disks_ are virtual versions of physical storage devices, such as SSD and HDD.

Disks are designed to store data and are attached to [desktops](desktops-and-groups.md) as [network block devices](https://en.wikipedia.org/wiki/Network_block_device). Stopping a desktop does not delete its data.

{{ cloud-desktop-name }} supports network SSDs and HDDs.

Each desktop is attached a [boot](#boot-disk) disk and a [working](#working-disk) disk.

Disks are set up when [creating a desktop group](../operations/desktop-groups/create.md).

For more information about disks, see the [{{ compute-name }} documentation](../../compute/concepts/disk.md).

## Boot disk {#boot-disk}

A boot disk contains OS files and desktop software components.

You cannot edit the boot disk parameters after creating a desktop group.

Updating a desktop group's [image](images.md) deletes all data on the boot disk.

## Working disk {#working-disk}

A working disk contains user files. On Linux desktops, this disk is mounted to the user's directory.

You can [increase](../operations/desktop-groups/update.md) the size of the working disk after creating a desktop group.

Updating a desktop group's image does not delete any data on the working disk.
