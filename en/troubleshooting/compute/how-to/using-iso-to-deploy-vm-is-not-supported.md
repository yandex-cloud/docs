# How to use an ISO image for deploying VM instances



## Issue description {#case-description}

You need to deploy a VM instance in {{ compute-name }} from an ISO image.

## Solution {#case-resolution}

Due to specifics of the {{ yandex-cloud }} infrastructure, you cannot deploy a VM instance from an ISO image. {{ yandex-cloud }} only supports these disk image formats: 

* `Qcow2` 
* `VMDK`
* `VHD`

To learn more, see [our guide on how to set up a custom disk image](../../../compute/operations/image-create/custom-image.md#create-image-file).

If you need to upload a custom VM image, follow these steps:

1. Install the OS you need on a local hypervisor. You can use [VirtualBox](https://www.virtualbox.org/) or [QEMU](https://www.qemu.org/) for this.
1. Set up a custom disk image following [this guide](../../../compute/operations/image-create/custom-image.md).
1. [Upload](../../../compute/operations/image-create/upload.md) your image to {{ objstorage-name }}.
1. [Create](../../../compute/operations/image-create/upload.md#create-image) a new image using the link you got in {{ objstorage-name }}.
1. [Deploy](../../../compute/operations/vm-create/create-from-user-image.md) a cloud VM from the image you got.

{% note alert %}

The above recommendations apply to VM disk images that use the Linux kernel as a guest operating system.

If you need to deploy an image of a Microsoft Windows® product, this guide is not for you.

{% endnote %}
