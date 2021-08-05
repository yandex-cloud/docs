---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating a Linux-based product image to upload to {{ marketplace-name }}

To add a product to the Marketplace, you need to upload an image to {{ yandex-cloud }}. The products can be based on Linux and Windows Server. These instructions will help you create an image based on Linux. To create an image with Windows, see [{#T}](create-image-ms.md).

## Creating an image {#create}

{% include [create-image](../../_includes/marketplace/image.md) %}

## Image requirements {#requirements}

{% include [image-create-requirements](../../_includes/compute/image-create-requirements.md) %}

For instructions on how to configure the OS to meet the requirements, see [{#T}](../../compute/operations/image-create/custom-image.md).

To use the image for a Marketplace product, also follow these steps:

1. Clean up:
   * The `/tmp`, `/var/tmp`, and `/var/log` directories.
   * The package manager cache.
   * `.bash_history` for all users.
   * The data on configurations previously received via DHCP (`dhcp.leases` and `dhcp.log`).
   * The `/etc/machine-id` file.

### Preparing an image {#preparation}

Clean up:

* The `/tmp`, `/var/tmp`, and `/var/log` directories.
* The package manager cache.
* `.bash_history` for all users.
* The data on configurations previously received via DHCP (`dhcp.leases` and `dhcp.log`).
* The `/etc/machine-id` file.

Make sure that:

* The image only has the system users that the applications need.
* There are no pre-generated SSH keys or passwords in the image. If necessary, application passwords are generated at VM startup. The user can change them the first time they log in via the serial console or SSH. Password-based access via SSH must be disabled for all users. They may log in only using a key obtained from the [metadata service](../../compute/operations/vm-info/get-info.md#inside-instance).
* The `/etc/sudoers*` file has no extra privileges configured for users.

## Checking your image {#check-image}

You can use the [yc-image-cleanup.sh](https://github.com/yandex-cloud/examples/blob/master/products-prepare/linux/yc-image-cleanup.sh) script to:

* Clean up a VM before creating an image from it:

    ```bash
    ./yc-image-cleanup.sh -c
    ```

    {% note warning %}

    The cleanup command deletes some files and directories. Before running it, make sure that you have backups of important data.

    {% endnote %}

* Check the image for compliance with some [requirements](#requirements):

    ```bash
    ./yc-image-cleanup.sh -d
    ```

* Test the VM that you [created](../../compute/operations/image-create/upload.md#create-vm-from-user-image) from the image:

    ```
    ./yc-image-cleanup.sh -t
    ```

You should run the `yc-image-cleanup.sh` script inside the VM instance as a `root` user.

The `yc-image-cleanup.sh` script does not check the product image for compliance with all requirements and is not compatible with all distributions. Before uploading the image to the Marketplace, you'll need to perform additional checks yourself.

