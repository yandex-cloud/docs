---
title: Mounting file systems to a {{ sf-full-name }} function
description: In this tutorial, you will learn how to mount file systems to a function in {{ sf-full-name }}.
---

# Mounting external resources to a function file system

You can mount [buckets](../../storage/concepts/bucket.md) and one ephemeral disk to a {{ sf-full-name }} function. To avoid data access errors, all mount points for ephemeral disks and buckets must be unique.

{% endnote %}

## Mounting buckets {#mount-backet}

Mounting buckets allows you to access them through the file system interface. In the function [version settings](function.md#version), you can specify one or more mount points. Use this path to access the directory in which the bucket is mounted: `/function/storage/<mount_point>`.

You can mount the whole bucket or a specific [folder](../../storage/concepts/object.md#folder).


{% include [roles-for-bucket-mounting](../../_includes/functions/roles-for-bucket-mounting.md) %}

## Mounting an ephemeral disk {#mount-ephemeral-storage}

{% include [preview-and-request](../../_includes/note-preview-by-request.md) %}

To mount an ephemeral disk, you can specify a mount point. Use this path to access the directory in which the ephemeral disk is mounted: `/function/storage/<mount_point>`.

The ephemeral disk size is a multiple of 1 GB and is set in the range from 1 to 100 GB. The maximum size of the ephemeral disk at the [Preview](../../overview/concepts/launch-stages.md) stage cannot exceed 100 GB.

An ephemeral disk of a given size is created when the function is called just before the user code is executed. It is formatted into the [ext4](https://en.wikipedia.org/wiki/Ext4) file system and mounted at the specified mount point.

The user code will have read-write access to the ephemeral disk throughout the function's lifetime.

If a function is called multiple times, there is a chance that its repeated calls will be processed by the same instance. In this case, the data remaining on the disk after the previous call can be accessed. This function behavior is not determinated, and you cannot rely on the data being saved between calls.

{% note info %}

When the function's lifecycle ends, the ephemeral disk is permanently deleted. Use this type of disk space only to save temporary state.

{% endnote %}


## See also {#see-also}

* [Mounting buckets to a function](../operations/function/mount-bucket.md)
* [Mounting an ephemeral disk to a function](../operations/function/mount-ephemeral-disk.md)
* [Mounting buckets to a container](../../serverless-containers/operations/mount-bucket.md)
* [Mounting an ephemeral disk to a container](../../serverless-containers/operations/mount-ephemeral-disk.md)
