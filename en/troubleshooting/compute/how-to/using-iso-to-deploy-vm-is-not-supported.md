# Using an ISO image for deploying VM instances



## Issue description {#case-description}

You need to deploy a VM instance in Compute Cloud from an ISO image

## Solution {#case-resolution}

Due to the peculiarities of the Yandex Cloud infrastructure, you cannot deploy a VM instance from an ISO image.
Only `QCOW2`, `VMDK`, and `VHD` hard disk image formats are supported.

For more details about this, see the guide on [how to prepare a disk image](../../../compute/operations/image-create/custom-image.md#create-image-file).

If you need to upload a custom VM image, complete these steps:

1. Install the appropriate OS on a local hypervisor. You can use [VirtualBox](https://www.virtualbox.org/) or [QEMU](https://www.qemu.org/) for this.
2. Prepare your disk image following the [instructions from the documentation](../../../compute/operations/image-create/custom-image.md).
3. [Upload](../../../compute/operations/image-create/upload.md) your image to Object Storage.
4. [Create](../../../compute/operations/image-create/upload.md#create-image) a new image from the link obtained in Object Storage.
5. [Deploy](../../../compute/operations/vm-create/create-from-user-image.md) a cloud VM based on the resulting image.

{% note alert %}

The above recommendations apply to VM disk images that use the Linux kernel as a guest operating system.
If you need to deploy an image of a product based on Microsoft Windows®, this guide is not for you.

{% endnote %}
