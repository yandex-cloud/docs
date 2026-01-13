---
title: Uploading a disk image to a cloud
description: This guide describes how to upload a disk image file to a Linux {{ objstorage-name }} and use it to create an image and a virtual machine in {{ compute-name }}.
keywords:
  - upload image
  - upload disk image
  - upload to cloud
  - disk image
  - Linux image
---

# Uploading a custom disk image to {{ yandex-cloud }}

This guide explains how to upload a Linux image file to [{{ objstorage-full-name }}](../../../storage/) and use it to create an [image](../../concepts/image.md) and a [VM](../../concepts/vm.md) in {{ compute-name }}.

Major virtualization systems are supported.

{% note warning %}

In {{ compute-name }}, you can only create images using files uploaded to {{ objstorage-name }}. You can also migrate a VM using [Hystax Acura](../../../tutorials/infrastructure-management/hystax-migration.md).

{% endnote %}

## Prepare an image file {#prepare-file}

{% include [image-create-requirements](../../../_includes/compute/image-create-requirements.md) %}

{% include [available-image-format](../../../_includes/compute/available-image-format.md) %}

For configuration steps, see [{#T}](custom-image.md).

## Upload the image file to {{ objstorage-name }} {#upload-file}

{% include [image-file-upload-to-bucket](../../../_includes/compute/image-file-upload-to-bucket.md) %}

## Creating an image in {{ compute-name }} {#create-image}

{% include [create-own-image-from-bucket](../../../_includes/compute/create-own-image-from-bucket.md) %}

## Deleting the image from {{ objstorage-name }} {#delete-image}

If you have successfully created an image, you can [delete the image file](../../../storage/operations/objects/delete.md) from {{ objstorage-name }}. You can also [delete the bucket](../../../storage/operations/buckets/delete.md) if it contains no objects.

## Creating a VM from a pre-built image {#create-vm-from-user-image}

You can create a VM with disks from a pre-built image.

{% include notitle [How to create a VM from custom image](../../operations/vm-create/create-from-user-image.md#create-vm-from-image) %}

For information about the {{ objstorage-name }} pricing, see [{#T}](../../../storage/pricing.md).