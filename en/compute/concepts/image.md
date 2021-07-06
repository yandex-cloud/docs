---
title: What is a virtual machine image? Overview
description: An image is a complete copy of the file system structure and data on a disk. It is designed to quickly create a data disk, primarily a virtual machine’s boot disk. Images can be used for distributing software, such as OS distributions or disks with pre-installed software.
keywords:
  - vm
  - vm image
  - virtual machine image
---

# Images

_An image_ is a complete copy of the file system structure and data on a disk.

It is designed to quickly create a data disk, primarily a VM's boot disk. Images can be used for distributing software, such as OS distributions or disks with pre-installed software.

{% note tip %}

To regularly back up your data on disks, use [snapshots](snapshot.md).

{% endnote %}

You can create an image from a disk, snapshot, or other image. If you have an image, you can [import](../operations/image-create/upload.md) it to {{ yandex-cloud }}. You can't import Windows boot disk images.

When you create a Windows boot disk image, indicate this in the operating system type. This is important for proper CPU emulation and billing.

## Image family {#family}

If you regularly update your images, you can group them into families. You can use the family name to find the latest image in the family.

{% note warning %}

All images belonging to the same family must be in the same folder.

{% endnote %}

> Let's say you want to upload an image of your operating system to {{ yandex-cloud }}. When creating an image, specify a family, like `best-linux-distro`. This lets other users get the latest version of your operating system by specifying the family and image folder ID in the [query](../api-ref/Image/getLatestByFamily).

## Public images {#public}

You can grant public access to your image by assigning the `{{ roles-image-user }}` role to the `{{ subjects-allAuthenticatedUsers }}` system group. Then other {{ yandex-cloud }} users will be able to use your image to create their own disks and VMs. However, the `{{ roles-image-user }}` role doesn't grant permission to delete or edit your image.

An example of public images are OS distributions provided by {{ yandex-cloud }}.