---
title: "What is a virtual machine image? Overview"
description: "A VM image is a complete copy of the file system structure and data on a disk. Images can be used for distributing software, e.g., OS distributions or disks with pre-installed software."
keywords:
  - vm
  - vm image
  - virtual machine image
---

# Images

An _image_ is a complete copy of the file system structure and data on a disk.

It is designed to quickly create a data disk, primarily, a VM boot disk. Images can be used for distributing software, e.g., OS distributions or disks with pre-installed software.

{% include [end-of-life](../../_includes/compute/end-of-life.md) %}

{% note tip %}

To regularly back up your data on disks, use [snapshots](snapshot.md).

{% endnote %}

You can create an image from a disk, snapshot, or another image. If you have an image file, you can [import](../operations/image-create/upload.md) it to {{ yandex-cloud }}.

When you create a Windows boot disk image, specify this in the operating system type. This is important for proper CPU emulation and calculating resource usage costs.

## Image family {#family}

If you regularly update your images, you can group them into families. You can use the family name to find the latest image in the family.

{% note warning %}

All images belonging to the same family must be in the same folder.

{% endnote %}

> Let's assume you want to [upload](../operations/image-create/upload.md) an image of your operating system to {{ yandex-cloud }}. When creating an image, specify a family, e.g., `best-linux-distro`. This will allow other users to get the latest version of your operating system by specifying the family and image folder ID in the [request](../api-ref/Image/getLatestByFamily.md).

## Public images {#public}

{% note info %}

{% include [public-image-support](../../_includes/compute/public-image-support.md) %}

{% endnote %}

Public images are, e.g., [products and solutions from {{ marketplace-full-name }}](/marketplace).

You can learn how to get a list of public images [here](../operations/images-with-pre-installed-software/get-list.md).

To make your image available to other {{ yandex-cloud }} users, grant them public access to it. To do this, assign the `{{ roles-image-user }}` [role](../security/) to the `{{ subjects-allAuthenticatedUsers }}` system group. However, the `{{ roles-image-user }}` role does not grant permission to delete or edit your image.

## Images optimized for deployment {#images-optimized-for-deployment}

_The feature is at the [Preview](../../overview/concepts/launch-stages.md) stage._

{% note info %}

You can migrate both optimized and non-optimized images.

{% endnote %}

Use optimized images only if you have a lot of disks and deployments.

An image can be optimized for frequent VM deployments. This speeds up the deployment of VMs and enables you to quickly expand your computing power and use the relevant tools from your own image.

Fast deployment is achieved by using multiple layers for storing data in a storage. The first layer stores the image source data, while the second one stores user data. When creating VM disks from optimized images, the first layer is reused rather than copied to a new storage location every time. Disks created from optimized images run on VMs in the same way as disks created from regular images: they can be used as boot disks and are fully available for data storage. The performance of these disks does not differ from that of regular ones.

Regular images from {{ marketplace-name }} are already optimized for deployment. To optimize your image, select the **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}** option when uploading the image.

By default, optimized images have a zero [quota](../concepts/limits.md#compute-quotas). To increase the [quota]({{ link-console-quotas }}), contact [support](../../support/overview.md).

## See also {#see-also}

* Learn how to create a VM from a [custom](../operations/vm-create/create-from-user-image.md) or [public](../operations/images-with-pre-installed-software/create.md) image.
* [{#T}](../operations/image-create/custom-image.md)
* [{#T}](../operations/image-control/import.md)
* [{#T}](../operations/image-control/access.md)
