---
title: OS images in {{ baremetal-full-name }}
description: In this guide, you will learn about the OS images you can use for OS installation on servers in {{ baremetal-full-name }}.
---

# OS images

An _image_ is a complete copy of the file system structure and data on a disk. Images are ideal for providing software, including OS distributions and other software products.

In {{ baremetal-full-name }}, you install each [server](./servers.md) OS from an image. These images fall into the following categories:

* [{{ marketplace-short-name }} images](#marketplace-images)
* [Custom images](#user-images)

## {{ marketplace-short-name }} images {#marketplace-images}

{{ marketplace-short-name }} images are public, preconfigured OS images available in a catalog for all {{ baremetal-name }} users to install on their {{ baremetal-name }} servers. Currently, the following {{ marketplace-short-name }} images for OS installation are available:

* Ubuntu 20.04 LTS
* Ubuntu 22.04 LTS
* Ubuntu 24.04 LTS
* Debian 10
* Debian 11
* CentOS 7

{{ marketplace-short-name }} images include all hardware drivers and system settings required for the OS to run properly on a {{ baremetal-name }} server.

When you [install](../operations/servers/reinstall-os-from-marketplace.md) a server OS from a {{ marketplace-short-name }} image, it is always installed and booted in Legacy [mode](./server-advanced-settings.md#boot-mode).

When installing a server OS from a {{ marketplace-short-name }} image, you can select the image you need directly in the [management console]({{ link-console-main }}) interface. Alternatively, you can specify the image ID or name if you are using the {{ yandex-cloud }} [CLI](../../cli/cli-ref/baremetal/cli-ref/index.md) or [API](../api-ref/authentication.md).

## Custom images {#user-images}

Custom images are OS or software product images that users [upload](../operations/image-upload.md) on their own into {{ baremetal-name }}. With custom images, you can install a [Linux](https://en.wikipedia.org/wiki/Linux) or [Windows](https://en.wikipedia.org/wiki/Microsoft_Windows) OS as well as software such as VMware [ESXi](https://en.wikipedia.org/wiki/VMware_ESXi), [OPNsense](https://opnsense.org/), etc.

Custom images must be uploaded to {{ baremetal-name }} in [ISO](https://en.wikipedia.org/wiki/Optical_disc_image) format.

When installing an OS from a custom image, you can select the [boot mode](./server-advanced-settings.md#boot-mode), `Legacy` or `UEFI`, and, optionally, [create](./server-advanced-settings.md#creating-rst-raids) RAIDs on the server drives using the built-in RAID controllers on its motherboard, provided the OS or software supports this feature.

To [install](../operations/servers/reinstall-os-from-own-image.md) an OS from a custom image, employ the [server KVM console](../operations/servers/server-kvm.md) to mount the custom image on the server's virtual CD drive, then boot from it as follows:

1. Click the CD icon or select **Media** → **Virtual Media Wizard...** in the top menu of the KVM console window. In the window that opens:

    1. In the **CD/DVD Media1** section, click **Browse** and select the [previously uploaded](../operations/image-upload.md) custom OS image in the `user-iso` directory.
    1. Click **Connect CD/DVD**.
    1. Check the **Status** section for the **Virtual CD 1** device to make sure the **Connected To** field now gives the path to the image you selected, and click **Close**.
1. To boot the server up from the selected custom image, click **Reboot to cdrom** in the top-right corner of the KVM console.

    The server will restart and boot from the virtual CD drive.

#### See also {#see-also}

* [{#T}](../operations/servers/reinstall-os-from-marketplace.md)
* [{#T}](../operations/servers/reinstall-os-from-own-image.md)
* [{#T}](./server-advanced-settings.md)