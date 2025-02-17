---
title: Working with disks in {{ cos-full-name }}
description: In this article, you will learn about working with boot and secondary disks when creating a VM from a {{ coi }}.
---

# Working with disks

## Working with a boot disk {#boot-disk}

When [creating](../tutorials/vm-create.md) a VM from a {{ coi }}, mind the following:
* You cannot create a boot disk from a [disk snapshot](../../compute/concepts/snapshot.md).
* By default, you create a disk that is the same size as the image. Therefore, a VM from a {{ coi }} may not have enough free space to deploy a Docker container. To avoid this, specify the required boot disk size using this flag: `--create-boot-disk size=<disk_size_in_GB>`.

   {% include [min-disk-size](../../_includes/cos/min-disk-size.md) %}

## Working with secondary disks {#second-disk}

You can [mount](../tutorials/vm-create-with-second-disk.md) a secondary disk into a container using the `x-yc-disks` extension in the [Docker Compose specification](./coi-specifications.md#compose-spec):
* To mount a disk into a VM from a {{ coi }} and to search using the `/dev/disk/by-id/virtio-...` tree, you need to use the disk’s `device-name`. If you do not specify this parameter when connecting the disk to the VM, you may get a [mount error](../error/index.md#disk-mount).
* When using a partitioned secondary disk, provide the `partition: x` parameter in the [Docker Compose specification](./coi-specifications.md#compose-spec-example), where `x` is the number of the partition to mount.
