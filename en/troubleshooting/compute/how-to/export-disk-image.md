# Exporting disk images of Compute Cloud VM instances



## Issue description {#case-description}

* You need to download an image of one or more VM disks to your local storage.

## Solution {#case-resolution}

An image or snapshot of a VM disk can only be used within Yandex Cloud. You cannot directly download it to your computer via the management console interface or YC CLI.
You can vote for the implementation of the functionality to download snapshots and disk images in our community [at this link](https://cloud.yandex.ru/features/78).

To solve your task, you can use third-party software or OS standard tools to create an image or backup of your disk (for example, `dd` or `dump`/`restore` on Linux machines), and then upload the image to a storage of your choice.

In case you need to transfer the disk image within Yandex Cloud, you can provide public access to the disk image. To do this, assign the `compute.images.user` role to the `allAuthenticatedUsers` system group. The `compute.images.user` role does not grant permissions to delete or update your images.
