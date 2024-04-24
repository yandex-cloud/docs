# Disks

In {{ cloud-desktop-name }}, _disks_ are virtual counterparts of physical storage devices, such as SSDs and HDDs.

Disks are designed to store data and are attached to [desktops](desktops-and-groups.md) as [network block devices](https://en.wikipedia.org/wiki/Network_block_device). In case you stop a desktop, its data will be still there.

{{ cloud-desktop-name }} supports network SSDs and HDDs.

Each desktop has a [boot](#boot-disk) disk and a [working](#working-disk) disk attached.

You specify disk configuration when [creating a desktop group](../operations/desktop-groups/create.md).

For more information about disks, see the [{{ compute-name }} documentation](../../compute/concepts/disk.md).

## Boot disk {#boot-disk}

A boot disk contains OS files and desktop software components.

You cannot edit the boot disk configuration after creating a desktop group.

In case you update the desktop group [image](images.md), this will delete all data on the boot disk.

## Working disk {#working-disk}

A working disk contains user files. On Linux desktops, this disk is mounted to the user directory.

You can [increase](../operations/desktop-groups/update.md) the size of the working disk after creating a desktop group.

In case you update the desktop group image, the data on the working disk will be still there.
