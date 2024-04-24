# Images

An _image_ is a complete copy of the file system structure and data on a disk. {{ cloud-desktop-name }} images always contain an OS.

An image is used to create a desktop [boot disk](disks.md#boot-disk).

For more information about images, see the [{{ compute-name }} documentation](../../compute/concepts/image.md).

## System images {#system-images}

{{ cloud-desktop-name }} system images contain a basic OS version, such as Ubuntu 20.04 LTS.

You cannot delete such images.

## Custom images {#custom-images}

You can add custom images created from a [desktop](../operations/images/create-from-desktop.md) or [{{ compute-name }} VM](../operations/images/create-from-compute.md), to {{ cloud-desktop-name }}.

This way, you can deploy and configure the required software environment on your desktop or VM and replicate it to users through images.

You can [delete](../operations/images/delete.md) custom images.
