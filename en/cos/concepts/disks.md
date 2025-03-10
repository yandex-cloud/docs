---
title: How to work with disks in {{ cos-full-name }}
description: In this article, you will learn about working with boot and secondary disks when creating a VM from a {{ coi }}.
---

# How to work with disks

## Working with a boot disk {#boot-disk}

When [creating](../tutorials/vm-create.md) a {{ coi }} VM, keep in mind that:
* You cannot create a boot disk from a [disk snapshot](../../compute/concepts/snapshot.md).
* By default, you create a disk the same size as the image. Therefore, a {{ coi }} VM may not have enough free space to deploy a Docker container. To avoid this, specify the required boot disk size using this flag: `--create-boot-disk size=<disk_size_in_GB>`.

   {% include [min-disk-size](../../_includes/cos/min-disk-size.md) %}

## Working with secondary disks {#second-disk}

You can [mount](../tutorials/vm-create-with-second-disk.md) a secondary disk into the container by using the `x-yc-disks` section of the [Docker Compose specification](./coi-specifications.md#compose-spec):
* To mount a disk into a {{ coi }} VM and search in the `/dev/disk/by-id/virtio-...` tree, use the disk `device-name`. If you do not specify this parameter when connecting the disk to the VM, you may get a [mount error](../error/index.md#disk-mount).
* When using a partitioned secondary disk, provide the `partition: x` parameter in the [Docker Compose specification](./coi-specifications.md#compose-spec-example), where `x` is the number of the partition to mount.
