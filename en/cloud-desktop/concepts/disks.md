---
title: Disks in {{ cloud-desktop-name }}
description: Disks are virtual counterparts of physical storage devices, such as SSDs and HDDs. Disks are designed to store data and are attached to desktops as network block devices.
---

# Disks

_Disks_ are virtual counterparts of physical storage devices, such as SSDs and HDDs.

Disks are designed to store data and are attached to [desktops](desktops-and-groups.md) as [network block devices](https://en.wikipedia.org/wiki/Network_block_device). In case you stop a desktop, its data will be still there.

{{ cloud-desktop-name }} supports network SSDs and HDDs.

Each desktop has a [boot](#boot-disk) disk and a [data](#working-disk) disk attached.

You specify disk configuration when [creating a desktop group](../operations/desktop-groups/create.md).

For more on disks, see [this {{ compute-name }} guide](../../compute/concepts/disk.md).

## Boot disk {#boot-disk}

A boot disk contains OS files and desktop software components.

You cannot edit the boot disk configuration after creating a desktop group.

Updating an [image](images.md), data disk size, vCPU, vCPU or RAM share will delete all data on the boot disk.

## Data disk {#working-disk}

A data disk contains user files. On Linux desktops, this disk is mounted to the user directory.

You can [increase](../operations/desktop-groups/update.md) the data disk size after creating a desktop group.

All data on the data disk is preserved when you update the desktop group image.
