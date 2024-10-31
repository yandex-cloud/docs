---
title: Specifics of working with disks in {{ cos-full-name }}
description: Please note that, when creating a VM from a {{ coi }}, it's necessary to consider some specific aspects of working with disks.
---

# Specifics of working with disks

## Specifics of working with a boot disk

When [creating a VM from a {{ coi }}](../tutorials/vm-create.md), take into account the following specifics:
* You cannot create a boot disk from a [disk snapshot](../../compute/concepts/snapshot.md).
* By default, you create a disk that is the same size as the image. However, since the purpose of a VM created from a {{ coi }} is to run a Docker container, there may not be enough free space to deploy the Docker container. To avoid this, explicitly specify the required size of the boot disk using the `--create-boot-disk size=<disk_size_in_GB>` flag. The disk size must be at least 30 GB.

## Specifics of working with additional disks {#second-disk}

Using the `x-yc-disks` extension section in the [Docker Compose specification](./coi-specifications.md#compose-spec), you can [mount an additional volume inside the container](../tutorials/vm-create-with-second-disk.md):
* To mount a disk inside a virtual machine with {{ coi }}, the disk's `device-name` is used to search through the `/dev/disk/by-id/virtio-...` tree. If this parameter is not specified when attaching a disk to a VM, a [mounting error](../error/index.md#disk-mount) may occur.
* When using an additional disk that's partitioned, it's important to use the `partition: X` parameter with the partition number for mounting in the [Docker Compose specification](./coi-specifications.md#compose-spec-example).